#!/bin/bash

echo 'CDS 7.0'
echo "Configurando /etc/hosts..."

# Añadimos las rutas al host (agrupado para mayor claridad)
echo "172.18.43.37 ip_cds" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.37 ip_cds_remote" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.42.207 s_fatw" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.153 ip_statics" | sudo tee -a /etc/hosts > /dev/null

# Modificamos host para evitar timeouts
echo "127.0.0.1 emssas.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "127.0.0.1 datalog.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "127.0.0.1 datastatics.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "127.0.0.1 emsstatics.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null

# Mapping de dns bs
echo "172.17.100.13 svmprosvn01.adgbs.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.17.100.210 svmprosvn02.adgbs.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.37 cdsapp1i.bancsabadell.com cdsapp1i" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.29 cdsapp1d.bancsabadell.com cdsapp1d" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.13 cdsapp1r.bancsabadell.com cdsapp1r" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.14 cdsapp2r.bancsabadell.com cdsapp2r" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.161 dev.sabadellatlantico.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.176 int.sabadellatlantico.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.39.94 pre.sabadellatlantico.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.30 cdsws1d.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.38 cdsws1i.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.43.15 cdsws1r.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.30.220.34 xfdcon01db01-vip.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.30.220.36 xfdcon01db02-vip.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.29.220.34 xfdcon02db01-vip.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.29.220.36 xfdcon02db02-vip.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.30.220.38 xfdcon01-scan" | sudo tee -a /etc/hosts > /dev/null
echo "172.29.220.38 xfdcon02-scan" | sudo tee -a /etc/hosts > /dev/null
echo "172.22.193.7 sonarqube.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.70.109 sv.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.70.9 tdm.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.70.103 ra.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.18.70.112 cdd.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.22.192.250 factory.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.30.11.7 sso.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.22.193.99 confluence.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null
echo "172.17.100.210 svmprosvn02" | sudo tee -a /etc/hosts > /dev/null
echo "172.22.193.8 repos.bancsabadell.com" | sudo tee -a /etc/hosts > /dev/null

echo "Arrancando apache 2.4..."
# Añadimos || true para que el script no aborte si el proceso no existía
sudo httpd -k stop || true
sudo httpd -k start

echo "Arrancando ssh..."
sudo /usr/sbin/sshd

# Variables VNC
export DISPLAY=${DISPLAY:-:1}
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
VNC_PORT="590"${DISPLAY:1}

echo "Configurando VNC password..."
mkdir -p /home/utibco/.vnc
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

echo "Limpiando locks antiguos de VNC/X11..."
# Matamos el display si ya existía y borramos los locks de pantalla gráfica de forma segura
vncserver -kill $DISPLAY > /dev/null 2>&1 || true
sudo rm -rfv /tmp/.X1* /tmp/.X11-unix

echo "Iniciando servidor VNC..."
# Ya no lanzamos startxfce4 aquí. VNC lo lanzará leyendo el archivo ~/.vnc/xstartup
vncserver $DISPLAY -depth ${VNC_COL_DEPTH:-24} -geometry ${VNC_RESOLUTION:-1280x1024}

sleep 2

echo -e "\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY"
# Cambiamos el log para recordarte que uses localhost desde el VNC Viewer
echo -e "\t=> Connect via VNC viewer using: localhost:$VNC_PORT"
echo -e "\t   (Asegúrate de que mapeaste el puerto -p $VNC_PORT:$VNC_PORT en Docker)"

for i in "$@"
do
    case $i in
        -t|--tail-log)
            echo -e "\n------------------ /home/utibco/.vnc/*$DISPLAY.log ------------------"
            tail -f /home/utibco/.vnc/*$DISPLAY.log
            ;;
        *)
            exec $i
            ;;
    esac
done
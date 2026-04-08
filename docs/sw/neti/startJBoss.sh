export JBOSS_HOME=/home/utibco/sw/jboss-eap-6.4/
export JBOSS_MODULEPATH="$JBOSS_HOME/modules:/home/utibco/sw/neti/jbossModules"

if [ $# -eq 0 ]
  then
     echo "Error missing target. Usage: startJBoss.sh <target>   ex: startJBoss.sh netibs"
    exit -1
fi

#setup config directorio deploy jboss
echo "**********Adaptando la configuración de jboss para los proyectos neti*****************"
mkdir -p /home/utibco/sw/neti/jbossdeploy
sudo cp -R /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/jbossconfiguration/*  /home/utibco/sw/jboss-eap-6.4/standalone/configuration/


	echo "Copiando fichero de configuración de apache correspondiente"
	cp /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/httpd/httpd_"$1".conf /etc/httpd/conf/httpd.conf
	echo "Reiniciando Apache"
	sudo httpd -k stop
	sudo httpd -k start

NETI_TARGET=/home/utibco/sw/neti/jbossModules/"$1"Config/main/web-xml.properties
echo "loading profile: $NETI_TARGET"

NETI_TARGET_TXBS=/home/utibco/sw/neti/jbossModules/netibsConfig/main/web-xml.properties
echo "loading profile: $NETI_TARGET_TXBS"

NETI_TARGET_TXBSEMP=/home/utibco/sw/neti/jbossModules/netiempbsConfig/main/web-xml.properties
echo "loading profile: $NETI_TARGET_TXBSEMP"



cd $JBOSS_HOME/bin
./standalone.sh -P=$NETI_TARGET -P=$NETI_TARGET_TXBSEMP -P=$NETI_TARGET_TXBS -b 0.0.0.0 -bmanagement 0.0.0.0 --debug
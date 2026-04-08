#!/bin/sh
#
#	Menu del entorno local
#
#   Created 06-03-2019
#

if ! rpm -qa | grep -qw gnome-terminal; then
    sudo yum install gnome-terminal
fi

my_string=$PATH
substring="scripts"
if [ "${my_string/$substring}" = "$my_string" ] ; then
	echo "export PATH=$PATH\:/home/utibco/scripts" >> ~/.bashrc
	bash
fi

menu()
{
	echo "**********************************"
	echo "**********************************"
	echo 
	echo "      Menu Entorno local"
	echo "  ==========================="
	echo 
	echo "1- Arrancar CDS (SM + DAS2)"
	echo 
	echo "2- Arrancar SM"
	echo 
	echo "3- Arrancar DAS2"
	echo 
	echo "4- Arrancar CDS - Modo Debug"
	echo 
	echo "5- Arrancar JBoss Particulares"
	echo 
	echo "6- Arrancar ESI"
	echo 
	echo "7- Arrancar ESI - Modo Debug"
	echo 
	echo "8- Arrancar JBoss CDSWS"
	echo 
	echo "0- Salir"
	echo
	echo "Selecciona opcion:" 
	read OPCION
}

arrancar_cds_debug()
{
	gnome-terminal --working-directory=/app/cds/capa_prd/bin/cdslocal --tab -t "SM" -e "bash -c './startSM.sh'" --tab -t "DAS2" -e "bash -c './startDAS2Debug.sh'"
}

execute_script_cds()
{
	gnome-terminal --working-directory=/app/$2/capa_prd/bin/cdslocal --tab -t $1 -e "bash -c './$3'"
}

arrancar_cds()
{
	gnome-terminal --working-directory=/app/cds/capa_prd/bin/cdslocal --tab -t "SM" -e "bash -c './startSM.sh'" --tab -t "DAS2" -e "bash -c './startDAS2.sh'"
}

execute_script_neti()
{
	gnome-terminal --working-directory=/home/utibco/sw/neti --tab -t $1 -e "bash -c './$2 $3'"
    sudo httpd -k start
}

execute_script_bg()
{
	gnome-terminal --working-directory=/home/utibco/sw/$2 --tab -t $1 -e "bash -c './$3'"
}

while $SALIR
do
	clear
	menu
	case $OPCION in
	1) clear
	   echo "Arrancando CDS (SM + DAS2)"
	   echo "==================================="
	   echo
	   arrancar_cds
	   ;;
	2) clear
	   echo "Arrancando SM"
	   echo "==================================="
	   echo
	   execute_script_cds "SM" "cds" "startSM.sh"
	   ;;
	3) clear
	   echo "Arrancando DAS2"
	   echo "==================================="
	   echo
	   execute_script_cds "DAS2" "cds" "startDAS2.sh"
	   ;;
	4) clear
	   echo "Arrancando CDS - Modo Debug"
	   echo "==================================="
	   echo 
	   arrancar_cds_debug
	   ;;
	5) clear
	   echo "Arrancando JBoss Particulares"
	   echo "==================================="
       echo
	   echo "Introduce el nombre de la instancia: (ex: netibs)"
       echo
	   read ID
	   echo
	   execute_script_neti "Neti JBOSS" "startJBoss.sh" $ID
	   ;;
	6) clear
	   echo "Arrancando ESI"
	   echo "==================================="
	   echo 
	   execute_script_cds "ESI" "cds" "startESI.sh"
	   ;;
	7) clear
	   echo "Arrancando ESI"
	   echo "==================================="
	   echo
	   execute_script_cds "ESI-Debug" "cds" "startESIDebug.sh"
	   ;;
	8) clear
	   echo "Arrancando JBoss CDSWS"
	   echo "==================================="
	   echo
	   execute_script_bg "JBoss-CDSWS" "cdsws" "startJBoss.sh"
	   ;;
	0) SALIR=si
	   ;;
	*) echo Opciones 1,2,3,4,5,6,7,8 o 0 
	   echo "Pulsa enter..."
	   read tmp
	   ;;
	esac
done
clear
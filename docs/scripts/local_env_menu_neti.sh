#!/bin/sh
#
#	Menu del entorno local para neti
#
#   Created 28-03-2019
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
    echo 
    echo " Menu NETi - neti-webapp"
	echo " ==========================="
	echo 
	echo "1- Generar WAR"
	echo 
	echo "2- Arrancar JBoss"
    echo 
	echo "0- Salir"
	echo
	echo "Selecciona opcion:" 
	read OPCION
}


execute_script_neti()
{
	gnome-terminal --working-directory=/home/utibco/sw/neti --tab -t $1 -e "bash -c './$2 $3'"    
}

git_switch_neti()
{
	BASE_DIR_NETI=/home/utibco/develop/neti-webapp/
	cd $BASE_DIR_NETI
	git fetch origin
	git -c diff.mnemonicprefix=false -c core.quotepath=false checkout $1
}


git_switch_neti_new()
{
	BASE_DIR_NETI=/home/utibco/develop/neti-webapp/
	cd $BASE_DIR_NETI
	git fetch origin
	git -c diff.mnemonicprefix=false -c core.quotepath=false checkout -b $1
}

git_status_neti()
{
	BASE_DIR_NETI=/home/utibco/develop/neti-webapp/
	cd $BASE_DIR_NETI
    git checkout $1
    git pull origin $1
	git branch
}

git_commit_neti()
{
	BASE_DIR_NETI=/home/utibco/develop/neti-webapp/
	cd $BASE_DIR_NETI
    git checkout $1
	git -c diff.mnemonicprefix=false -c core.quotepath=false commit -a -m $2
}

git_push_neti(){
    BASE_DIR_NETI=/home/utibco/develop/neti-webapp/
	cd $BASE_DIR_NETI
    git -c diff.mnemonicprefix=false -c core.quotepath=false push -v --tags --set-upstream origin $1:$1
}



while $SALIR
do
	clear
	menu
	case $OPCION in
	1) clear
	   echo "Generando WAR"
	   echo "==================================="
	   echo
	   echo "Introduce el nombre de la instancia: (ex: netibs)"
       echo
	   read ID
	   echo
	   execute_script_neti "Deploy war" "git_deploy.sh" $ID
	   ;;
	2) clear
	   echo "Arrancando JBoss Particulares"
	   echo "==================================="
	   echo
       echo "Introduce el nombre de la instancia: (ex: netibs)"
       echo
	   read ID
	   echo
	   execute_script_neti "Neti JBOSS" "startJBoss.sh" $ID
	   ;;
	0) SALIR=si
	   ;;
	*) echo Opciones 1,2 o 0 
	   echo "Pulsa enter..."
	   read tmp
	   ;;
	esac
done
clear
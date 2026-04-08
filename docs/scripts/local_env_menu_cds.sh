#!/bin/sh
#
#	Menu del entorno local
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
	echo " Menu CDS - cds-main"
	echo " ==========================="
	echo 
	echo "1- Arrancar CDS (SM + DAS2)"
	echo 
	echo "2- Arrancar CDS - Modo Debug"
    echo 
	echo "3- Deploy changes"
	echo 
	echo "4- Deploy classes only"
    echo 
	echo "0- Salir"
	echo
	echo "Selecciona opcion:" 
	read OPCION
}

arrancar_cds()
{
	gnome-terminal --working-directory=/app/cds/capa_prd/bin/cdslocal --tab -t "SM" -e "bash -c './startSM.sh'" --tab -t "DAS2" -e "bash -c './startDAS2.sh'"
}

arrancar_cds_debug()
{
	gnome-terminal --working-directory=/app/cds/capa_prd/bin/cdslocal --tab -t "SM" -e "bash -c './startSM.sh'" --tab -t "DAS2" -e "bash -c './startDAS2Debug.sh'"
}

deploy_cds()
{
	BASE_DIR_CDS=/home/utibco/sw/cds/
	cd $BASE_DIR_CDS
	./$1
}

git_switch_cds()
{
	BASE_DIR_CDS=/home/utibco/develop/cds-main/
	cd $BASE_DIR_CDS
	git fetch origin
	git -c diff.mnemonicprefix=false -c core.quotepath=false checkout -b $1
}

git_switch_cds_new()
{
	BASE_DIR_CDS=/home/utibco/develop/cds-main/
	cd $BASE_DIR_CDS
	git fetch origin
	git -c diff.mnemonicprefix=false -c core.quotepath=false checkout -b $1
}

git_status_cds()
{
	BASE_DIR_CDS=/home/utibco/develop/cds-main/
	cd $BASE_DIR_CDS
    git checkout $1
    git pull origin $1
	git branch
}

git_commit_cds()
{
	BASE_DIR_CDS=/home/utibco/develop/cds-main/
	cd $BASE_DIR_CDS
    git checkout $1
	git -c diff.mnemonicprefix=false -c core.quotepath=false commit -a -m $2
}

git_push_cds(){
    BASE_DIR_CDS=/home/utibco/develop/cds-main/
	cd $BASE_DIR_CDS
    git -c diff.mnemonicprefix=false -c core.quotepath=false push -v --tags --set-upstream origin $1:$1
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
	   echo "Arrancando CDS - Modo Debug"
	   echo "==================================="
	   echo 
	   arrancar_cds_debug
	   ;;
	3) clear
	   echo "Deploy CDS - nuevos cambios"
	   echo "==================================="
	   echo
	   deploy_cds "git_deploy_main.sh"
	   echo "Pulsa enter..."
	   read tmp
	   ;;
	4) clear
	   echo "Deploy CDS - classes java"
	   echo "==================================="
	   echo
	   deploy_cds "git_fast_deploy_classes.sh"
	   echo "Pulsa enter..."
	   read tmp
	   ;;
	0) SALIR=si
	   ;;
	*) echo Opciones 1,2,3,4 o 0 
	   echo "Pulsa enter..."
	   read tmp
	   ;;
	esac
done
clear
INIT_BASEDIR=$(dirname "$0")

if [ $# -eq 0 ]
  then
     echo "Error missing target. Usage: git_deploy.sh <target>   ex: git_deploy.sh netibs"
    exit -1
fi

NETI_TARGET=$1
TO_REPLACE=neti
REPLACE=tx

WAR_TARGET=$(echo $NETI_TARGET.war| sed -e "s/${TO_REPLACE}/${REPLACE}/g")

#correccion war empresas
TO_REPLACE_EMP=txbsem
REPLACE_EMP=txempbs

WAR_TARGET=$(echo $WAR_TARGET| sed -e "s/${TO_REPLACE_EMP}/${REPLACE_EMP}/g")
#fin correccion war empresas

echo "Deploying $1 into $WAR_TARGET"

#tareas previas
#rm -rf   /app/cds/capa_prd/*



#conf
cd /home/utibco/develop/neti-webapp-conf
mvn clean package
###descomprimir
unzip -o  ./target/*.zip -d /home/utibco/sw/neti/tmp

###copiar modules
mkdir -p /home/utibco/sw/neti/jbossModules
rm -rf /home/utibco/sw/neti/jbossModules/*

cp -r  /home/utibco/sw/neti/tmp/LOCAL/net* /home/utibco/sw/neti/jbossModules/


#main

###aplicar patch local a los fuentes (TODO: no lo hago en una rama para permitir bajar develop)

cp -r  /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/srcpatch/localdevjb/common/WEB-INF/classes/*  /home/utibco/develop/neti-webapp/src/main/java/classes/
cd /home/utibco/develop/neti-webapp/$1
mvn clean package -P gen_src_local



#deploy en jboss

cp /home/utibco/develop/neti-webapp/$NETI_TARGET/target/$NETI_TARGET*.war /home/utibco/sw/neti/jbossdeploy/$WAR_TARGET


touch /home/utibco/sw/neti/jbossdeploy/$WAR_TARGET.dodeploy
 


rm -rf /home/utibco/sw/neti/tmp

cd $INIT_BASEDIR

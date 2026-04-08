INIT_BASEDIR=netibs

export JBOSS_HOME=/home/utibco/sw/jboss-eap-6.4/
export JBOSS_MODULEPATH="$JBOSS_HOME/modules:/home/utibco/sw/neti/jbossModules"

NETI_TARGET=$INIT_BASEDIR
TO_REPLACE=neti
REPLACE=tx

WAR_TARGET=$(echo $NETI_TARGET.war| sed -e "s/${TO_REPLACE}/${REPLACE}/g")

#correccion war empresas
if [ $NETI_TARGET == "netibsem" ]
  then
	TO_REPLACE_EMP=txbsem
	REPLACE_EMP=txempbs

	WAR_TARGET=$(echo $WAR_TARGET| sed -e "s/${TO_REPLACE_EMP}/${REPLACE_EMP}/g")
fi
#fin correccion war empresas

echo "Deploying $INIT_BASEDIR into $WAR_TARGET"

#tareas previas
#rm -rf   /app/cds/capa_prd/*



#conf
cd /home/utibco/develop/neti-webapp-conf
mvn package
###descomprimir
unzip -o  ./target/*.zip -d /home/utibco/sw/neti/tmp

###copiar modules
mkdir -p /home/utibco/sw/neti/jbossModules
rm -rf /home/utibco/sw/neti/jbossModules/*

cp -r  /home/utibco/sw/neti/tmp/LOCAL/net* /home/utibco/sw/neti/jbossModules/

#main

###aplicar patch local a los fuentes
cp -r  /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/srcpatch/localdevjb/common/WEB-INF/classes/*  /home/utibco/develop/neti-webapp/src/main/java/classes/

###borramos wars de versiones antiguas
rm -rf /home/utibco/develop/neti-webapp/$NETI_TARGET/target/$NETI_TARGET*.war
rm -rf /home/utibco/sw/neti/jbossdeploy/$WAR_TARGET

if [ $NETI_TARGET != "netibs" ]
  then
	cd /home/utibco/develop/neti-webapp/netibs
    mvn package -P gen_src_local
fi

cd /home/utibco/develop/neti-webapp/$NETI_TARGET
mvn package -P gen_src_local

#deploy en jboss
mkdir -p /home/utibco/sw/neti/jbossdeploy
cp /home/utibco/develop/neti-webapp/$NETI_TARGET/target/$NETI_TARGET*.war /home/utibco/sw/neti/jbossdeploy/$WAR_TARGET

if [ $NETI_TARGET == "netibsem" ]
  then
	TO_REPLACE_CONFIG=netibsem
	REPLACE_EMP_CONFIG=netiempbs

	NETI_TARGET=$(echo $NETI_TARGET| sed -e "s/${TO_REPLACE_CONFIG}/${REPLACE_EMP_CONFIG}/g")
fi

if [ $NETI_TARGET != "netibsa" ]
  then
	cp -r /home/utibco/sw/neti/jbossModules/netibsConfig/main/WEB-INF/COMMON /home/utibco/sw/neti/jbossModules/${NETI_TARGET}Config/main/WEB-INF
fi

touch /home/utibco/sw/neti/jbossdeploy/$WAR_TARGET.dodeploy

rm -rf /home/utibco/sw/neti/tmp

cd $INIT_BASEDIR

### Arrancamos Jboss

#setup config directorio deploy jboss
echo "**********Adaptando la configuración de jboss para los proyectos neti*****************"
mkdir -p /home/utibco/sw/neti/jbossdeploy
sudo cp -R /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/jbossconfiguration/*  /home/utibco/sw/jboss-eap-6.4/standalone/configuration/


	echo "Copiando fichero de configuración de apache correspondiente"
	cp /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/httpd/httpd_"$INIT_BASEDIR".conf /etc/httpd/conf/httpd.conf
	echo "Reiniciando Apache"
	sudo httpd -k stop
	sudo httpd -k start

NETI_TARGET=/home/utibco/sw/neti/jbossModules/"$INIT_BASEDIR"Config/main/web-xml.properties
echo "loading profile: $NETI_TARGET"

NETI_TARGET_TXBS=/home/utibco/sw/neti/jbossModules/netibsConfig/main/web-xml.properties
echo "loading profile: $NETI_TARGET_TXBS"

NETI_TARGET_TXBSEMP=/home/utibco/sw/neti/jbossModules/netiempbsConfig/main/web-xml.properties
echo "loading profile: $NETI_TARGET_TXBSEMP"



cd $JBOSS_HOME/bin
./standalone.sh -P=$NETI_TARGET -P=$NETI_TARGET_TXBSEMP -P=$NETI_TARGET_TXBS -b 0.0.0.0 -bmanagement 0.0.0.0 --debug

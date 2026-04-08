export JBOSS_HOME=/home/utibco/sw/jboss-eap-6.4/


JSP_DIR=/home/utibco/sw/odp/
ODP_DIR=/home/utibco/develop/odp/

#traspasar JSP a war deployado
cp -R $JSP_DIR/* $JBOSS_HOME/standalone/tmp/vfs/temp/temp*/txbs*/COMMON/documents/jsp/servicios/

#traspasar ODP application a war deployado
cd $JBOSS_HOME/standalone/tmp/vfs/temp/temp*/txbs*/
mkdir odp
cp -R $ODP_DIR/* $JBOSS_HOME/standalone/tmp/vfs/temp/temp*/txbs*/odp/
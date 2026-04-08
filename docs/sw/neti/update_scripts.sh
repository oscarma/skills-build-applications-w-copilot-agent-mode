INIT_BASEDIR=$(dirname "$0")


BASE_DIR=/home/utibco/develop
cd  $BASE_DIR/neti-webapp-conf

git pull

#setup config directorio deploy jboss
sudo cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/jbossconfiguration/*  /home/utibco/sw/jboss-eap-6.4/standalone/configuration/

#scripts
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/scripts/*  /home/utibco/scripts/
chmod -R +x /home/utibco/scripts/*.sh

#httpd
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/httpd/httpd.conf  /etc/httpd/conf/

#git scripts neti
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/bin/* /home/utibco/sw/neti/
chmod -R +x /home/utibco/sw/neti/*.sh

#odp
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/odp/* /home/utibco/sw/odp/

cd $INIT_BASEDIR
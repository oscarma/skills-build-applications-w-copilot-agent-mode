INIT_BASEDIR=$(dirname "$0")

#conf

rm -rf /home/utibco/develop/cds-conf/target/*.zip

cd /home/utibco/develop/cds-conf
mvn clean package

rm -rf /tmp/conf
mkdir -p /tmp/conf
unzip -o  ./target/*.zip -d /tmp/conf
cp -r  /tmp/conf/LOCAL/* /app/cds/capa_prd/
chmod +x /app/cds/capa_prd/bin/cdslocal/*.sh

cd $INIT_BASEDIR


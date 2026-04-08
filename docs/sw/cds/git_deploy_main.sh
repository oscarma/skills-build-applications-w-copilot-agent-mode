INIT_BASEDIR=$(dirname "$0")

mkdir -p /app/cds/capa_prd/tmp
mkdir -p /app/cds/capa_prd/components/das2/data/spain

#main
cd /home/utibco/develop/cds-main/das2
mvn package

#descomprimir zip das2
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components

cp -r /home/utibco/sw/cds/capa_prd/* /app/cds/capa_prd/

chmod +x /app/cds/capa_prd/snmp/*.sh

mkdir -p /app/cds/capa_prd/log/

cd $INIT_BASEDIR


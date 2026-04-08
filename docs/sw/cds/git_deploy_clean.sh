INIT_BASEDIR=$(dirname "$0")




rm -rf   /app/cds/capa_prd/*


mkdir -p /app/cds/capa_prd/tmp
mkdir -p /app/cds/capa_prd/components/das2/data/spain

#main

cd /home/utibco/develop/cds-main
mvn clean  package



#descomprimir zip das2
unzip -o  ./das2/target/*.zip -d /app/cds/capa_prd/components
unzip -o  ./esi/target/*.zip -d /app/cds/capa_prd/components


#common
cd /home/utibco/develop/cds-common
mvn clean  package
#descomprimir 
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components

#dmps
cd /home/utibco/develop/cds-dmps
mvn clean  package
#descomprimir 
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components


#dsi
cd /home/utibco/develop/cds-dsi
mvn clean  package
#descomprimir 
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components


#logtracesvr
cd /home/utibco/develop/cds-logtracesvr
mvn clean  package
#descomprimir 
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components

#sessionmanager
cd /home/utibco/develop/cds-sessionmanager
mvn clean  package
#descomprimir 
unzip -o  ./target/*.zip -d /app/cds/capa_prd/components

#conf
cd /home/utibco/develop/cds-conf
mvn clean  package

rm -rf /tmp/conf
mkdir -p /tmp/conf
unzip -o  ./target/*.zip -d /tmp/conf
cp -r  /tmp/conf/LOCAL/* /app/cds/capa_prd/
chmod +x /app/cds/capa_prd/bin/cdslocal/*.sh



cp -r /home/utibco/sw/cds/capa_prd/* /app/cds/capa_prd/

chmod +x /app/cds/capa_prd/snmp/*.sh

mkdir -p /app/cds/capa_prd/log/

cd $INIT_BASEDIR


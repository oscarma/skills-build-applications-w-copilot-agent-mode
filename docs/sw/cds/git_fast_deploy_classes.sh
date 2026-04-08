INIT_BASEDIR=$(dirname "$0")



rm -rf   /app/cds/capa_prd/components/das2/data/spain/COMMON/classes/*


#main

cd /home/utibco/develop/cds-main/das2
mvn compile

cp -r /home/utibco/develop/cds-main/das2/target/das2/data/spain/COMMON/classes/* /app/cds/capa_prd/components/das2/data/spain/COMMON/classes


cd $INIT_BASEDIR


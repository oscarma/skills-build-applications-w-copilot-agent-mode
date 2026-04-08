INIT_BASEDIR=$(dirname "$0")

BASE_DIR=/home/utibco/develop
cd  $BASE_DIR
mkdir odp

cd  /home/utibco/sw/
mkdir odp

#git scripts odp
cp -R /home/utibco/develop/neti-webapp-conf/src/LOCAL/localresources/odp/* /home/utibco/sw/odp/


cd $INIT_BASEDIR
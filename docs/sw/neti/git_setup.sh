INIT_BASEDIR=$(dirname "$0")
#tareas iniciales, updata  las shells
cp /usr/share/maven/conf/settings.xml /home/utibco/.m2/settings.xml

BASE_BRANCH=develop
BASE_DIR=/home/utibco/develop

rm -rf $BASE_DIR/neti-*

cd  $BASE_DIR

git config --global credential.helper cache
git clone --single-branch --branch feature/main-fixes http://repos.bancsabadell.com/bitbucket/scm/neti/neti-webapp-conf.git

cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/bin/*  /home/utibco/sw/neti
chmod +x /home/utibco/sw/neti/*.sh


cd $INIT_BASEDIR


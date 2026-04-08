INIT_BASEDIR=$(dirname "$0")

#set de artifactory en mvn

cp /usr/share/maven/conf/settings.xml /home/utibco/.m2/settings.xml

BASE_BRANCH=develop
BASE_DIR=/home/utibco/develop

rm -rf $BASE_DIR/neti-*

cd  $BASE_DIR

git config --global credential.helper cache
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/neti/neti-webapp.git
git clone --single-branch --branch feature/main-fixes http://repos.bancsabadell.com/bitbucket/scm/neti/neti-webapp-conf.git

#scripts
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/scripts/*  /home/utibco/scripts/
chmod -R +x /home/utibco/scripts/*.sh

#httpd
cp -R $BASE_DIR/neti-webapp-conf/src/LOCAL/localresources/httpd/httpd.conf  /etc/httpd/conf/

cd $INIT_BASEDIR
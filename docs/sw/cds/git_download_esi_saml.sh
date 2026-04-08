INIT_BASEDIR=$(dirname "$0")
#set de artifactory en mvn

cp /usr/share/maven/conf/settings.xml /home/utibco/.m2/settings.xml

BASE_BRANCH=master
BASE_DIR=/home/utibco/develop

rm -rf $BASE_DIR/cds-esi-samtoken*

cd  $BASE_DIR

git config --global credential.helper cache


git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cdsesi/cds-esi-samltoken.git

cd $INIT_BASEDIR



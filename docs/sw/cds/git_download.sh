INIT_BASEDIR=$(dirname "$0")

#set de artifactory en mvn

cp /usr/share/maven/conf/settings.xml /home/utibco/.m2/settings.xml

BASE_BRANCH=develop
BASE_DIR=/home/utibco/develop

rm -rf $BASE_DIR/cds-*

cd  $BASE_DIR

git config --global credential.helper cache
#git clone --single-branch --branch feature/CS-1285  http://repos.bancsabadell.com/bitbucket/scm/cds/cds-main.git
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-main.git 
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-common.git 
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-dmps.git 
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-logtracesvr.git 
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-dsi.git 
git clone --single-branch --branch $BASE_BRANCH http://repos.bancsabadell.com/bitbucket/scm/cds/cds-sessionmanager.git 
git clone --single-branch --branch feature/main-fixes http://repos.bancsabadell.com/bitbucket/scm/cds/cds-conf.git 




cd $INIT_BASEDIR
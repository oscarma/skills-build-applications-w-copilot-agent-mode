#tareas iniciales, updata  las shells
cp /usr/share/maven/conf/settings.xml /home/utibco/.m2/settings.xml

BASE_BRANCH=develop
BASE_DIR=/home/utibco/develop

rm -rf $BASE_DIR/cds-*

cd  $BASE_DIR

git config --global credential.helper cache
git clone --single-branch --branch feature/main-fixes http://repos.bancsabadell.com/bitbucket/scm/cds/cds-conf.git 


cp -R /home/utibco/develop/cds-conf/src/LOCAL/bin/cdslocal/git_*  /home/utibco/sw/cds
chmod +x /home/utibco/sw/cds/*.sh


cd /home/utibco/sw/cds


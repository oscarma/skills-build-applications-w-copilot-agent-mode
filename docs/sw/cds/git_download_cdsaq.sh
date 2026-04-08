INIT_BASEDIR=$(dirname "$0")

BASE_BRANCH=master
BASE_DIR=/home/utibco/develop

cd  $BASE_DIR
git config --global credential.helper cache
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-rightsizing.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-das2server.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-datacontainer.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-datamessage.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-dmpsclient.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-dmpsserver.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-dsiserver.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-esiserver.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-logtraceserver.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/cds-sessionmanager.git
git clone http://repos.bancsabadell.com/bitbucket/scm/aqcds/vs-connector.git



cd $INIT_BASEDIR


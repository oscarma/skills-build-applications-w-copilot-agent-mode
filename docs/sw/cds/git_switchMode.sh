#!/bin/bash

LIB_DIR=/home/utibco/develop/cds-conf/src/LOCAL/
BASE_DIR=/app/cds/capa_prd/components/das2/lib

cd $BASE_DIR
#Rename el das2server actual
if [ ! -e ./das2server.jar_online ] 
then
  echo "Estamos en modo online. Vamos a hacer el cambio a offline"
  mv das2server.jar das2server.jar_online
  cp /home/utibco/develop/cds-conf/src/LOCAL/offlineMode/das2server.jar das2server.jar

  echo "Copiamos dummies a la carpeta repo"
  cp -r /home/utibco/develop/cds-conf/src/LOCAL/offlineMode/XML_REPO/* /app/cds/capa_prd/components/dsi/data/VS_FS_REPO/
fi
 
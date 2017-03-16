#!/bin/bash

#if [ "$1"x == x ]; then
#    echo "getVersion.sh {dc|campus|rgonc}"
#    exit
#fi

REMOTE_URL=http://192.168.5.14/ngcf/output/sdn_UI/SDN_NFV_web_UI/
wget -q ${REMOTE_URL} -O /tmp/514tmp
REMOTE_DIR=`cat /tmp/514tmp | grep "onc_UI" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
wget -q ${REMOTE_URL} -O /tmp/514tmp

FILE_NAME=`cat /tmp/514tmp | grep Web.tar.gz | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
REMOTE_URL=${REMOTE_URL}${FILE_NAME}

echo "get url ${REMOTE_URL}"

echo ${REMOTE_URL} > /root/rgonc_web_version

#echo "get url ${REMOTE_URL}"
#wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

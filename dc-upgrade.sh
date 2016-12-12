#!/bin/bash

REMOTE_URL=http://192.168.5.14/ngcf/output/sdn/SDN_NFV_onc_trunk_code/
wget -q ${REMOTE_URL} -O /tmp/514tmp
REMOTE_DIR=`cat /tmp/514tmp | grep "dc_1.0" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
wget -q ${REMOTE_URL} -O /tmp/514tmp

FILE_NAME=`cat /tmp/514tmp | grep Upgrade | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
REMOTE_URL=${REMOTE_URL}${FILE_NAME}

#echo "get url ${REMOTE_URL}"
wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

#!/bin/bash

if [ "$1"x == x ]; then
    echo "getVersion.sh {dc|campus|rgonc}"
    exit
fi

REMOTE_URL=http://192.168.5.14/ngcf/output/sdn/SDN_NFV_onc_trunk_code/
wget -q ${REMOTE_URL} -O /tmp/514tmp
REMOTE_DIR=`cat /tmp/514tmp | grep "$1" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
wget -q ${REMOTE_URL} -O /tmp/514tmp

FILE_NAME=`cat /tmp/514tmp | grep RG-ONC |grep -v Upgrade | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
REMOTE_URL=${REMOTE_URL}${FILE_NAME}

echo "get url ${REMOTE_URL}"

echo ${REMOTE_URL} > /root/"$1""_version"

#echo "get url ${REMOTE_URL}"
#wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

#!/bin/bash

#if [ "$1"x == x ]; then
#    echo "getVersion.sh {dc|campus|rgonc}"
#    exit
#fi

get_web_version() {
    REMOTE_URL=http://192.168.5.14/ngcf/output/sdn_UI/$1/
    wget -q ${REMOTE_URL} -O /tmp/514tmp
    REMOTE_DIR=`cat /tmp/514tmp | grep "onc_UI" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
    REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
    wget -q ${REMOTE_URL} -O /tmp/514tmp

    FILE_NAME=`cat /tmp/514tmp | grep Web.tar.gz | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
    REMOTE_URL=${REMOTE_URL}${FILE_NAME}

    echo "get url ${REMOTE_URL}"

    echo ${REMOTE_URL} > /root/"$2""_web_version"

    #echo "get url ${REMOTE_URL}"
    #wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

}

WEB_DIR=""
PROJECT=""
case  "$1"  in
    dc_1.1_tags)
        get_web_version RGONC-LS-DC-CLOUD $1
        ;;   

    campus_1.10)
        get_web_version RGONC-CAMPUS-CLOUD $1
        ;;

    rgonc_2.2.0)
        get_web_version SDN_NFV_web_UI $1
        ;;

    esac

get_web_version() {
    REMOTE_URL=http://192.168.5.14/ngcf/output/sdn_UI/$1/
    wget -q ${REMOTE_URL} -O /tmp/514tmp
    REMOTE_DIR=`cat /tmp/514tmp | grep "onc_UI" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
    REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
    wget -q ${REMOTE_URL} -O /tmp/514tmp

    FILE_NAME=`cat /tmp/514tmp | grep Web.tar.gz | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
    REMOTE_URL=${REMOTE_URL}${FILE_NAME}

    echo "get url ${REMOTE_URL}"

    echo ${REMOTE_URL} > /root/"$2""_web_version"

    #echo "get url ${REMOTE_URL}"
    #wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

}


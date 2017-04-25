#!/bin/bash

if [ "$1"x == x ]; then
    echo "getVersion.sh {dc|campus|rgonc}"
    exit
fi

timestamp=`date +%Y-%m-%d\ %H:%M:%S`
echo "[${timestamp}] get version $1" >> getversion.log

REMOTE_URL=http://192.168.5.14/ngcf/output/sdn/SDN_NFV_onc_trunk_code/
wget -q ${REMOTE_URL} -O /tmp/$1
REMOTE_DIR=`cat /tmp/$1 | grep "$1_[0-9]" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
wget -q ${REMOTE_URL} -O /tmp/$1

FILE_NAME=`cat /tmp/$1 | grep RG-ONC |grep -v Upgrade | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
if [[ x"${FILE_NAME}" = x"" ]]; then
    echo "[${timestamp}] get $1 version fileName failed" >> getversion.log
    exit
fi  

REMOTE_URL=${REMOTE_URL}${FILE_NAME}

echo "[${timestamp}] get url ${REMOTE_URL}" >> getversion.log

if [[ ${REMOTE_URL} =~ "tar.gz" ]]; then
    echo ${REMOTE_URL} > /root/"$1""_version"
else
   echo "[${timestamp}] get url ${REMOTE_URL} not contain tar.gz" >> getversion.log
   exit 
fi
#echo "get url ${REMOTE_URL}"
#wget ${REMOTE_URL} -O /tmp/${FILE_NAME}

#!/bin/bash

#if [ "$1"x == x ]; then
#    echo "getVersion.sh {dc|campus|rgonc}"
#    exit
#fi

get_web_version() {
    REMOTE_URL=http://192.168.5.14/ngcf/output/sdn_UI/$1/
    wget -q ${REMOTE_URL} -O /tmp/$1
    REMOTE_DIR=`cat /tmp/$1 | grep "onc_UI" | head -n 1 | awk -F 'href' '{print $2}' | awk -F '"' '{print $2}'`
    REMOTE_URL=${REMOTE_URL}${REMOTE_DIR}
    wget -q ${REMOTE_URL} -O /tmp/$1

    FILE_NAME=`cat /tmp/$1 | grep Web.tar.gz | awk -F 'href' '{print $2}' | awk -F '"'  '{print $2}'`
    if [[ x"${FILE_NAME}" = x"" ]]; then
        echo "get $1 web version error"
        exit
    fi
    REMOTE_URL=${REMOTE_URL}${FILE_NAME}

    echo "[${timestamp}] get web url ${REMOTE_URL}" >> getversion.log

    if [[ ${REMOTE_URL} =~ "tar.gz" ]]; then
        echo ${REMOTE_URL} > /root/"$2""_web_version"
    else
        echo "[${timestamp}] get web url ${REMOTE_URL} not contain tar.gz" >> getversion.log
        exit
    fi
}

case  "$1"  in
    dc_1.1_tags)
        get_web_version RGONC-LS-DC-CLOUD $1
        ;;   

    campus_1.10)
        get_web_version RGONC-CAMPUS-CLOUD $1
        ;;

    rgonc_2.2)
        get_web_version SDN_NFV_web_UI $1
        ;;

    esac


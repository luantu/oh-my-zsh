#!/bin/bash
#file_name: rg-deploy.sh

UPGRADE_PACKAGE="/root/odl_test/RG-ONC_2.1.0-Web.tar.gz"

export depoly_ip=`echo  $SSH_CONNECTION | awk '{print $3}'` 

# kill tomcat
export tomcatpid=`ps -ef | grep tomcat | grep -v grep | awk '{print $2}'` && \
[ -n "$tomcatpid" ] && \
kill -9 ${tomcatpid} && \
sleep 5

WEB_PROCESS_CNT=`ps -ef | grep tomcat | grep -v grep | wc -l`
if [ ${WEB_PROCESS_CNT} -eq 0 ]; then
    echo "stop tomcat success... "
fi

#if [ ! -f "${UPGRADE_PACKAGE}" ]; then  
    # download tar.gz
#    read -p "Enter web.tar.gz url:" weburl 
#    CURRENTDIR=${PWD}
#    cd /root/odl_test/ && wget ${weburl}
#fi

WEB_URL=`cat /root/rgonc_web_version`
cd /root/odl_test/ && wget ${WEB_URL}

# upgrade
echo "upgrade new version ... "
rm -rf /root/odl_test/web/ && \
tar -xf /root/odl_test/RG-ONC_2.2.0-Web.tar.gz && \
mv /root/odl_test/RG-ONC_2.2.0-Web /root/odl_test/web && \
rm /root/odl_test/RG-ONC_2.2.0-Web.tar.gz && \
chmod +x /root/odl_test/web/bin/* && ./web/bin/startFirst.sh ${depoly_ip} && /root/odl_test/web/bin/https.sh ${depoly_ip}

# start tomcat
/root/odl_test/web/bin/startup.sh


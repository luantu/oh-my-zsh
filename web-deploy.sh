#!/bin/bash
#file_name: rg-deploy.sh

export depoly_ip=`echo  $SSH_CONNECTION | awk '{print $3}'` 

# kill tomcat
export tomcatpid=`ps -ef | grep tomcat | grep -v grep | awk '{print $2}'` && \
[ -n "$tomcatpid" ] && \
kill -9 ${tomcatpid} && \
sleep 5 &&  \
ps -ef | grep tomcat | grep -v grep

# download tar.gz
read -p "Enter web.tar.gz url:" weburl 
CURRENTDIR=${PWD}
cd /root/odl_test/ && wget ${weburl}

# upgrade
rm -rf /root/odl_test/web/ && \
tar -xf /root/odl_test/RG-ONC_2.1.0-Web.tar.gz && \
mv /root/odl_test/RG-ONC_2.1.0-Web /root/odl_test/web && \
rm /root/odl_test/RG-ONC_2.1.0-Web.tar.gz && \
chmod +x /root/odl_test/web/bin/* && ./web/bin/startFirst.sh ${depoly_ip} && /root/odl_test/web/bin/https.sh ${depoly_ip}

# start tomcat
/root/odl_test/web/bin/startup.sh


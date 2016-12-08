#!/bin/bash
#file_name: rg-deploy.sh

export depoly_ip=`echo  $SSH_CONNECTION | awk '{print $3}'` 
expect -c " 
spawn scp root@192.168.23.61:/home/wangxiaoyang/code/rg-deploy/org.ops4j.pax.logging.cfg ./etc/org.ops4j.pax.logging.cfg
expect \"password:\"
send \"wangxiaoyang\r\"
expect eof
"

expect -c " 
spawn scp root@192.168.23.61:/home/wangxiaoyang/code/rg-deploy/rg-deploy-${depoly_ip}.json ./etc/rg-deploy.json
expect \"password:\"
send \"wangxiaoyang\r\"
expect eof
"
chmod +x ./bin/* && ./bin/rg-deploy && ./bin/run start


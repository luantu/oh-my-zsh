#!/bin/bash

SAMBA_INSTALL=`dpkg -l | grep samba | wc -l`
if [ ${SAMBA_INSTALL} -eq 0 ] then
    sudo apt-get install -y samba
    sudo apt-get install -y cifs-utils
    
    sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
    scp root@192.168.23.61:/etc/samba/smb.conf /etc/samba/smb.conf
    sudo touch /etc/samba/smbpasswd
    sudo smbpasswd -a root
    service smbd restart
else 
    echo "samba already installed."
    exit 0
fi


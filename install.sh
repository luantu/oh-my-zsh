#!/bin/bash

IS_ZSH_INSTALL=`dpkg -l | grep zsh | wc -l`
CURRENT_SHELL=`ps | grep $$ | awk '{print $4}'`

if [ ${IS_ZSH_INSTALL} -eq 0 ]; then
    echo "zsh not install..."
    apt-get install zsh
fi

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

chsh -s /bin/zsh


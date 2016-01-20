#!/bin/bash
#enter
#passwd  #ROOT
#useradd -m -G users ucb
#passwd ucb
#su - ucb   
/etc/init.d/sshd start  #4
ifconfig                #5
sleep 3
ping -c 3 www.baidu.com # 6
# cfdisk                #7

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
#sda1- boot:1GiB   #sda2- swap:1GiB  #sda3- /:28GiB   #total：30Gib
## Format and activate  partition：
#mkfs.ext4 /dev/sda1    #8
#mkfs.ext4 /dev/sda3
#mkswap /dev/sda2       #9
#swapon /dev/sda2
mount /dev/sda3 /mnt/gentoo        #10
mkdir /mnt/gentoo/boot              #10
mount /dev/sda1 /mnt/gentoo/boot    #10
# date MMDDhhmmYYYY     #11  set time.
# cd /mnt/gentoo        #12
links http://www.gentoo.org/main/en/mirrors.xml # 13  download the stage3
#tar xvjpf stage3-*.tar.bz2     #14
cd /mnt/gentoo                  #15
links http://www.gentoo.org/main/en/mirrors.xml #16
tar xvjf /mnt/gentoo/portage-lastest.tar.bz2 -C /mnt/gentoo/usr    #17








#!/bin/bash

0，Get the liveCD from the 163 mirrors
http://mirrors.163.com/gentoo/releases/amd64
1, gentooo dopcmcia
2，config the network.
# ifconig    //check the network and remember the netcard name.
# ifconfig eth0 192.168.1.100/24  
# route add default gw 192.168.1.1  
# echo "nameserver 202.96.128.86" >> /etc/resolv.conf 
# ping www.baidu.com  

3,set the root pw.
# passwd   
# useradd -m -G users ucb
# passwd ucb
3.5 boot the ssh server
# /etc/init.d/sshd start   


4，XShell

5，partition the SSD.(fdisk)
# fdisk -l 
# fdisk /dev/sda  
sda1 : n,p,1,enter,+1gib
sda2 : n,p,2,enter,+2gib  
sda3 : n,p,3,enter,enter    
sda1-boot:：a,1
sda2-swap: t,2,82
w to save the config.

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      411647      204800   83  Linux
/dev/sda2          411648     4605951     2097152   82  Linux swap / Solaris
/dev/sda3         4605952    20971519     8182784   83  Linux
# partprobe //reset the partition

6，Format -- MKFS.ext
# mkfs.ext2 /dev/sda1
# mkfs.ext4 /dev/sda3
# mkswap /dev/sda2   
# swapon /dev/sda2    

7，create the mount point of the system.  
# mount /dev/sda3 /mnt/gentoo   
# mkdir /mnt/gentoo/boot
# mount /dev/sda1 /mnt/gentoo/boot 

7.5, date MMDDhhmmYYYY

8，download the package.
# cd /mnt/gentoo  
# wget http://mirrors.163.com/gentoo/releases/x86/current-iso/stage3-i486-20140211.tar.bz2  
# wget http://mirrors.163.com/gentoo/snapshots/portage-20140213.tar.bz2  
# tar -xjf stage3-i486-20140211.tar.bz2  
# tar -xjf portage-20140213.tar.bz2 -C /mnt/gentoo/usr  
8，Compiler options ：
# vi /mnt/gentoo/etc/portage/make.conf

CFLAGS="-O2 -march=native -pipe"
CXXFLAGS="${CFLAGS}"                 
MAKEOPTS="-j9"

9，set the mirrors.
# mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf    
# mirrorselect -i -r -o >> /mnt/gentoo/etc/portage/make.conf  
10，Copy the DNS.
# cp -L /etc/resolv.conf /mnt/gentoo/etc/

11，Mount system for the special district
# mount -t proc proc /mnt/gentoo/proc
# mount --rbind /sys /mnt/gentoo/sys
# mount --make-rslave /mnt/gentoo/sys
# mount --rbind /dev /mnt/gentoo/dev  
# mount --make-rslave /mnt/gentoo/dev     

12，Switch to the new system and update the environment variable
# chroot /mnt/gentoo /bin/bash    //chroot to new system
# env-update
# source /etc/profile            //exec new profile env
# export PS1="(chroot) $PS1"    // Update terminal command prompt
13，update the Portage tree
# emerge --sync
14，reset system profile
# eselect profile list  
# eselect profile set 3 

15，set the timezone
# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

15.1 , USE  

15.2 , nano -w /etc/locale.gen
en_US.UTF-8 UTF-8

locale-gen

16，Compiling kernel
# emerge gentoo-sources //install kernel sources
#ls -l /usr/src/linux
# emerge genkernel //Install auto configuration tool
# genkernel all   //Automatic compilation
# ls /boot/kernel* /boot/initramfs* // Compiler complete view of the generated kernel and initrd's name.
17，Install vim
# emerge vim
18，Configuration fstab, the final content is as follows
/dev/sda1		/boot		ext2		defaults,noatime	1 2
/dev/sda2		none		swap		sw		            0 0
/dev/sda3		/		    ext4		noatime		        0 1
/dev/cdrom		/mnt/cdrom	auto		noauto,user	        0 0

18.1  set the hostname
   nano -w /etc/conf.d/hostname
   HOSTNAME="ucb"
   
19，config the network.
# vim /etc/conf.d/net   //content is as follows
config_eth0="192.168.1.100 netmask 255.255.255.0 brd 192.168.1.255"
route_eth0="default via 192.168.1.1"
# ln -s /etc/init.d/net.lo /etc/init.d/net.eth0  
20，start the machine and load the eth0.
# rc-update add net.eth0 default
21，Configure SSH service and boot in start the machine.
# rc-update add sshd dafault
22，Serial console:  environment configuration
# vim /etc/inittab //content is as follows
s0:12345:respawn:/sbin/agetty 9600 ttyS0 vt100
s1:12345:respawn:/sbin/agetty 9600 ttyS1 vt100
22 ,Set the new system root's pw.
# passwd root

23,Install some of the commonly used services, skip this step can be put in the future
# emerge syslog-ng  
# rc-update add syslog-ng default   
# emerge logrotate 
# emerge vixie-cron  
# rc-update add vixie-cron default  
# echo "export EDITOR='/usr/bin/vim'" >> /etc/profile  

23.5 emerge dhcpcd 

24，Install grub:
# emerge sys-boot/grub  
# grub2-install /dev/sda          //install the grub2 to the MBR in SSD.
# grub2-mkconfig -o /boot/grub/grub.cfg          //Automatically generated grub.cfg configuration file
# eit

25，OK
# reboot 
# ===============================================================================
# ===============================================================================
# ===============================================================================






26，USE ： /usr/portage/profiles/use.desc          // look 15.1
    example:   USE="bindist mmx sse sse2 X dbus pcmcia wifi usb unicode dri udev m17n-lib"
    emerge xorg-x11
    
27，bianyi file：  /etc/portage/make.conf 
     

28，/usr/portage/package.use/iputils
       http://tieba.baidu.com/p/2513669438
  
29, https://wiki.gentoo.org/wiki/Xfce

http://wenku.baidu.com/link?url=AWK-6hB_UVueRe5rfUOxJd1vO0Ss_l_i6hS2IWLV_ZVkmq3uKcY3Abw6NY8_HoyQAyWchAHVRaYogbw6wvT4ShGEV61FdRRpTCl-KUrTIFm


30，config gentoo netcard.(eth0 is your network card's name)
# cd /etc/init.d
# ln -s net.lo net.eth0
# /etc/init.d/net.eth start
# /etc/init.d/net.eth stop


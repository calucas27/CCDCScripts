#!/bin/bash
#Script to install important security programs on a box.
#Run as root or with sudo privelages.

#install and configure firejail
echo -e "Installing Firejail!"
apt-get install -y firejail
mkdir -p ~/.config/firejail
cp /etc/firejail/generic.profile ~/.config/firejail/generic.profile
echo -e "Firejail installed successfully!"

#install and configure ossec
echo -e "Installing ossec!"
apt-get update
apt-get install -y build-essential inotify-tools
wget -U ossec http://www.ossec.net/files/ossec-hids-2.8.1.tar.gz
tar -zxf ossec-hids-2.8.1.tar.gz
ossec-hids-2.8.1.tar.gz/install.sh
echo -e "Starting ossec!"
/var/ossec/bin/ossec-control start
echo -e "Note: Manual configuration of /var/ossec/rules required!"


#install and configure ntop
echo -e "Installing ntop!"
apt-get install -y ntop
ntop
service ntop start
echo -e "ntop installed successfully!" 

#install and configure fail2ban
apt-get install -y fail2ban
echo -e "fail2ban installed successfully!"



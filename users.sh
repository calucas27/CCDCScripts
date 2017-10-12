#!/bin/bash

#Short script to lock down user accounts, except for the root account.
#Run with sudo or as root.

users="$(awk -F: '$7 == "/bin/bash" { print $1 }' /etc/passwd | grep -v root)"

#lock all user accounts except for root
echo -e "Locking user accounts!"
for user in $users
do
	passwd -l $user
done

#add new user account and group them
echo -e "Adding backup admin account!"
useradd ccdcadmin
usermod -aG sudo ccdcadmin

#purge ssh keys
rm -rf $HOME/.ssh/authorized_keys

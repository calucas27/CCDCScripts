#!/bin/bash

#Short script to lock down user accounts, except for the root account.
#Run with sudo or as root.

#add new user account and group them
echo -e "Adding backup admin account!"
useradd ccdcadmin
usermod -aG sudo ccdcadmin

users="$(cat /etc/passwd | grep /bin/bash | cut -d : -f 1 | grep -v root | grep -v ccdcadmin)"

#deny login for all accounts except for root and ccdcadmin
echo -e "Locking user accounts!"
for user in $users
do
    usermod -s /bin/false $user
done

#purge ssh keys
rm -rf $HOME/.ssh/authorized_keys

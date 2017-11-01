#!/bin/bash

#Kicks all users connected from the system except for root.
#Run this script with sudo privelages or as root.
#Note: If you are logged in as another user besides root, you will be disconnected.

users="$(cut -d : -f 1 /etc/passwd | grep -v root)"
i=1

echo -e "Kicking all connected users!"

sleep 2

for user in $users
do
	echo -e "Get off my lawn!" | write $user | clear
	skill -KILL -u $user
done

clear

echo -e "Here comes the new user listing..."
who -la

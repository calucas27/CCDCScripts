#!/bin/bash

#This is a script for finding (and killing) Meterpreter shells running on the default port (4444)
#Note: This script will not work if the shells are running on a port other than 4444.
#Run this script as root, or with sudo privelages.

while true
do
	output=$(lsof -t -i:4444)

	if [ -z "$output" ]
	then
		echo "No processes found on default Meterpreter port, exiting!"
		break #output is empty, no shells found -- break the loop
	else
		kill -9 $(lsof -t -i:4444) #output is NOT empty, kill all shells on 4444
	fi

done

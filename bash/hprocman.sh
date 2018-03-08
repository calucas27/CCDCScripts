#Hadriel: The CCDC Swiss Army Knife
#By: Chase Lucas

#Section 2: Process and Service Management

if [[ $1 == "-proc" ]]
then
	echo $1 $2
		echo "Getting processes for $2..."
		echo "(n)etstat -pant view or (p)s -auxf view? "
		read choice
		if [[ $choice == "n" ]]
		then
			netstat -pant | grep $2 | grep -v grep
		fi

		 if [[ $choice == "p" ]]
		then
			ps -auxf | grep $2 | grep -v grep
		fi
fi
if [[ $1 == "-netproc" ]]
then
    echo $1 $2
    echo "Getting network processes for user $2"
    lsof -i | grep $2
fi
if [[ $1 == "-srvrunning" ]]
then
    echo "Checking running services..."
    service --status-all | grep "[+]"
fi
if [[ $1 == "-srvdisabled" ]]
then
    echo "Checking disabled/non-running services..."
    service --status-all | grep -v "[+]"
fi

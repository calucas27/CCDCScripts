#Hadriel: The CCDC Swiss Army Knife
#By: Chase Lucas

#Section 1: User and Password Management
if [[ $1 == "-chpasswd" ]]
then
        echo "Enter password for $2 : "
        read -s newpasswd
        echo "$2:$newpasswd" | chpasswd
        echo "Changed password!"
fi

if [[ $1 == "-batchpw" ]]
then
        echo "Enter master password: "
        read -s newpasswd
        users=$(cat /etc/passwd | grep /bin/bash | grep -v root | cut -d ":" -f1)
        echo $users
        for user in $users
        do
                echo "$user:$newpasswd" | chpasswd
                echo "Changed passwords in batch mode!"
        done
fi

if [[ $1 == "-pwfile" ]]
then
	cat $2
	echo "Loaded passwords from file $2."
fi

if [[ $1 == "-remotepw" ]]  #issues with this - no https so red team can sniff traffic (mitigate with apache tls on server)
then    #check to see if wget works with basic auth, don't want them crawling my site for creds either.
        echo "Connecting to remote password storage: "
        wget "http://chaselucas.cf/projects/passwords.hd"
        for user in `cat passwords.hd`
        do
            echo "$user"
        done
        echo "Successful!  Removing local password storage."
        rm "passwords.hd"   #shred this file for maximum effect
fi

if [[ $1 == "-pwgen" ]]
then
        if [ -e "genpass.hd" ]
        then
            echo "Removed pre-existing password file."
            rm "genpass.hd"
        fi
        apt-get install -y wamerican-large > /dev/null
        echo "Generating passwords..."
        users=$(cat /etc/passwd | grep /bin/bash | grep -v root | cut -d ":" -f1)
        for user in $users
        do
            password=$(shuf -n 3 /usr/share/dict/american-english-large | sed 's/./\u&/' | tr -cd '[A-Za-z]'; echo $(shuf -i0-999 -n 1))
            echo "$user:$password" >> genpass.hd
        done
        echo "Written new user/pass file to genpass.hd"
fi

if [[ $1 == "-lock" ]]
then
        echo "Are you sure you want to lock account $2?  y/n"
        read choice
        if [[ $choice == "y" ]]
        then
            echo "passwd -l $2"
        fi
        else
            exit
fi
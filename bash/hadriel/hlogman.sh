#Hadriel: The CCDC Swiss Army Knife
#By: Chase Lucas

#Section 3: Log Management

if [[ $1 == "-auth" ]]
then
        echo "Checking /var/log/auth.log for $2 services"
        tail /var/log/auth.log | grep $2
fi

if [[ $1 == "-f2b" ]]
then
    echo "Checking /var/log/fail2ban.log"
    tail /var/log/fail2ban.log

    if [[ $2 == "-blocklist" ]]
    then
        echo "Most common blocked IPs: "
        cat /var/log/fail2ban.log | cut -d " " -f19 | grep -v -e '^$' | uniq -c | sort | tail -n 10
    fi
fi

if [[ $1 == "-apache" ]]
then
    echo "Checking for entry $2 in /var/log/apache2/access.log..."
    for entry in `cat /var/log/apache2/access.log | cut -d " " -f7 | grep $2 | sort`
    do
        cat /var/log/apache2/access.log | grep $entry | sort | uniq -c 
    done
fi

if [[ $1 == "-syslog" ]]
then
    echo "Checking for entry $2 in /var/log/syslog..."
    cat /var/log/syslog | grep $2 | tail -n 10 | sort
fi

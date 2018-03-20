echo "Flushing all chains"
iptables -F

echo "Setting default policy to DROP"
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -P INPUT DROP

echo "Allowing anything marked RELATED/ESTABLISHED"
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "ACCEPT incoming RELATED/ESTABLISHED"
iptables -A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "ACCEPT outgoing RELATED/ESTABLISHED"

echo "Allowing everything on loopback"
iptables -A INPUT -s 127.0.0.1 -j ACCEPT -m comment --comment "ACCEPT all incoming on loopback"
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT -m comment --comment "ACCEPT all outgoing on loopback"

echo "Dropping anything marked INVALID"
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP -m comment --comment "REJECT anything marked INVALID"

#echo "Allowing ping"
#iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming ping request"
#iptables -A OUTPUT -p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT -m comment --comment "ACCEPT outgoing ping reply"

echo "Allowing services"

    #echo " - ssh       (IN/OUT)"
    #iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming ssh"
    #iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT outgoing ssh"

    #echo " - smtp      (IN/OUT)"
    #iptables -A INPUT -p tcp --dport 25 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming smtp"
    #iptables -A OUTPUT -p tcp --dport 25 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT outgoing smtp"

    #echo " - dns       (OUT)"
    #iptables -A OUTPUT -p udp --dport 53 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT outgoing dns"

    #echo " - http      (IN/OUT)"
    #iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming http"
    #iptables -A OUTPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT outgoing http"

    #echo " - https     (IN/OUT)"
    #iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming https"
    #iptables -A OUTPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT outgoing https"

    #echo " - imap      (IN)"
    #iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming imap"

    
    #echo " - ssl-smtp  (IN)"
    #iptables -A INPUT -p tcp --dport 587 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming smtps"

    #echo " - ssl-imap  (IN)"
    #iptables -A INPUT -p tcp --dport 993 -m conntrack --ctstate NEW -j ACCEPT -m comment --comment "ACCEPT incoming imaps"

echo "Gracefully rejecting everything else"
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable -m comment --comment "Graceful UDP REJECTs"
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst -m comment --comment "Graceful TCP REJECTst"
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable -m comment --comment "Graceful UNKNOWN REJECTs"

echo "Saving configuration"```

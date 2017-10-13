# ccdcscripts
Collection of scripts for hardening systems in a CCDC-style competition.

users.sh
Creates a backup user account on the system, modifies the default shell to be /bin/false for non-admin accounts, and deletes any SSH keys  stored under ~/.ssh/authorized_keys

installtools.sh
Installs several important security auditing tools (firejail, ossec, ntop fail2ban)

iptables.sh
Enforces a set of iptables rules.

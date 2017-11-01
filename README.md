# ccdcscripts
Simple collection of scripts for securing systems in a CCDC-style competition.

| Script | Description |
| --- | --- |
| users.sh | Creates a backup user account on the system, modifies the default shell to be /bin/false for non-admin accounts, and deletes any SSH keys  stored under *~/.ssh/authorized_keys* |
| installtools.sh | Installs several important security auditing tools **(firejail, ossec, ntop fail2ban)** |
| iptables.sh | Enforces a set of iptables rules.  *Can be customized prior to running.* |
| killusers.sh | Kills all connected users on the system *except* root. |
| whiterabbit.sh | Searches the system for Meterpreter shells running on the default port 4444, and attempts to kill them.  Note: If the shells are on a non-default port, this script *will not* find them. |

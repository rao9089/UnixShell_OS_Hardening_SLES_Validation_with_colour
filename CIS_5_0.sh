#---------------------Begin of CIS 5.0----------------------------#

# CIS 5.0  Access, Authentication and Authorization
#
#

#! /bin/bash

export DATE=`date +%d-%m-%Y`
export TIME=`date +%H:%M:%S`

## Define some functions and/or variables used for logging output
export LOGERR="Date:$DATE || Time: $TIME || ERR:"

function check_exitstatus {
        if [ $? -ne 0 ] ; then
                echo "${LOGERR} execution of command failed" >>/var/log/cis_5_0.log
                exit 1
        fi
}

# Whether script has already been implemented
# if [ -e /var/local/ccc-hardened ] ; then
#  echo "script has already been implemented (/var/local/ccc-hardened exist)"
#  exit 0
# fi
if [ -e /var/log/cis_5_0.log ] ; then
 rm /var/log/cis_5_0.log
check_exitstatus
fi


if [ -e /var/log/cis_5_0_status.html ] ; then
 rm /var/log/cis_5_0_status.html
check_exitstatus
fi

if [ -e /var/local/CIS_5_0-hardened ]
then
  echo -e "\n CIS_5_0-hardened script has already been implemented \n"
  exit 0
fi

echo -e " <span style='color: blue;'>\n--------------------------CIS 5.0 Access, Authentication and Authorization---------------------------------------------------------------------------</p>\n" >>/var/log/cis_5_0_status.html
# -------------------------------------------Begin CIS 5.1 ------------------------------------------------------------------

# 5.1.1 Ensure cron daemon is enabled and running
# Run the following command to verify cron  is enabled and running:
if [[ $(systemctl is-enabled cron) != "enabled" ]] ; then
echo -e "<p style='color: red;'>CIS 5.1.1 cron daemon is not enabled </p>" >> /var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.1 corn daemon is already  enabled </p>" >> /var/log/cis_5_0_status.html
fi
# 5.1.2 Ensure permissions on /etc/crontab are configured
#chown root:root /etc/crontab
#chmod u-x,og-rwx /etc/crontab
if [[ $(stat -c  "%a" /etc/crontab) != 600 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.2 permission for /etc/crontab not  set to 600 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.2 permission for /etc/crontab correctly   set to 600 </p>" >>/var/log/cis_5_0_status.html
fi

if [[ $(stat -c  "%U" /etc/crontab) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.2 Ownership for /etc/crontab not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.2 Ownership for /etc/crontab correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/crontab) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.2 Group for /etc/crontab not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.2 Group for /etc/crontab correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi
# 5.1.3 Ensure permissions on /etc/cron.hourly are configured
#chown root:root /etc/cron.hourly
#chmod og-rwx /etc/cron.hourly
if [[ $(stat -c  "%a" /etc/cron.hourly) != 700 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.3 permission for /etc/cron.hourly not  set to 700 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.3 permission for /etc/cron.hourly correctly   set to 700 </p>" >>/var/log/cis_5_0_status.html
fi

if [[ $(stat -c  "%U" /etc/cron.hourly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.3 Ownership for /etc/cron.hourly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.3 Ownership for /etc/cron.hourly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.hourly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.3 Group for /etc/cron.hourly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.3 Group for /etc/cron.hourly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
# 5.1.4 Ensure permissions on /etc/cron.daily are configured
#chown root:root /etc/cron.daily
#chmod og-rwx /etc/cron.daily

if [[ $(stat -c  "%a" /etc/cron.daily) != 700 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.4 permission for /etc/cron.daily not  set to 700 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.4 permission for /etc/cron.daily correctly   set to 700 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/cron.daily) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.4 Ownership for /etc/cron.daily not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.4 Ownership for /etc/cron.daily correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.daily) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.4 Group for /etc/cron.daily not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.4 Group for /etc/cron.daily correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
# 5.1.5 Ensure permissions on /etc/cron.weekly are configured
#chown root:root /etc/cron.weekly/
#chmod og-rwx /etc/cron.weekly/
if [[ $(stat -c  "%a" /etc/cron.weekly) != 700 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.5 permission for /etc/cron.weekly not  set to 700 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.5 permission for /etc/cron.weekly correctly   set to 700 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/cron.weekly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.5 Ownership for /etc/cron.weekly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.5 Ownership for /etc/cron.weekly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.weekly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.5 Group for /etc/cron.weekly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.5 Group for /etc/cron.weekly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi


# 5.1.6 Ensure permissions on /etc/cron.monthly are configured
#chown root:root /etc/cron.monthly
#chmod og-rwx /etc/cron.monthly
if [[ $(stat -c  "%a" /etc/cron.monthly) != 700 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.6 permission for /etc/cron.monthly not  set to 700 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.6 permission for /etc/cron.monthly correctly   set to 700 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/cron.weekly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.6 Ownership for /etc/cron.monthly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.6 Ownership for /etc/cron.monthly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.weekly) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.6 Group for /etc/cron.monthly not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.6 Group for /etc/cron.monthly correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi

# 5.1.7 Ensure permissions on /etc/cron.d are configured
#chown root:root /etc/cron.d
#chmod og-rwx /etc/cron.d
if [[ $(stat -c  "%a" /etc/cron.d) != 700 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.7 permission for /etc/cron.d not  set to 700 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.7 permission for /etc/cron.d correctly   set to 700 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/cron.d) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.7 Ownership for /etc/cron.d not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.7 Ownership for /etc/cron.d correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.d) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.7 Group for /etc/cron.d not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.7 Group for /etc/cron.d correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi

# 5.1.8 Ensure cron is restricted to authorized users
if [  -f /etc/cron.deny ] ; then
echo -e "<p style='color: red;'>CIS 5.1.8 filename  /etc/cron.deny  already present </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.8 filename  /etc/cron.deny  not  present </p>" >>/var/log/cis_5_0_status.html
fi

if [   -f /etc/cron.allow ] ; then
if [[ $(stat -c  "%a" /etc/cron.allow) != 600 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.8 permission for /etc/cron.allow not  set to 600 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.8 permission for /etc/cron.d correctly   set to 600 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/cron.allow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.8 Ownership for /etc/cron.allow not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.8 Ownership for /etc/cron.allow correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/cron.allow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.8 Group for /etc/cron.allow not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.8 Group for /etc/cron.allow correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
else
echo -e "<p style='color: red;'>CIS 5.1.8 filename  /etc/cron.allow  not present </p>" >>/var/log/cis_5_0_status.html
fi


#chown root:root /etc/cron.allow /etc/cron.deny
#chmod u-x,og-rwx /etc/cron.allow /etc/cron.deny

# 5.1.9 Ensure at is restricted to authorized users
#if [ ! -f /etc/at.allow ] ; then
#touch /etc/at.allow
#check_exitstatus
#fi

if [  -f /etc/at.deny ] ; then
echo -e "<p style='color: red;'>CIS 5.1.9 filename  /etc/at.deny  already present </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.9 filename  /etc/at.deny  not  present </p>" >>/var/log/cis_5_0_status.html
fi
if [   -f /etc/at.allow ] ; then
if [[ $(stat -c  "%a" /etc/at.allow) != 600 ]]; then
echo -e "<p style='color: red;'>CIS 5.1.9 permission for /etc/at.allow not  set to 600 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.9 permission for /etc/at.allow correctly   set to 600 </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%U" /etc/at.allow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.9 Ownership for /etc/at.allow not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.9 Ownership for /etc/at.allow correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
if [[ $(stat -c  "%G" /etc/at.allow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.1.9 Group for /etc/at.allow not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.1.9 Group for /etc/at.allow correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi
else
echo -e "<p style='color: red;'>CIS 5.1.9 filename  /etc/at.allow  not present </p>" >>/var/log/cis_5_0_status.html
fi
#chown root:root /etc/at.allow /etc/at.deny
#chmod u-x,og-rwx /etc/at.allow /etc/at.deny
# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured
stat -c "%n" /etc/ssh/sshd_config 2>&1 > /dev/null
if  [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.2.1 filename  /etc/ssh/sshd_config  not  present </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.1 filename  /etc/ssh/sshd_config  already  present </p>" >>/var/log/cis_5_0_status.html
fi

if [[ $(stat -c  "%a" /etc/ssh/sshd_config) != 600 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.1 permission for /etc/ssh/sshd_config not  set to 600 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.1 permission for /etc/ssh/sshd_config correctly   set to 600 </p>" >>/var/log/cis_5_0_status.html
fi

if [[ $(stat -c  "%U" /etc/ssh/sshd_config) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.1 Ownership for /etc/ssh/sshd_config not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.1 Ownership for /etc/ssh/sshd_config correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi

if [[ $(stat -c  "%G" /etc/ssh/sshd_config) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.1 Group for /etc/ssh/sshd_config not  set to "root" </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.1 Group for /etc/ssh/sshd_config correctly   set to "root" </p>" >>/var/log/cis_5_0_status.html
fi

# 5.2.2 Ensure permissions on SSH private host key files are configured
# Run the following commands to set permissions, ownership, and group on the private SSH host key files:
#find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chmod u-x,g-wx,o-rwx {} \;
#find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chown root:root {} \;
#find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chmod u-x,g-wx,o-rwx {} \;
#find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chown root:root {} \;
# 5.2.4  Ensure SSH access is limited
privperm=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -c "%a"  {} \;)
if [[ $(echo $privperm|cut -f1 -d" ") != 600 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.2 permission for  /etc/ssh/ssh_host_*_key private key files not  set to 600 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.2 permission for /etc/ssh/ssh_host_*_key private key  files correctly   set to 600 </p>" >>/var/log/cis_5_0_status.html
fi

privroot=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -c "%U"  {} \;)
if [[ $(echo $privroot|cut -f1 -d" ") != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.2 Ownership for  /etc/ssh/ssh_host_*_key private key files not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.2 Ownership for /etc/ssh/ssh_host_*_key private key files correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi

privgroup=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat -c "%G"  {} \;)
if [[ $(echo $privgroup|cut -f1 -d" ") != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.2 Group for  /etc/ssh/ssh_host_*_key private key files not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.2 Group for /etc/ssh/ssh_host_*_key private key files correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi

# 5.2.3 Ensure permissions on SSH public host key files are configured

pubperm=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat -c "%a"  {} \;)
if [[ $(echo $pubperm|cut -f1 -d" ") != 644 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.3 permissions for  /etc/ssh/ssh_host_*_key.pub public key files not  set to 644 </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.3 permissions for /etc/ssh/ssh_host_*_key.pub publicfiles correctly   set to 644 </p>" >>/var/log/cis_5_0_status.html
fi

pubroot=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat -c "%U"  {} \;)
if [[ $(echo $pubroot|cut -f1 -d" ") != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.3 Ownership for  /etc/ssh/ssh_host_*_key.pub private key files not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.3 Ownership for /etc/ssh/ssh_host_*_key.pub private key files correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi

pubgroup=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat -c "%U"  {} \;)
if [[ $(echo $pubgroup|cut -f1 -d" ") != "root" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.3 Group for  /etc/ssh/ssh_host_*_key.pub private key files not  set to root </p>" >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.3 Group for /etc/ssh/ssh_host_*_key.pub private key files correctly   set to root </p>" >>/var/log/cis_5_0_status.html
fi

# 5.2.4 Ensure SSH access is limited
sshd -T | grep -E '^\s*(allow|deny)(users|groups)\s+\S+' 2>&1 > /dev/null
if [ $? -ne 0 ]; then
echo -e "<p style='color: red;'>CIS 5.2.4 SSH Access is not limited </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.4 SSH Access is secured and limited </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.5 Ensure SSH LogLevel is appropriate

if [[ $(grep "#LogLevel" /etc/ssh/sshd_config) != 'LogLevel INFO'  ]]; then
echo -e "<p style='color: red;'>CIS 5.2.5 SSH loglevel is not set to 'LogLevel INFO'  </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.5 SSH loglevel is set to 'LogLevel INFO' </p>"  >>/var/log/cis_5_0_status.html
fi


# 5.2.6 Ensure SSH X11 forwarding is disabled

if [[ $(grep "X11Forwarding" /etc/ssh/sshd_config|cut -f2 -d' ') == 'yes'  ]]; then
echo -e "<p style='color: red;'>CIS 5.2.6 SSH X11 forwarding is not disabled  </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.6 SSH  X11 forwarding is already disabled </p>"  >>/var/log/cis_5_0_status.html
fi


# 5.2.7 Ensure SSH MaxAuthTries is set to 4 or less
if [[ $(grep "MaxAuthTries" /etc/ssh/sshd_config|cut -f2 -d' ') != 4 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.7 SSH 'MaxAuthTries' is not set to 4 </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.7 SSH  X11 'MaxAuthTriesg' is already set to 4  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.8 Ensure SSH IgnoreRhosts is enabled
grep "IgnoreRhosts yes" /etc/ssh/sshd_config > /dev/null 2>&1
if [[ $(grep -E "^\s*IgnoreRhosts" /etc/ssh/sshd_config|cut -f2 -d" ") != "yes" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.8 SSH 'IgnoreRhosts' is not set to yes i.e. not enabled   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.8 SSH  X11 'IgnoreRhosts' is already set to yes i.e. enabled  </p>"  >>/var/log/cis_5_0_status.html

fi

# 5.2.9 Ensure SSH HostbasedAuthentication is disabled
if [[ $(grep -E  "^\s*HostbasedAuthentication" /etc/ssh/sshd_config|cut -f2 -d" ") != no ]]; then
echo -e "<p style='color: red;'>CIS 5.2.9 SSH 'HostbasedAuthentication' is not set to no i.e. not disabled   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.9 SSH  X11 'HostbasedAuthentication' is already set to no i.e. disabled  </p>"  >>/var/log/cis_5_0_status.html

fi

# 5.2.10 Ensure SSH root login is disabled
if [[ $(grep "PermitRootLogin" /etc/ssh/sshd_config|cut -f2 -d' ') != 'no'  ]]; then
echo -e "<p style='color: red;'>CIS 5.2.10 SSH root login was not set to  'no' i.e. not disabled   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.10 SSH root login  is already set to 'no' i.e. disabled  </p>"  >>/var/log/cis_5_0_status.html

fi

# 5.2.11 Ensure SSH PermitEmptyPasswords is disabled
if [[ $(grep -E "^\s*PermitEmptyPasswords" /etc/ssh/sshd_config|cut -f2 -d" ") != "no" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.11 SSH PermitEmptyPassword was not set to 'no' i.e. not disabled   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.11 SSH PermitEmptyPassword is already set to 'no' i.e. disabled  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.12 Ensure SSH PermitUserEnvironment is disabled
if [[ $(grep -E "^\s*PermitUserEnvironment" /etc/ssh/sshd_config|cut -f2 -d" ") != "no" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.12 SSH PermitUserEnvironment was not set to 'no' i.e. not disabled   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.12 SSH PermitUserEnvironment is already set to 'no' i.e. disabled  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.13 Ensure only strong Ciphers are used
echo -e  "<p style='color: red;'>\n CIS  5.2.13 - Ensure only strong Ciphers are used.  Ignore as these are default values so default values are present in all linux hosts\"  5.2.13  </p>" >>/var/log/cis_5_0_status.html

# 5.2.14 Ensure only strong MAC algorithms are used
echo -e  "<p style='color: red;'>\n CIS 5.2.14 Ensure only strong MAC algorithms are used.  Ignore ias these are default values so default values are present in all linux hosts\"  5.2.14  </p>" >>/var/log/cis_5_0_status.html

# 5.2.15 Ensure only strong Key Exchange algorithms are used
echo -e  "<p style='color: red;'>\n CIS 5.2.15 Ensure only strong Key Exchange algorithms are used.   Ignore these are default values so default values are present in all linux hosts\"  5.2.15  </p>" >>/var/log/cis_5_0_status.html

# 5.2.16 Ensure SSH Idle Timeout Interval is configured

if [[ $(grep -E "^\s*ClientAliveInterval" /etc/ssh/sshd_config|cut -f2 -d" ") != 300 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.16 SSH ClientAliveInterval was not set to 300 seconds  </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.16 SSH ClientAliveInterval is already set to 300  </p>"  >>/var/log/cis_5_0_status.html
fi

if [[ $(grep -E "^\s*ClientAliveCountMax" /etc/ssh/sshd_config|cut -f2 -d" ") != 3 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.16 SSH ClientAliveCountMax was not set to 3  </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.16 SSH ClientAliveCountMax is already set to 3  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.17 Ensure SSH LoginGraceTime is set to one minute or less
if [[ $(grep -E  "^\s*LoginGraceTime" /etc/ssh/sshd_config|cut -f2 -d' ') != 60 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.17 SSH *LoginGraceTime was not set to 60 seconds  </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.17 SSH *LoginGraceTime is already set to 60 seconds  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.18 Ensure SSH warning banner is configured
if [[ $(grep -E "^\s*Banner" /etc/ssh/sshd_config|cut -f2 -d" ") != "no" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.18 SSH Banner was not set to 'no' </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.18 SSH Banner is already set to 'no'  </p>"  >>/var/log/cis_5_0_status.html
fi

#  5.2.19 Ensure SSH PAM is enabled
#echo -e  "\n   Inore  CIS 5.2.19  as the default value UsePam Yes is present . hence no change  </p>" >>/var/log/cis_5_0_status.html
grep "UsePAM yes" /etc/ssh/sshd_config > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.2.19 SSH UsePAM was not set to 'yes' </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.19 SSH UsePAM is already set to 'yes'  </p>"  >>/var/log/cis_5_0_status.html
fi

# CIS 5.2.20 Ensure SSH AllowTcpForwarding is disabled
if [[ $(grep -E "^\s*AllowTcpForwarding" /etc/ssh/sshd_config|cut -f2 -d" ") != "no" ]]; then
echo -e "<p style='color: red;'>CIS 5.2.20 SSH AllowTcpForwarding was not set to 'no' </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.20 SSH AllowTcpForwarding is already set to 'no'  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.2.21 Ensure SSH MaxStartups is configured
grep -E "^\s*MaxStartups 10\:30\:60" /etc/ssh/sshd_config > /dev/null 2>&1
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.2.21 SSH MaxStartups was not set to '10:30:60' </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.21 SSH MaxStartups is already set to '10:30:60'  </p>"  >>/var/log/cis_5_0_status.html

fi

# 5.2.22 Ensure SSH MaxSessions is limited
#grep "#MaxSessions 10" /etc/ssh/sshd_config > /dev/null 2>&1
#if [ $? -eq 0 ] ; then
#/bin/sed -i "s/\#MaxSessions /MaxSessions /"  /etc/ssh/sshd_config
#check_exitstatus
#fi

if [[ $(grep -E  "^\s*MaxSessions" /etc/ssh/sshd_config|cut -f2 -d' ') != 10 ]]; then
echo -e "<p style='color: red;'>CIS 5.2.22 SSH MaxSessions was not set to 10   </p>"  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.2.22 SSH MaxSessions is already set to 10   </p>"  >>/var/log/cis_5_0_status.html
fi
# 5.3 Configure PAM
# 5.3.1 Ensure password creation requirements are configured
#/bin/sed -i -e 's/minlen=./minlen=14/g '  /etc/pam.d/common-password
#grep -P '^\s*password\s+(requisite|required)\s+pam_cracklib.so\s+retry=3\sminlen=(1[4-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password
#if [ $? -ne 0 ] ; then
#pam-config -a --cracklib-minlen=14 --cracklib-retry=3 --cracklib-lcredit=-1 --cracklib-ucredit=-1 --cracklib-dcredit=-1 --cracklib-ocredit=-1 --cracklib
#sed -i 's/^password.*requisite.*pam_cracklib.so/password    requisite    pam_cracklib.so retry=3 minlen=14 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1/' /etc/pam.d/common-password
#check_exitstatus
#fi
grep -E "^\s*password.*minlen=14" /etc/pam.d/common-password > /dev/null 2>&1
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.1 minimum length of password i.e..minlen not set to 14 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.1 minimum  length of password i.e. minlen already  set to 14 </p>"  >>/var/log/cis_5_0_status.html
fi

grep -E "^\s*password.*dcredit=-1" /etc/pam.d/common-password  > /dev/null 2>&1 
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.1 at least one digit not set i.e. dcredit value not to set to -1 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.1  at least one digit already set i.e. dcredit value already  set to -1 </p>"  >>/var/log/cis_5_0_status.html
fi

grep -E "^\s*password.*ucredit=-1" /etc/pam.d/common-password  > /dev/null 2>&1 
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.1 at least one uppercase character not set i.e. ucredit value not to set to -1 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.1  at least one uppercase character already set i.e. ucredit value already  set to -1 </p>"  >>/var/log/cis_5_0_status.html
fi

grep -E "^\s*password.*ocredit=-1" /etc/pam.d/common-password  > /dev/null 2>&1 
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.1 at least one special character not set i.e. ocredit value not to set to -1 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.1  at least one special character already set i.e. ocredit value already  set to -1 </p>"  >>/var/log/cis_5_0_status.html
fi

grep -E "^\s*password.*lcredit=-1" /etc/pam.d/common-password  > /dev/null 2>&1 
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.1 at least one lowercase character not set i.e. lcredit value not to set to -1 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.1  at least one lowercase character already set i.e. lcredit value already  set to -1 </p>"  >>/var/log/cis_5_0_status.html
fi

#/bin/sed -i -e 's/dcredit=./dcredit=-1/g '  /etc/pam.d/common-password
#/bin/sed -i -e 's/ucredit=./ucredit=-1/g '  /etc/pam.d/common-password
#/bin/sed -i -e 's/ocredit=./ocredit=-1/g '  /etc/pam.d/common-password
#/bin/sed -i -e 's/lcredit=./lcredit=-1/g '  /etc/pam.d/common-password


# 5.3.2 Ensure lockout for failed password attempts is configured
#echo -e  "\  CIS 5.3.2  - Need to review  whether to ignore or to include </p>" >>/var/log/cis_5_0_status.html
grep -E "^\s*.*deny=5" /etc/pam.d/login > /dev/null 2>&1
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.2 Number of times unsuccessful consecutive login attempts i.e. deny value was not set to 5 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.2  Number of times unsuccessful consecutive login attempts i.e. deny value was already set to 5 </p>"  >>/var/log/cis_5_0_status.html
fi
grep -E "^\s*.*unlock_time=900" /etc/pam.d/login > /dev/null 2>&1
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.2 number of seconds the account remains locked i.e. unlock_time not set to 900  \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.2 number of seconds the account remains locked i.e. unlock_time already  set to 900 </p>"  >>/var/log/cis_5_0_status.html
fi



# 5.3.3 Ensure password reuse is limited
#echo -e  "\n  CIS 5.3.3   - Need to review  whether to ignore or to include </p>" >>/var/log/cis_5_0_status.html
grep -E "^\s*password.*remember=5" /etc/pam.d/common-password  > /dev/null 2>&1 
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 5.3.3 remembered password history not set to 5 or higher for password reuse \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.3.3  remembered password history already set to 5 or higher for password reuse </p>"  >>/var/log/cis_5_0_status.html
fi

#--------------------------------Begin CIS 5.4----------------------
# 5.4.1.1 Ensure password hashing algorithm is SHA-512
if [[ $(grep -Ei '^\s*ENCRYPT_METHOD\s+SHA512' /etc/login.defs) !=  "ENCRYPT_METHOD SHA512" ]] ; then
echo -e "<p style='color: red;'>CIS 5.4.1.1 password hashing algorithm isnot set to  SHA-512 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.1  password hashing algorithm already  set to  SHA-512 </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.1.2 Ensure password expiration is 365 days or less
if [[ $(grep ^\s*PASS_MAX_DAYS /etc/login.defs| awk '{print $2}') != '365' ]]; then
echo -e "<p style='color: red;'>CIS 5.4.1.2  password expiration is not set to 365 days or less \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.2  password expiration already set to 365 days or less </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.1.3 Ensure minimum days between password changes is configured
if [[ $(grep ^\s*PASS_MIN_DAYS /etc/login.defs| cut -f2 ) != '1' ]]; then
echo -e "<p style='color: red;'>CIS 5.4.1.3  prevent users from changing their password until a minimum number of days.PASS_MIN_DAYS not set to value 1 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.3   prevent users from changing their password until a minimum numberof days.PASS_MIN_DAYS already set to value 1 </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.1.4 Ensure password expiration warning days is 7 or more
if [[ $(grep ^\s*PASS_WARN_AGE  /etc/login.defs| cut -f2) != '7' ]]; then
echo -e "<p style='color: red;'>CIS 5.4.1.4  password expiration warning days is not set to 7 \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.4 password expiration warning days is already set to 7  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.1.5 Ensure inactive password lock is 30 days or less
# Run the following command to set the default password inactivity period to 30 days:
if [[ $( useradd -D | grep INACTIVE|cut -f2 -d=) != 30 ]]; then 
echo -e "<p style='color: red;'>CIS 5.4.1.5 inactive password lock is not set to 30 days \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.5 inactive password lock is already set to 30 days  </p>"  >>/var/log/cis_5_0_status.html
fi


# 5.4.1.6 Ensure all users last password change date is in the past
for usr in $(cut -d: -f1 /etc/shadow); do [[ $(chage --list $usr | grep '^Last password change' | cut -d: -f2) > $(date) ]] && echo "$usr :$(chage --list $usr | grep '^Last password change' | cut -d: -f2)"; done >> /var/log/cis_5_0_status.html
#echo -e  "\n  CIS 5.4.1.6 - run the command manually as per CIS 5.4.1.6  </p>" >>/var/log/cis_5_0_status.html
if [ $? -ne 0 ]; then
echo -e "<p style='color: red;'>CIS 5.4.1.6 last password change date is not in the past \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.1.6 last password change date is in the past  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.2 Ensure system accounts are secured
#echo -e  "\n  CIS 5.4.2 -  run the command manually as per CIS 5.4.2</p>" >>/var/log/cis_5_0_status.html
awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print}' /etc/passwd >>/var/log/cis_5_0_status.html
if [ $? -ne 0 ]; then
echo -e "<p style='color: red;'>CIS 5.4.2 system accounts are not secured \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.2 system accounts are secured  </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.3 Ensure default group for the root account is GID 0
if [[ $(grep "^root:" /etc/passwd | cut -f4 -d:) != 0 ]] ; then
# Run the following command to set the root user default group to GID 0
echo -e "<p style='color: red;'>CIS 5.4.3 default group for the root account is not GID 0  \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.3 default group for the root account is GID 0   </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.4.4 Ensure default user shell timeout is configured
echo -e  "\n  CIS 5.4.4 - default user shell timeout is configured .check CIS manual </p>" >>/var/log/cis_5_0_status.html

# 5.4.5 Ensure default user umask is configured
if [[ $(grep -Ei '^\s*UMASK\s+022' /etc/login.defs| awk '{print $2}') != 027 ]]  ;  then
echo -e "<p style='color: red;'>CIS 5.4.4 default user umask not set to 027  \n "  >>/var/log/cis_5_0_status.html
else
echo -e "<p style='color: green;'>CIS 5.4.4 default user umask already set to 027   </p>"  >>/var/log/cis_5_0_status.html
echo -e "<p style='color: green;'>CIS 5.4.4 This might impacts SAP Applications and Database </p>"  >>/var/log/cis_5_0_status.html
fi

# 5.5 Ensure root login is restricted to system console
echo -e  "<p style='color: red;'>\n  CIS 5.5 -  Ensure root login is restricted to system console.Refer CIS Manual  </p>" >>/var/log/cis_5_0_status.html

# 5.6 Ensure access to the su command is restricted
echo -e  "<p style='color: red;'>\n  CIS 5.6  -  Ensure access to the su command is restricted. Refer CIS Manual</p>" >>/var/log/cis_5_0_status.html

echo -e "<p style='color: green;'>-------------------------------------End of  CIS 5.0-----------------------------------------------------------</p>"  >> /var/log/cis_5_0_status.html
echo  -e "\n CIS 5.0 Script execution completed \n"
echo -e "\n check the validation report5  file located in /var/log/cis_5_0_status.html \n"
echo  -e "\n check the Error log file located in /var/log/cis_5_0.log \n"
#-------------------- --- -----------------End of CIS 5.0 --------------------------------------#
if [ ! -d /var/local ] ; then
mkdir -p /var/local
fi
check_exitstatus

cat << EOF >> /var/local/CIS_5_0-hardened
CIS_5_0 script completed
EOF

echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_5_0_status.html
echo -e "\nVersion of the CIS 5.0 Validation Shell script file name $(basename $0) is 1.0 Latest version date is 14-02-2024"
exit 0

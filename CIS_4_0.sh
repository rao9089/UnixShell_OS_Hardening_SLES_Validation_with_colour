#---------------------Begin of CIS 4.0----------------------------#

# CIS 4.0 Auditing 
#
#

#! /bin/bash

export DATE=`date +%d-%m-%Y`
export TIME=`date +%H:%M:%S`

## Define some functions and/or variables used for logging output
export LOGERR="Date:$DATE || Time: $TIME || ERR:"

function check_exitstatus {
        if [ $? -ne 0 ] ; then
                echo "${LOGERR} execution of command failed" >>/var/log/cis_4_0.log
                exit 1
        fi
}
if [ -e /var/log/cis_4_0.log ] ; then
 rm /var/log/cis_4_0.log
check_exitstatus
fi

if [ -e /var/log/cis_4_0_status.html ] ; then
 rm /var/log/cis_4_0_status.html
check_exitstatus
fi

if [ -e /var/local/CIS_4_0-hardened ]
then
  echo -e "\n CIS_4_0-hardened script has already been implemented \n"
  exit 0
fi

if [[ $( grep "^NAME" /etc/os-release|cut -f2 -d=) != "\"SLES\""  ]] ; then
	echo -e "\n This is not SLES Linux OS. Shell script works only on SLES Linux OS \n"
	exit 0
else
	echo -e "\n This is SUSE Linux OS. \n"
fi


echo -e " <span style='color: blue;'>\n--------------------------CIS 4.0 Logging And  Auditing ---------------------------------------------------------------------------</p>\n" >>/var/log/cis_4_0_status.html
# -------------------------------------------Begin CIS 4.1--------------------------------------------------------------
# 4.1.1.1 Ensure auditd is installed 
rpm -q audit 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e "<p style='color: red;'>CIS 4.1.1.1 Audit Oackage is not installed. Indtall Audit package </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.1.1.1 Audit Oackage already  installed.  </p>" >>/var/log/cis_4_0_status.html
fi

# 4.1.1.2 Ensure auditd service is enabled and running 
if [[ $(systemctl is-enabled auditd) != "enabled" ]] ; then
echo -e "<p style='color: red;'> 4.1.1.2 Auditd service  not  enabled </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.1.2 Auditd service  already enabled </p>" >>/var/log/cis_4_0_status.html
fi

# 4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled 
if [[ $(grep "^GRUB_CMDLINE_LINUX=\"audit=1\"" /etc/default/grub) != 'GRUB_CMDLINE_LINUX=\"audit=1\"' ]] ; then
echo -e "<p style='color: red;'> 4.1.1.3 audit=1 parameter not set in  /etc/default/grub </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.1.3 audit=1 parameter was set in /etc/default/grub </p>" >>/var/log/cis_4_0_status.html
fi 

# 4.1.2.1 Ensure audit log storage size is configured 
if [[ $(grep "max_log_file.=" /etc/audit/auditd.conf|cut -f3 -d' ') == 8 ]] ; then
echo -e "<p style='color: red;'> 4.1.2.1 parameter max_log_file size must be set to 32 MB  or higher as 8MB is too low and the system might hang if the audit log reaches full in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.1  parameter max_log_file size set to 32 MB  or higher  in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
fi

# 4.1.2.2 Ensure audit logs are not automatically deleted 
if [[ $(grep max_log_file_action /etc/audit/auditd.conf |cut -f3 -d' ') == 'ROTATE' ]] ; then 
echo -e "<p style='color: red;'> 4.1.2.2 parameter max_log_file_action  NOT set to 'keep_logs' in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.2  parameter max_log_file_action was set to 'keep_logs'  in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
fi

# 4.1.2.3 Ensure system is disabled when audit logs are full 
if [[ $(grep space_left_action /etc/audit/auditd.conf |cut -f3 -d' ') != 'email' ]] ; then 
echo -e "<p style='color: red;'> 4.1.2.3 parameter space_left_action  NOT set to 'email' in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.3  parameter space_left_action set to 'email'  in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
fi

if [[ $(grep action_mail_acct /etc/audit/auditd.conf |cut -f3 -d' ') != 'root' ]] ; then 
echo -e "<p style='color: red;'> 4.1.2.3 parameter action_main_acct  NOT set to 'root' in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.3  parameter action_main_acct set to 'root'  in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
fi

if [[ $(grep admin_space_left_action /etc/audit/auditd.conf |cut -f3 -d' ') != 'halt' ]] ; then 
echo -e "<p style='color: red;'> 4.1.2.3 parameter admin_space_left_action  NOT set to 'halt' in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.3  parameter admin_space_left_action set to 'halt'  in /etc/audit/auditd.conf </p>" >>/var/log/cis_4_0_status.html
fi 

# 4.1.2.4 Ensure audit_backlog_limit is sufficient 
grep "audit_backlog_limit" /etc/default/grub 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.2.4 parameter audit_backlog_limit  NOT set to '8192' in /etc/default/grub </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.2.4  parameter  audit_backlog_limit set to '8192'  in /etc/default/grub </p>" >>/var/log/cis_4_0_status.html
fi

# 4.1.3  to 4.1.17
# cat << EOF >> /etc/audit/rules.d/hardening.rules              #CIS 4.1.3-4.1.17
# CIS 4.1.3
 if [ ! -d  /etc/audit/rules.d/ ] ; then
echo -e "<p style='color: red;'> 4.1.3 directory /etc/audit/rules.d/ not present </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.3  directory  /etc/audit/rules.d/ present </p>" >>/var/log/cis_4_0_status.html

 fi

#if [ ! -f /etc/audit/rules.d/50-time_change.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-time_change.rules 
#-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change 
#-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
#-a always,exit -F arch=b64 -S clock_settime -k time-change
#-a always,exit -F arch=b32 -S clock_settime -k time-change
#-w /etc/localtime -p wa -k time-change
#EOF
#check_exitstatus
#fi
grep time-change /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.3 time-change rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.3  time-change rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.4
#if [ ! -f /etc/audit/rules.d/50-identity.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-identity.rules 
#-w /etc/group -p wa -k identity 
#-w /etc/passwd -p wa -k identity 
#-w /etc/gshadow -p wa -k identity 
#-w /etc/shadow -p wa -k identity 
#-w /etc/security/opasswd -p wa -k identity 
#EOF
#check_exitstatus
#fi
grep identity /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.4 identity  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.4  identity  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.5
#if [ ! -f /etc/audit/rules.d/50-system_locale.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-system_locale.rules 
#-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
#-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
##-w /etc/issue -p wa -k system-locale
#-w /etc/issue.net -p wa -k system-locale
#-w /etc/hosts -p wa -k system-locale
#-w /etc/sysconfig/network -p wa -k system-locale 
#EOF
#check_exitstatus
#fi
grep system-locale /etc/audit/rules.d/*.rules  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.5 system-locale  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.5  system-locale  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.6
#if [ ! -f /etc/audit/rules.d/50-MAC_policy.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-MAC_policy.rules 
#-w /etc/selinux/ -p wa -k MAC-policy
#-w /usr/share/selinux/ -p wa -k MAC-policy 
#EOF
#check_exitstatus
#fi

grep MAC-policy /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.6 MAC-policy  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.6  MAC-policy  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi

## CIS 4.1.7
#if [ ! -f  /etc/audit/rules.d/50-logins.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-logins.rules 
#-w /var/log/faillog -p wa -k logins
#-w /var/log/lastlog -p wa -k logins
#-w /var/log/tallylog -p wa -k logins
#EOF
#check_exitstatus
#fi
grep logins /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.7 login  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.7  login  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi

# CIS 4.1.8
#if [ ! -f  /etc/audit/rules.d/50-session.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-session.rules 
#-w /var/run/utmp -p wa -k session
#-w /var/log/wtmp -p wa -k session
#-w /var/log/btmp -p wa -k session
#EOF
#check_exitstatus
#fi
grep -E '(session|logins)' /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.8 session  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.8  session  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


#CIS 4.1.9
#if [ ! -f  /etc/audit/rules.d/50-perm_mod.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-perm_mod.rules 
#-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
#-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
#-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
#-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
#-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
#-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
#EOF
#check_exitstatus
#fi
grep perm_mod /etc/audit/rules.d/*.rules  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.9 perm_mod  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.9  perm_mod  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi



# CIS 4.1.10
#if [ ! -f /etc/audit/rules.d/50-access.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-access.rules 
#-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
#-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
#-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
#-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
#EOF
#check_exitstatus
#fi
grep access /etc/audit/rules.d/*.rules  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.10 access  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.10  access  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi



# CIS 4.1.11
#if [ ! -f /etc/audit/rules.d/50-privileged.rules ] ; then
#find / -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>='"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' -F auid!=4294967295 -k privileged" }' >> /etc/audit/rules.d/50-privileged.rules
#check_exitstatus
#fi
find /  -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>='"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' -F auid!=4294967295 -k privileged" }' 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.11 privileged  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.11  privileged  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.12
#if [ ! -f /etc/audit/rules.d/50-mounts.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-mounts.rules 
#-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
#-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts
#EOF
#check_exitstatus
#fi
grep mounts /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.12 mount  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.12  mount  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.13
#if [ ! -f /etc/audit/rules.d/50-deletion.rules ] ; then
##cat << EOF >> /etc/audit/rules.d/50-deletion.rules 
#-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete 
#-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete 
#EOF
#check_exitstatus
#fi
grep delete /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.13 delete  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.13  delete  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi

# CIS 4.1.14
#if [ ! -f /etc/audit/rules.d/50-scope.rules  ] ; then
#cat << EOF >> /etc/audit/rules.d/50-scope.rules 
#-w /etc/sudoers -p wa -k scope
#-w /etc/sudoers.d/ -p wa -k scope 
#EOF
#check_exitstatus
#fi
grep scope /etc/audit/rules.d/*.rules  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.14 scope  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.14  scope  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi


# CIS 4.1.15
#if [ ! -f /etc/audit/rules.d/50-action.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-action.rules 
#-w /var/log/sudo.log -p wa -k actions
#EOF
#check_exitstatus
#fi
grep action /etc/audit/rules.d/*.rules  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.15 action  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.15  action  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi

# CIS 4.1.16
#if [ ! -f /etc/audit/rules.d/50-modules.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/50-modules.rules 
#-w /sbin/insmod -p x -k modules
#-w /sbin/rmmod -p x -k modules
#-w /sbin/modprobe -p x -k modules
#-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
#EOF
#check_exitstatus
#fi

grep modules /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.16 kernel modules  rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.16  kernel modules  rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi

# CIS 4.1.17
#if [ ! -f /etc/audit/rules.d/99-finalize.rules ] ; then
#cat << EOF >> /etc/audit/rules.d/99-finalize.rules 
#-e 2                                                             
#EOF
#check_exitstatus
#fi
grep "-e 2" /etc/audit/rules.d/*.rules 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> 4.1.17 finalize rules not present in /etc/audit/rules.d/*.rules</p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> 4.1.17  finalize rules  present in /etc/audit/rules.d/*.rules  </p>" >>/var/log/cis_4_0_status.html
fi



# ----------------------------------Begin CIS 4.2---------------------------------
# 4.2.1.1 Ensure rsyslog is installed 
rpm -q rsyslog 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e "<p style='color: red;'>CIS 4.2.1.1  rsyslog package not installed </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.1.1  rsyslog package already installed </p>" >>/var/log/cis_4_0_status.html
fi


# 4.2.1.2 Ensure rsyslog Service is enabled and running 
if [[ $(systemctl is-enabled rsyslog) != "enabled" ]] ; then
echo -e "<p style='color: red;'> CIS 4.2.1.2  rsyslog service  not enabled </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'> CIS 4.2.1.2  rsyslog service  already enabled </p>" >>/var/log/cis_4_0_status.html
fi

# 4.2.1.3 Ensure rsyslog default file permissions configured 
if [[ $( grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf|cut -f2 -d' ') != '0640' ]] ; then
echo -e "<p style='color: red;'>CIS 4.2.1.3 \$FileCreateMode 0640 not present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf file  </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.1.3 \$FileCreateMode 0640 already present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf file  </p>" >>/var/log/cis_4_0_status.html
fi

# 4.2.1.4 Ensure logging is configured 
echo -e "\n CIS 4.2.1.4 Ensure logging is configured.  Ignore this section  </p>" >>/var/log/cis_4_0_status.html

# 4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host 
echo -e "<p style='color: red;'>\n CIS 4.2.1.5 - Ensure rsyslog is configured to send logs to a remote log hosI. Ignore this section . </p>" >>/var/log/cis_4_0_status.html

# 4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts 
echo -e "\n CIS 4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts. </p>" >>/var/log/cis_4_0_status.html
grep '^\s*\$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e "<p style='color: red;'>CIS 4.2.1.6  \$ModLoad imtcp is not present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.1.6  \$ModLoad imtcp is  present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf </p>" >>/var/log/cis_4_0_status.html
fi
grep '^\s*\$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e "<p style='color: red;'>CIS 4.2.1.6  \$InputTCPServerRun 514 not present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.1.6   \$InputTCPServerRun 514 not present in /etc/rsyslog.conf /etc/rsyslog.d/*.conf  </p>" >>/var/log/cis_4_0_status.html
fi


# 4.2.2.1 Ensure journald is configured to send logs to rsyslog 
if [[ $(grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf|cut -f2 -d=) != "yes" ]]; then 
echo -e "<p style='color: red;'>CIS 4.2.2.1  ForwardToSyslog=yes not set in /etc/systemd/journald.conf  </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.2.1   ForwardToSyslog=yes already present  in /etc/systemd/journald.conf </p>" >>/var/log/cis_4_0_status.html
fi

# 4.2.2.2 Ensure journald is configured to compress large log files 
if [[ $(grep -E ^\s*Compress /etc/systemd/journald.conf|cut -f2 -d=) != "yes" ]];then
echo -e "<p style='color: red;'>CIS 4.2.2.2  Compress=yes not set in /etc/systemd/journald.conf  </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.2.2   Compress=yes already present  in /etc/systemd/journald.conf </p>" >>/var/log/cis_4_0_status.html
fi


# 4.2.2.3 Ensure journald is configured to write logfiles to persistent disk 
if [[ $(grep -E ^\s*Storage /etc/systemd/journald.conf|cut -f2 -d=) != "persistent" ]]; then
echo -e "<p style='color: red;'>CIS 4.2.2.3  Storage=persistent  not set in /etc/systemd/journald.conf  </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.2.3    Storage=persistent already present  in /etc/systemd/journald.conf </p>" >>/var/log/cis_4_0_status.html
fi


#CIS 4.2.3 Ensure permissions on all logfiles are configured 
# Run the following commands to scheck  permissions on all existing log files: 
find /var/log -type f -exec chmod g-wx,o-rwx "{}" +   >>/var/log/cis_4_0_status.html
if [[ $(find /var/log -type f -perm /g+wx,o+rwx -exec ls -l {} \;|wc -l) != 0 ]]; then
echo -e "<p style='color: red;'>CIS 4.2.3  other has  permissions on any files and group does  have write or execute permissions on any files in /var/log </p>" >>/var/log/cis_4_0_status.html
else
echo -e "<p style='color: green;'>CIS 4.2.3  other has no permissions on any files and group does not have write or execute permissions on any files in /var/log  </p>" >>/var/log/cis_4_0_status.html
fi


echo -e "<p style='color: green;'>-------------------------------------End of  CIS 4.0-----------------------------------------------------------</p>"  >> /var/log/cis_4_0_status.html
echo  -e "\n ----------------- CIS 4.0 Script execution completed ---------------------- \n"
echo -e "\n check the recommend or validation report  file located in /var/log/cis_4_0_status.html \n"
echo  -e "\n check the Error log file located in /var/log/cis_4_0.log \n"
#---------------------End of CIS 4.0 ----------------------------------------------------------#
if [ ! -d /var/local ] ; then
mkdir -p /var/local
fi
check_exitstatus

cat << EOF >> /var/local/CIS_4_0-hardened
CIS_4_0 script completed
EOF

echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_1_0_status.html
echo -e "\nVersion of the CIS 4.0 validation Shell script file name $(basename $0) is 1.0  Latest version date is 13-02-2024"
exit 0

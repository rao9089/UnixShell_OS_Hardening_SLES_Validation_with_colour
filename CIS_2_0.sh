#---------------------Begin of CIS 2.0----------------------------#

# CIS 2.1 Services
#
#

#! /bin/bash

export DATE=`date +%d-%m-%Y`
export TIME=`date +%H:%M:%S`

## Define some functions and/or variables used for logging output
export LOGERR="Date:$DATE || Time: $TIME || ERR:"

function check_exitstatus {
        if [ $? -ne 0 ] ; then
                echo "${LOGERR} execution of command failed" >>/var/log/cis_2_0.log
                exit 1
        fi
}

if [ -e /var/log/cis_2_0.log ] ; then
 rm /var/log/cis_2_0.log
check_exitstatus
fi

if [ -e /var/log/cis_2_0_status.html ] ; then
 rm /var/log/cis_2_0_status.html
check_exitstatus
fi


if [ -e /var/local/CIS_2_0-hardened ]
then
  echo -e "\n CIS_2_0-hardened script has already been implemented </p>"
  exit 0
fi

if [[ $( grep "^NAME" /etc/os-release|cut -f2 -d=) != "\"SLES\""  ]] ; then
echo -e "\n This is not SLES Linux OS. Shell script works only on SLES Linux OS </p>"
exit 0
else
echo -e "\n This is SUSE Linux OS. \n"
fi

echo -e " <span style='color: blue;'>\n--------------------------CIS 2.0 Services  ---------------------------------------------------------------------------</p>\n" >>/var/log/cis_2_0_status.html
# ----------------------------------------Begin CIS 2.1----------------------------------------------------------------
# CIS 2.1 Services
# CIS 2.1.1 Ensure xinetd is not installed
# The eXtended InterNET Daemon ( xinetd ) is an open source super daemon that replaced the original inetd daemon. The xinetd daemon listens for well known services and dispatches the appropriate daemon to properly respond to service requests. #
# If there are no xinetd services required, it is recommended that the package be removed to reduce the attack surface are of the system.
# Run the following command to verify xinetd is not installed:
rpm -q xinetd 2>&1 > /dev/null
if [ $? -eq  0 ] ; then
echo -e "<p style='color: red;'>\n CIS 2.1.1 Extended Internet Daemon  xinetd package already installed. </p>" >>/var/log/cis_2_0_status.html
echo -e "<p style='color: red;'>\n CIS 2.1.1 Uninstall Extended Internet Daemon  xinetd package. </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>\n Package xinetd is not installed </p>" >>/var/log/cis_2_0_status.html
fi
#


# CIS 2.2  Special Purposes Services
# CIS 2.2.1 Time Synchronization
# 2.2.1.1 Ensure time synchronization is in use

# Run the following command to verify chrony  is  installed:
rpm -q chrony 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
# Run the following command to install chrony:
echo -e "<p style='color: red;'>CIS 2.2.1.1 Chrony package is not installed. Install Chrony package </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.2.1.1 Chrony  is already  installed </p>" >>/var/log/cis_2_0_status.html
fi

if [ `systemctl is-enabled systemd-timesyncd` = "disabled" ] ; then
# run the following command to enable service
echo -e "<p style='color: red;'>CIS 2.2.1.1 systemd-timesyncd is disabled. Enable this service </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.2.1.1 systemd-timesyncd   is already  enabled  </p>" >>/var/log/cis_2_0_status.html
fi
#

# CIS 2.2.1.2 Ensure systemd-timesyncd is configured  . This is Manual not automation.
 if [ `systemctl is-enabled systemd-timesyncd.service` = "disabled" ]; then 
echo -e "<p style='color: red;'>CIS 2.2.1.2 systemd-timesyncd.service is disabled. Enable this service </p>" >>/var/log/cis_2_0_status.html
else
echo -e "<p style='color: green;'>CIS 2.2.1.2 systemd-timesyncd.service is already enabled. </p>" >>/var/log/cis_2_0_status.html
fi

#  CIS 2.2.1.3 Ensure chrony is configured
if [ ! -f /etc/chrony.conf ] ; then
echo -e  "<p style='color: red;'>/etc/chrony file not found - CIS 2.2.1.3   </p>" >>/var/log/cis_2_0_status.html
else
grep -E "^(server|pool)" /etc/chrony.conf  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e  "<p style='color: red;'> CIS 2.2.1.3 chrony is not  configured    </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>chrony is already configured   as per the - CIS 2.2.1.3   </p>" >>/var/log/cis_2_0_status.html
  fi
fi

if [ ! -d /etc/sysconfig ] ; then
echo -e  "<p style='color: red;'>CIS 2.2.1.3 /etc/sysconfig/ directory not found </p>" >>/var/log/cis_2_0_status.html
else
if [ ! -f /etc/sysconfig/chronyd ] ; then
echo -e  "<p style='color: red;'>/CIS 2.2.1.3 etc/chrony file not found </p>" >>/var/log/cis_2_0_status.html
else
grep "^OPTIONS=\"-u chrony\""  /etc/sysconfig/chronyd  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 2.2.1.3 entry '-u chrony' is not present in the /etc/sysconfig/chronyd  </p>" >>/var/log/cis_2_0_status.html
else
echo -e "<p style='color: green;'>CIS 2.2.1.3 entry '-u chrony' present in the /etc/sysconfig/chronyd  </p>" >>/var/log/cis_2_0_status.html
    fi
  fi
fi

# CIS 2.2.2 Ensure X11 Server components are not installed
# Run the following command to Verify X Windows Server is not installed.

rpm -q xorg-x11-server*  2>&1 > /dev/null
if [ $? -eq 0 ] ; then
echo -e  "<p style='color: red;'>CIS 2.2.2  X org-x11-server* already installed. Recommend as per CIS is to be uninstalled. However this might affects SWPM installation   </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.2.2  X org-x11-server* not installed. </p>" >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.3 Ensure Avahi Server is not installed
# Run one of the following command to verify avahi-autoipd and avahi are not installed: #
rpm -q avahi-autoipd avahi  2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'> CIS 2.2.3 avahi-autoipd avahi not  installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'> CIS 2.2.3 avahi-autoipd avahi already  installed. stop the service and uninstall  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.4 Ensure CUPS is not installed
#Run the following command to verify cups is not installed: #
rpm -q cups 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.4  CUPS not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.4  CUPS already installed. Uninstall CUPS. </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.5 Ensure DHCP Server is not installed
#Run the following command to verify dhcp is not installed: #
rpm -q dhcp 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.5  DHCP  not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.5  DHCP  already  installed. Uninstall DHCP  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.6 Ensure LDAP server is not installed
# Run the following command to verify openldap-servers is not installed: #

rpm -q openldap2 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.6  openldap2  not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.6  openldap2  already  installed. Uninstall openldap2  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.7 Ensure nfs-utils is not installed or the nfs-server service is masked
rpm -q nfs-utils nfs-kernel-server 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.7  nfs-utils nfs-kernel-server  not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.7  nfs-utils nfs-kernel-server  already  installed.   </p>"  >>/var/log/cis_2_0_status.html
echo -e  "<p style='color: red;'>\n  Ignore this section as nfs server is required for sapmnt, /usr/sap/trans shareable (common folder) for all R3 Systems landscape (i.e. Dev to QAS and then to Prod. We cannot disable the NFS service as NFS service is needed for SAP applications - CIS 2.2.7    </p>"  >>/var/log/cis_2_0_status.html
fi

#  CIS 2.2.8 Ensure rpcbind is not installed or the rpcbind services are masked
rpm -q rpcbind 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.8  rpcbind  not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.8  rpcbind  already  installed.  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.9 Ensure DNS Server is not installed

rpm -q bind  2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'> CIS 2.2.9 - DNS Server not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'> CIS 2.2.9 - DNS Server already  installed  </p>"  >>/var/log/cis_2_0_status.html
fi
#
# CIS 2.2.10 Ensure FTP Server is not installed
# Run the following command to verify vsftpd is not installed:

rpm -q vsftpd 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'> CIS 2.2.10 - FTP  Server  not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'> CIS 2.2.10 - Uninstall FTP  Server  </p>"  >>/var/log/cis_2_0_status.html
fi
#

# CIS 2.2.11 Ensure HTTP server is not installed
# Run the following command to verify apache2 is not installed:
rpm -q apache2  2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.11  HTTP Server not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.11  Uninstall  HTTP  server .  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.12 Ensure IMAP and POP3 server is not installed
# Run the following command to verify dovecot is not installed:
rpm -q dovecot   2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.12  IMAP and POP3 not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.12  IMAP and POP3 already installed. Uninstall dovecot  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.13 Ensure Samba is not installed
# Run the following command to verify samba is not installed:

rpm -q samba   2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.13  samba not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.13  samba already installed, Uninstall samba  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.14 Ensure HTTP Proxy Server is not installed
# Run the following command to verify squid is not installed:
rpm -q squid    2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.14  HTTP Proxy not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.14  HTTP Proxy not installed  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.15 Ensure net-snmp is not installed
# Run the following command to verify net-snmp is not installed:
rpm -q net-snmp   2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.15 net-snmp  not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.15 net-snmp  already  installed  </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.16 Ensure mail transfer agent is configured for local-only mode
ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|\[?::1\]?):25\s' 2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e "<p style='color: green;'>CIS 2.2.16 MTA is not listening on any non-loopback address \n " >>/var/log/cis_2_0_status.html
else
echo -e "<p style='color: red;'>CIS 2.2.16 MTA is listening on any non-loopback address.  \n " >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.17 Ensure rsync is not installed or the rsyncd service is masked
rpm -q rsync   2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.17  rsync not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.17 NIS already installed </p>"  >>/var/log/cis_2_0_status.html
fi


#  CIS 2.2.18 Ensure NIS server is not installed
# Run the following command to verify ypserv is not installed:
rpm -q ypserv    2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.2.18  NIS Server  not installed </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.18 NIS Server  not installed </p>"  >>/var/log/cis_2_0_status.html
fi

# CIS 2.2.19 Ensure telnet-server is not installed
rpm -q telnet-server     2>&1 > /dev/null
if [  $? -ne 0  ] ; then
echo -e  "<p style='color: green;'>CIS 2.3.19  telnet-Server  not installed  </p>"  >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: red;'>CIS 2.2.19  telnet-Server  already  installed </p>"  >>/var/log/cis_2_0_status.html
fi
#
# CIS 2.3 Service Clients
# CIS 2.3.1 Ensure NIS Client is not installed
# Run the following command to verify ypbind is not installed:

rpm -q ypbind 2>&1 > /dev/null
if [  $? -eq  0  ] ; then
# Run the following command to remove ypbind:
echo -e  "<p style='color: red;'>CIS 2.3.1 Package ypbind already installed  </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.3.1 Package ypbind is not installed  </p>" >>/var/log/cis_2_0_status.html
fi
#
#  CIS 2.3.2 Ensure rsh client is not installed
 # Run the following command to verify rsh is not installed:
rpm -q rsh 2>&1 > /dev/null
if [  $? -eq  0  ] ; then
# Run the following command to remove rsh:
echo -e  "<p style='color: red;'>CIS 2.3.2 Package rsh already  installed </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.3.2 Package rsh is not installed   </p>" >>/var/log/cis_2_0_status.html
fi

# CIS 2.3.3 Ensure talk client is not installed
 # Run the following command to verify talk package is not installed:
rpm -q talk 2>&1 > /dev/null
if [  $? -eq  0  ] ; then
# Run the following command to remove talk:
echo -e  "<p style='color: red;'> CIS 2.3.3  Package talk already installed  </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.3.3 Package talk is not installed  </p>" >>/var/log/cis_2_0_status.html
fi

# CIS 2.3.4 Ensure telnet client is not installed
 # Run the following command to verify telnet package is not installed:
rpm -q telnet 2>&1 > /dev/null
if [  $? -eq  0  ] ; then
echo -e  "<p style='color: red;'>CIS 2.3.4 telnet Package already installed  </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.3.4 telnet Package is not installed </p>" >>/var/log/cis_2_0_status.html
fi

# CIS 2.3.5 Ensure LDAP client is not installed
 # Run the following command to verify openldap2-clients package is not installed:
rpm -q openldap2-clients  2>&1 > /dev/null
if [  $? -eq  0  ] ; then
echo -e  "<p style='color: red;'> CIS 2.3.5 openldap2-clients  Package already installed  </p>" >>/var/log/cis_2_0_status.html
else
echo -e  "<p style='color: green;'>CIS 2.3.5  openldap2-clients  Package is not installed  </p>" >>/var/log/cis_2_0_status.html
fi
#

# CIS 2.4  Ensure nonessential services are removed or masked
# Run the following command to verify non essential services are removed or masked :
echo -e  "<p style='color: red;'>  CIS 2.4 - Ignore non-essential services  script .  </p>" >>/var/log/cis_2_0_status.html
#
#
#----------------------------------------------End of CIS 2.4 ---------------------------------------------

echo -e "<p style='color: green;'>-------------------------------------End of  CIS 2.0-----------------------------------------------------------</p>"  >> /var/log/cis_2_0_status.html
echo -e "\n CIS 2.0 Script execution completed \n"
echo -e "\n check the validation  report  file located in /var/log/cis_2_0_status.html \n"
echo -e "\n check the Error log file located in /var/log/cis_2_0.log \n"
#---------------------End of CIS 2.0------------------------------------------------------------------------#
if [ ! -d /var/local ] ; then
mkdir -p /var/local
fi
check_exitstatus

cat << EOF >> /var/local/CIS_2_0-hardened
CIS_2_0 script completed
EOF
echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_2_0_status.html
echo -e "\nVersion of the CIS 2.0 validation Shell script file name $(basename $0) is 1.0. Latest version date is 13-02-2024"
exit 0

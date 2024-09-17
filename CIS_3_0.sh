#---------------------Begin of CIS 3.0----------------------------#

# CIS 3.0 Network configuration
#
#

#! /bin/bash

export DATE=`date +%d-%m-%Y`
export TIME=`date +%H:%M:%S`

## Define some functions and/or variables used for logging output
export LOGERR="Date:$DATE || Time: $TIME || ERR:"

function check_exitstatus {
        if [ $? -ne 0 ] ; then
                echo "${LOGERR} execution of command failed" >>/var/log/cis_3_0.log
                exit 1
        fi
}

if [ -e /var/log/cis_3_0.log ] ; then
 rm /var/log/cis_3_0.log
check_exitstatus
fi


if [ -e /var/log/cis_3_0_status.html ] ; then
 rm /var/log/cis_3_0_status.html
check_exitstatus
fi

if [ -e /var/local/CIS_3_0-hardened ]
then
  echo -e "\n CIS_3_0-hardened script has already been implemented  \n"
  exit 0
fi

if [[ $( grep "^NAME" /etc/os-release|cut -f2 -d=) != "\"SLES\""  ]] ; then
	echo -e "\n This is not SLES Linux OS. Shell script works only on SLES Linux OS \n"
	exit 0
else
	echo -e "\n This is SUSE Linux OS. \n"
fi

#


echo -e " <span style='color: blue;'>\n--------------------------CIS 3.0 Network  Configuration ---------------------------------------------------------------------------</p>\n" >>/var/log/cis_3_0_status.html
# ------------------------------Begin of CIS 3.1 ---------------------------------------------------------------
# CIS 3.1 Disable unused network protocols and devices 
# To reduce the attack surface of a system, unused network protocols and devices should be disabled 
# 3.1.1 Disable IPv6 
# Run the following command to verify IPV6 services are disabled : 
#if [[ $(sysctl -n -q net.ipv6.conf.all.disable_ipv6) == 0 ]] ; then
# echo 'net.ipv6.conf.all.disable_ipv6 = 1'  > /etc/sysctl.d/02-net.ipv6.conf.all.disable_ipv6.conf
#sysctl -w -q  net.ipv6.conf.all.disable_ipv6=1 > /dev/null 2>&1
#check_exitstatus
#fi
sysctl net.ipv6.conf.all.disable_ipv6 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.1.1  IPV6 is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.1.1  IPV6  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.1.2 Ensure wireless interfaces are disabled 
echo -e  "<p style='color: red;'>\n CISR 3.1.2 Wireless interfaces - Ignore this script .  </p>" >>/var/log/cis_3_0_status.html

#  ------------------------Begin of CIS 3.2--------------------------------------
#  3.2.1 Ensure IP forwarding is disabled 
sysctl net.ipv4.ip_forward 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.2.1  IPV4 forwarding is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.2.1  IPV4 forwarding is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv6.conf.all.forwarding 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.2.1  IPV6 forwarding is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.2.1  IPV6 forwarding is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi
# 3.2.2 Ensure packet redirect sending is disabled 

sysctl net.ipv4.conf.all.send_redirects  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.2.2  IPV4 packet redirect all sending is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.2.2  IPV4 packet redirect all sending is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.default.send_redirects 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.2.2  IPV4 packet redirect default sending is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.2.2  IPV4 packet redirect default sending is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.all.accept_source_route 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.1  IPV4 packet all accept source route is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.1  IPV4 packet all accept source route is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.default.accept_source_route 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.1  IPV4 packet default accept source route is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.1  IPV4 packet default accept source route is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv6.conf.all.accept_source_route 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.1  If IPV6 enabled, IPV6 packet all accept source route is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.1  If IPV6 enabled, IPV6 packet all accept source route is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv6.conf.default.accept_source_route 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.1  If IPV6 enabled,  default accept source route is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.1  If IPV6 enabled,  default accept source route is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.all.accept_redirects 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.2  IPV4 packet all accept redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.2  IPV4 packet all accept redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.default.accept_redirects 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.2  IPV4 packet default accept redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.2  IPV4 packet default accept redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv6.conf.all.accept_redirects 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.2  If IPV6 enabled, all accept redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.2  If IPV6 enabled all accept redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv6.conf.default.accept_redirects 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.2  If IPV6 enabled, default accept redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.2  If IPV6 enabled default accept redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.all.secure_redirects  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.3  IPV4 packet all secure redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.3  IPV4 packet all secure redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.default.secure_redirects  2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.3  IPV4 packet default secure redirect  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.3  IPV4 packet default secure redirect  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.all.log_martians 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.4  IPV4 packet all log martians  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.4  IPV4 packet all log martians  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

sysctl net.ipv4.conf.default.log_martians 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 3.3.4  IPV4 packet default log martians  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.4  IPV4 packet default log martians  is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.3.5 Ensure broadcast ICMP requests are ignored 
if [[ $(sysctl -n -q net.ipv4.icmp_echo_ignore_broadcasts)  != 1 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.5  IPV4 icmp echo ignore broadcasts  is not disabled. This should be disabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.5  IPV4 packet echo ignore broadcasts is  disabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.3.6 Ensure bogus ICMP responses are ignored 
if [[ $(sysctl -n -q net.ipv4.icmp_ignore_bogus_error_responses)  != 1 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.6  IPV4 icmp echo ignore bogus error responses  is not ignored. This should be ignored </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.6  IPV4 packet echo ignore bogus error responses is  ignored. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.3.7 Ensure Reverse Path Filtering is enabled 
if [[ $(sysctl -n -q net.ipv4.conf.all.rp_filter)  != 1 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.7  IPV4  all rp filters  is not enabled. This should be enabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.7  IPV4 all rp filters is  enabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.3.8  Ensure TCP SYN Cookies is enabled 
if [[ $(sysctl -n -q net.ipv4.tcp_syncookies)  != 1 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.8  IPV4  tcp syncookies  is not enabled. This should be enabled </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.8  IPV4 tcp syncookies is  enabled. No action </p>" >> /var/log/cis_3_0_status.html
fi

# 3.3.9 Ensure IPv6 router advertisements are not accepted 
if [[ $(sysctl -n -q net.ipv6.conf.all.accept_ra)  != 0 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.9  IPV6  router all advertisements are  accepted </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.9  IPV6 router all are not accepted. No action </p>" >> /var/log/cis_3_0_status.html
fi
if [[ $(sysctl -n -q net.ipv6.conf.default.accept_ra)  != 0 ]] ; then
echo -e "<p style='color: red;'>CIS 3.3.9  IPV6  router default advertisements are  accepted </p>" >> /var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.3.9  IPV6 router default are not accepted. No action </p>" >> /var/log/cis_3_0_status.html

fi
#------------------------------------Begin CIS 3.4 ---------------------------------- 
# 3.4.1 Ensure DCCP is disabled 
modprobe -n -v -q dccp > /dev/null 2>&1
if [ $? -ne 0 ] ; then 
	echo -e "<p style='color: green;'>CIS 3.4.1 dccp driver not installed </p>" >>/var/log/cis_3_0_status.html
else
	echo -e "<p style='color: red;'>CIS 3.4.1 dccp driver installed . This should not be installed </p>" >>/var/log/cis_3_0_status.html
fi
#
# 3.4.2 Ensure SCTP is disabled 
modprobe -n -v -q sctp > /dev/null 2>&1
if [ $? -ne 0 ] ; then 
	echo -e "<p style='color: green;'>CIS 3.4.2 sctp driver not installed </p>" >>/var/log/cis_3_0_status.html
else
 echo -e "<p style='color: red;'>CIS 3.4.2 sctp driver installed. Should not be installed </p>" >>/var/log/cis_3_0_status.html
fi


#---------------------------Begin CIS 3.5 ------------------------------------
# CIS 3.5 Firewall COnfiguration
# 3.5.1.1 Ensure FirewallD is installed 
rpm -q firewalld 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e "<p style='color: red;'>CIS 3.5.1.1 firewalld not installed. This shoudl be installed...</p>" >>/var/log/cis_3_0_status.html
else
echo -e "<p style='color: green;'>CIS 3.5.1.1 firewalld already installed. </p>" >>/var/log/cis_3_0_status.html

fi

# 3.5.1.1 and 3.5.3.1.1  Ensure iptables is installed 
rpm -q iptables   2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e  "<p style='color: red;'>CIS 3.5.1.1  iptables not  installed </p>" >> /var/log/cis_3_0_status.html
else
echo -e  "<p style='color: green;'>CIS 3.5.1.1 iptables is already  installed </p>" >> /var/log/cis_3_0_status.html
fi

# 3.5.1.2  and 3.5.3.1.2 Ensure nftables is not installed or stopped and masked 
rpm -q  nftables    2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e  "<p style='color: green;'>CIS 3.5.1.2   nftables package not installed  </p>" >>/var/log/cis_3_0_status.html
else
echo -e  "<p style='color: red;'> CIS 3.5.1.2   nftables package already installed. This should not be installed.  </p>" >>/var/log/cis_3_0_status.html
fi

#  3.5.1.3 Ensure firewalld service is enabled and running 
#echo -e  "\n   Ignore this section as SAP application and database will be highly impacted as per the - CIS 3.5.1.3</p>" >>/var/log/cis_3_0_status.html
#systemctl is-enabled firewalld  2>&1 > /dev/null
#if [ $? -ne  0 ] ; then
#echo -e "\n enabling the service ...</p>"
#systemctl --now --quiet enable firewalld 2>&1 > /dev/null
#check_exitstatus
#fi

#  3.5.1.4 Ensure default zone is set 
#echo -e  "\n   Ignore this section as per the - CIS 3.5.1.4</p>" >>/var/log/cis_3_0_status.html
#firewall-cmd --get-default-zone 2>&1 > /dev/null
#if [ $? -ne  0 ] ; then
# firewall-cmd --set-default-zone=public 2>&1 > /dev/null
#else
# echo -e "\n firewalld default zone is set 3.4.1.5 </p>" >> /var/log/cis_3_0_status.html
#fi


# 3.5.1.5 Ensureonetwork interfaces are assigned to appropriate zone 
echo -e  "<p style='color: red;'>CIS 3.5.1.5   Ignore this section </p>" >>/var/log/cis_3_0_status.html

# 3.5.1.6 Ensure unnecessary services and ports are not accepted 
echo -e  "<p style='color: red;'>CIS 3.5.1.6   Ignore this section </p>" >>/var/log/cis_3_0_status.html

# 3.5.2 Configure nftables 
echo -e  "<p style='color: red;'>CIS 3.5.1.7   Ignore this section </p>" >>/var/log/cis_3_0_status.html
#       3.5.2.1 Ensure nftables is installed 
# In CIS Section  3.5.1.2  - it says that nftables must not be installed if firewalld package is installed and enabled otherwise there will be conflicts for nftables service and firewalld service 
echo -e  "<p style='color: red;'>CIS 3.5.2.1   Ignore this section as per the - CIS 3.5.2.1 . In CIS Section  3.5.1.2  - it says that nftables must not be installed if firewalld package is installed and enabled otherwise Running both nftables.service and firewalld.service may lead to conflict and unexpected results.   </p>" >>/var/log/cis_3_0_status.html

#  3.5.2.2 Ensure firewalld is not installed or stopped and masked 
# In CIS 3.5.1.3 section, Running both nftables.service and firewalld.service may lead to conflict and unexpected results. . Hence ignore this 
echo -e  "<p style='color: red;'>CIS 3.5.2.2   Ignore this section as per the - CIS 3.5.2.2 . In CIS Section  3.5.1.3  - it says that firewalld service must not be enabled  if nftables service is installed and enabled otherwise Running both nftables.service and firewalld.service may lead to conflict and unexpected results.   </p>" >>/var/log/cis_3_0_status.html

# 3.5.2.3 Ensure iptables are flushed 
#echo -e  "\n   Ignore this section as per the - CIS 3.5.2.3  You may manually run the command \"iptables -F\"  </p>" >>/var/log/cis_3_0_status.html
iptables -L 2>&1 > /dev/null
if [ $? -ne  0 ] ; then
echo -e  "<p style='color: green;'>CIS 3.5.2.3   iptables rules are not existed  </p>" >>/var/log/cis_3_0_status.html
else
echo -e  "<p style='color: red;'> CIS 3.5.2.3  iptables rules are existed . if rules are returned then flush iptables  </p>" >>/var/log/cis_3_0_status.html
fi

ip6tables -L 2>&1 > /dev/null 

if [ $? -ne  0 ] ; then
echo -e  "<p style='color: green;'>CIS 3.5.2.3   ip6table rules are not existed  </p>" >>/var/log/cis_3_0_status.html
else
echo -e  "<p style='color: red;'> CIS 3.5.2.3  ip6tables rules are existed . if rules are returned then flush ip6tables  </p>" >>/var/log/cis_3_0_status.html
fi

#  3.5.2.4 -  3.5.2.10
echo -e  "<p style='color: red;'>\n Ignore CIS 3.5.2.4 to 3.5.2.10 as the nft command not available  </p>" >>/var/log/cis_3_0_status.html

# 3.5.3
echo -e  "<p style='color: red;'>\n Ignore entire CIS 3.5.3 as the nft command not available</p>" >>/var/log/cis_3_0_status.html

#


echo -e "<p style='color: green;'>-------------------------------------End of  CIS 3.0-----------------------------------------------------------</p>"  >> /var/log/cis_3_0_status.html
echo  -e "\n CIS 3.0 Script execution completed \n"
echo -e "\n check the recommend or validation report file located in /var/log/cis_3_0_status.html \n"
echo  -e "\n check the Error log file located in /var/log/cis_3_0.log \n"

#---------------------End of CIS 3.0 ----------------------------#
if [ ! -d /var/local ] ; then 
mkdir -p /var/local
fi
check_exitstatus

cat << EOF >> /var/local/CIS_3_0-hardened
CIS_3_0 script completed
EOF
echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_3_0_status.html
echo -e "\nVersion of the CIS 3.0 validation Shell script file name $(basename $0) is 1.0 Latest vesrion date is 13-02-2024"
exit 0

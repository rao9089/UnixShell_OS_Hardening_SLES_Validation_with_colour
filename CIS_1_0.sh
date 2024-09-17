#---------------------Begin of CIS 1.1----------------------------#

# CIS 1.1 Filesystem Configuration
#

#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'

export DATE=`date +%d-%m-%Y`
export TIME=`date +%H:%M:%S`

## Define some functions and/or variables used for logging output
export LOGERR="Date:$DATE || Time: $TIME || ERR:"

function check_exitstatus {
        if [ $? -ne 0 ] ; then
                echo "${LOGERR} execution of command failed" >>/var/log/cis_1_0.log
                exit 1
        fi
}
if [ -e /var/log/cis_1_0.log ] ; then
 rm /var/log/cis_1_0.log
check_exitstatus
fi

if [ -e /var/log/cis_1_0_status.html ] ; then
 rm /var/log/cis_1_0_status.html
check_exitstatus
fi

if [ -e /var/local/CIS_1_0-hardened ]
then
  echo -e "\n CIS_1_0-hardened script has already been implemented "
  exit 0
fi

if [[ $( grep "^NAME" /etc/os-release|cut -f2 -d=) != "\"SLES\""  ]] ; then
echo -e "\n This is not SLES Linux OS. Shell script works only on SLES Linux OS "
exit 0
else
echo -e "\n This is SUSE Linux OS. "
fi

if [[ $(dmidecode --string chassis-asset-tag) == '7783-7084-3265-9085-8269-3286-77' ]] ; then
echo -e "<p style='color: green;'>This VM host resides in Azure cloud .. </p>" >> /var/log/cis_1_0_status.html
else
if [[ $(dmidecode |grep UUID|cut -f2 -d: | cut -c -4) == ' ec2' ]] ; then
echo -e "<p style='color: green;'>This VM host resides in AWS  cloud ...</p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'>This VM host resided either in unknown location ...</p>" >> /var/log/cis_1_0_status.html
 fi
fi


echo -e "<p style='color: green;'>OS Name and Version is $(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2) </p>" >> /var/log/cis_1_0_status.html

#check swapspace filesystem configured .....
if [[ $(grep swap /etc/fstab|cut -f2 -d' ') != 'swap' && $(sudo swapon --show=TYPE --noheadings|grep file) != 'file' && $(sudo swapon --show=TYPE --noheadings|grep partition) != 'partition' ]]; then
 echo -e "<p style='color: red;'> Swapspace is not configured. Please configure swapspace FS as performance will slow down  and might gets hang. Impossible to work on the system for several minutes. Thumbsrule - size for Swapspace partition should be  3 times of RAM configured .  </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> swapspace filesystem or swapfile was  already  configured </p>" >>/var/log/cis_1_0_status.html
fi

echo -e " <span style='color: blue;'>\n--------------------------CIS 1.0 Initail Setup ---------------------------------------------------------------------------</p>\n" >>/var/log/cis_1_0_status.html
##########  CIS 1.1.1 Disable unused filesystems  ###############################
# Disable mounting of unneeded filesystems CIS 1.1.1.1  to CIS 1.1.1.3

#1.1.1.1 Ensure mounting of squashfs filesystems is disabled (
modprobe -n -v  squashfs | grep -E '(\/bin\/true)' > /dev/null 2>&1
if  [ $? -ne 0 ] ;  then
 echo -e "<p style='color: red;'>CIS 1.1.1.1 disable and unload unused squashfs filesystem  </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: green;'>CIS 1.1.1.1 squashfs filesystem already disabled  </p>" >>/var/log/cis_1_0_status.html
fi
# 1.1.1.2 Ensure mounting of udf filesystems is disabled
modprobe -n -v  udf | grep -E '(\/bin\/true)'  > /dev/null 2>&1
if  [ $? -ne 0 ] ;  then
 echo -e "<p style='color: red;'>CIS 1.1.1.2 disable and unload unused udf filesystem  </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: green;'>CIS 1.1.1.2 udf filesystem already disabled  </p>" >>/var/log/cis_1_0_status.html
fi

# 1.1.1.3 Ensure mounting of FAT filesystems is limited
modprobe -n -v fat | grep -E '(fat|install)' |  grep -E '(\/bin\/true)' > /dev/null 2>&1
if  [ $? -ne 0 ] ;  then
 echo -e "<p style='color: red;'>disable and unload fat  filesystem - CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: green;'>fat  filesystem already disabled- CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
fi

modprobe -n -v vfat | grep -E '(vfat|install)' |  grep -E '(\/bin\/true)' > /dev/null 2>&1
if  [ $? -ne 0 ] ;  then
 echo -e "<p style='color: red;'>disable and unload vfat  filesystem - CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: green;'> vfat filesystem already disabled- CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
fi

modprobe -n -v msdos | grep -E '(msdos|install)' |  grep -E '(\/bin\/true)' > /dev/null 2>&1
if  [ $? -ne 0 ] ;  then
 echo -e "<p style='color: red;'>disable and unload msdos  filesystem - CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: red;'> msdos filesystem already disabled- CIS 1.1.1.3 </p>" >>/var/log/cis_1_0_status.html
fi

# CIS 1.1.2 Ensure /tmp is configured . This is Memory Filesystem.
# However after rebooting the server, all the contents of /tmp filesystem will be lost i.e.
# Files in tmpfs are automatically cleared at each bootup.  However, the tmpfs type is not recommended for SAP Installation.
# tmpfs    /tmp        tmpfs    nosuid,nodev,noexec     0 0

mount | grep -E '\s/tmp\s'  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.2 to CIS 1.1.5 - Recommend to create partition for /tmp filesystem and setnosuid,noexec and nodev attributes for /tmp filesystem. Ensure that FS type tmpfs should not be defined for /tmp mountpoint </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>\tmp filesystem is present </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/tmp\s' | grep  noexec > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.3 noexec mount option for /tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.3 noexec mount option for /tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi

mount | grep -E '\s/tmp\s' | grep  nodev > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.4 nodev mount option for /tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.4 nodev mount option for /tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/tmp\s' | grep  nosuid > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.5 nosuid mount option for /tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.5 nosuid mount option for /tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
#
# CIS 1.1.6 Ensure /dev/shm is configured .

mount | grep -E '\s/dev/shm\s'  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
 echo -e "<p style='color: red;'>CIS - 1.1.6 to CIS 1.1.9 Add the entry 'tmpfs    /dev/shm           tmpfs    defaults, nosuid,nodev,noexec, size=2G      0  0' in the /etc/fstab and run the remount command 'mount -o noexec,nodev,nosuid /dev/shm' </p>" >>/var/log/cis_1_0_status.html
else
 echo -e "<p style='color: green;'>CIS - 1.1.6 to CIS 1.1.9  /dev/shm already mounted </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/dev/shm\s'| grep  noexec  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.7 noexec mount option for /dev/shm not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.7 noexec mount option for /dev/shm already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/dev/shm\s'| grep  nodev  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.8 nodev mount option for /dev/shm not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.8 nodev mount option for /dev/shm already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/dev/shm\s'| grep  nosuid  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.9 nosuid mount option for /dev/shm not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.9 nosuid mount option for /dev/shm already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
# CIS 1.1.10 Ensure separate partition exists for /var . By default, During Unix installation, /var directory is created under the "/" filesystem.
#  The /var directory is used by daemons and other system services to temporarily store dynamic data.

findmnt --kernel /var  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.10 For new installations, during installation create a custom partition setup and specify a separate partition for /var  </p>" >>/var/log/cis_1_0_status.html
echo -e "<p style='color: red;'>Also  '/var /dev/<sdb>  ext4 rw,relatime,seclabel,data=ordered' to be maintained in the /etc/fstab file and then remount </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.10 /var filesystem is already mounted </p>" >>/var/log/cis_1_0_status.html
fi

# CIS 1.1.11 Ensure separate partition exists for /var/tmp
# tmpfs should not be used for /var/tmp/
# tmpfs is a temporary filesystem that resides in memory and/or swap partition(s).
# Files in tmpfs are automatically cleared at each bootup .
# Check whether /var/tmp mountpoint is present or not.
mount | grep /var/tmp  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.11 /var/tmp FS not exists </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.11 /var/tmp filesystem exists</p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/var/tmp\s'| grep  noexec  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.12 noexec mount option for /var/tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.12 noexec mount option for /var/tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
mount | grep -E '\s/var/tmp\s'| grep  nodev  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.13 nodev mount option for /var/tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.13 nodev mount option for /var/tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi

mount | grep -E '\s/var/tmp\s'| grep  nosuid  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.14 nosuid mount option for /var/tmp not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.14 nosuid mount option for /var/tmp already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi
#
# CIS 1.1.15 Ensure separate partition exists for /var/log
# The /var/log directory is used by system services to store log data.  Since no attributes are defined for /var/log,  ignore this section.

findmnt --kernel /var/log  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> CIS 1.1.15  /var/log filesystem not exists  </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.15 /var/log filesystem exists </p>" >>/var/log/cis_1_0_status.html
fi

# CIS 1.1.16 Ensure separate partition exists for /var/log/audit

findmnt --kernel /var/log/audit  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CSI 1.1.16  /var/log/audit filesystem not exists  </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.16 /var/log/audit filesystem exists </p>" >>/var/log/cis_1_0_status.html
fi


# CIS 1.1.17 Ensure separate partition exists for /home .
mount | grep /home  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "\n CIS 1.1.17   /home filesystem not exists.   </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.17 /home filesystem exists </p>" >>/var/log/cis_1_0_status.html
fi

mount | grep -E '\s/home\s'| grep  nodev  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.1.18 nodev mount option for /home not added in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.1.18 nodev mount option for /home already present in /etc/fstab </p>" >>/var/log/cis_1_0_status.html
fi

#
# CIS 1.1.19, 1.1.20 and 1.1.21 Ensure noexec, nodev and nosuid  option set on      # removable media partitions.
# This cannot be used as we need to execute manually. SO ignore this section
echo -e "\n CIS 1.1.19, 1.1.20 and 1.1.21 This cannot be checked validation  as we need to execute this manually. SO ignore this section </p>" >>/var/log/cis_1_0_status.html

# 1.1.22 Ensure sticky bit is set on all world-writable directories
echo -e "\n CIS 1.22 Run the following command to verify no world writable directories exist without the sticky bit set:" >>/var/log/cis_1_0_status.html
df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) >>/var/log/cis_1_0_status.html
df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>1.1.22 if the above foldder or fiename is returned then then  sticky bit is not set on all world-writable as listed above>' </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>1.1.22 if  sticky bit is already  set on all world-writable as listed above>' </p>" >>/var/log/cis_1_0_status.html
fi

# CIS 1.1.23 Disable Automounting
# automatic mounting of devices, typically including CD/DVDs and USB drives must be disabled.
# The command to check whether it is automatically mounted or not

systemctl -q is-enabled autofs  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: green;'>CIS 1.1.23 Automatic mounting of devices such as CD. DVD, USB drives  is disabled</p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'>CIS 1.1.23 Disable or mask the automatic mounting of devices such as CD. DVD, USB drives. </p>" >>/var/log/cis_1_0_status.html
fi

#---------------------------------------------End of CIS 1.1 -------------------------------------------------#

#---------------------Begin of CIS 1.2------------------------------------------------------------------------#

# CIS 1.1 Configure SOftware Updates

# CIS 1.2.1 Ensure GPG keys are configured (Manual)
# Verify GPG keys are configured correctly for your package manager. Depending on the # package management in use one of the following command groups may provide the # needed information:
rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n' 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.2.1 Update your package manager GPG keys in accordance with site policy - # CIS 1.2.1 Ensure GPG keys are configured (Manual) </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'>CIS 1.2.1 No need to Update package manager GPG keys  </p>" >> /var/log/cis_1_0_status.html
fi

#  CIS 1.2.2 Ensure package manager repositories are configured (Manual)
# Ignore this section.
echo -e "\n CIS 1.2.2  Ensure package manager repositories are configured . Run the  following command to verify repositories are configured correctly 'zypper repos' </p>" >> /var/log/cis_1_0_status.html

# CIS 1.2.3 Ensure gpgcheck is globally activated
# It is important to ensure that an RPM's package signature is always checked prior to # # installation to ensure that the software is obtained from a trusted source
# Run the following command and verify gpgcheck is set to 1:

if [[ -f /etc/zypp/zypp.conf ]] ; then
grep ^\s*gpgcheck /etc/zypp/zypp.conf  2>&1 > /dev/null
  if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.2.3 'gpgcheck' is not set to 1. Edit /etc/zypp/zypp.conf and set 'gpgcheck=1' in the [main] section </p>"  >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.2.3 'gpgcheck' was set to 1.  No action required.</p>"  >> /var/log/cis_1_0_status.html
  fi
else 
echo -e "<p style='color: red;'>CIS 1.2.23 file /etc/zypp/zypp.conf not found </p>" >> /var/log/cis_1_0_status.html
fi
#---------------------------------------------End of CIS 1.2 -------------------------------------------------#

#---------------------Begin of CIS 1.3------------------------------------------------#

# CIS 1.3 Configure Sudo
#
#

# CIS 1.3
# CIS 1.3 Configure sudo
# CIS 1.3.1 Ensure sudo is installed
# Run the following command to verify that sudo is installed:

rpm -q sudo > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.3.1 sudo is not installed. Install sudo package using zypper command </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.3.1 sudo ialready installed. No action required  </p>" >> /var/log/cis_1_0_status.html
fi
# CIS 1.3.2 Ensure sudo commands use pty
# This can be mitigated by configuring sudo to run other commands only from a
#  pseudo-pty, whether I/O logging is turned on or not.

grep -Ei '^\s*Defaults\s+use_pty\b' /etc/sudoers  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.3.2 entry 'Defaults use_pty' not maintained in /etc/sudoers file. iRecommend to  add the entry ''Defaults use_pty' in the /etc/sudoers file. </p>" >> /var/log/cis_1_0_status.html 
else
echo -e "<p style='color: green;'>CIS 1.3.2 entry 'Defaults use_pty' already maintained in /etc/sudoers file. no action required. </p>" >> /var/log/cis_1_0_status.html
fi
#

#CIS 1.3.3 Ensure sudo log file exists
# Verify that sudo has a custom log file configured
# Run the following command:

grep -Ei '^\s*Defaults\s+logfile' /etc/sudoers /etc/sudoers.d/* > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.3.3 entry 'Defaults logfile="/var/log/sudo.log"' not not maintained in /etc/sudoers file. iRecommend to  add the entry ''Defaults use_pty' in the /etc/sudoers file. </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.3.3 entry 'Defaults logfile="/var/log/sudo.log"' not not maintained in /etc/sudoers file.No action required. </p>" >> /var/log/cis_1_0_status.html
fi


#---------------------------------------------End of CIS 1 .3------------------------------------------------#
#---------------------Begin of CIS 1.4----------------------------#

# CIS 1.4 Filesystems Integrity
# CIS 1.4.1 Ensure AIDE is installed
# AIDE takes a snapshot of filesystem state including modification times, permissions,
# Run the following command to verify that aide is installed:

rpm -q aide  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.4.1 AIDE is not installed. Install AIDE  and then initialize AIDE. </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.4.1 AIDE already  installed. No action </p>" >> /var/log/cis_1_0_status.html
fi

crontab -u root -l  > /dev/null 2>&1
if [ $? -eq 0 ] ; then
crontab -u root -l | grep aide  > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.4.2  no cron job scheduled to run the aide </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.4.2 cron job already scheduled to run the aide. No Action </p>" >> /var/log/cis_1_0_status.html
fi
else
echo -e "<p style='color: red;'>CIS 1.4.2  no crontab for root defined  </p>" >> /var/log/cis_1_0_status.html
fi

systemctl is-enabled aidecheck.service > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.4.2  aidecheck.service is not enabled. Enable aidecheck.service </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.4.2  aidecheck.service is  enabled. </p>" >> /var/log/cis_1_0_status.html
fi

systemctl is-enabled aidecheck.timer > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.4.2  aidecheck.timer  is not enabled. Enable aidecheck.timer  </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.4.2  aidecheck.timer  is  enabled. </p>" >> /var/log/cis_1_0_status.html
fi
#

#---------------------------------------------End of CIS 1 .4------------------------------------------------#
#---------------------Begin of CIS 1.5----------------------------#

# CIS 1.5 Secure Boot settings
#
#

# CIS 1.5.1 Ensure bootloader password is set. Ignore this setting. We will check this CIS 1.5.1 in the next phase
grep "^\s*set superusers" /boot/grub2/grub.cfg > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.5.1 bootloader set superuser and password is not set.  </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.1 bootloader set superuser and password is set.  </p>" >>/var/log/cis_1_0_status.html
fi


# CIS 1.5.2 Ensure permissions on bootloader config are configured
# Run the following commands to set ownership and permissions on your grub
# configuration:
if [[ $(stat -c  "%a"  /boot/grub2/grub.cfg) != 600 ]]; then
echo -e "<p style='color: red;'>CIS 1.5.2 permission for   /boot/grub2/grub.cfg not  set to 600 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.2 permission for   /boot/grub2/grub.cfg correctly   set to 600 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U"  /boot/grub2/grub.cfg) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.5.2 Ownership for  /boot/grub2/grub.cfg not  set to 'root' </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.2 Ownership for  /boot/grub2/grub.cfg correctly set to 'root' </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G"  /boot/grub2/grub.cfg) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.5.2 Group for  /boot/grub2/grub.cfg not  set to 'root' </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.2 Group for  /boot/grub2/grub.cfg correctly set to 'root' </p>" >>/var/log/cis_6_0_status.html
fi
#
# 1.5.3 Ensure authentication required for single user mode. Ignore this section.
grep /systemd-sulogin-shell /usr/lib/systemd/system/rescue.service > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.5.3 Entry 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell rescue' must be added in /usr/lib/systemd/system/rescue.service file. </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.3 Entry 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell rescue' already added  in /usr/lib/systemd/system/rescue.service file. </p>" >>/var/log/cis_1_0_status.html
fi

grep /systemd-sulogin-shell /usr/lib/systemd/system/emergency.service > /dev/null 2>&1
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.5.3 Entry 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell emergency' must be added in /usr/lib/systemd/system/emergency.service file. </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.5.3 Entry 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell emergency' already added  in /usr/lib/systemd/system/emergency.service file. </p>" >>/var/log/cis_1_0_status.html
fi

#---------------------------------------------End of CIS 1 .5------------------------------------------------#
#---------------------Begin of CIS 1.6----------------------------#

# CIS 1.6  Additional Process Hardening
#
# CIS 1.6.1 Ensure core dumps are restricted
#
#if [ ! -f  /etc/security/limits.d/* ] ; then


if [  -f  /etc/security/limits.conf/ ] ; then
grep -E "^\s*\*\s+hard\s+core" /etc/security/limits.conf 2>&1 > /dev/null
    if [ $? -ne 0 ] ; then
# Add the following line * hard core  to /etc/security/limits.conf or
echo -e "<p style='color: red;'>CIS 1.6.1 entry '* hard core 0' not added in /etc/security/limits.conf' </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.6.1 entry '* hard core 0' already added in /etc/security/limits.conf' </p>" >>/var/log/cis_1_0_status.html
   fi
fi

#
sysctl fs.suid_dumpable 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.6.1 entry 'fs.suid_dumpable = 0 not added in /etc/sysctl.conf or a /etc/sysctl.d/* file </p>" >>/var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.6.1 entry 'fs.suid_dumpable = 0' already added in /etc/sysctl.conf or a /etc/sysctl.d/* file' </p>" >>/var/log/cis_1_0_status.html
fi

#

rpm -q systemd-coredump 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.6.1 systemd-coredump is not installed and  not enabled. Install systemd-coredump and then add Storage=none and ProcessSizeMax=0 in /etc/systemd/coredump.conf </p>" >>/var/log/cis_1_0_status.html
else 
echo -e "<p style='color: green;'>CIS 1.6.1 systemd-coredump is installed If it is installed  then add Storage=none and ProcessSizeMax=0 in /etc/systemd/coredump.conf </p>" >>/var/log/cis_1_0_status.html
  fi

#
#  CIS 1.6.2 Ensure XD/NX support is enabled
# Ignore this section.
journalctl | grep 'protection: active' 2>&1 > /dev/null
if [ $? -eq 0 ] ; then
echo -e "<p style='color: green;'>CIS 1.6.2  kernel has identified and activated NX/XD protection. No action required for 64 bit processors \n " >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'>CIS 1.6.2  Not activated NX/XD protection. System not supported NX/DX protection. COntact hardware vendor  \n " >> /var/log/cis_1_0_status.html
fi

# CIS .6.3 Ensure address space layout randomization (ASLR) is enabled  Randomly placing virtual memory regions will make it difficult to write memory page # exploits as the memory placement will be consistently shifting. Run the following commands and verify output matches: #
#
sysctl kernel.randomize_va_space 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> entry not added 'kernel.randomize_va_space = 2' in /etc/sysctl.d/01-kernel.randomize_va_space.conf </p>"  >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>kernel.randomize_va_space is already present and activated in kernel parameter </p>"  >> /var/log/cis_1_0_status.html
fi
#
# CIS 1.6.4 Ensure prelink is disabled (Automated)

#Run the following command to verify that 1prelink` is not installed:

rpm -q prelink 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: green;'>CIS 1.6.4 Package prelink is not installed -  CIS 1.6.4 </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'>CIS 1.6.4run cmmand 'prelink -ua' to restore binaries to normal and then uninstall prelink package using zypper command </p>" >> /var/log/cis_1_0_status.html
fi

#---------------------------------------------End of CIS 1 .6------------------------------------------------#
#---------------------------------------------Begin of CIS 1 .7------------------------------------------------#

# 1.7.1 Configure AppArmor 

rpm -q apparmor 2>&1 > /dev/null

if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'> CIS 1.7.1 apparmor package not installed. Install apparmor package using zypper command   </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.7.1 Package apparmor  is already  installed -  CIS 1.7.1 </p>" >> /var/log/cis_1_0_status.html
fi

#1.7.1.2 Ensure AppArmor is enabled in the bootloader configuration (Automated)
#Run the following commands to verify that all linux lines have the apparmor=1 and security=apparmor parameters set:

grep "^\s*linux" /boot/grub2/grub.cfg | grep -v "apparmor=1" 2>&1 > /dev/null
if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.7.1.2 AppArmor is not enabled at boot time in your bootloader configuration. Add 'GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"' </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.7.1.2 AppArmor is enabled at boot time in your bootloader configuration. No Action required </p>" >> /var/log/cis_1_0_status.html
fi
#---------------------------------------------End of CIS 1 .7------------------------------------------------#

#---------------------Begin of CIS 1.8-----------------------------------------------------------------------#

# CIS 1.8  Warning banners
# CIS 1.8  Warning Banners
# CIS 1.8.1  1.8.1 Command Line Warning Banners

# Run the following command and verify no results are returned:
#
grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd 2>&1 > /dev/null
if [ $? -eq 0 ] ; then 
echo -e "<p style='color: red;'>CIS 1.8.1  Information present in /etc/motd if they display operating system information: \m - machine architecture \r - operating system release \s - operating system name \v - operating system version etc </p>" >> /var/log/cis_1_0_status.html
echo -e "\n CIS 1.8.1 if machine type RAM memory value, OS release vesrion shown in the output of grep command as shown above ,please remove entry line in /etc/motd </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.8.1  not showing operating system information: \m - machine architecture \r - operating system release \s - operating system name \v - operating system version etc in /etc/motd file </p>" >> /var/log/cis_1_0_status.html
fi


#
# CIS 1.8.1.2 Ensure local login warning banner is configured properly
# Edit the /etc/issue file with the appropriate contents according to your site policy, remove any instances of \m , \r , \s , \v or references to the OS platform #
#
if [ ! -f /etc/issue  ] ; then
echo -e "<p style='color: red;'>CIS 1.8.1.2 /etc/issue file is not present </p>" >> /var/log/cis_1_0_status.html
else
# Run the following command and verify no results are returned:
grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f3 | sed -e 's/"//g'))" /etc/issue 2>&1 > /dev/null
    if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.8.1.1.2 if machine type RAM memory value, OS release vesrion present in the /etc/issue , remove all entry lines in /etc/issue </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.8.1.2 entry lines not present in  /etc/issue file \n " >> /var/log/cis_1_0_status.html
 fi
fi
# CIS 1.8.1.3 Ensure remote login warning banner is configured properly
 # Edit the /etc/issue.net file with the appropriate contents according to your site policy, remove any instances of \m , \r , \s , \v or references to the OS platform #
if [ ! -f /etc/issue.net  ] ; then
echo -e "<p style='color: red;'>CIS 1.8.1.3 /etc/issue.net file is not present </p>" >> /var/log/cis_1_0_status.html
else
# Run the following command and verify no results are returned:
grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net 2>&1 > /dev/null
    if [ $? -eq 0 ] ; then
echo -e "<p style='color: red;'>CIS 1.8.1.3 if machine type RAM memory value, OS release vesrion present in the /etc/issue.net remove entry line in /etc/issue.net  </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>CIS 1.8.1.3 entry lines not present in  /etc/issue file \n " >> /var/log/cis_1_0_status.html
 fi
fi


#  CIS 1.8.1.4, 1.8.1.5,1.8.1.6  Ensure permissions on /etc/motd , /etc/issue. /etcv/issue.net are configured "
if [[ $(stat -c "%a" /etc/motd) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.4 - permissions for /etc/motd is not 644. Change the permission to 644 </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.4 - permissions for /etc/motd is 644. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [[ $(stat -c "%U" /etc/motd) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.4 - Ownership  for /etc/motd is not root. Change the ownership to root </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.4 - Ownership  for /etc/motd is root. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [[ $(stat -c "%G" /etc/motd) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.4 - Group  for /etc/motd is not root. Change the Group to root </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.4 - Group  for /etc/motd is root. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [[ $(stat -c "%a" /etc/issue) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.5 - permissions for /etc/issue is not 644. change the permission to 644 </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.5 - permissions for /etc/issue is 644. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [[ $(stat -c "%U" /etc/issue) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.5 - Ownership  for /etc/issue is not root. Change the ownership to root </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.5 - Ownership  for /etc/issue is root. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [[ $(stat -c "%G" /etc/issue) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 1.8.1.5 - Group  for /etc/issue is not root. Change the Group to root </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'> CIS 1.8.1.5 - Group  for /etc/issue is root. No action required. n" >> /var/log/cis_1_0_status.html
fi

if [  -f /etc/issue.net  ] ; then
  if [[ $(stat -c "%a" /etc/issue.net) != 644 ]]; then
  echo -e "<p style='color: red;'>CIS 1.8.1.6 - permissions for /etc/issue.net is not 644. change the permission to 644 </p>" >> /var/log/cis_1_0_status.html
  else
  echo -e "<p style='color: green;'> CIS 1.8.1.6 - permissions for /etc/issue.net is 644. No action required. n" >> /var/log/cis_1_0_status.html
  fi

  if [[ $(stat -c "%U" /etc/issue.net) != "root" ]]; then
  echo -e "<p style='color: red;'>CIS 1.8.1.6 - Ownership  for /etc/issue.net is not root. Change the ownership to root </p>" >> /var/log/cis_1_0_status.html
  else
  echo -e "<p style='color: green;'> CIS 1.8.1.6 - Ownership  for /etc/issue.net is root. No action required. n" >> /var/log/cis_1_0_status.html
  fi

  if [[ $(stat -c "%G" /etc/issue.net) != "root" ]]; then
  echo -e "<p style='color: red;'>CIS 1.8.1.6 - Group  for /etc/issue.net is not root. Change the Group to root </p>" >> /var/log/cis_1_0_status.html
  else
  echo -e "<p style='color: green;'> CIS 1.8.1.6 - Group  for /etc/issue.net is root. No action required. n" >> /var/log/cis_1_0_status.html
  fi
else
echo -e "<p style='color: red;'>CIS 1.8.1.6 /etc/issue.net file is not present </p>" >> /var/log/cis_1_0_status.html
fi



#---------------------------------------------End of CIS 1 .8------------------------------------------------#
#---------------------Begin of CIS 1.9 ----------------------------#

# CIS 1.9   Updates Patches and Additional Security softwares
#
# CIS 1.9  Ensure updates, patches, and additional security software are installed
# This is manual acton .
# Run the following command and verify there are no updates or patches to install:
zypper -n list-updates |grep -q "No updates found." 2>&1 > /dev/null
# Update the Patch software
if [ $? -ne 0 ] ; then
echo -e "<p style='color: red;'>updates are available. Perform latest update </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: green;'>No updates found.  </p>" >> /var/log/cis_1_0_status.html
fi


#---------------------End of CIS 1.9---------------------------------------------------------#
#---------------------Begin of  CIS 1.10----------------------------------------------------#

#  CIS 1.10 Ensure GDM is removed or login is configured
# Run the following command to verify the GDM is not installed on the system:
rpm -q gdm 2>&1 > /dev/null
if [ $? -ne 0 ] ; then
echo -e "<p style='color: green;'> CIS 1.10  - gdm software is not installed. </p>" >> /var/log/cis_1_0_status.html
else
echo -e "<p style='color: red;'> CIS 1.10  - recommend to uninstall gdm software.  </p>" >> /var/log/cis_1_0_status.html
fi



echo -e "\n ------------------------ CIS 1.0   Script execution completed  --------------------\n"
echo -e "<p style='color: green;'>-------------------------------------End of  CIS 1.0-----------------------------------------------------------</p>"  >> /var/log/cis_1_0_status.html
echo -e "\n  check the status or validation report  file located in /var/log/cis_1_0_status.html \n"
echo -e "\n  check the Error log file located in /var/log/cis_1_0.log "
#---------------------End of CIS 1.10-------------------------------------------------------------#
if [ ! -d /var/local ] ; then
mkdir -p /var/local
fi
check_exitstatus

cat << EOF >> /var/local/CIS_1_0-hardened
CIS_1_0 script  for validation for SLES completed
EOF

echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_1_0_status.html
echo -e "\n Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 \n"
exit 0

#---------------------Begin of CIS 6.0----------------------------#

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
                echo "${LOGERR} execution of command failed" >>/var/log/cis_6_0.log
                exit 1
        fi
}

# Whether script has already been implemented
# if [ -e /var/local/ccc-hardened ] ; then
#  echo "script has already been implemented (/var/local/ccc-hardened exist)"
#  exit 0
# fi
if [ -e /var/log/cis_6_0.log ] ; then
 rm /var/log/cis_6_0.log
fi


if [ -e /var/log/cis_6_0_status.html ] ; then
 rm /var/log/cis_6_0_status.html
fi

if [ -e /var/local/CIS_6_0-hardened ]
then
  echo -e "\n CIS_6_0-hardened script has already been implemented \n"
  exit 0
fi

if [[ $( grep "^NAME" /etc/os-release|cut -f2 -d=) != "\"SLES\""  ]] ; then
echo -e "\n This is not SLES Linux OS. Shell script works only on SLES Linux OS \n"
exit 0
echo -e "\n This is SUSE Linux OS. \n"
fi

echo -e " <span style='color: blue;'>\n--------------------------CIS 6.0 System Maintenance ---------------------------------------------------------------------------</p>\n" >>/var/log/cis_6_0_status.html
# 6.1.1 Audit system file permissions 
echo -e  "<p style='color: red;'> CIS 6.1.1 - This is Manual activity.  ignore  </p>" >>/var/log/cis_6_0_status.html

# 6.1.2, 6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7
#  Ensure permissions on /etc/passwd, /etc/shadow, /etc/group,  /etc/passwd- , /etc/shadow-  , /etc/group- are configured 
if [[ $(stat -c  "%a" /etc/passwd) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.2 permission for /etc/password not  set to 644 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.2 permission for /etc/password correctly   set to 644 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/passwd) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.2 Ownership for /etc/password not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.2 ownership for /etc/password correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/passwd) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.2 Group for /etc/password not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.2 Group for /etc/password correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%a" /etc/shadow) != 640 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.3 permission for /etc/shadow not  set to 640 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.3 permission for /etc/shadow correctly   set to 640 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/shadow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.3 Ownership for /etc/shadow not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.3 Ownership for /etc/shadow correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/shadow) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.3 Group for /etc/shadow not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.3 Group for /etc/shadow correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%a" /etc/group) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.4 permission for /etc/group not  set to 644 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.4 permission for /etc/group correctly   set to 644 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/group) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.4 Ownership for /etc/group not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.4 Ownership for /etc/group correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/group) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.4 Group for /etc/group not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.4 Group for /etc/group correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi


if [[ $(stat -c  "%a" /etc/passwd-) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.5 permission for /etc/password- not  set to 644 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.5 permission for /etc/password- correctly   set to 644 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/passwd-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.5 Ownership for /etc/password- not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.5 ownership for /etc/password- correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/passwd-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.5 Group for /etc/password- not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.5 Group for /etc/password- correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%a" /etc/shadow-) != 640 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.6 permission for /etc/shadow- not  set to 640 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.6 permission for /etc/shadow- correctly   set to 640 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/shadow-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.6 Ownership for /etc/shadow- not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.6 Ownership for /etc/shadow- correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/shadow-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.6 Group for /etc/shadow not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.6 Group for /etc/shadow correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%a" /etc/group-) != 644 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.7 permission for /etc/group- not  set to 644 </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.7 permission for /etc/group- correctly   set to 644 </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%U" /etc/group-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.7 Ownership for /etc/group- not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.7 Ownership for /etc/group- correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

if [[ $(stat -c  "%G" /etc/group-) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.1.7 Group for /etc/group- not  set to non-root </p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.7 Group for /etc/group- correctly   set to root </p>" >>/var/log/cis_6_0_status.html
fi

# CIS 6.1.8 Ensure no world writable files exist
echo -e "\n CIS 6.1.8 verify no files are returned. If following files are retured then Removing write access for the "other" category ( chmod o-w <filename> ) is advisable </p>" >> /var/log/cis_6_0_status.html 
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 >> /var/log/cis_6_0_status.html

if [[ $(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002| wc -l) != 0 ]]; then 
echo -e "<p style='color: red;'>CIS 6.1.8 world writables files exist </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.8 world writables files not exists </p>" >> /var/log/cis_6_0_status.html
fi

# CIS 6.1.9 Ensure no unowned files or directories exist
echo -e "\n CIS 6.1.9 verify no list of unknown users files are returned. If following files are retured then change the ownership or user using command chown </p>" >> /var/log/cis_6_0_status.html

df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser >> /var/log/cis_6_0_status.html
if [[ $(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser| wc -l ) != 0 ]]; then 
echo -e "<p style='color: red;'>CIS 6.1.9 list of unknown users files are returned. If following files are retured then change the ownership   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.9 unknown users files are not listed  </p>" >> /var/log/cis_6_0_status.html
fi



# 6.1.10 Ensure no ungrouped files or directories exist
echo -e "\n CIS 6.1.10 verify no list of unknown group files are returned. If following files are retured then change the ownership or user using command chown </p>" >> /var/log/cis_6_0_status.html

df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup >> /var/log/cis_6_0_status.html
if [[ $(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup| wc -l) != 0 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.10 list of unknown group  files are listed. If following files are listed then change the group   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.10 unknown group files are not listed  </p>" >> /var/log/cis_6_0_status.html
fi


# 6.1.11 Audit SUID executables 
echo -e "\n CIS 6.1.11 verify no list of SUID  files are returned. If following files are retured then change then review the permission of the following files   </p>" >> /var/log/cis_6_0_status.html

df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 >> /var/log/cis_6_0_status.html
if [[ $(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000|wc -l)  != 0 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.11 list of SUID files are returned or listed. If following files are listed then change the SUID   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.11 SUID files are not listed  </p>" >> /var/log/cis_6_0_status.html
fi

# 6.1.12 Audit SGID executables
echo -e "\n CIS 6.1.12 verify no list of SGID  files are returned. If following files are retured then change then review the permission of the following files   </p>" >> /var/log/cis_6_0_status.html

df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 >> /var/log/cis_6_0_status.html
if [[ $(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000|wc -l) != 0 ]]; then
echo -e "<p style='color: red;'>CIS 6.1.12 list of SGID files are returned or listed. If following files are listed then change the SGID   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.1.12 SGID files are not listed  </p>" >> /var/log/cis_6_0_status.html
fi

# 6.2.1 Ensure accounts in /etc/passwd use shadowed passwords
echo -e "\n CIS 6.2.1 List the following users that does not have "x" in /etc/passwd    </p>" >> /var/log/cis_6_0_status.html
awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd >> /var/log/cis_6_0_status.html
if [[ $( awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd|wc -l) != 0 ]]; then 
echo -e "<p style='color: red;'>CIS 6.2.1 list of accounts in /etc/passwd exists i.e. list of users does not have 'x'   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.2.1 no list of accounts in /etc/passwd  </p>" >> /var/log/cis_6_0_status.html
fi

# 6.2.2 Ensure /etc/shadow password fields are not empty 

echo -e  "\n  6.2.2 run the command  user does  not have a password \n " >>/var/log/cis_6_0_status.html
awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow >> /var/log/cis_6_0_status.html
if [[ $(awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow|wc -l) != 0 ]]; then
echo -e "<p style='color: red;'>CIS 6.2.2 list of accounts in /etc/passwd exists i.e. list of users does not  have password   </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.2.2 no list of accounts in /etc/passwd  </p>" >> /var/log/cis_6_0_status.html
fi

# 6.2.3 Ensure root is the only UID 0 account 
echo -e  "\n 6.2.3  run the command  ensure root is the only UID 0 account \n " >>/var/log/cis_6_0_status.html
if [[ $(awk -F: '($3 == 0) { print $1 }' /etc/passwd ) != "root" ]]; then
echo -e "<p style='color: red;'>CIS 6.2.3 non-compliance. Output 'non-root' returned  </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>CIS 6.2.3 compliance as the output returned root  </p>" >> /var/log/cis_6_0_status.html
fi

# 6.2.4 Ensure root PATH Integrity (Automated) 
echo -e  "\n   6.2.4 run the following command to verify that no results are returned </p>" >>/var/log/cis_6_0_status.html
if echo "$PATH" | grep -q "::" ; then 
echo -e "<p style='color: red;'>6.2.4 Empty Directory in PATH (::)"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.4 No Empty directory exists in Path </p>"  >>/var/log/cis_6_0_status.html
fi 

if echo "$PATH" | grep -q ":$" ; then 
echo -e "<p style='color: red;'>6.2.4 Trailing : in PATH" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.4 No Trailing ':' present in PATH" >>/var/log/cis_6_0_status.html
fi 

for x in $(echo "$PATH" | tr ":" " ") ; do
if [ -d "$x" ] ; then
ls -ldH "$x" | awk ' $9 == "." {print "PATH contains current working directory (.)"}
$3 != "root" {print $9, "is not owned by root"}
substr($1,6,1) != "-" {print $9, "is group writable"}
substr($1,9,1) != "-" {print $9, "is world writable"}' >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: red;'>6.2.4 $x is not a directory" >>/var/log/cis_6_0_status.html
fi
done

# 6.2.5  Ensure all users' home directories exist
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read -r user dir; do
if [ ! -d "$dir" ]; then
echo -e "<p style='color: red;'> 6.2.5 The home directory ($dir) of user $user does not exist.</p>" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'> 6.2.5 No results are returned. </p>" >>/var/log/cis_6_0_status.html
fi
 done
#
#6.2.6 Ensure users' home directories permissions are 750 or more restrictive

grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; 
do
if [ ! -d "$dir" ]; then
echo -e "<p style='color: red;'>6.2.6 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
dirperm=$(ls -ld $dir | cut -f1 -d" ")
     if [ $(echo $dirperm | cut -c6) != "-" ]; then
     echo -e "<p style='color: red;'>6.2.6 Group Write permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
    else
     echo -e "<p style='color: green;'>6.2.6 No Group Write permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
     fi
   if [ $(echo $dirperm | cut -c8) != "-" ]; then
   echo -e "<p style='color: red;'>6.2.6 Other Read permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
    else
    echo -e "<p style='color: green;'>6.2.6 No Other Read permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
   fi
 if [ $(echo $dirperm | cut -c9) != "-" ]; then
 echo -e "<p style='color: red;'>6.2.6 Other Write permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
    else
    echo -e "<p style='color: green;'>6.2.6 No Other Write permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
 fi
 if [ $(echo $dirperm | cut -c10) != "-" ]; then 
 echo -e "<p style='color: red;'>6.2.6 Other Execute permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
    else
echo -e "<p style='color: green;'>6.2.6 No Other Execute permission set on the home directory ($dir) of user $user" >>/var/log/cis_6_0_status.html
 fi
fi
done
#
# 6.2.7  Ensure users own their home directories
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir;
do
if [ ! -d "$dir" ]; then
echo -e "<p style='color: red;'>6.2.7 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
owner=$(stat -L -c "%U" "$dir")
  if [ "$owner" != "$user" ]; then
  echo -e "<p style='color: red;'>6.2.7 The home directory ($dir) of user $user is owned by $owner." >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.7 The home directory ($dir) of user $user is NOT owned by $owner." >>/var/log/cis_6_0_status.html
  fi
fi
done
#
# 6.2.8 Ensure users' dot files are not group or world writable
grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir;
do
if [ ! -d "$dir" ]; then
echo -e "<p style='color: red;'>6.2.8 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
  for file in $dir/.[A-Za-z0-9]*; do
    if [ ! -h "$file" -a -f "$file" ]; then
    fileperm=$(ls -ld $file | cut -f1 -d" ")
          if [ $(echo $fileperm | cut -c6) != "-" ]; then
          echo -e "<p style='color: red;'>6.2.8 Group Write permission set on file $file" >>/var/log/cis_6_0_status.html
          else
          echo -e "<p style='color: green;'>6.2.8 Group Write permission NOT set on file $file" >>/var/log/cis_6_0_status.html
          fi
              if [ $(echo $fileperm | cut -c9) != "-" ]; then
              echo -e "<p style='color: red;'>6.2.8 Other Write permission set on file $file" >>/var/log/cis_6_0_status.html
               else
              echo -e "<p style='color: green;'>6.2.8 Other Write permission NOT set on file $file" >>/var/log/cis_6_0_status.html
              fi
    fi
  done
fi
done

# 6.2.9 Ensure no users have .forward files
awk -F: '($1 !~ /^(root|halt|sync|shutdown)$/ && $7 != "'"$(which nologin)"'" && $7 != "/bin/false" && $7 != "/usr/bin/false") { print $1 " " $6 }' /etc/passwd | while read user dir;
do
if [ ! -d "$dir" ] ; then
echo -e "<p style='color: red;'>6.2.9 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
     if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ] ; then
     echo -e "<p style='color: red;'>6.2.9 .forward file $dir/.forward exists" >>/var/log/cis_6_0_status.html
     else
     echo -e "<p style='color: green;'>6.2.9 .forward file $dir/.forward NOT exists" >>/var/log/cis_6_0_status.html
     fi
fi
done

# 6.2.10 Ensure no users have .netrc files
awk -F: '($1 !~ /^(root|halt|sync|shutdown)$/ && $7 != "'"$(which nologin)"'" && $7 != "/bin/false" && $7 != "/usr/bin/false") { print $1 " " $6 }' /etc/passwd | while read user dir; do
if [ ! -d "$dir" ]; then
echo -e "\n 6.2.10R The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
    if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
    echo -e "<p style='color: red;'>6.2.10 .netrc file $dir/.netrc exists" >>/var/log/cis_6_0_status.html
    else
    echo -e "<p style='color: green;'>6.2.10 .netrc file $dir/.netrc NOT exists" >>/var/log/cis_6_0_status.html
    fi
fi
done

# 6.2.11 Ensure users' .netrc Files are not group or world accessible
awk -F: '($1 !~ /^(root|halt|sync|shutdown)$/ && $7 != "'"$(which nologin)"'" && $7 != "/bin/false" && $7 != "/usr/bin/false") { print $1 " " $6 }' /etc/passwd | while read user dir; do
if [ ! -d "$dir" ]; then
echo -e "<p style='color: red;'>6.2.11 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else
for file in $dir/.netrc; do
if [ ! -h "$file" -a -f "$file" ]; then
fileperm=$(ls -ld $file | cut -f1 -d" ")
if [ $(echo $fileperm | cut -c5) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Group Read set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Group Read NOT set on $file"  >>/var/log/cis_6_0_status.html
fi
if [ $(echo $fileperm | cut -c6) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Group Write set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Group Write NOT set on $file"  >>/var/log/cis_6_0_status.html
fi
if [ $(echo $fileperm | cut -c7) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Group Execute set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Group Execute NOT set on $file"  >>/var/log/cis_6_0_status.html
fi
if [ $(echo $fileperm | cut -c8) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Other Read set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Other Read NOT set on $file"  >>/var/log/cis_6_0_status.html
fi
if [ $(echo $fileperm | cut -c9) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Other Write set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Other Write NOT set on $file"  >>/var/log/cis_6_0_status.html
fi
if [ $(echo $fileperm | cut -c10) != "-" ]; then
echo -e "<p style='color: red;'>6.2.11 Other Execute set on $file"  >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.11 Other Execute set on $file"  >>/var/log/cis_6_0_status.html
             fi
       fi
   done
fi
done

# 6.2.12 Ensure no users have .rhosts files
awk -F: '($1 !~ /^(root|halt|sync|shutdown)$/ && $7 != "'"$(which nologin)"'" && $7 != "/bin/false" && $7 != "/usr/bin/false") { print $1 " " $6 }' /etc/passwd | while read user dir; do
if [ ! -d "$dir" ]; then 
echo -e "<p style='color: red;'>6.2.12 The home directory ($dir) of user $user does not exist." >>/var/log/cis_6_0_status.html
else 
for file in $dir/.rhosts; do 
if [ ! -h "$file" -a -e "$file" ]; then 
echo -e "<p style='color: red;'>6.2.12 .rhosts file in $dir" >>/var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.12 .rhosts file NOT exist in $dir" >>/var/log/cis_6_0_status.html
   fi 
  done 
fi 
done

#
# 6.2.13 Ensure all groups in /etc/passwd exist in /etc/group
echo -e "\n 6.2.13 Ensure all groups in /etc/passwd exist in /etc/group" >> /var/log/cis_6_0_status.html
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
grep -q -P "^.*?:[^:]*:$i:" /etc/group > /dev/null 2>&1
   if [ $? -ne 0 ]; then
   echo -e "<p style='color: red;'>6.2.13 Group $i is referenced by /etc/passwd but does not exist in /etc/group" >> /var/log/cis_6_0_status.html
else
   echo -e "<p style='color: green;'>6.2.13 Group $i is referenced by /etc/passwd but does exist in /etc/group" >> /var/log/cis_6_0_status.html
   fi
done

#
# 6.2.14 Ensure no duplicate UIDs exist
echo -e "\n 6.2.14 Ensure no duplicate  UIDs exis" >> /var/log/cis_6_0_status.html
cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
[ -z "$x" ] && break
set - $x
  if [ $1 -gt 1 ]; then
  users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
  echo -e "<p style='color: red;'>6.2.14 Duplicate UID ($2): $users exists" >> /var/log/cis_6_0_status.html
else
  echo -e "<p style='color: green;'>6.2.14 Duplicate UID ($2): $users not present" >> /var/log/cis_6_0_status.html
  fi
done

#
# 6.2.15 Ensure no duplicate GIDs exist
echo -e "\n 6.2.15 Ensure no duplicate  GIDs exis" >> /var/log/cis_6_0_status.html
cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
echo -e "<p style='color: red;'>6.2.15 Duplicate GID ($x) exists in /etc/group" >> /var/log/cis_6_0_status.html
done

#
# 6.2.16 Ensure no duplicate user names exist
echo -e "\n 6.2.16 Ensure no duplicate user names exist" >> /var/log/cis_6_0_status.html
cut -d: -f1 /etc/passwd | sort | uniq -d | while read x; do
echo -e "<p style='color: red;'>6.2.16 Duplicate login name ${x} exists in /etc/passwd" >> /var/log/cis_6_0_status.html
done
duplicate_names=$(cut -d: -f1 /etc/passwd | sort | uniq -d)
 if [[ -n $duplicate_names ]]; then
echo "$duplicate_names" | while read -r x; do
echo -e "<p style='color: red;'>6.2.16 Duplicate login name ${x} exists in /etc/passwd" >> /var/log/cis_6_0_status.html
done
else
echo -e "<p style='color: green;'>Duplicate login names do not exist in /etc/passwd"  >> /var/log/cis_6_0_status.html
fi

# 6.2.17 Ensure no duplicate group names exist
echo -e "\n 6.2.17 Ensure no duplicate group names exist " >> /var/log/cis_6_0_status.html
cut -d: -f1 /etc/group | sort | uniq -d | while read x; do
echo -e "<p style='color: red;'>6.2.17 Duplicate group name ${x} in /etc/group" /var/log/cis_6_0_status.html
done
duplicate_groups=$(cut -d: -f1 /etc/group | sort | uniq -d)
if [[ -n $duplicate_groups ]]; then
echo "$duplicate_groups" | while read -r x; do
echo -e "<p style='color: red;'>6.2.16 Duplicate group name ${x} exists in /etc/passwd" >> /var/log/cis_6_0_status.html
done
else
echo -e "<p style='color: green;'>Duplicate group names do not exist in /etc/passwd"  >> /var/log/cis_6_0_status.html
fi


# 6.2.18 Ensure shadow group is empty
echo -e "\n 6.2.18 Ensure shadow group is empty " >> /var/log/cis_6_0_status.html
grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group >> /var/log/cis_6_0_status.html 
awk -F: '($4 == "<shadow-gid>") { print }' /etc/passwd >> /var/log/cis_6_0_status.html
if [ $? -ne 0 ]; then
echo -e "<p style='color: red;'>CIS 6.2.18 shadow group is not empty in /etc/passwd </p>" >> /var/log/cis_6_0_status.html
else
echo -e "<p style='color: green;'>6.2.18 shadow group is empty in /etc/passwd </p>" >> /var/log/cis_6_0_status.html
fi


#------------------------------------------End of CIS 6.0--------------------------------
# 

echo -e "<p style='color: green;'>-------------------------------------End of  CIS 6.0-----------------------------------------------------------</p>"  >> /var/log/cis_6_0_status.html
echo  -e "\n CIS 6.0 Script execution completed \n"
echo -e "\n check the recommend or validation report located in /var/log/cis_6_0_status.html \n"
echo  -e "\n check the Error log file located in /var/log/cis_6_0.log \n"
#-------------------- --- -----------------End of CIS 6.0 --------------------------------------#
if [ ! -d /var/local ] ; then
mkdir -p /var/local
fi

cat << EOF >> /var/local/CIS_6_0-hardened
CIS_6_0 script completed
EOF

echo -e "<p style='color: green;'> Version of the validation OS Shell script file name $(basename $0) is 1.0 and latest version date is 13-02-2024 </p>"  >> /var/log/cis_6_0_status.html
echo -e "\nVersion of CIS 6.0 validation  Shell script file name $(basename $0) is 1.0  Latest version date is 14-02-2024"
exit 0

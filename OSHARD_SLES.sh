#!/bin/bash

clear
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 0
fi

path=`readlink -f "${BASH_SOURCE:-$0}"`

DIR_PATH=`dirname $path`

echo "The Directory Path is" $DIR_PATH

read -p "Press any key when ready to run CIS_1_0.sh script file  ..."
clear
echo "\n Currently executing CIS_1_0 Script file ....\n"
sh $DIR_PATH/CIS_1_0.sh

read -p "Press any key when ready to run CIS_2_0.sh script file  ..."
clear
echo "\n Currently executing CIS_2_0 Script file ....\n"

sh $DIR_PATH/CIS_2_0.sh

read -p "Press any key when ready to run CIS_3_0.sh script file  ..."
clear
echo "\n Currently executing CIS_3_0 Script file ....\n"
sh $DIR_PATH/CIS_3_0.sh

read -p "Press any key when ready to run CIS_4_0.sh script file  ..."
clear
echo "\n Currently executing CIS_4_0 Script file ....\n"
sh $DIR_PATH/CIS_4_0.sh

read -p "Press any key when ready to run CIS_5_0.sh script file  ..."
clear
echo "\n Currently executing CIS_5_0 Script file ....\n"
sh $DIR_PATH/CIS_5_0.sh

read -p "Press any key when ready to run CIS_6_0.sh script file  ..."
clear
echo "\n Currently executing CIS_6_0 Script file ....\n"
sh $DIR_PATH/CIS_6_0.sh


#!/bin/bash
# This script creates two helper scripts to aid unbind and bind a USB device
# from a linux system. grep filters and sed substitutions are very much 
# specific to 9$ CHIP computer. These filters might vary for your system.
#
# This script does not do any unbind/bind jobs directly. One HAS to unbind
# and bind the usb devices bu executing the generated scripts by this script.
#
# For more info see: http://lwn.net/Articles/143397/
#
#set -x
driver_root=/sys/bus/usb/drivers;
wh=./tmp
mkdir -p ./tmp >/dev/null 2>&1

usb_devs=$*
#usb_devs="usb-storage";
#if [ "x$1" != "x" ];then
#        usb_devs=$*
#fi

for i in $usb_devs;
do
  echo Creating $wh/$i.unbind.sh and $wh/$i.bind.sh
  echo "echo -n \"`tree $driver_root/$i/|grep platform|sed -e 's#.*/##g'`\" > $driver_root/$i/unbind" |tee $wh/$i.unbind.sh ;
  echo "echo -n \"`tree $driver_root/$i/|grep platform|sed -e 's#.*/##g'`\" > $driver_root/$i/bind" |tee $wh/$i.bind.sh ;
  chmod +x $wh/$i*.sh
done

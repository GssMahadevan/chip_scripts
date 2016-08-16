# linux_scripts
## Add and remove USB device in programmatic way
usbdev_add_remove_helper.sh. By default script does not bind/unbind any devices. It takes modules (that needs to be unbinded/
binded from command lines arguments. Then this script generates two scripts for unbinding and binding in ./tmp directory for that
module.

#### Usage
```
root@chip2:~# usbdev_add_remove_helper.sh  usb-storage
```
Output looks like:
```
Creating ./tmp/usb-storage.unbind.sh and ./tmp/usb-storage.bind.sh
echo -n "2-1.4:1.0" > /sys/bus/usb/drivers/usb-storage/unbind
echo -n "2-1.4:1.0" > /sys/bus/usb/drivers/usb-storage/bind
```
Now execute the unbind
```
root@chip2:~# ./tmp/usb-storage.unbind.sh
```
System log looks like:
```
root@chip2:~# dmesg |tail
[  994.170000] sd 1:0:0:0: [sda] Attached SCSI removable disk
[ 1905.435000] usb-storage 2-1.4:1.0: USB Mass Storage device detected
[ 1905.440000] scsi host2: usb-storage 2-1.4:1.0
[ 1906.445000] scsi 2:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.00 PQ: 0 ANSI: 6
[ 1906.475000] sd 2:0:0:0: [sda] 31260672 512-byte logical blocks: (16.0 GB/14.9 GiB)
[ 1906.495000] sd 2:0:0:0: [sda] Write Protect is off
[ 1906.500000] sd 2:0:0:0: [sda] Mode Sense: 43 00 00 00
[ 1906.515000] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1906.580000]  sda: sda1
[ 1906.615000] sd 2:0:0:0: [sda] Attached SCSI removable disk
```

When you want the USB module , then execue the corresponding bind scripts:
```
root@chip2:~# ./tmp/usb-storage.bind.sh
```

System log looks like:
```
root@chip2:~# dmesg |tail
[ 1906.615000] sd 2:0:0:0: [sda] Attached SCSI removable disk
[ 2268.925000] usb-storage 2-1.4:1.0: USB Mass Storage device detected
[ 2268.935000] scsi host3: usb-storage 2-1.4:1.0
[ 2269.940000] scsi 3:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.00 PQ: 0 ANSI: 6
[ 2269.965000] sd 3:0:0:0: [sda] 31260672 512-byte logical blocks: (16.0 GB/14.9 GiB)
[ 2269.985000] sd 3:0:0:0: [sda] Write Protect is off
[ 2269.995000] sd 3:0:0:0: [sda] Mode Sense: 43 00 00 00
[ 2270.015000] sd 3:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 2270.095000]  sda: sda1
[ 2270.135000] sd 3:0:0:0: [sda] Attached SCSI removable disk
root@chip2:~# 
```

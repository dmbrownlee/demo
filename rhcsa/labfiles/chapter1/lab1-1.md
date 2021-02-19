# lab1-2: Creating USB Installation Media (Linux instructions)

## OBJECTIVE

In this lab, you will learn how to make a bootable Linux flash drive from a downloaded ISO file using the Linux command line.

## SETUP

No special setup is needed for this lab but you will need a USB flash drive if you want to try out the commands.

## BACKGROUND

Linux and other software is often distributed in ```.iso``` files on the Internet.  ISO9660 is an international standard for a CD-ROM file system which is where the ```.iso``` extension originates.  These files contain an entire file system, including any boot sectors, within them.  When copied to a raw device, the file system within the ```.iso``` file replaces any file system that may already be on the device.  This is a destructive operation so it is important you specify the correct destination device.  If you specify the wrong device, you might overwrite your Linux machine's hard drive leaving you with no choice but to reinstall or restore the file system from a backup (if you have one).  The steps below show you how to find the correct device name of your USB flash drive.  Once you have that, you will use the ```dd``` command to write the file system withing the ISO image to the device.

## STEPS

1. Download a CentOS ISO image from [a mirror site near you](http://isoredirect.centos.org/centos/8/isos/x86_64/).

  > Note: for the **boot** ISO image you will need a 1GB flash drive or larger.  The **DVD1** ISO image requires at least a 16GB flash drive (well, larger than 8GB) and will take longer to download.

1. Before inserting the flash drive, open a terminal and run:

  ```
  lsblk
  ```

  The output will show the existing system disks.

1. Insert the flash drive and run ```lsblk``` again.  You should now see an additional disk beginning with ```/dev/sd```*```X```* where *```X```* is a letter. If the flash drive already has partitions, you may also see entries for the partitions which would include a number *```N```* after the *```X```* like ```/dev/sd```*```XN```*.  We will only use the whole disk so you can ignore the partitions.  Pay close attention to the letter for *```X```* as yours may be different and you don't want to erase the wrong disk.

1. Change to the directory with the ISO image and run ```dd```:
  > **Important**: The command below should be typed on a single line and ```/dev/sdb``` should be replaced with the name of the disk you found in the steps above

  ```
  sudo dd if=CentOS-8.3.2011-x86_64-boot.iso of=/dev/sdb bs=4M status=progress
  ```

  > Tip: The above command will take about 15 minutes to run with the larger **DVD1** ISO file and the ```status=progress``` option will cause ```dd``` to periodically output its progress.  Also note the Linux version of ```dd``` uses ```M``` (uppercase) units when specifying blocksize with ```bs=``` where as Mac's version of ```dd``` uses lowercase units.

1. When ```dd``` completes, you are done.  Remove the flash drive.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You can boot a spare machine or a virtual machine into the CentOS installer using the USB flash drive you created.

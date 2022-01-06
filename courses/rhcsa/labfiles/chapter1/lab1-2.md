# lab1-2: Creating USB Installation Media (Mac instructions)

## OBJECTIVE

In this lab, you will learn how to make a bootable Linux flash drive from a downloaded ISO file using the Mac OS X command line.

## SETUP

No special setup is needed for this lab but you will need a USB flash drive if you want to try out the commands.

## BACKGROUND

Linux and other software is often distributed in ```.iso``` files on the Internet.  ISO9660 is an international standard for a CD-ROM file system which is where the ```.iso``` extension originates.  These files contain an entire file system, including any boot sectors, within them.  When copied to a raw device, the file system within the ```.iso``` file replaces any file system that may already be on the device.  This is a destructive operation so it is important you specify the correct destination device.  If you specify the wrong device, you might overwrite your Mac's hard drive leaving you with no choice but to follow Apple's documentation for [reinstalling Mac OS X](https://support.apple.com/en-us/HT204904) using Internet Recovery.  The steps below show you how to find the correct device name of your USB flash drive.  Once you have that, you will use the ```dd``` command to write the file system withing the ISO image to the device.

## STEPS

1. Download a CentOS ISO image from [a mirror site near you](http://isoredirect.centos.org/centos/8/isos/x86_64/).

  > Note: for the **boot** ISO image you will need a 1GB flash drive or larger.  The **DVD1** ISO image requires at least a 16GB flash drive (well, larger than 8GB) and will take longer to download.

1. Insert the flash drive.  If you get a dialog saying the disk is not readable and offering to initialize the disk, choose "Ignore".

1. Open a terminal and type:

  ```
  diskutil list| grep '(external, physical)'
  ```

1. The output will start with something like ```/dev/disk6``` which is the name of the disk.

  > **Important:** Pay close attention to the number as yours may be different and you don't want to erase the wrong disk.

1. Use the ```diskutil``` command to ensure the disk is unmounted:

  ```
  diskutil unmountDisk /dev/disk6
  ```

1. Change to the directory with the ISO image and run ```dd```:
  > **Important**: The command below should be typed on a single line and ```/dev/disk6``` should be replaced with the name of the disk you found in the steps above

  ```
  sudo dd if=CentOS-8.3.2011-x86_64-boot.iso of=/dev/disk6 bs=4m
  ```

  > Tip: The above command will take about 15 minutes to run with the larger **DVD1** ISO file.  If you know how to use ```kill``` to send a signal to the ```dd``` process, you can send SIGINT to the ```dd``` process from another terminal to get it to output its current progress.  Also note the Mac version uses ```m``` (lowercase) units when specifying blocksize with ```bs=``` where as Linux uses uppercase units.

1. When ```dd``` completes, you are done.  Remove the flash drive.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You can boot a spare machine or a virtual machine into the CentOS installer using the USB flash drive you created.

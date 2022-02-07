#Setting Up a Virtual Machine from ISO image 

In this lab, we will be going through the steps and procedures of setting up a virtual machine inside of VirtualBox. After this lab you should be able to successfully setup a range of Virtual Machines to experiment with if you get curious.

15-2 and 15-3 goes into a bit more details regarding the configurations of possible inputs and outputs as well as networking these virtual machines together--

## Host Setup 
In the initial setup of the lab folders and environments, a hypervisor was installed called VirtualBox. This hypervisor is where you will configure and run your Virtual machines. If you have confirmed that Virtual Box is present on the machine, we can move forward with setting up a Virtual Machine locally. If virtual box is not present, please revisit https://github.com/dmbrownlee/setup 


##Grabbing an ISO Image

1. We will need an iso file to get started, given the /demo setup includes the RHCSA directory, I will use the most up-to-date rocky linux image in this example, which can be downloaded here https://rockylinux.org/download/


		For Mac I have chosen to download the x86_64 minimal.iso file, although other options are available.
		You are welcome to try out any OS that might peak your interest, just ensure they are from a reliable source. 


2. Once you have an ISO file for your desired Operating system, I recommend moving it to a designated folder, just for the sake of staying organized and having all your iso images in one place, in my case the command is as follows 
	
		` mv Downloads/Rocky-8.4-x86_64-minimal.iso VirtualBox_VMS/images ` 
 
Once the image is in safe place, we can start on creating your Virtual machine!


## VirtualBox Setup 


1. First we will want to open up the Hypervisor, in this case VirtualBox.
		
		The setup of the actual virtual machine in a gui will very after this point based on what hypervisor you choose to use. As mentioned VirtualBox will be used in this example 

2. In the center at the top of the VirtualBox Manager window, you should see a few options, `Preferences, Import, Export, New, ADD`. If this is not the case, ensure you have `tools` selected in the left hand corner.  

3. Here we will be able to create a new machine and import or export an existing machine.
	We will want to select `New` and then we will start the Virtual Machine Configuration 

	a. The first thing the OS will prompt you with is the 
	
		name of the machine: Client
		
		Machine Folder: /User/$your_user/Virtualbox_Vms
		
		OS Type: Linux
		
		Operating System Version: Fedora (64-bit)



4. Next, VirtualBox will prompt you for the amount of Random Access Memory (RAM) you would like the virtual machine to utilize. My system holds 32 gb of ram, I intend to only use this as demonstartion, so I will use the recommended 1024mb given I am not needing this machine to perform any other tasks. Keep in mind this can be changed later.  
	Note: Any resource utilization is taken from the host. I typically do about 1/4th, that way I have enough resources for the virtual machine to run without interruption, while still leaving enough resources for the host to run other programs if needed.


5. The window will then prompt us if we want to create a virtual hard disk, use an existing one or neither. In this case I will create a virtual hard disk, to store scripts, files and other data we might want to access later 

6. After we have chose to create a disk, we get to choose th file type that we would like to use, given we are using virutalbox through out this course, I will stick with vdi, but here is a quick summary of each option. 

	a. VDI: This is a portable virtual drive, which allows both fixed size and dynamically allocated storage(which means you can add increase the disk size later).This format is specific to VirtualBox, but is compatible with other virtualization software
	b. VHD: This is the standard disk format for Microsofts  virtualization products, this is less common being superseded by the VHDX, which is essentially v2 which allows for significantly larger storage capacity along with other benefits. This also supports fixed and dynamic hard disk  images 
	c. VMDK: This was previously proprietary to vmware virtual appliances, but is now open format and widely used across many virtualization platforms. It allows cloning of physical disks and buckup of vm's offsite, VMDK also allows incremental backups, which makes the backup process much quicker than VDI or VHD. 
		 This format also support dynamic or fixed storage. 

7. Next you will choose if you want the drive to be Dynamically allocated, or a Fixed Size, I typically go for dynamic, because why not? 

8. Next it will request that you choose a location to store your file, I typically leave this as default, to save all the vm's configurations within its own folder. 
	I have plenty of storage, but to ensure the full image has enough space, I will go ahead and up the disk size to 15gb's, you can add additional storage later if you find that you need more room which will be covered in RHCSA or other Linux Tutorials. 

With that you have successfully added your first Virtual Machine to Virtual box, all thats left is to launch the Virtual machine and install the OS by following the onscreen instructions. 

There is a second section in 15-2, I highly recommend anyone interested to spend some time there as well, as it will cover a few things that may come in handy later down the road in your IT journey, but as far as this module goes, we can consider it complete, Congrats! 

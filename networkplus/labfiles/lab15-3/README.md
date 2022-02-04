#Setting up a Gateway to the outside World, Careful it can be dangerous out there.. 

In this lab, we will going through the steps and procedures of setting up a router, that will allow two different networks to communicat, pay attention, because this may get a bit messy if you are not familiar with the processes we performed in lab 2. 


## Host setup

1. To start, we are going to need a second interface for NAT active, in lab 15-2 we disabled these mainly due to the fact we were generating our own internal network (10 points if you can explain what NAT does and how it works). The following steps should be performed on all 3 vm's, The reason we did not clone these steps are due to differences on the vm's. We will see the additonal steps and differneces later on in this chapter.
	
	a. As we did in lab15_2 you will want to add another interface to your machine in the virtualbox, but instead of an internal network assignment we will want to assign it as NAT under ADAPTER_2 so, adapter 2 should looks as follows. (Virtual_box > Server1_2_gateway > Settings > Network > ADAPTER_2). 
		* Enable Network Adapter 
		Attached to: NAT
		* Cable Connected
	
2. Now that we have NAT setup, lets boot into the machine and see if it is visible, we will be introducing `nmcli` in this step
	
	a. If we run the command `ip addr` we should see 3 interfaces, our local inet (enp0s3), the NAT (enp0s8) and the local address (lo) (this might very depending on setup). If we open nmtui, we would see only 1 interface shows up that we can edit or activate. Strange right, or is it? lets dig deeper into linux networking. 

	b. lets run this command, `nmcli device`. ahh there it is, Now I am seeing all 3 device, on that is "connected", one that is "diconnected" and another that is "unmanaged". 

	c. To activate this interface lets run `nmcli device connect enp0s8` (substitiue enp0s8 for what ever your disconnected interface might be). 
	
	d. repeat these steps for server2 and the gateway. we will make some additonal changes to server2 and the gateway below, so you might want to read ahead and edit your configuration accodingly, this is where things get a little messy. 

								    Server2 Setup
								    Gateway Setup


1. We


For 

2. Once  

` mv ` 

Once 


## VirtualBox Setup 


1. First 

2. In 

3. Here 
a. The 

----------------##Insert VB1_image.png here##---------------------


4. Next, 


5. The 

6. After 
	a. VDI: This is 
	b. VHD: This  
	c. VMDK: This 
7. Next 

8. Next 

With that you have successfully added your first Virtual Machine to Virtual box, all thats left is to launch the Virtual machine and install the OS by following the onscreen instructions. 

There is a second section in 15-2, I highly recommend anyone interested to spend some time there as well, as it will cover a few things that may come in handy later down the road in your IT journey, but as far as this module goes, we can consider it complete, Congrats! 

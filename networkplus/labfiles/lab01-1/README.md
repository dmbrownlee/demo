# Intro to Wireshark

In this lab, we will be looking at packets caputured in Wireshark.

## Wireshark

Go ahead and start Wireshark. Upon loading, you should see all the network interfaces that you're able to capture internet traffic on. Hovering over each interface will display some key information about that interface. To start caputing, simply double click on that interface. After caputing the required packets, hit the red square on the left side of the Wireshark tool bar.

## Hands-on Practice

In Wireshark, open the 'Lab 1 Packet Capture.pcapng' file. After opening the file, you should see a packet capture from another machine.

1. Look online to find a filter so that you're only viewing the HTTP GET request traffic in this packet capture. You should only see 3 packets after entering a suitable filter, No. 106, No. 2196, and No.2206.
2. The packet at the top should be No. 106, select this packet to display the details of the packet in the bottom section of Wireshark.
3. Contained within the top layer of the output is OSI Layer 1 information. Followed by Layer 2, 3 and 4 PDU information.
4. Find the MAC address for the source machine for packet No. 106. You should see that the source MAC is : e0:b5:5f:f3:20:7c. Using an online MAC Address Lookup, what was the manufacture of the source device? What is the mininum informaitno that you can enter that will ID the vendor based on the MAC and Why?

## Exercise - Looking for information

1. Load Wireshark and start capturing you own traffic.
2. Go head and load Chrome and visit www.google.com
3. Stop your packet traffic
4. From the packets you have captured, find your machines IP address, and MAC address.
5. Look for the TCP source port number.

# Intro to Wireshark

In this lab, we will be looking at packets caputured in Wireshark.

## Wireshark

Go ahead and start Wireshark. Upon loading, you should see all the network interfaces that you're able to capture internet traffic on. Hovering over each interface will display some key information about that interface. To start caputing, simply double click on that interface. After caputing the required packets, hit the red square on the left side of the Wireshark tool bar.

## Hands-on Practice
1. First open Wireshark. If you're unable to find Wireshark on the Dock, then press 'CMD + Spacebar' to load Spotlight, and search for Wireshark.
2. Now that Wireshark has loaded, select the 'Open a caputre file' in the top left corner, highlighted in the follow image, and nagivate through the lab 1 packet capture file:
![lab01-01 Wireshark](lab01-1_wireshark_loading_pcap.png)
3. Look online to find a filter so that you only view the HTTP GET request traffic in this packet capture. You will be able to find a filter at the bottom of the lab, however try to search for one. Enter the filter into the search bar at the top of Wireshark, and highlighted in this iamge:
![lsb01-1 Wireshark Filter](lab01-1_wireshark_filterbox.png)
4. After entering a filter you will only see 3 packets, No. 106, No. 2196, and No.2206.
4. Select packet No.106 to display its details in the bottom section of Wireshark.
3. Contained within the top layer of the output is OSI Layer 1 information. Followed by Layer 2, 3 and 4 PDU information.
4. Select the Layer 2 PDU and find the MAC address for the source machine for the packet No. 106. You should see that the source MAC is : e0:b5:5f:f3:20:7c. Use an online OUI Lookup website 'ouilookup.com', what was the manufacture of the source device? What is the mininum information that you can enter that will ID the vendor based on the MAC address, and why?

## Exercise - Looking for information

1. Load Wireshark and start capturing you own traffic.
2. Go head and load Chrome and visit www.google.com
3. Stop your packet traffic
4. From the packets you have captured, find your machines IP address, and MAC address.
5. Look for the TCP source port number.
6. Compare the OSI Model and the information within the packets catpured, and look for the corresponding PDU header information.

## Answer
Filter : `http.request.method == "GET"`

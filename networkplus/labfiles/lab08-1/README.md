# Viewing the TCP Three-Way handshake | Four-way Disconnect process

## Setup
For this lab, please load the '/Users/[USERNAME]/demo/networkplus/labfiles/lab08-1/Lab 8 Packet Capture.pcapng' into Wireshark.

## Lab 

For this lab, we're going to be viewing the TCP Three-way handshake. You should already know from the chapter that this process is used to establish a reliable connection between two machine for transferring data such as webpages.

The Three-way handshake consists of the following steps: SYN, SYN-ACK, ACK. Your challenge within this lab is to find the first occurance of this process. By now, you should have a good understanding of filtering in Wireshark. Try and answer the following questions:

Question 1 : What is the packet number of the first SYN request?

Question 2 : What is the packet number of the last ACK request?

Question 3 : What is the port number on the local machine? 

Question 4 : What is the port number on the remote machine? And why?

After the commication has completed, the machines need to close the established channels of communication. This is where the Four Way Disconnect comes in. The four way disconnect follows the following sequence : FIN/ACK, ACK, FIN/ACK, ACK.

The next challenge of this lab is to find this sequence of packets within the packet capture. Now that you know the details of the Three-way handshake, right click on one of the packets at select 'Follow > TCP Stream'. This automatically filters all of the packets so that you only see the stream of packets related to this TCP connveration. Go ahead and answer the following on the four-way disconnect:

Question 5 : What is the first FIN/ACK packet number?

Now that you've analysed a set of pre-caputed packets, go aheaed and start ccapturing your own network traffic and find the Three-way handshake along with the Four-Way Disconnect. Try SSHing to another machine and caputuring the traffic. What do you notice about the hankshaking process?

## Answers
Question 1 : 116

Question 2 : 120

Question 3 : Port 38990

Question 4 : Port 80 - This is the port used to serve HTTP pages

Question 5 : 830

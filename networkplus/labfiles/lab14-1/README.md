# Troubleshooting Slow Networks

## Exam Objective 📑
[5.0 Network Troubleshooting and Tools: 5.4 Given a scenario, troubleshoot common wireless
connectivity and performance issues.](https://www.comptia.jp/pdf/comptia-network-n10-007-v-3-0-exam-objectives.pdf)

## Setup 💻
Open '/Users/[USERNAME]/demo/networkplus/labfiles/lab14-1/timing.pcapng' in Wireshark.

## Lab Overview 🔬
Network latency (aka slow wireless connection) is the delay in transmitting requests or data from the source to destination. This can be harder to troubleshoot than no connection at all because the device is properly connected to an SSID, has a valid IP address, and it runs well overall but still YouTube loads painfully slow and the Play store times out. Long delays or excessive latency are undesirable since they degrade the user experience. When troubleshooting network latency, we utilize Wireshark to discover the source of poor performance. 

### **Let's explore Wireshark's built-in features for resolving slowness**
_____
### A. Protocol Time Filters
The filter `http.time` allows us to easily calculate the HTTP response times which helps to detect delays in data transfer. 

> Complete the steps and then answer the questions below.
1. Open timing.pcapng in Wireshark
2. Apply the display filter `http`
3. Click any TCP packet and right-click on the TCP header > Protocol preferences > uncheck 'allow subdissector to reassemble TCP streams'

Unchecking this feature will undo the TCP reassembly feature and allow us to troubleshoot the actual application response time of HTTP

4. Click packet #35 and select the HTTP header. 

Notice the Time since request is less than .5 seconds. This is ideal for smooth data transfer. 

5. Apply the display filter `http.time > 1` to look for any HTTP responses that are longer than 1 second. 
6. Right-click the packet > Conversation filter > TCP

Now we can examine the data transfer to locate the delay from the server.

- A.1. Which packet did the time filter provide?
- A.2. How long did that HTTP response take to reach the client?

💡Tip: Click the `+` button to save the display filter `http.time > 1` as a button. 
_____
### B. TCP Timestamps
Most applications have more than one TCP conversation happening at once. This causes the sequence of the packet capture to be pretty scrambled. Enabling TCP timestamps in wireshark helps us locate delays within a single data exchange. 

> Complete the steps and then answer the questions below.
1. Open timing.pcapng in Wireshark
2. Click any TCP packet and right-click on the TCP header > Protocol preferences > check 'calculate conversation timestamps'

This is to ensure we only show the delta time between packets within the same TCP conversation. Within the TCP header, you will now see [Timestamps].

3. Click packet #14 > TCP header > Timestamps > right-click [Time since previous frame in this TCP stream: 0.000000000 seconds] > Apply as Column
4. Click on the new column and click the down arrow in the toolbar
5. Find the packet sent by the server, 72.246.56.25, with the greatest value for 'Time since previous frame in this TCP stream'. Hint: Ignore the [FIN, ACK] packets. 
6. Right-click the packet > Conversation filter > TCP (this filters the view down to just one TCP conversation)
7. Click the No. column to sort the packets

Now we can examine the data transfer to locate the delay from the server.

- B.1. Which packet sent by the server, 72.246.56.25, has the greatest value for 'Time since previous frame in this TCP stream'?
- B.2. How long did the server take to send that block of application data? 

💡Tip: Click the `+` button to save the display filter `tcp.time_delta > 9 and !ip.src == 0.0.0.0` as a button. 
_____
  
## Answers ✅
**A.1.** 10533
**A.2.** 9 seconds
**B.1.** 9890
**B.2.** 10 seconds

## Links 📚
[Chapter 14 Wireless Networking](https://learning.oreilly.com/library/view/comptia-network-certification/9781260122398/ch14.xhtml#ch14sec194) by Mike Meyers

[Wireless Troubleshooting](https://www.professormesser.com/network-plus/n10-007/wireless-network-troubleshooting/) by Professor Messer

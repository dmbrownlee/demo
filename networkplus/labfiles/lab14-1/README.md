# Troubleshooting Slow Networks

## Exam Objective 📑
[5.0 Network Troubleshooting and Tools: 5.4 Given a scenario, troubleshoot common wireless
connectivity and performance issues.](https://www.comptia.jp/pdf/comptia-network-n10-007-v-3-0-exam-objectives.pdf)

## Setup 💻
Locate the following packet captures under '/Users/[USERNAME]/demo/networkplus/labfiles/lab14-1' :
- timing.pcapng
- 

## Lab Overview 🔬
Network latency (aka slow wireless connection) is the delay in transmitting requests or data from the source to destination. This can be harder to troubleshoot than no connection at all because the device is properly connected to an SSID, has a valid IP address, and it runs well overall but still YouTube loads painfully slow and the Play store times out. Long delays or excessive latency are undesirable since they degrade the user experience. When troubleshooting network latency, we utilize Wireshark in many ways to quickly and efficiently discover the source of poor performance. 

### **Let's explore Wireshark's built-in features for resolving slowness**
_____
### A. Protocol Time Filters
The filter `http.time` allows us to easily calculate the HTTP response times which helps to detect delays in data transfer. 

> Complete the steps and then answer the questions below.
1. Open timing.pcapng in Wireshark
2. Apply the display filter `http`
3. Click any packet and right-click on the TCP header > Protocol preferences > uncheck 'allow subdissector to reassemble TCP streams'

Unchecking this feature will undo the TCP reassembly feature and allow us to troubleshoot the actual application response time of HTTP

4. Click packet #35 and select the HTTP header. 

Notice the Time since request is less than .5 seconds. This is ideal for smooth data transfer. 

5. Apply the display filter `http.time > 1` to look for any HTTP responses that are longer than 1 second. 
6. Click the `+` button to save the display filter as a button. 

This helps us quickly find the slow HTTP responses whenever we examine large packet captures. 

7. Right-click the packet > Conversation filter > TCP. 

Now we can view the TCP 3-Way Handshake to better analyze what exaclty happened between the client and server.

- A.1. Which packet did the time filter provide?
- A.2. How long did that HTTP response take to reach the client?
_____
### B. 


> Complete the steps and then answer the questions below.
1. 

- B.1. 
- B.2. 
  
## Answers ✅
**A.1.** 10533
**A.2.** 9 seconds
**A.3.** 
**B.1.** 
**B.2.** 
**B.3.** 
**B.4.**   
**B.5.** 

## Links 📚
[Chapter 14 Wireless Networking](https://learning.oreilly.com/library/view/comptia-network-certification/9781260122398/ch14.xhtml#ch14sec194) by Mike Meyers

[Wireless Troubleshooting](https://www.professormesser.com/network-plus/n10-007/wireless-network-troubleshooting/) by Professor Messer

[WiFi Encryption](https://www.cbtnuggets.com/learn/it-training/wireless-security-protocols-authentication-methods/3?autostart=1) by Keith Barker

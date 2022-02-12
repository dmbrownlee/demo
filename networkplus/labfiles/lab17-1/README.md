# Unified Communication

## Exam Objective 📑
[2.0 Infrastructure: 2.3 Explain the purposes and use cases for advanced networking devices](https://www.comptia.jp/pdf/comptia-network-n10-007-v-3-0-exam-objectives.pdf)

## Setup 💻
Open '/Users/[USERNAME]/demo/networkplus/labfiles/lab17-1/VoIP.pcap' in Wireshark.

## Lab 🔬
Voice over IP (VoIP) made it possible to communicate by voice right over an IP network. The switch to TCP/IP enabled companies to minimize wire installation and better implement unified communication (UC). UC adds various services to VoIP including video conferencing, fax, and messaging. UC relies on the following protocols: Session Initiation Protocol (SIP), Transport Protocol (RTP), and H.323. Now let's see how it works!

**Explore an overview of the information being presented in this packet capture:**

1. Open Statistics > Protocol Hierarchy.
    * 100% of the packets are IPv4 and 99.9% are UDP which is made up of 95% RTP packets. [hierarchy-nofilter.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/hierarchy-nofilter.png)

2. Enter `sip` in the display filter box. Open Statistics > Protocol Hierarchy.
    * There are 40 SIP packets and 75% of them are TCP. [hierarchy-filter.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/hierarchy-filter.png)

3. Open Statistics > Packet Lengths.
    * 54% of the packets are within the packet length of 160-319 bytes. [packet-lengths.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/packet-lengths.png)
    * This is the most optimal packet size because the majority of the traffic is for the real-time service(voice).

4. Open Statistics > IPv4 Statistics > All Addresses.
    * 94% of all the packets are being sent and received by these two addresses: 50.28.1.203 and 192.168.1.21 [all-adresses.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/all-addresses.png)

5. Open Statistics > Flow Graph > check limit to display filter
    * This display simply visualizes SIP between the addresses. [flow-chart.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/flow-chart.png)

6. Remove the display filter. Open Telephony > RTP > RTP Streams
    * Lost somewhat demonstrates UDP which is what's used transport the data. UDP is unreliable at times, so we monitor the Lost percentages to see the amount of dropped packets and make sure its not getting too high. 
    * Jitter relates to the timing and sequence of the arriving RTP packets. The lower the Jitter, the better the user experience. [rtp-streams.png](https://github.com/shellam4/demo/blob/main/networkplus/labfiles/lab17-1/rtp-streams.png)

#### SIP 
SIP is a signaling protocol that supports voice calls, video conferencing, instant messaging, and media distribution. SIP handles initiating, maintaining, and terminating real-time sessions between the client and the server. 

Answer the questions below. (Hint: use display filter `sip`)

  A.1. In packet 3, the client starts the process by sending a REQUEST packet to the server at which IP address and on which port?

  A.2. In which packet, does the server alert the client that its ready to establish the session and what is the packet length?

  A.3. In which packet, does the client alert the server that its ending the session and what is the packet length?

#### RTP and H.323
RTP defines the type of packets used on the Internet to move voice or data from a server to clients. The vast majority of VoIP solutions available today use RTP. RTP controls the destination of the packets and identifies the type of information being transported. H.323 handles the initiation, setup, and delivery of VoIP sessions. It runs on top of RTP and is able to handle multicasting.

Complete the steps and then answer the questions below.
1. Select the stream with source port 4042 > Click Find Reverse to highlight both sides of the conversation 
2. Click Analyze > Select the Reverse tab > Play Streams

  B.1. Who is making this call to Doug?
  
  B.2. How much money did they agree on?
  
  B.3. What does Doug want to get into? 
  
  B.4. What difference does setting the Jitter Buffer to 200 make? 
  
  B.5. What does raising the Jitter Buffer do to the stream?
  
## Answers ✅
**A.1.** 192.168.2.6, 5060
**A.2.** 8, 938
**A.3.** 2374, 510
**B.1.** Bill
**B.2.** $10,500
**B.3.** Car racing
**B.4.** The audio sounds slightly clearer and less choppy  
**B.5.** Its actively delaying and storing incoming voice packets to ensure they arrive in order with minimal delay.

## Links 📚
[Chapter 17 Building a Real-World Network](https://learning.oreilly.com/library/view/comptia-network-certification/9781260122398/ch17.xhtml) by Mike Meyers

[Unified Communication Technologies](https://www.professormesser.com/network-plus/n10-006/unified-communication/) by Professor Messer

[VoIP](https://www.cbtnuggets.com/learn/it-training/playlist/nrn:playlist:certification:5e0b96bf2fd1290015ddc049/80?autostart=1) by Keith Barker

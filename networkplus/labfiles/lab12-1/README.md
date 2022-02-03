# Neighbor Discovery Protocol

## Setup
Open '/Users/[USERNAME]/demo/networkplus/labfiles/lab12-1/IPv6-NDP.pcapng' in Wireshark.

## Lab 
The Neighbor Discovery Protocol (NDP) makes the IPv6 automation magic work. NDP consists of four different packet types: Neighbor solicitation, Neighbor advertisement, Router solicitation, and Router advertisement.

**How does the Neighbor solicitation and Neighbor advertisement segments of NDP replace IPv4’s Address Resolution Protocol (ARP)?**
When an IPv6 host joins a network, it sends out multicast neighbor solicitation packets which all begin with ff02 to search for other computers on its broadcast domain. Only the other IPv6-capable hosts on the broadcast domain will hear the multicast neighbor solicitation packet and then respond with a unicast neighbor advertisement packet, essentially saying, “I hear you and this is who I am.” 

*Review the packet capture in Wireshark to answer the following questions:*

- A.1. In packet #28, the first Neighbor Solicitation, what is the layer 3 multicast address that this packet is being sent out to? 
- A.2. What is the layer 2 MAC address which corresponds to the multicast address that is on the receiving end of the neighbor solicitation?
- A.3. In packet #29, the responding Neighbor Advertisement, what is the layer 2 MAC address of the host that sent this unicast packet? 
- A.4. What are the correct ICMPv6 types for these two packet types?

**How does Router solicitation and Router advertisement allow an IPv6 host to automatically discover what the network it's connected to and then configure a usable IP address?**
The host begins by sending out a multicast router solicitation to any routers who are currently on that network segment so that the host can get the information it needs about that network. The router responds by sending out a multicast router advertisement to all the nodes on the network. Even if there's no router solicitation, a router will still periodically send out router advertisements onto the network to advertise its presence and the information for the network.

*Review the packet capture in Wireshark to answer the following questions:*

- B.1. In packet #4, the first Router Advertisement that has been periodically generated, what is the link-local IPv6 address of the router that this packet is being sent from?
- B.2.  What layer 2 MAC address corresponds to the multicast address for all the nodes on the network?
- B.3. In packet #6, the first Router Solicitation, what is the layer 3 IP address of the host that’s looking for the router? 
- B.4. In which number packet does the router immediately respond to the multicast solicitation packet and what is the ICMPv6 type? 

## Answers
**A.1.** ff02::1:ff66:6802 
**A.2.** 33:33:ff:66:68:02
**A.3.** 00:50:79:66:68:02
**A.4.** Neighbor Solicitation is 135 and Neighbor Advertisement is 136
**B.1.** fe80::1
**B.2.** 33:33:00:00:00:01
**B.3.** 2001:db8:1:2050:79ff:fe66:6801
**B.4.** 7, 134

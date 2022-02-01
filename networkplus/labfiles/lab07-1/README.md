# Routing Concepts

## OBJECTIVE

In this lab, we will be exploring IPv4 routing by running various commands on the hosts and routers in our network model. You will learn how to read the routing tables on hosts and routers, use route tracing tools on hosts to view the route traffic will take, and observe the affects of links going down.

## SETUP

This lab uses the same virtual lab environment as the other labs.  Make sure you have opened this project and run the `setup` script on the control node as described [here](https://github.com/dmbrownlee/demo/blob/release/networkplus/labfiles/README.md).

The firewall and routers in the virtual lab environment are Linux containers running Quagga, an open source suite of routing protocols that allow a Linux machine to server as a router. Quagga's command line interface is designed to look and work similar to Cisco's Internetwork Operating System (IOS) and the commands listed here can also be used on a Cisco router.

## STEPS
### Host routing tables
OSI layer 3, the Networking layer is responsible for getting bits of data from one host to another, regardless of which network they are on.  In practice, IPv4 and IPv6 are the networking protocols at this layer and they use source and destination IP addresses (either 4 byte IPv4 or 16 byte IPv6 addresses) to identify the endpoints of communication.  Contrast this with Ethernet and WiFi (layer 2) which can only move data between nodes on the _same_ network using MAC addresses.  Since IP packets are encapsulated inside of ethernet frames, the networking software on the host has one very important question to ask, "Is the destination IP address I'm trying to reach on my network or a different network?"  Either way, the destination IP address in the IP header will be the same.  The reason the host needs to answer this is so that it knows which destination MAC address to put in the Ethernet frame.  In IPv4, if the destination IP address is on the same network, the host will broadcast an ARP (Address Resolution Protocal, a protocol for matching MAC addresses with IP addresses) request for the destination IP address and use the MAC address provided by the destination host in the ARP reply as the destination MAC address in the Ethernet frame.  If the destination IP address is on a different network, the host needs to set the packet the router configured as the default gateway so that it can forward the traffic through the Internet until it reaches the destination host.  The process for finding the destinaation MAC address is the same except the host sends an ARP request for the default gateway's IP address rather than the final destination's IP address since it is the next hop and the only address in the path reachable by Ethernet.  Note, IPv6 also has to answer this question but IPv6 uses the Neighbor Discovery Protocol (NDP) rather than ARP since it does not use broadcasts and is therefore more efficient.  Hosts use a routing table to determine the answer to this important question.

You can view the routing table on hosts as follows:
- Linux:
  ```
  student@debian1:~$ ip route
  default via 192.168.45.254 dev enp0s3 proto dhcp metric 100
  169.254.0.0/16 dev enp0s3 scope link metric 1000
  192.168.45.0/24 dev enp0s3 proto kernel scope link src 192.168.45.127 metric 100
  student@debian1:~$
  ```
  Note, older versions of Linux used `netstat` with output similar to Mac and Windows below and the netstat utility can still be installed, but it has been depreated in favor of the `ip route` command.
- Windows:
  ```
  PS C:\Users\vagrant> netstat -nr
  ===========================================================================
  Interface List
    6...08 00 27 88 cf a0 ......Intel(R) PRO/1000 MT Desktop Adapter
    1...........................Software Loopback Interface 1
  ===========================================================================

  IPv4 Route Table
  ===========================================================================
  Active Routes:
  Network Destination        Netmask          Gateway       Interface  Metric
            0.0.0.0          0.0.0.0   192.168.45.254   192.168.45.149     25
          127.0.0.0        255.0.0.0         On-link         127.0.0.1    331
          127.0.0.1  255.255.255.255         On-link         127.0.0.1    331
    127.255.255.255  255.255.255.255         On-link         127.0.0.1    331
      192.168.45.0    255.255.255.0         On-link    192.168.45.149    281
    192.168.45.149  255.255.255.255         On-link    192.168.45.149    281
    192.168.45.255  255.255.255.255         On-link    192.168.45.149    281
          224.0.0.0        240.0.0.0         On-link         127.0.0.1    331
          224.0.0.0        240.0.0.0         On-link    192.168.45.149    281
    255.255.255.255  255.255.255.255         On-link         127.0.0.1    331
    255.255.255.255  255.255.255.255         On-link    192.168.45.149    281
  ===========================================================================
  Persistent Routes:
    None

  IPv6 Route Table
  ===========================================================================
  Active Routes:
  If Metric Network Destination      Gateway
    1    331 ::1/128                  On-link
    6    281 fe80::/64                On-link
    6    281 fe80::a5bb:1469:280c:c321/128
                                      On-link
    1    331 ff00::/8                 On-link
    6    281 ff00::/8                 On-link
  ===========================================================================
  Persistent Routes:
    None
  PS C:\Users\vagrant>
  ```
- Mac:
  ```
  student@students-MacBook-Pro ~ % netstat -nr
  Routing tables

  Internet:
  Destination        Gateway            Flags           Netif Expire
  default            192.168.42.1       UGScg             en0
  127                127.0.0.1          UCS               lo0
  127.0.0.1          127.0.0.1          UH                lo0
  169.254            link#4             UCS               en0      !
  192.168.42         link#4             UCS               en0      !
  192.168.42.1/32    link#4             UCS               en0      !
  192.168.42.1       50:c7:bf:87:d4:ac  UHLWIir           en0   1195
  192.168.42.161     a4:8d:3b:b3:b2:89  UHLWIi            en0   1158
  192.168.42.169/32  link#4             UCS               en0      !
  192.168.42.169     78:4f:43:94:b9:39  UHLWI             lo0
  192.168.56         link#17            UC           vboxnet0      !
  192.168.56.1       a:0:27:0:0:0       UHLWIi            lo0
  192.168.56.101     8:0:27:5f:1:63     UHLWIi       vboxnet0   1177
  224.0.0/4          link#4             UmCS              en0      !
  224.0.0.251        1:0:5e:0:0:fb      UHmLWI            en0
  239.255.255.250    1:0:5e:7f:ff:fa    UHmLWI            en0
  255.255.255.255/32 link#4             UCS               en0      !

  Internet6:
  Destination                             Gateway                         Flags           Netif Expire
  default                                 fe80::%utun0                    UGcIg           utun0
  default                                 fe80::%utun1                    UGcIg           utun1
  default                                 fe80::%utun2                    UGcIg           utun2
  ::1                                     ::1                             UHL               lo0
  fe80::%lo0/64                           fe80::1%lo0                     UcI               lo0
  fe80::1%lo0                             link#1                          UHLI              lo0
  fe80::%en0/64                           link#4                          UCI               en0
  fe80::c82:3229:779a:23f3%en0            78:4f:43:94:b9:39               UHLI              lo0
  fe80::%en5/64                           link#5                          UCI               en5
  fe80::aede:48ff:fe00:1122%en5           ac:de:48:0:11:22                UHLI              lo0
  fe80::aede:48ff:fe33:4455%en5           ac:de:48:33:44:55               UHLWIi            en5
  fe80::%awdl0/64                         link#12                         UCI             awdl0
  fe80::44b0:81ff:fe68:a41d%awdl0         46:b0:81:68:a4:1d               UHLI              lo0
  fe80::%llw0/64                          link#13                         UCI              llw0
  fe80::44b0:81ff:fe68:a41d%llw0          46:b0:81:68:a4:1d               UHLI              lo0
  fe80::%utun0/64                         fe80::3490:f639:8aa0:5627%utun0 UcI             utun0
  fe80::3490:f639:8aa0:5627%utun0         link#14                         UHLI              lo0
  fe80::%utun1/64                         fe80::1eac:7783:3b8c:7d32%utun1 UcI             utun1
  fe80::1eac:7783:3b8c:7d32%utun1         link#15                         UHLI              lo0
  fe80::%utun2/64                         fe80::ce81:b1c:bd2c:69e%utun2   UcI             utun2
  fe80::ce81:b1c:bd2c:69e%utun2           link#16                         UHLI              lo0
  ff00::/8                                ::1                             UmCI              lo0
  ff00::/8                                link#4                          UmCI              en0
  ff00::/8                                link#5                          UmCI              en5
  ff00::/8                                link#12                         UmCI            awdl0
  ff00::/8                                link#13                         UmCI             llw0
  ff00::/8                                fe80::3490:f639:8aa0:5627%utun0 UmCI            utun0
  ff00::/8                                fe80::1eac:7783:3b8c:7d32%utun1 UmCI            utun1
  ff00::/8                                fe80::ce81:b1c:bd2c:69e%utun2   UmCI            utun2
  ff01::%lo0/32                           ::1                             UmCI              lo0
  ff01::%en0/32                           link#4                          UmCI              en0
  ff01::%en5/32                           link#5                          UmCI              en5
  ff01::%awdl0/32                         link#12                         UmCI            awdl0
  ff01::%llw0/32                          link#13                         UmCI             llw0
  ff01::%utun0/32                         fe80::3490:f639:8aa0:5627%utun0 UmCI            utun0
  ff01::%utun1/32                         fe80::1eac:7783:3b8c:7d32%utun1 UmCI            utun1
  ff01::%utun2/32                         fe80::ce81:b1c:bd2c:69e%utun2   UmCI            utun2
  ff02::%lo0/32                           ::1                             UmCI              lo0
  ff02::%en0/32                           link#4                          UmCI              en0
  ff02::%en5/32                           link#5                          UmCI              en5
  ff02::%awdl0/32                         link#12                         UmCI            awdl0
  ff02::%llw0/32                          link#13                         UmCI             llw0
  ff02::%utun0/32                         fe80::3490:f639:8aa0:5627%utun0 UmCI            utun0
  ff02::%utun1/32                         fe80::1eac:7783:3b8c:7d32%utun1 UmCI            utun1
  ff02::%utun2/32                         fe80::ce81:b1c:bd2c:69e%utun2   UmCI            utun2
  student@students-MacBook-Pro ~ %
  ```
While the commands above vary in verbosity, they all have elements in common.  In particular, each line describes a route to a destination.  The destination is expressed as the combination of a destination address and netmask.  The host will take the destination IP address you are trying reach and use a bitwise AND operation to combine the address with the route's netmask, effectively replacing all the host-specific bits with zeros, leaving you with an address to match against the destination in the route.  If the result applying the netmask to the destination IP address matches the destination address in the route, the route may be used.  The default route, shown as `default` in the output above, has a destination/netmask of 0.0.0.0/0.  The default route will always be an option since, if you apply a /0 netmask to any IP address, you will will get 0.0.0.0.  Of the routes that match, the route that gets used is the route with the most specific netmask (i.e. has the most network bits) and the packet will be sent out the interface specified in that route. If more than one route matches and they have the same number of bits in the netmask, other routing metrics will be used to select which route to use.

Let's look at an example on our Linux VM.  Since we are using DHCP to get an IP address, it would be helpful to know what our IP address and default gateway are:
```
student@debian1:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:a3:db:bd brd ff:ff:ff:ff:ff:ff
    inet 192.168.45.127/24 brd 192.168.45.255 scope global dynamic noprefixroute enp0s3
       valid_lft 13225sec preferred_lft 13225sec
    inet6 fe80::fc0d:ea:7553:364a/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
student@debian1:~$ ip route
default via 192.168.45.254 dev enp0s3 proto dhcp metric 100
169.254.0.0/16 dev enp0s3 scope link metric 1000
192.168.45.0/24 dev enp0s3 proto kernel scope link src 192.168.45.127 metric 100
student@debian1:~$
```
From these two command, we can see our Ethernet interface, `enp0s3` has been assigned an IPv4 (`inet`) address of 192.168.45.127 with a netmask of /24 (255.255.255.0). The second command shows our default route to other networks is via 192.168.45.254, the IP address of our default gateway.

Let's assume we are are trying to get to 192.168.45.149 (this happens to be my Windows VM but your VM may have received a different IP address from the DHCP server).  I see this route in the Linux routing table:
```
192.168.45.0/24 dev enp0s3 proto kernel scope link src 192.168.45.127 metric 100
```
If we apply the /24 netmask to 192.168.45.149, the IP address we're trying to reach, we're left with 192.168.45.0 which matches this route's destination and we can use this route.  If we were instead trying to get to 8.8.8.8, we would apply the route's /24 netmask and be left with 8.8.8.0 which does not match the route's destination of 192.168.45.0 so we can not use this route to get to 8.8.8.8.  If we look at some of the other fields in this route, we see packets using this route will be sent out the enp0s3 device (our network interface) and will be dumped on the the wire rather than sent through a gateway since this route has link scope (i.e. is only valid on this network).  The default route (0.0.0.0/0) also matches, but because this route has a more specific netmask (24 bits versus 0 bits), this is the route that will be used.

### Routing Tables on Routers
> Note:</br>
  The default shell on the the routers should be Quagga's vtysh which emulates Cisco's IOS interface.  If you just configured these devices using the setup script on the "control" container, you may get a bash shell the first time you open a console.  In that case (or if you're unsure), just type exit to get to the Quagga vtysh prompt.  If you instead get another bash shell, you should rerun the setup scrip on the control container.  The vtysh should look like this:</br>
  ```
  router2.networkplus.test# exit

  Hello, this is Quagga (version 1.2.4).
  Copyright 1996-2005 Kunihiro Ishiguro, et al.

  router2.networkplus.test#
  ```
> Typing a `?` at the vtysh prompt will print a list of commands available at your current location in the command hierarchy.  To start the vtysh interface on firewall or control, type `sudo vtysh`.

Routing tables on routers work the same way as on hosts.  However, whereas hosts typically just have routes for just the networks they are connected to, routers share their routing tables with other routers using routing protocols like OSPF and BGP and dynamically keep track of where to sent packets.

It should be noted that protocols used to route packets through internets, such as IPv4 and IPv6, are called "routable" protocols whereas "routing" protocals like OSPF are the protocols routers use to share their routes with other routers.  Let's take a look at a routing table on a router.

1. Open the console on router2. The prompt should look like:
   ```
   router2.networkplus.test#
   ```
   You are already in what is referred to as "enable mode" (or privileged EXEC mode) in Cisco iOS. Enable mode allows you to run commands that make changes to the Router's configuration.  You can run `disable` to exit privileged mode since you won't need it for this exercise.  Running `?` will show you have a reduced number of commands available and running `enable` will get you back to privileged mode when you need it.

1. Run `show ip route` to display router2's routing table.  Your output so far should look somthing like this:
   ```
   router2.networkplus.test# exit
 
   Hello, this is Quagga (version 1.2.4).
   Copyright 1996-2005 Kunihiro Ishiguro, et al.
 
   router2.networkplus.test#
     clear        Reset functions
     configure    Configuration from vty interface
     copy         Copy from one file to another
     debug        Debugging functions (see also 'undebug')
     disable      Turn off privileged mode command
     enable       Turn on privileged mode command
     end          End current mode and change to enable mode
     exit         Exit current mode and down to previous mode
     list         Print command list
     no           Negate a command or set its defaults
     ping         Send echo messages
     quit         Exit current mode and down to previous mode
     show         Show running system information
     ssh          Open an ssh connection
     start-shell  Start UNIX shell
     telnet       Open a telnet connection
     terminal     Set terminal line parameters
     test         Test
     traceroute   Trace route to destination
     undebug      Disable debugging functions (see also 'debug')
     write        Write running configuration to memory, network, or terminal
   router2.networkplus.test# disable
   router2.networkplus.test>
     clear       Reset functions
     enable      Turn on privileged mode command
     exit        Exit current mode and down to previous mode
     list        Print command list
     ping        Send echo messages
     quit        Exit current mode and down to previous mode
     show        Show running system information
     ssh         Open an ssh connection
     telnet      Open a telnet connection
     terminal    Set terminal line parameters
     traceroute  Trace route to destination
   router2.networkplus.test> show ip route
   Codes: K - kernel route, C - connected, S - static, R - RIP,
         O - OSPF, I - IS-IS, B - BGP, P - PIM, A - Babel, N - NHRP,
         > - selected route, * - FIB route
 
   O>* 0.0.0.0/0 [110/1] via 192.168.41.5, eth1, 05:14:22
   C>* 127.0.0.0/8 is directly connected, lo
   O>* 192.168.41.0/30 [110/20] via 192.168.41.5, eth1, 05:14:23
   O   192.168.41.4/30 [110/10] is directly connected, eth1, 05:15:13
   C>* 192.168.41.4/30 is directly connected, eth1
   O   192.168.42.0/24 [110/25] is directly connected, eth0, 05:14:58
   C>* 192.168.42.0/24 is directly connected, eth0
   O>* 192.168.43.0/24 [110/30] via 192.168.41.5, eth1, 05:14:23
   O>* 192.168.44.0/24 [110/20] via 192.168.41.5, eth1, 05:14:23
   O   192.168.45.0/24 [110/10] is directly connected, eth2, 05:15:13
   C>* 192.168.45.0/24 is directly connected, eth2
   O   192.168.46.0/24 [110/10] is directly connected, eth2.100, 05:15:13
   C>* 192.168.46.0/24 is directly connected, eth2.100
   O   192.168.47.0/24 [110/10] is directly connected, eth2.200, 05:15:13
   C>* 192.168.47.0/24 is directly connected, eth2.200
   router2.networkplus.test>
   ```
 
   Just like with host routing tables, each line describes a possible route. Notice the output starts with a key to explain the letter in the first column of each route. The letter indicates how the route was learned. Since the routers in our model are using OSPF to share routes, the letter in this column will either be a "C" (C for Connected, the route was learned because it is directly attached to router2) or an "O" (O for OSPF, Open Shortest Path First). A router may learn about a network using multiple methods and we see many routes were learned from a directly connected interface and via OSPF.

1. Let's focus on just the routes we would know about if we were not using OSPF. You can use `show ip route connected` to see which networks are connected to each interface:
   ```
   router2.networkplus.test> show ip route connected
   Codes: K - kernel route, C - connected, S - static, R - RIP,
         O - OSPF, I - IS-IS, B - BGP, P - PIM, A - Babel, N - NHRP,
         > - selected route, * - FIB route
 
   C>* 127.0.0.0/8 is directly connected, lo
   C>* 192.168.41.4/30 is directly connected, eth1
   C>* 192.168.42.0/24 is directly connected, eth0
   C>* 192.168.45.0/24 is directly connected, eth2
   C>* 192.168.46.0/24 is directly connected, eth2.100
   C>* 192.168.47.0/24 is directly connected, eth2.200
   router2.networkplus.test>
   ```
   You can use the `show interface` command to see the status and specific IP addresses assigned to each of the routers interfaces:</br>
   ```
   router2.networkplus.test> show interface
   Interface eth0 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     Description: Provisioning
     index 34 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 32:b0:0b:68:60:85
     inet 192.168.42.4/24
     inet6 fe80::30b0:bff:fe68:6085/64
   Interface eth1 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     Description: Backbone
     index 35 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 9a:2e:97:e2:eb:26
     inet 192.168.41.6/30 broadcast 192.168.41.7
     inet6 fe80::982e:97ff:fee2:eb26/64
   Interface eth2 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     Description: Office and Labs
     index 36 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 0a:7f:d2:b8:08:b8
     inet 192.168.45.254/24
     inet6 fe80::87f:d2ff:feb8:8b8/64
   Interface eth2.100 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     index 2 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 0a:7f:d2:b8:08:b8
     inet 192.168.46.254/24
     inet6 fe80::87f:d2ff:feb8:8b8/64
   Interface eth2.200 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     index 3 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 0a:7f:d2:b8:08:b8
     inet 192.168.47.254/24
     inet6 fe80::87f:d2ff:feb8:8b8/64
   Interface eth3 is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     index 37 metric 0 mtu 1500
     flags: <UP,BROADCAST,RUNNING,MULTICAST>
     Type: Ethernet
     HWaddr: 6a:7c:f1:5f:81:99
     inet6 fe80::687c:f1ff:fe5f:8199/64
   Interface lo is up, line protocol is up
     Link ups:       1  last: Wed, 01 Dec 2021 19:57:33 +0000
     Link downs:     0  last: (never)
     vrf: 0
     index 1 metric 0 mtu 65536
     flags: <UP,LOOPBACK,RUNNING>
     Type: Loopback
     inet 127.0.0.1/8
     inet6 ::1/128
   router2.networkplus.test>
   ```
   > Note: eth2 has two sub-interfaces, eth2.100 and eth2.200, each with its own IP address.  This means the eth2 network card is simultaneously connected to three different networks running on a single ethernet cable.  This is possible because this interface is a VLAN trunk line which carries traffic for multiple virtual networks (more on VLANs in a later chapter).
 
   From the output above, we can see router2 is not directly connected to 192.168.44.0/24, the internal server network where dns1 lives, or 192.168.43.0/24, the DMZ network where www1 lives.  Also note that eth1 is directly connected to 192.168.41.4/30 which using a /30 netmask.  This can be tricky so we will come back to it later.

1. Now we will switch our attention to the routes learned via OSPF.  Use `show ip route ospf` to display just the routes learned via OSPF.</br>
   ```
   router2.networkplus.test> show ip route ospf
   Codes: K - kernel route, C - connected, S - static, R - RIP,
         O - OSPF, I - IS-IS, B - BGP, P - PIM, A - Babel, N - NHRP,
         > - selected route, * - FIB route
 
   O>* 0.0.0.0/0 [110/1] via 192.168.41.5, eth1, 06:30:06
   O>* 192.168.41.0/30 [110/20] via 192.168.41.5, eth1, 06:30:07
   O   192.168.41.4/30 [110/10] is directly connected, eth1, 06:30:57
   O   192.168.42.0/24 [110/25] is directly connected, eth0, 06:30:42
   O>* 192.168.43.0/24 [110/30] via 192.168.41.5, eth1, 06:30:07
   O>* 192.168.44.0/24 [110/20] via 192.168.41.5, eth1, 06:30:07
   O   192.168.45.0/24 [110/10] is directly connected, eth2, 06:30:57
   O   192.168.46.0/24 [110/10] is directly connected, eth2.100, 06:30:57
   O   192.168.47.0/24 [110/10] is directly connected, eth2.200, 06:30:57
   router2.networkplus.test>
   ```
   It is possible for a router to be directly connected to a network and not share that information with other routers.  However, in our model, router2 is sharing information about its directly connected interfaces with the other routers via OSPF.  This is why these directly connected routes show up in OSPF routes as well.
   Let's take a closer look a the fields in the output of the OSPF routes. Notice there is a third field with two numbers in brackets. The first number is the "administrative distance".  As we have seen, a router may learn about a network via different methods.  Each routing protocol has its own method for calculating metrics to find the best route to a network.  For example, RIP just counts the number of routers between the source and destination where as OSPF is a little more complicated and considers the bandwidth of the links as well.  This means RIP metrics are only useful when comparing with other RIP routes, OSPF metrics are only useful when comparing OSPF routes, etc.  Comparing RIP metrics to OSPF metrics is comparing apples to oranges.  Therefore, when a router learns about networks from different methods, it needs to know which method is more trustworthy.  "Administrative distance" is the number used to determine how trustworthy the source of the route is with lower numbers being better.  Directly connected routes have an adminitrative distance of 0 and are the prefered route.  Static routes, that is routes manually entered by the network administrator have an administrative distance of 1 and are trusted over everything but directly connected routes.  The various routing protocols all have default administrative distances with OSPF having an administrative distance of 110 which is lower (more trustworthy) than RIP with an administrative distance of 120.</br>

### Route troubleshooting tools
So far, we have been looking at commands to help us collect routing information. Before we can see the effects of route metrics or watch OSPF in action, we are going to need some tools for troubleshooting routes.

The `ping` utility is a common tool for testing contectivity and is available on most platforms by default.

1. Login to the debian1-1 VM and use ping to verify you have connectivity to 8.8.8.8:
   ```
   student@debian1:~$ ping -c 3 8.8.8.8
   PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
   64 bytes from 8.8.8.8: icmp_seq=1 ttl=55 time=17.1 ms
   64 bytes from 8.8.8.8: icmp_seq=2 ttl=55 time=17.6 ms
   64 bytes from 8.8.8.8: icmp_seq=3 ttl=55 time=13.7 ms
 
   --- 8.8.8.8 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2002ms
   rtt min/avg/max/mdev = 13.745/16.149/17.630/1.715 ms
   student@debian1:~$
   ```
   Note: adding `-c 3` causes ping on Linux to quit after three pings.

1. While `ping` is nice for verifying you have connectivity and watching the round trip time, it doesn't tell you which route it took.  For that, we can use `traceroute` (`tracert` on Windows):
   ```
   student@debian1:~$ traceroute 8.8.8.8
   traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
   1  _gateway (192.168.45.254)  1.576 ms  1.957 ms  2.176 ms
   2  192.168.41.5 (192.168.41.5)  3.042 ms  3.488 ms  3.888 ms
   3  192.168.41.1 (192.168.41.1)  4.276 ms  4.733 ms  4.856 ms
   4  192.168.122.1 (192.168.122.1)  6.347 ms  6.888 ms  8.221 ms
   5  10.0.3.2 (10.0.3.2)  8.676 ms  9.361 ms  9.716 ms
   6  * * *
   7  * * *
   8  * * *
   9  * * *
   10  24.124.128.89 (24.124.128.89)  23.699 ms  23.704 ms  23.539 ms
   11  24.124.128.122 (24.124.128.122)  20.967 ms  24.335 ms  21.811 ms
   12  50.218.57.26 (50.218.57.26)  21.778 ms 50.222.176.218 (50.222.176.218)  22.098 ms 50.222.176.214 (50.222.176.214)  25.611 ms
   13  * * *
   14  dns.google (8.8.8.8)  14.506 ms  13.356 ms  14.392 ms
   student@debian1:~$
   ```
   Not every intermeddiate device will respond which is why some of the intermittent hops show up as stars.  However, if you can ping your default gateway but cannot ping other sites on the Internet, this tool can help you find out where the connection is failing.
   A similar tool is `mtr`.  It as the added feature that you can continuously monitor the connection (press `q` to quit) and watch for packet loss, but you will have to install it first:
   ```
   student@debian1:~$ sudo apt install -y mtr
   Reading package lists... Done
   Building dependency tree... Done
   Reading state information... Done
   The following NEW packages will be installed:
     mtr
   0 upgraded, 1 newly installed, 0 to remove and 13 not upgraded.
   Need to get 87.1 kB of archives.
   After this operation, 219 kB of additional disk space will be used.
   Get:1 http://http.us.debian.org/debian bullseye/main amd64 mtr amd64 0.94-1+deb11u1 [87.1 kB]
   Fetched 87.1 kB in 0s (218 kB/s)
   Selecting previously unselected package mtr.
   (Reading database ... 164313 files and directories currently installed.)
   Preparing to unpack .../mtr_0.94-1+deb11u1_amd64.deb ...
   Unpacking mtr (0.94-1+deb11u1) ...
   Setting up mtr (0.94-1+deb11u1) ...
   Processing triggers for man-db (2.9.4-2) ...
   student@debian1:~$ mtr --curses --nodns8.8.8.8
   ```
   The screen will clear and present you output like this:</br>
   ```
                                 My traceroute  [v0.94]
   debian1 (192.168.45.127) -> 8.8.8.8                    2021-12-02T06:16:17+0000
   Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                         Packets               Pings
   Host                                Loss%   Snt   Last   Avg  Best  Wrst StDev
   1. 192.168.45.254                    0.0%    40    1.3   1.2   0.9   1.7   0.2
   2. 192.168.41.5                      0.0%    40    1.0   1.3   1.0   2.3   0.3
   3. 192.168.41.1                      0.0%    40    1.7   1.8   1.1   8.9   1.5
   4. 192.168.122.1                     0.0%    40    2.0   2.7   1.9   7.7   1.0
   5. 10.0.3.2                          0.0%    40    2.0   2.7   2.0   6.0   0.8
   6. (waiting for reply)
   7. (waiting for reply)
   8. (waiting for reply)
   9. (waiting for reply)
   10. 24.124.128.89                     0.0%    39   15.7  14.9  12.5  22.0   1.7
   11. 24.124.128.122                    0.0%    39   12.9  18.6  12.4  53.9   8.2
   12. 50.222.176.214                    0.0%    39   14.1  15.1  12.6  22.5   1.6
   13. 142.251.50.43                     0.0%    39   16.5  15.9  13.6  19.6   1.4
   14. 142.251.48.211                    0.0%    39   16.4  14.7  12.3  18.0   1.4
   15. 8.8.8.8                           0.0%    39   15.4  14.8  12.5  22.2   1.7
   ```
   Press `q` to quit.
 
   From the output above, we can see packets going from debian1-1 to 8.8.8.8 are first sent to the interface on router2 which is closest to the debian1-1 VM (192.168.45.254). From there, router2 send packets to the interface on router1 (192.168.41.5) which is closest to router2.  Router1 then sends the packets to the interface on firewall (192.168.41.1) which is closest to it and then firewall sends packets to the ISP (the Internet cloud in our model) which has the IP address 192.168.l22.1 before leaving the virtual model and traversing the real Internet.
 
You might be wondering why there are two hops on the 192.168.41 network, but remember these routes have a /30 netmask.  If you use `ipcalc` (installed on the debian1-1 VM in a previous lab) to investgate these routes, you will see there are two networks, the 192.168.41.0/30 network and the 192.168.41.4/30 network, each with just two IP addresses.  This means the networks between firewall and router1 and between router1 and router2 are point to point networks:</br>
```
student@debian1:~$ ipcalc 192.168.41.0/30
Address:   192.168.41.0         11000000.10101000.00101001.000000 00
Netmask:   255.255.255.252 = 30 11111111.11111111.11111111.111111 00
Wildcard:  0.0.0.3              00000000.00000000.00000000.000000 11
=>
Network:   192.168.41.0/30      11000000.10101000.00101001.000000 00
HostMin:   192.168.41.1         11000000.10101000.00101001.000000 01
HostMax:   192.168.41.2         11000000.10101000.00101001.000000 10
Broadcast: 192.168.41.3         11000000.10101000.00101001.000000 11
Hosts/Net: 2                     Class C, Private Internet

student@debian1:~$ ipcalc 192.168.41.4/30
Address:   192.168.41.4         11000000.10101000.00101001.000001 00
Netmask:   255.255.255.252 = 30 11111111.11111111.11111111.111111 00
Wildcard:  0.0.0.3              00000000.00000000.00000000.000000 11
=>
Network:   192.168.41.4/30      11000000.10101000.00101001.000001 00
HostMin:   192.168.41.5         11000000.10101000.00101001.000001 01
HostMax:   192.168.41.6         11000000.10101000.00101001.000001 10
Broadcast: 192.168.41.7         11000000.10101000.00101001.000001 11
Hosts/Net: 2                     Class C, Private Internet

student@debian1:~$
```

### Metrics and route convergence
Now that we have some tools for tracing network traffic, we can explore route metrics and OSPF route convergence.

The backbone our our virtual lab network connecting our debian1-1 VM to the Internet passes through the routers and out the firewall.  However, looking at the model, you may have noticed that router2 can reach firewall directly through OpenvSwitch-1 on the 192.168.42.0/24 provisioning network, but the traceroute/mtr output shows it takes the longer route through router1.  This is a result of route metrics.  By manually increasing the OSPF cost of using the network interfaces on the provisioning network, we discourage packets from taking that route.  However, the route is still available should a link in the backbone go down.  Let's test that now.

1. Start a wireshark packet capture on the link between router1 and router2.  Set the filter line to `ospf`.  You will immediately see OSPF hello packets as the routers are in constant communication.  The inner working of how OSPF updates the link state database are outside of the scope for Network+, but you will need to know this if you are studying for a CCNA cert and you can find more information about how OSPF works in CCNA study guides. The network trace is just to give you a taste of what the conversation look like when OSPF communicates links state changes.

1. From the debian1-1 VM, use traceroute to see the path packets take on their way to www1:
   ```
   student@debian1:~$ traceroute www1
   traceroute to www1 (192.168.43.1), 30 hops max, 60 byte packets
   1  _gateway (192.168.45.254)  1.358 ms  1.517 ms  1.201 ms
   2  192.168.41.5 (192.168.41.5)  2.588 ms  2.699 ms  2.617 ms
   3  192.168.41.1 (192.168.41.1)  2.588 ms  3.052 ms  3.270 ms
   4  www1.networkplus.test (192.168.43.1)  5.370 ms  6.140 ms  6.340 ms
   student@debian1:~$
   ```

1. Login to router1 and view the routing table:
   ```
   router1.networkplus.test# show ip route
   Codes: K - kernel route, C - connected, S - static, R - RIP,
          O - OSPF, I - IS-IS, B - BGP, P - PIM, A - Babel, N - NHRP,
          > - selected route, * - FIB route
   
   O>* 0.0.0.0/0 [110/1] via 192.168.41.1, eth1, 08:58:59
   C>* 127.0.0.0/8 is directly connected, lo
   O   192.168.41.0/30 [110/10] is directly connected, eth1, 08:59:50
   C>* 192.168.41.0/30 is directly connected, eth1
   O   192.168.41.4/30 [110/10] is directly connected, eth3, 08:59:50
   C>* 192.168.41.4/30 is directly connected, eth3
   O   192.168.42.0/24 [110/25] is directly connected, eth0, 08:59:45
   C>* 192.168.42.0/24 is directly connected, eth0
   O>* 192.168.43.0/24 [110/20] via 192.168.41.1, eth1, 08:59:00
   O   192.168.44.0/24 [110/10] is directly connected, eth2, 08:59:50
   C>* 192.168.44.0/24 is directly connected, eth2
   O>* 192.168.45.0/24 [110/20] via 192.168.41.6, eth3, 08:59:05
   O>* 192.168.46.0/24 [110/20] via 192.168.41.6, eth3, 08:59:05
   O>* 192.168.47.0/24 [110/20] via 192.168.41.6, eth3, 08:59:05
   router1.networkplus.test#
   ```

1. We are now going to disable eth1 on router1 to create an outage on the link between router1 and firewall.  On router1, run these commands:</br>
   ```
   router1.networkplus.test# configure terminal
   router1.networkplus.test(config)# interface eth1
   router1.networkplus.test(config-if)# shutdown
   router1.networkplus.test(config-if)# exit
   router1.networkplus.test(config)# exit
   router1.networkplus.test#
   ```

1. View the packets in the wireshark trace and notice you have new OSPF packets with link state updates and acknowlegements.  It may take a few seconds for all the routers to converge on a new view of the network.

1. Return to the debian1-1 VM and rerun the traceroute command to see how the route to www1 has changed:
   ```
   student@debian1:~$ traceroute www1
   traceroute to www1 (192.168.43.1), 30 hops max, 60 byte packets
   1  _gateway (192.168.45.254)  2.144 ms  2.530 ms  2.970 ms
   2  firewall.networkplus.test (192.168.42.2)  4.272 ms  4.209 ms  4.904 ms
   3  www1.networkplus.test (192.168.43.1)  6.956 ms  10.937 ms  11.056 ms
   student@debian1:~$
   ```

1. Reenable eth1 on router1 with the following commands:
   ```
   router1.networkplus.test# configure terminal
   router1.networkplus.test(config)# interface eth1
   router1.networkplus.test(config-if)# no shutdown
   router1.networkplus.test(config-if)# exit
   router1.networkplus.test(config)# exit
   router1.networkplus.test#
   ```

1. View more link state updates in the network trace.  Stop the trace when it looks like it's just "hello" packets again.

1. Return to debian1-1 and rerun traceroute to www1 to confirm the routes have returned to normal.
   ```
   student@debian1:~$ traceroute www1
   traceroute to www1 (192.168.43.1), 30 hops max, 60 byte packets
   1  _gateway (192.168.45.254)  1.179 ms  1.370 ms  1.575 ms
   2  192.168.41.5 (192.168.41.5)  2.209 ms  2.492 ms  2.656 ms
   3  192.168.41.1 (192.168.41.1)  2.982 ms  3.355 ms  3.534 ms
   4  www1.networkplus.test (192.168.43.1)  6.078 ms  7.305 ms  8.312 ms
   student@debian1:~$
   ```

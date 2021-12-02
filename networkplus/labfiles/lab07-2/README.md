# Network Address Translation (NAT)

## OBJECTIVE

In this lab, we will capture network packets to see NAT in action.

## SETUP

This lab uses the same virtual lab environment as the other labs.  Make sure you have opened this project and run the `setup` script on the control node as described [here](https://github.com/dmbrownlee/demo/blob/master/networkplus/labfiles/README.md).

The firewall in the virtual lab environment is doing NAT, specifically source NAT (aka SNAT), to rewrite the source IP address for all outbound traffic.  To the outside world, it looks like all connections are coming from the firewall.  This allows us to use non-routable, private address ranges inside the firewall and still be able to connect to destinations on the Internet.  The non-routable address ranges defined in RFC 1918 are:

|Class|Reserved, non-routable netblock|number of private networks in range|
---|---|---
|A|10.0.0.0/8|1 private network|
|B|172.16.0.0/12|16 private networks when using /16 netmasks|
|C|192.168.0.0/16|256 private networks when using /24 netmasks|

Our network model uses multip networks in the 192.168.0.0/16 range as do many home network devices by default.

## STEPS

### NAT

For this part of the lab we'll demonstrate how NAT looks in realtime, using WireShark.

1. First, we want to start capturing network packets inside the firewall:
   1. Right click (two fingers on the Mac trackpad) the link connecting router1 to firewall and select "Start capture."
   1. Hit "OK" to use the default options in the dialog that appears.
   1. Type `icmp` in the view filter bar below the wireshark's button bar to restrict the packets displayed to only ICMP packets

1. Next, we want to simultaneously capture the same packets outside the firewall
   1. Right click the link connecting firewall to the NetworkTap hub and select "Start capture."
   1. Hit "OK" to use the default options in the dialog that appears.
   1. Type `icmp` in the view filter bar below the wireshark's button bar to restrict the packets displayed to only ICMP packets

   You should now have two Wireshark windows, one capturing ICMP packets between router1 and firewall, and one capturing ICMP packets between firewall and NetworkTap.

1. Open a terminal on the debian1-1 VM and send three pings to 8.8.8.8:
   ```
   student@debian1:~$ ping -c 3 8.8.8.8
   PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
   64 bytes from 8.8.8.8: icmp_seq=1 ttl=55 time=15.0 ms
   64 bytes from 8.8.8.8: icmp_seq=2 ttl=55 time=14.0 ms
   64 bytes from 8.8.8.8: icmp_seq=3 ttl=55 time=14.7 ms

   --- 8.8.8.8 ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2002ms
   rtt min/avg/max/mdev = 14.032/14.578/14.966/0.397 ms
   ```

Now observe the packets in the two Wireshark capters.  You will see see three `Echo (ping) request` packets in each capture followed by the corresponding `Echo (ping) reply` packet.  The request packets all have a destination of 8.8.8.8 which is also the source IP address of all the replies.  In the first capture from inside the firewall, the source address of the requests and the destination address of the replies is debian1-1's IP address (you can verify debian1-1's IP address by entering `ip address` in the terminal).  In the second packet capture taken from outside the firewall, we can see that the firewall is doing SNAT by replacing debian1-1's IP address with its own address (a random address on the 192.168.122.0/24 network) in both the requests and replies.  The firewall keeps track of all the connections passing through it and can perform NAT for multiple connections from multipls hosts simultaneously.

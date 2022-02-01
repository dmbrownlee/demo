# Network Address Translation (NAT)

## OBJECTIVE

In this lab, we will capture network packets to see NAT in action.

## SETUP

This lab uses the same virtual lab environment as the other labs.  Make sure you have opened this project and run the `setup` script on the control node as described [here](https://github.com/dmbrownlee/demo/blob/release/networkplus/labfiles/README.md).

The firewall in the virtual lab environment is doing NAT, specifically source NAT (aka SNAT), to rewrite the source IP address for all outbound traffic.  To the outside world, it looks like all connections are coming from the firewall.  This allows us to use non-routable, private address ranges inside the firewall and still be able to connect to destinations on the Internet.  The non-routable address ranges defined in RFC 1918 are:

|Class|Reserved, non-routable netblock|number of private networks in range|
---|---|---
|A|10.0.0.0/8|1 private network|
|B|172.16.0.0/12|16 private networks when using /16 netmasks|
|C|192.168.0.0/16|256 private networks when using /24 netmasks|

Our network model uses multip networks in the 192.168.0.0/16 range as do many home network devices by default.

## STEPS

### Source NAT

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

### Destination NAT (aka Port Forwarding)
Destination NAT is when the destination IP address is rewritten.  In this example, we will use Firefox running on the debian3-1 VM (outside the network) to connect to port 80 on the firewall's external interface.  However, the firewall is not running a web server.  Instead, it forwards the connection to www1 running inside the firewall.  From the client, debian3-1, it looks like the web server is running on firewall.

First, let's observe the problem port forwarding tries to solve.  We can see in the network model that www1 resides on the 192.168.43.0/24 network (the DMZ in our model).  Furthermore, if we open www1's console and run `ip a`, we can see that www1 has an IP address of 192.168.43.1.  This is a private address and not routable on the Internet.  When www1 sends traffic to the Internet, it passes through firewall which does source NAT as decribed above which allows www1 to open outbound connections with the world.  However, the outside world has no way to open new connections to the private addresses behind the firewall since those addresses are not routable over the Internet.  We can see this from the debian3-1 VM which is outside the firewall.  If you run `ip a` on debian3-1, you will see it has a random address on the 192.168.122.0/24 network.  More importantly, if you run `ip route` you will see its default route to the Internet is 192.168.122.1, the IP address of the ISP's router (represented by the Internet cloud in our model).  This mean debian3-1 will send all traffic not on its network through the Internet.  Fortunately, the firewall's external interface is on the same network so debian3-1 can reach the firewall and we can setup port forwarding on the firewall to pass traffic to services to hosts running behind the firewall.

   > Note:</br>The observant will notice that 192.168.122.0/24 is also a private netblock as opposed to a real, routable Internet netblock.  This is so our virtual network does not conflict with a real Internet netblock.  How then does traffic get back to the virtual networks in our model?  Well, like the firewall, the Internet cloud in our model is also doing source NAT as packets leave the virtual network and get passed to the host OS.  The Internet cloud is also the DHCP and DNS server handing out addresses and resolving hostnames on the 192.168.122.0/24 netblock so, in that sense, the Internet cloud in our model works much like a consumer wireless router.  On top of that, your host machine might be running on a home network where you have a wireless access point that also does source NAT on the way to the Internet.  As you can see, NAT allows us to do some pretty interesting things with routing packets.

1. First, we want to start capturing network packets inside the firewall:
   1. Right click (two fingers on the Mac trackpad) the link connecting www1 to firewall and select "Start capture."
   1. Hit "OK" to use the default options in the dialog that appears.
   1. Type `http` in the view filter bar below the wireshark's button bar to restrict the packets displayed to only ICMP packets

1. Next, we want to simultaneously capture the same packets outside the firewall
   1. Right click the link connecting firewall to the NetworkTap hub and select "Start capture."
   1. Hit "OK" to use the default options in the dialog that appears.
   1. Type `http` in the view filter bar below the wireshark's button bar to restrict the packets displayed to only ICMP packets

   You should now have two Wireshark windows, one capturing HTTP packets between www1 and firewall, and one capturing HTTP packets outside the firewall.

1. Open the console on firewall and run the following command to find the IP address for firewall's external interface, `eth1`:
   ```
   student@firewall:~$ ip a show dev eth1
   28: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
       link/ether b6:9f:ef:f3:27:82 brd ff:ff:ff:ff:ff:ff
       inet 192.168.122.81/24 brd 192.168.122.255 scope global eth1
          valid_lft forever preferred_lft forever
   student@firewall:~$
   ```
   In the example above, the IP address is 192.168.122.81 but you may have a different IP address on the 192.168.122.0/24 network since this is randomly assigned by DHCP.  ___Make a note of your specific IP address as you will soon be connecting to this IP address from debian3-1 using Firefox___.

1. Before leaving firewall, you can confirm there is no process listening (i.e. the command will produce no output) on port 80 on the firewall itself with (note, `ss` is a Linux specific replacement for the older `netstat` utility found across different Unix variants):
   ```
   student@firewall:~$ sudo ss -ntlp | grep :80
   student@firewall:~$
   ```
   If you run the same command on www1, you will see there is an `nginx` process listening on port 80 both on IPv4 addresses (0.0.0.0:80 means nginx is listening to port 80 on all the hosts IPv4 addresses) and IPv6 ([::]:80 is similarly port 80 on all local IPv6 addresses)
   ```
   student@www1:~$ sudo ss -ntlp | grep :80
   LISTEN    0         511                0.0.0.0:80               0.0.0.0:*        users:(("nginx",pid=2709,fd=6),("nginx",pid=2708,fd=6),("nginx",pid=2706,fd=6))
   LISTEN    0         511                   [::]:80                  [::]:*        users:(("nginx",pid=2709,fd=7),("nginx",pid=2708,fd=7),("nginx",pid=2706,fd=7))
   student@www1:~$
   ```
1. Back on the debian3-1 VM, open the Firefox browser and type http://192.168.122.x (replace 'x' so that it matches your firewall's IP address you learned in the steps above) into the Location bar.  You should see the default "Welcome to nginx" landing page from nginx server running on www1.

Now observe the destination IP address in the in the two Wireshark capters.  You will see see

> Note:</br>You might also see a lot more HTTP traffic to the Internet than you expected.  This is because apt, which tries to keep your software up to date uses HTTP to check the Debian software repositories for updates.

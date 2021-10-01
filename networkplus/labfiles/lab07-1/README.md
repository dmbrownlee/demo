# Routing Concepts

## OBJECTIVE

In this lab, we will be running various commands on the routers in our network model to gain a better understanding of routing protocols. We will take a look at how a routing table looks in Quagga and analyze its contents. We'll use traceroute to see the implications of the various information found in a routing table. We will also use WireShark to see NAT in action.

## SETUP

This lab uses the networkplus.gns3 model. Open the model and run the setup script on the control machine.

The routers we will be using in this lab are running. Quagga is a routing suite that is very similar to the Cisco Internetwork Operating System (IOS). Many of the commands listed here can also be used on a Cisco router.

## STEPS

### Routing Tables

1.  Open the console on router1, then run the command `sudo vtysh` to switch to Quagga, the password is `password`. The prompt should look like `router1.networkplus.test#`. You are already in what is referred to as "enable mode" (or privileged EXEC mode) in Cisco iOS. Enable mode allows you to run commands that make changes to the Router's configuration.
2. Run the command `show ip route` to display router1's routing table.

Notice that the first column in the table lists a letter. The letter indicates which routing protocol was used to learn that particular route. Since the routers in our model are configured to use OSPF, the letter in this column will either be a "C" (C for Connected, the route was learned because it is directly attached to router1) or an "O" (O for OSPF, Open Shortest Path First). Some routes that were learned by being directly Connected and via OSPF are listed twice, row 3 and row 4 in the screenshot, for example. Since all routes were learned via OSPF, we can run a command to show only routes in the routing table learned via OSPF to get a cleaner output whilst not losing much information (only the loopback address, 127.0.0.0/8, will not be shown via this command).

3. Use `show ip route ospf` to display all routes in the routing table learned via OSPF.

Here we get a much easier to read output. 

Let's take the second row of output for example.

`O` - indicates the route was learned via OSPF as mentioned previously\
`192.168.41.0/30` - indicates the address of the route\
`[110/10]` - the first number in the brackets indicates the administrative distance of the information source. The second number is the metric for that route.\
`eth1` - indicates the interface that this particular route can be reached through\
`01:36:52` - indicates the last time the route was updated (hh:mm:ss)


### NAT

For this part of the lab we'll demonstrate how NAT looks in realtime, using WireShark.

1. Right click the line connecting router1 to firewall and select "Start Capture." Hit "OK" to the prompt that appears. Do the same with the line connecting NetworkTap to Internet.
2. You should now have two WireShark windows. One capturing from router1 to firewall, and one capturing from InternetHub to NetworkTap. In both windows fill in "icmp" in the text box that reads "Apply a display filter" and hit enter. This will filter packet capture to only ICMP requests and replies (ICMP is the protocol used to send and reply to pings).
3. Open the Quagga console on router1 using the same steps seen earlier in the lab and run the command "ping google.com." After it has sent a few pings hit Ctrl+C to cancel, and take a look at the two WireShark windows that you have open.

You'll see an Echo (ping) request going from router1 to firewall with source IP 192.168.41.2. However, you'll see in the window tracking Ethernet2 to NetworkTap that the same ping request has a source IP of 192.168.122.42. This is an example of NAT. The firewall hides the IP of the local device sending the ping and translates it to a public IP before sending the packet on its way. 

You can see the same thing happen in reverse here as well. Take a look at the WireShark window capturing Ethernet2 to NetworkTap. The ping reply from google.com has a destination IP of 192.168.122.42 (from its perspective, the packet came from the firewall not router1). By the time the same reply packet is traveling from the firewall to router1, the destination IP is changed to 192.168.41.2. This is an example of NAT working both ways as the firewall handles masking the origin IP address, and then forwarding the packet back to the original machine as it comes back in.  

# lab8-1: Network Configuration
## OBJECTIVE

In this lab, you will practice viewing network settings and configuring
network connections.

## SETUP

There are no special setup steps for this lab.

## STEPS

On server2:
  1. Check your network settings to find out which network interface you're using to get to the Internet
  1. Create a new network connection using the same interface and gateway address, but using 192.168.4.20/24 as the IPv4 address and netmask
  1. Activate the new connection
  1. Change the hostname of server2 to newserver

On server1:
  1. Change any settings you need to in order to SSH to newserver by name

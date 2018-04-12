#!/bin/bash
NETWORKNAME=RHCSA

# Create the isolated test network
VBoxManage natnetwork list "$NETWORKNAME" |grep -q '1 network found'
if [[ $? -ne 0 ]]; then
  VBoxManage natnetwork add --netname "$NETWORKNAME" \
    --enable \
    --network "192.168.5.0/24" \
    --dhcp off \
    --ipv6 off
fi

#vagrant up

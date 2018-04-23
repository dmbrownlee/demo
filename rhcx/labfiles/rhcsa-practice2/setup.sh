#!/bin/bash
# Create the isolated test networks
for net in RHCSA:172.16.1.0/24 RHCSA2:172.16.2.0/24; do
  NETWORKNAME=${net/:*}
  NETBLOCK=${net/*:} 
  VBoxManage natnetwork list "$NETWORKNAME" |grep -q '1 network found'
  if [[ $? -ne 0 ]]; then
    VBoxManage natnetwork add --netname "$NETWORKNAME" \
      --enable \
      --network "$NETBLOCK" \
      --dhcp off \
      --ipv6 off
  fi
done

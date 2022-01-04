#!/bin/bash
if [[ "$ANSIBLE_CONTROLLER" == "true" ]]; then
  which curl || apk add --no-cache curl
  [ -f /home/USERNAME/setup ] ||
    curl --output /home/USERNAME/setup https://raw.githubusercontent.com/dmbrownlee/labnetwork/main/setup
  chmod +x /home/USERNAME/setup
fi

[ -f /etc/ssh/ssh_host_rsa_key ] ||
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

/sbin/runsvdir -P /etc/service &

while true; do
  # vtysh is Quagga's IOS-like shell which we would prefer on routers
  ( [ -f /root/startvtysh ] && /usr/bin/vtysh ) ||
  ( grep -q ^USERNAME: /etc/passwd && su - USERNAME ) ||
  /bin/bash
done

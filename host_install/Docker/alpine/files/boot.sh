#!/bin/bash
if [[ $ANSIBLE_CONTROLLER == 'true' ]]; then
  which curl || apk add --no-cache curl
  [ -f /home/ansible/setup ] ||
    curl --output /home/ansible/setup https://raw.githubusercontent.com/dmbrownlee/labnetwork/main/setup
  chmod +x /home/ansible/setup
fi

/usr/sbin/sshd

while true; do
  ( [ -f /root/startvtysh ] && /usr/bin/vtysh ) ||
  ( grep -q ^student /etc/passwd && su - student ) ||
  ( grep -q ^ansible /etc/passwd && su - ansible ) ||
  /bin/bash
done

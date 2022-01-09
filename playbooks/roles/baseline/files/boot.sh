#!/bin/bash

/usr/bin/runsvdir -P /etc/service &

while true; do
  ( [ -f /root/startvtysh ] && /usr/bin/vtysh ) ||
  ( grep -q ^student /etc/passwd && su - student ) ||
  ( grep -q ^ansible /etc/passwd && su - ansible ) ||
  /bin/bash
done

#!/bin/bash

if [[ $UID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

if [[ $(hostname -s) == "labipa" ]]; then
  echo password | kinit admin
  for n in server1 server2; do
    ipa service-find nfs/${n}.example.com ||
    ipa service-add nfs/${n}.example.com
  done
  systemctl enable nfs-secure
  systemctl start nfs-secure
else
  yum install -y pam_krb5
  authconfig --update --enablekrb5 --enablekrb5kdcdns --enablekrb5realmdns
  echo password | kinit admin
  ipa-client-install -U --enable-dns-updates -p admin@EXAMPLE.COM -w password
fi

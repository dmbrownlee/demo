#!/bin/bash
PASSWORD=password
echo $PASSWORD | kinit admin
for u in ldapuser1 ldapuser2 ldapuser3 ldapuser4 ldapuser5 isabelle; do
  echo | ipa user-add --first $u --last $u $u
  echo -e "$PASSWORD\n$PASSWORD" | ipa passwd $u
done

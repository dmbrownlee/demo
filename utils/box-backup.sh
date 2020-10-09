#!/bin/bash
if [[ $# -ne 1 ]]; then
  echo "USAGE: $0 <backup directory>"
  exit 1
fi

if [[ ! -d "$1" ]]; then
  echo "$1 does not exist or is not a directory."
  exit 1
fi

APARGS="$APARGS -e ansible_python_interpreter=$(which python3)"
APARGS="$APARGS -e backup_dir=$1"
APARGS="$APARGS --skip-tags disabled"

caffeinate -dsu ansible-playbook -i localhost, -c local $APARGS \
  /dev/stdin <<PLAYBOOK_END
---
# This playbook will backup your *.box files and corresponding keys so you can
# save time during testing. Assuming your external backup media is mounted on
# /mnt, you can use this:
#
# ansible-playbook -i localhost, -c local -e backup_dir=/mnt box-backup.yml
- name: box-backup
  hosts: localhost
  connection: local
  tasks:
    - name: Backing up vagrant keys, box files, and ISO downloads
      archive:
        path:
          - "{{ ansible_user_dir }}/keys/vagrant*"
          - "{{ ansible_user_dir }}/demo/.setup/packer/*.box"
          - "{{ ansible_user_dir }}/Downloads/*.iso"
        dest: "{{ backup_dir }}/box-backup.tar"
        format: tar
PLAYBOOK_END

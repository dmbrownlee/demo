#!/bin/bash
if [[ $# -ne 1 ]]; then
  echo "USAGE: $0 <backup directory>"
  exit 1
fi

if [[ ! -f "$1/box-backup.tar" ]]; then
  echo "$1/box-backup.tar does not exist."
  exit 1
fi

APARGS="$APARGS -e ansible_python_interpreter=$(which python3)"
APARGS="$APARGS -e backup_dir=$1"
APARGS="$APARGS --skip-tags disabled"

caffeinate -dsu ansible-playbook -i localhost, -c local $APARGS \
  /dev/stdin <<PLAYBOOK_END
---
# This playbook will restore from backups made with box-backup.yml. Assuming
# your external backup media is mounted on /mnt, you can use this:
#
# ansible-playbook -i localhost, -c local -e backup_dir=/mnt box-restore.yml
- name: box-restore
  hosts: localhost
  connection: local
  tasks:
    - name: Restoring files from backup
      command:
        cmd: "tar -xpvf {{ backup_dir }}/box-backup.tar"
        chdir: "{{ ansible_user_dir }}"
        warn: false
PLAYBOOK_END

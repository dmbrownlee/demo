#!/bin/sh
curl -fsSLo /root/.vimrc https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/vimrc.j2
curl -fsSLo /root/.tmux.conf https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/tmux.conf.j2

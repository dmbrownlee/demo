#!/bin/sh
curl -fsSLo ~/.vimrc https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/vimrc.j2
curl -fsSLo ~/.tmux.conf https://raw.githubusercontent.com/dmbrownlee/home/master/ansible/roles/baseline/templates/tmux.conf.j2

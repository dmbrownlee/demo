#!/bin/zsh
$(/usr/local/bin/vboxmanage list hostonlyifs | awk '/^Name:/{ NAME=$2}; /^IPAddress:/{ IP=$2 }; END { print "/usr/local/bin/vboxmanage hostonlyif ipconfig", NAME, "--ip", IP; }')

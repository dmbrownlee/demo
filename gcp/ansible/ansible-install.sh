#!/bin/bash
[ "$CLOUD_SHELL" == 'true' ] || {
  echo 'This script is intended for use only within a GCP Cloud Shell.'
  exit 1
}

which ansible 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  pip3 install --user ansible
  [[ "$PATH" =~ "$HOME/.local/bin" ]] || {
    echo '[[ "$PATH" =~ "$HOME/.local/bin" ]] || export PATH=$PATH:$HOME/.local/bin' >> $HOME/.bashrc
    export PATH=$PATH:$HOME/.local/bin
  }
fi

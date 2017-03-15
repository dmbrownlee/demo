#!/bin/bash

# Update the icons docked in the Unity Launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://gnome-terminal.desktop', 'application://wireshark.desktop']"

# Tweak Ubuntus invasive privacy settings
# Security Settings - Do not remember files
gsettings set org.gnome.desktop.privacy remember-recent-files 'false'

# Security Settings - Do not search Internet
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'

# lab4-1: Working With Text Files

## OBJECTIVE

In this lab, you will practice working with text files and searching both for
files and for contents within files.

## SETUP

There are no special setup steps for this lab.

## STEPS

These tasks can be completed on the host or in any virtual machine.

1. Create a directory named "mytmp" in your home directory
1. Create an empty file in the ~/mytmp directory named "timestamp" WITHOUT changing into the mytmp directory first
1. Open up the man page for the mandb command
1. Press 'h' to discover the method by which the man command displays the pages one screen at a time as well as learn helpful hot keys
1. Return to the mandb manual page and search for "SEE ALSO" to find other manual pages for commands and files related to mandb
1. Exit the mandb manual page (you might want to also take a quick look at the manual page for "tee" as you may find it useful soon)
1. Create a list of all the files in /etc (not including subdirectories) that contain the string "192.168" and save the list to a file, with a name of choosing, under /var/tmp
1. Display the number of lines in /etc/ssh/sshd_config (you will need root access to read the file so you might need to do this on the host using sudo or login to a virtual machine as root)
1. Display all the lines in /etc/ssh/sshd_config that do not begin with '#'
1. Display all the lines in /etc/ssh/sshd_config that do not begin with '#' and are not blank lines
1. Find all the files with the same inode as /usr/bin/sha1hmac (you may want to use "2>/dev/null" to send all errors to the bit bucket)
1. Create a list of all files owned by user "user" in /var/tmp and save the list to a file named myfiles.txt in the ~/mytmp directory
1. Display a list of all files under /var that have changed since you created the $HOME/mytmp/timestamp file in step one
1. Delete the ~/mytmp directory and all its contents

Note, you should have been able to do each of the tasks above with a single
command without resorting to using a text editor like vim.

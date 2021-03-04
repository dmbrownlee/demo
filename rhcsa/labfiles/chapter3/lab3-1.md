# lab3-1: Essential Tools - links

## OBJECTIVE

In this lab, you will practice creating symbolic and hard links.

## SETUP

There are no special setup steps for this lab.

## STEPS

These steps can be completed on the host or any of the virtual machines.

1.  Create directory with the name "foo"
1.  Without changing into the foo directory, create a file named "file1" inside the foo directory
1.  Create a link to the directory foo named "bar"
1.  Change into the directory bar and create a hard link to file1 named file2
1.  Create a symbolic link to the foo directory named "link"
1.  List the files in the current directory using the options to display a long listing which include inode number and take notice of the inode numbers of the files
1.  View the permissions on the directory foo
1.  Change the permissions on link with "chmod 777 link"
1.  View the permissions on foo and link again to observe what actually happened
1.  Remove file1
1.  Do another long listing to observe what actually happened
1.  Recreate file1 in a single command to recreate it as it was

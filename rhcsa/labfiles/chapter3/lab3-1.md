# lab3-1: Essential Tools - links
## <img align="left" src="../images/ConstructionSign.png">Sorry, this lab has not been reviewed recently and may contain:
  - outdated technical informatiom
  - spelling errors, grammar errors, and poor markdown formatting

## OBJECTIVE

In this lab, you will practice creating symbolic and hard links.

## SETUP

There are no special setup steps for this lab.

## STEPS

These steps can be completed on the host or any of the virtual machines.

 1.  Create directory with the name "foo"
 2.  Without changing into the foo directory, create a file named "file1"
     inside the foo directory
 3.  Create a link to the directory foo named "bar"
 4.  Change into the directory bar and create a hard link to file1 named file2
 5.  Create a symbolic link to foo named "link"
 6.  Do a long listing in the directory to see how the links differ
 7.  Use "ls -il" and take notice of the inode numbers of the files
 8.  Change the permissions on link with "chmod 777 link"
 9.  Do another long listing to observe what actually happened
10.  Remove file1
11.  Do another long listing to observe what actually happened
12.  Recreate file1 in a single command to recreate it as it was


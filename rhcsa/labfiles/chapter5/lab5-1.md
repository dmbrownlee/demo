# lab5-1: Using virtual consoles to work with multiple users

## OBJECTIVE

In this lab, you will practice working with different virtual terminals and setting up SSH for password-less logins.

## SETUP

There are no special setup steps for this lab.

## STEPS

1.  Make sure both the server1 and server2 virtual machines are started
1.  Open the console for server1 and login as the user "user"
1.  Open a terminal and verify your ID
1.  Verify you can ping server2 with

  ```ping -c 3 server2```

1.  Use Ctrl-Alt-F3 (fn-control-option-fn-F3 on Mac laptops) to switch to virtual console 3 on server1 and login as "student"
1.  Verify you can SSH to server2 and then logout of server2 to get back to your shell on server1
1.  Generate a keypair for ssh and install the public key in the student user's authorized_hosts on server2 (hint: there is a single command that can do this for you and ensures the permissions will be set correctly)
1.  Verify the student user can ssh to server2 and get logged in without a password
1.  Now, use the same keys to enable password-less login on server1 (from server1)
1.  Switch back to the graphical desktop on server1
1.  Since you are currently logged into the graphical desktop as user, open another terminal and become the "student" user in just that terminal (verify your ID)
1.  In your "student" terminal, verify you can still ssh to server2 without a password
1.  In your "user" terminal, generate a keypair for "user" and enable password-less ssh to server2 just like you did for the "student" user

# Sorry, this lab is still under construction

![Image of construction sign](../ConstructionSign.png)

## Ideas

1. Use openssl s_client to connect to encrypted services and view certificates
   ```
   openssl s_client --connect www.google.com:443
   ```
1. Use openssl to create a self-signed certificate
   ```
   # Edit CA config

   # generate the key pair
   openssl genrsa -aes256 -out servername.pass.key 4096

   # create the certificate signing request
   openssl req -nodes -new -key servername.key -out servername.csr

   # issue the cert
   openssl x509 -req -sha256 -days 365 -in servername.csr -signkey servername.key -out servername.crt
   ```

1. Use -v, -vv, and -vvv to debug ssh connections
   ```
   ssh -vvv remotehost
   ```

1. Reinstall sshd and troublehoot mismatched entries in known_hosts

1. Use ssh-keygen to create an asymetric key pair without a password and configure ssh to login without a password
   ```
   ssh-keygen -b 4096 -f ~/.ssh/mykey
   ```

1. Create another key pair protected by a passphrase and learn to use ssh-agent for authentication
   ```
   eval ssh-agent -s
   ssh-add -l
   ssh-add ~/.ssh/mykey
   ssh-add -l
   ```
   Inspect the process and local socket
   ```
   student@students-MacBook-Pro ~ % ps -ef | grep ssh-agent  
     501 16946     1   0  6Dec21 ??         0:00.30 /usr/bin/ssh-agent -l
     501 52995 52980   0  9:42AM ttys006    0:00.00 grep ssh-agent
   student@students-MacBook-Pro ~ % env | grep SSH           
   SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.bK3eUHkyQX/Listeners
   student@students-MacBook-Pro ~ % lsof -p 16946
   COMMAND     PID    USER   FD   TYPE             DEVICE SIZE/OFF                NODE NAME
   ssh-agent 16946 student  cwd    DIR                1,5      640                   2 /
   ssh-agent 16946 student  txt    REG                1,5   720304 1152921500312808720 /usr/bin/ssh-agent
   ssh-agent 16946 student  txt    REG                1,5  2016336 1152921500312809172 /usr/lib/dyld
   ssh-agent 16946 student    0r   CHR                3,2      0t0                 319 /dev/null
   ssh-agent 16946 student    1u   CHR                3,2      0t0                 319 /dev/null
   ssh-agent 16946 student    2u   CHR                3,2     0t95                 319 /dev/null
   ssh-agent 16946 student    3u  unix 0x4153756531b09f29      0t0                     /private/tmp/com.apple.launchd.bK3eUHkyQX/Listeners
   student@students-MacBook-Pro ~ % 
   ```

1. Use ssh forwarding to tunnel through a firewall
   ```
   # install nginx on machine that only has ssh port open in firewall
   ssh -l username -L 8080:remotehost:80 remotehost
   # connect browser to http://localhost:8080
   ```

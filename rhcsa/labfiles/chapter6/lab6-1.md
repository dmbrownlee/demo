# lab6-1: User and Group Management

## OBJECTIVE

In this lab, you will practice changing the contents of the default home
directory for all new users and forcing users to change their passwords on
the next login.

## SETUP

There are no special setup steps for this lab.

## STEPS

Login to server2

1.  Create a file named vimrc with the following contents:

  ```
  " Comments in .vimrc begin with a double quote like on this line
  set number
  set relativenumber
  set hlsearch
  set smartindent
  set tabstop=2
  set shiftwidth=2
  set smarttab
  set expandtab
  colorscheme blue
  ```

1.  Copy vimrc to .vimrc (note, the leading ```.``` makes the copy a hidden file) in the directory that serves as a template for home directories when new users are created
1.  Add a new user named "patrick" and set the password to "password"
1.  Switch to another virtual console
1.  Login as patrick and start ```vim```
1.  Within vim, type ```:set``` and press enter to verify you have the new system settings and/or run ```:edit $MYVIMRC``` to open the ~/.vimrc file within vim
1.  Quit vim without saving
1.  Switch back to the original virtual terminal
1.  Add patrick to the "itap" group (create the group if you need to)
1.  Configure the account so that patrick will have to set a new password on the next login
1.  Switch back to the virtual terminal where you are logged in as patrick
1.  Run ```id``` and note your group membership has **not** changed (group membership is set at the time you login)
1.  Logout of patrick's account
1.  Login as patrick again and verify you need to set a new password
1.  Run ```id``` and verify patrick is now a member of the itap group
1.  Logout and switch back to the original virtual terminal
1.  Delete patrick's user account and home directory with a single command


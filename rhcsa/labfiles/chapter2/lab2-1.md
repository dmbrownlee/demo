# lab2-1: Bash: Word splitting and expansion
## <img align="left" src="../images/ConstructionSign.png">Sorry, this lab has not been reviewed recently and may contain:
  - outdated technical informatiom
  - spelling errors, grammar errors, and poor markdown formatting

## OBJECTIVE

In this lab, we learn about some of the steps the Bash shell goes through when trying to figure out what to do with the command that was entered.

## BACKGROUND

The ```bash``` shell must do a lot of processing on the text you enter at the shell prompt before it can figure out what you're asking it to do.  First, it needs to split the your command into *words*, also called *tokens*.  Unquoted spaces will separate words.  If you enter ```echo $PATH``` at the command prompt, bash will split that into two words, ```echo``` and ```$PATH```.  Spaces within quotes do not separate words so ```echo "Hello World!"``` is also two words, ```echo``` and ```"Hello World!"```.  You can also escape spaces by preceding it with a backslash (```\```) character to take away its special function as a word boundary.  For example, ```ls ~/VirtualBox\ VMs``` is two words, the command ```ls``` and the command's first and only argument, a directory whose contents will be listed in this case, ```~/VirtualBox VMs```, which happens to have a space in the name. If you forgot the backslash, bash would interpret this command as three words and try to list ```VirtualBox``` in your home directory and ```VMs``` in your current directory. Besides spaces, there are other metacharacters which separate words (```|```, ```&```, ```;```, ```(```, ```)```, ```<```, ```>```, and ```[tab]```).  For example, ```cat /etc/passwd|less``` is four words, ```cat```, ```/etc/passwd```, ```|```, and ```less```, even though there are no spaces around the pipe (```|```) character.




## SETUP

Describe which hosts will be used here and list any setup steps.

## STEPS

Describe the steps needed to complete the lab in non-specific terms (i.e. give
tasks to complete, not commands to run.

Optionally, include instructions to verify work.

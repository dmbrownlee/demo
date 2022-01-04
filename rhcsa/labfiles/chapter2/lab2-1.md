# lab2-1: Bash: Shell Operations

## OBJECTIVE

In this lab, we learn about some of the steps the Bash shell goes through when trying to figure out what to do with the command that was entered.  For a more complete description, refer to the [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.pdf)

## BACKGROUND

The Bash shell must do a lot of processing on the text you enter at the shell prompt before it can figure out what you're asking it to do.  First, it needs to split the line you entered into tokens.  After that, aliases have to be rewritten, various shell expansions have to occur, file globbing needs to replace pathnames, redirection needs to setup file handles appropriately, all before the shell can then try to decided what your command actually is and how to run it.

## SETUP

There is no special setup for this lab.

## STEPS

### Tokenization
The first thing bash does after you enter a command is split the line you entered into *tokens*.  Tokens are sequences of characters treated as a single unit.  Tokens are separated by unquoted *metacharacters* and metacharacters are the *space*, *tab*, and *newline* characters as well as ```|```, ```&```, ```;```, ```(```, ```)```, ```<```, or ```>```.  *Words* are a subcategory of token that do not contain metachacters and tokens that contain one or more metacharaters are called *operators*.  Let's look at some examples.

1.  Bash interprets this command as two words, ```ls``` and ```~```
  ```
  ls ~
  ```
1. Bash interprets this command as two words, ```cd``` and ```/tmp```, followed by the metacharacter ```;```, followed by the word ```ls```, for a total of four tokens.
  ```
  cd /tmp ; ls
  ```
  > Note: ```;``` is a *control operator* which marks the end of a command and allows you to enter multiple commands on a single line.

  While a *blank* (a space or tab) is a metacharcter separating tokens, there was no need for the spaces around the semicolon in the command above since ```cd /tmp;ls``` would result in the same four tokens.  However, you do need a space between ```cd``` and ```/tmp```.  Without it, Bash would interpret ```cd/tmp``` as a single, relative pathname (the book covers absolute and relative pathnames in chapter three) and think you were trying to run the ```tmp``` command in the ```cd``` subdirectory in your current working directory which would almost certainly result in a ```no such file or directory``` error.

As alluded to above, metacharacters within quotes do not mark token boundaries.  Quoting characters on the command line can prevent the shell from performing the special processing it would do if the characters were not within quotes.  You can escape (disable the special interpretation of) a single character by placing a backslash (```\```) in front of it.  To escape a string of characters, you can surroung the string with single quotes (```'```) or double quotes (```"```).  Using double quotes around a string disables special characters other than ```$```, ```\```, ``` ` ```, and ```!``` (See the Bash Reference Manual linked above for information on ``` ` ``` and ```!```).  Using single quotes disables all special interpretation.
1. Consider the following command which displays your home directory:
  ```
  echo $HOME
  ```
  ```HOME``` is a variable and the ```$``` in front of it tells the shell to replace ```$HOME``` with the value currently stored in ```HOME```.
1. Now, compare the output of these commands:
  ```
  echo \$HOME
  echo '$HOME'
  echo "$HOME"
  ```
  The first two disable the special interpretation of ```$``` while the last command still allows for variable expansion.

  > Note: If you need to quote characters withing a string, you can use double quotes within single quotes and vice versa:
    ```
    echo "This isn't a problem"
    echo 'The manual says, "This is also OK"'
    echo "It also says,\"Backslashing double quotes within double quotes works\""
    echo 'However, his doesn\'t work because the \ isn't special within single quotes'
    ```

Returning back to the topic of tokenization, consider these two examples:
1. This is three tokens, the command ```echo``` followed by two arguments, ```foo``` and ```bar```.
  ```
  echo foo bar
  ```
  When the ```echo``` command has multiple arguments, it echoes each to standard out (by default, the terminal screen), separated by a single space, the resulting output is ```foo bar```.
1. This time, we add quotes:
  ```
  echo "foo bar"
  ```
  In this second case, the output is still ```foo bar``` but Bash is treating this as two tokens.  The first token is the ```echo``` command which is follow by just one argument, ```foo bar```, which is a string of seven characters that just happens to include a space.

  > Note: The quotes are not part of the token and will be removed as one of the last steps.

Given the output of both commands is the same, the way Bash is tokenizing these lines may not be obvious.  Let's change the commands slightly by adding a bunch of spaces between ```foo``` and ```bar``` to highlight the difference.  Look and these alternaive commands and try to guess what the output will be.  Then, run the commands to see if you guessed correctly.
1. First without quotes:
  ```
  echo foo        bar
  ```
  > Note: The extra, unquoted spaces are not a problem and will get reduced to a single space when we get to the word splitting step.
1. Then with quotes:
  ```
  echo "foo        bar"
  ```

### Alias Substitution
After Bash has split the input line into tokens, it checks to see if the first token is an unquoted word and, if it is also an alias, it replaces the token with its aliased value which may itself be multiple tokens.

1. Run these commands on server2:
  ```
  alias
  which ls
  ```
  The ```alias``` shell builtin (more on that later) displays a list of aliases which have already been defined for you by the sysadmin.  Notice ```ls``` is an alias for ```ls --color=auto```.  If you start your command line with ```ls```, Bash will replace the ```ls``` with ```ls --color=auto``` before it runs the command.  Note, it is fine if ```ls``` is included in the value of the alias as it only gets rewritten once so there is no danger of an infinite loop.  Run ```ls /tmp``` and you should get a colorized listing of the contents of the ```/tmp``` directory.  The ```which``` command shows you ```ls``` is an alias but also shows you there is an external command in the PATH named ```/usr/bin/ls```.

1. Sometimes you want to run the unaliased version of a command and you can do that two ways, by putting the alias in quotes or running the full path to the external command.  To quote the alias, you can use single quotes, double quotes, or the backslash (```\```) character to escape the alias.  These are all the same and will give you the non-colorized listing of the directory contents:
  ```
  'ls /tmp'
  "ls /tmp"
  \ls /tmp
  ```

  Alternatively, you can just use the full path to the external program since that does not match the alias:
  ```
  /ust/bin/ls /tmp
  ```

### Shell Expansion
After alias substitution, Bash performs another series of rewrites collectively known as shell expansions in this order:
1. brace expansion
1. tilde expansion
1. parameter and variable expansion
1. command substitution
1. arithmetic expansion
1. word splitting
1. filename expansion

#### Brace Expansion
Brace expasion can take a single word token containing a comma separated list of strings withing braces (```{```, ```}```) and an optional prefix and suffix and expand it out to multiple words.
1. Since it is easier to demonstrate than describe, try this:
  ```
  echo prefix\ {one,two,three}\ suffix
  ```
  > Note: The prefix and suffix cannot be separated from the braces so we have to escape the spaces with backslashes to prevent Bash from splitting it into three separate tokens.

1. While this may not seem immediately useful, consider these commands (I have left the ```echo``` at the beginning so you can see the command that would have been generated):
  ```
  echo cp important{,.save}
  echo mv ~/Downloads/*.{gif,jpg,png} ~/Pictures
  ```

#### Tilde Expansion
If an unquoted word begins with the tilde (```~```) character, Bash checks to see if the text following the tilde (if any) and up to the first slash (```/```) is a username and, if so, replaces the tilde and username with the home directory for that user.  If there is no text after the tilde, it gets replaced with the current user's home directory.

1. Again, we prefix these commands with ```echo``` so we can see how the shell is rewriting these commands without actually running them.
  ```
  echo cd ~/Downloads
  echo ls ~root
  ```

#### Parameter and Variable Expansion
A ```$``` followed by a variable name gets rewritten as the value currently stored in that variable.
1.  Try some common variables:
  ```
  echo $HOME
  echo $PATH
  echo $TERM
  ```
1. You can optionally put braces around the variable name and, depending on what you're trying to do, they may be necessary.  Consider the difference in output between these two commands:
  ```
  echo $SHELL_IS_MAGIC
  echo ${SHELL}_IS_MAGIC
  ```
1. You can also do lots of cool substitutions using braces with variable names but you'll have to read the reference manual for more on that.  But, as one example, here is how you can specify a default value for a variable:
  ```
  echo Your default editor is ${EDITOR:-not set}
  EDITOR=/usr/bin/vim
  echo Your default editor is ${EDITOR:-not set}
  ```

#### Command Substitution
Sometimes, you need to use data from the output of one command when typing another.  If a ```$``` comes right before a pair of parenthsis, the entire ```$(```...```)``` is replace by the output of the command (without any trailing newlines) within parenthesis.
1. The command ```date '+%Y%m%d'``` returns the current date in YYYYMMDD format so it is easily sortable.  If you want to make a copy of a file using the date the file was copied as part of the filename, you could do it this way:
  ```
  touch important_file
  cp important_file important_file.save.$(date '+%Y%m%d')
  ls
  ```
  Keep in mind that brace expansion happens first so you could rewrite the above as:
  ```
  cp important_file{,.save.$(date '+%Y%m%d')}
  ```

#### Arithmetic Expansion
There is no need to pull out a calulator if you are already at a shell prompt, the shell can do math for you.  Whereas command substitution above uses a single pair of parenthesis, arithmetic expansion uses a pair of double parenthesis.
1.  If you forget how many bytes are in a TiB, the shell can tell you:
  ```
  echo $((1024 * 1024 * 1024 * 1024))
  echo $((1024**4))   # alternative using '**' to mean exponents
  ```
  Arithmetic expansion can also be helpful when calculating time offsets in shell scripts.

#### Word Splitting
Some of the expansions above may result in single tokens getting expanded into multiple words so the shell will take the line resulting from all the expansions and split it into *fields* similar to the way it started by splitting the line into tokens.  The variable IFS (internal field separator) is a string of characters used to delimit fields and has the default value of *space*, *tab*, and *newline*.  Sequences of unquoted IFS characters are counted as a of *space*, *tab*, and *newline*.

1. A sequence of more than one unquoted IFS character are counted as a single delimiter.  For example, starting with FOO set to a string of characters with spaces:
  ```
  FOO='lots    of    spaces'
  echo $FOO
  ```
  The shell rewrites this as ```echo lots of spaces```, whereas with:
  ```
  FOO='lots    of    spaces'
  echo "$FOO"
  ```
  The shell rewrites this as ```echo "lots    of    spaces"```.

1. Quoted expansions that result in a null string (a sequence of characters that is currently empty) are retained as a separate field when surrounded by IFS characters, otherwise, they are discarded:
  ```
  FOO=''
  echo a "$FOO" b
  ```
  results in three fields, ```a```, an empty field, and ```b```.  Since there are spaces between all fields the ouput shows two spaces between ```a``` and ```b```.  Quoted null strings adjcent to other fields are discarded so:
  ```
  FOO=''
  echo "$FOO"a"$FOO" "$FOO"b"$FOO"
  ```
  still results in just two fields, ```a``` and ```b```, separated by a single space (note, it is the ```echo``` command adding the spaces between fields in both cases since that is how it separates output from multiple arguments)

#### Filename Expansion
If any of the remaining words at this stage have unquoted instances of ```*```, ```?```, or ```[```, the shell interprets this as a patern to replace with a list of all filenames in the current directory that match the patern.  These characters are called wildcards and replacing the words containing these wildcard characters with a list of matching filenames is a process known as file globbing.  In file globbing, the ```*``` matches a string of any number of characters (including the no characters), the ```?``` matches any single character, and ```[``` followed by a string of characters ending in ```]``` will match any single characters between the ```[``` and ```]```.
1. First, lets create some empty files for this example:
  ```
  touch word words wordz
  ```
  Assuming thes are the only files in this directory:
  ```
  echo word*
  ```
  gets rewritten as ```echo word words wordz```
  ```
  echo word?
  ```
  gets rewritten as ```echo words wordz```
  ```
  echo word[s]
  ```
  gets rewritten as ```echo words```.
  > Note: The echo command never sees the wildcard characters.  The shell will rewrite the line before echo is run.
  > Note: File globbing patterns are distinct from, and work differently than, regular expressions.  A regular expression (aka, regex) is a common pattern matching language used my many tools like ```grep```, ```sed```, and ```awk```.  Do not confuse shell file globbing with regular expressions.

### Quote Removal
Up to this point, we have controlled how the shell splits up lines through the use of single quites (```'```), double quotes (```"```), and the backslash escape character (```\```).  At this stage, these characters are no longer needed so, unless they are themselves quoted, the shell removes them.
1.  When you run:
  ```
  echo "hello world"
  ```
  the ```echo``` command gets a single argument, the string ```hello world```, but it never gets the surrounding quotes because the shell has removed them.  Even though the ```echo``` command doesn't get the quotes, they were necessary for in order to pass a single argument containing a space rather than two separate arguments, ```hello``` and ```world```.

  ### More to come
  As you can see from all the rewriting rules above, the shell has a lot of work to do.  While this takes care of the bulk of the rewriting, the shell still needs to look for redirection operators, pipes, etc. and use those to setup the process accodingingly.  Once that is done, it has to figure out if your command is a reserved word creating a complex command (such as a conditional command or loop), a shell function, a builtin, or an external command.  However, the purpose of this lab is just to cover how the shell rewrites your commands so we will stop here.
  
# CONFIRMATION
There is a lot of information above and you do not have to memorize the various transmutations or in what order they occur.  You will have completed this lab successfully when:
  - You have a better idea of when you need to use each kind of quote to control how the shell interprets your command.
  - You know which characters need to be escaped in order to disable special interpretation by the shell.
  - You understand how file globbing can help you specify a list of filenames on the command line by using a pattern.
  - You can do math calculations on the command line.
  - You can use the output of a command as part of a new command line.

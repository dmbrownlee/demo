# lab2-1: Learning Vim

## OBJECTIVE

In Unix and Linux, you will often hear the saying "everything is a file."  This makes a little more sense when you adopt the perspective that a file is just a sequence of bytes, but, regardless, there are a lot of files that control how system is configured and functions. It is absolutely essential that you become proficient with a text editor and Vim, sometimes being the only text editor installed on rescue media, makes an excellent choice.  In this lab, you will learn learning to use Vim is like learning a foreign language.  Rather than thinking of normal mode keys as a list of keyboard shortcuts to memorize, we will focus on learning Vim's grammar so you can learn to "talk" to Vim and tell it what to do.

## SETUP

There are no special setup steps for this lab.

> Note: Vim is already installed on Mac so can do this lab with or without a virtual machine.

We are not going to cover basic navigation and editing here. If you have not already done so, you may wish to spend 30 minutes working through the Vim totorial as mentioned in the study guide.  From your shell prompt, type:</br></br>
<code>vimtutor</code></br></br>
This will open a copy of the tutorial in Vim which you can edit as it you read it (Don't worry, it's just a copy so you don't have to worry about messing it up).

## BACKGROUND

Vim has several modes.  When you start Vim, it starts in ***normal*** mode.  In normal mode, your computer keys are mapped to movements, commands, or operators.  The philosophy behind Vim is that people spend more time editing existing files rather than writing new files so having lots of editing commands at your fingertips is super efficient.  Here is one of many Vim keyboard cheatsheets from the Internet:</br></br>
![Vim Normal Mode Cheatsheet](vim-cheat-sheet.png)
### Movement
First, notice there are many keys for movement besides ```h```, ```j```,```k```, and ```l```.  Besides moving one charater left or right, with ```h``` and ```l```, or one line up or down, with ```k``` and ```j```, there are also movements relative to text objects within the file.  Examples of "text objects" are ***words***, ***sentences***, ***paragraphs*** and various types of ***blocks*** and knowing what Vim considers a specific text object is helpful when using these movements.
* A ***word*** is a sequence of letters, numbers and underscores (_), or a sequence of *other* non-blank characters, separated by spaces, tabs, or newlines. (```:help word```).
* A ***WORD*** is a sequence of non-blank characters separated by blank characters but doesn't distinguish between the types of non-blank characters like a *word* does.  That is to say, "Owl-flavored" (one of David Letterman's top 10 least used hyphenated words) is three *words* but only one *WORD*. (```:help WORD```).
* A ***sentence*** is a sequence of characters ending in '.', '!', or '?', and then followed by a newline, space, or tab.  Trailing quotes immediately after the punctuation are also part of the *sentence* (```:help sentence```).
* Vim considers adjacent lines containing text, separated by one or more blank lines, to be ***paragraphs***. (```:help paragraph```).
* A ***block*** may start with a ```(```, ```[```, ```{```, ```<```, or HTML tag and continues until the matching closing character or HTML tag. (```:help sentence```).
* Text within quotes, either ```'``` or ```"```, is also a *block* of text.

Now that you know Vim's definition for these text objects, you can move around faster than one column or line at a time with these keys:
These are the movement commands related to text objects:
* ```w```/```W```: move to the begging of the next *word*/*WORD*
* ```b```/```B```: move to the begging of the current (or previous if already at the beggining of current) *word*/*WORD*
* ```e```/```E```: move to the end of the current (or next if already at the end of current) *word*/*WORD*
* ```(```/```)```: move backward/forward a *sentence*

  > Note: The cheat sheet says "sequence". I'm using *sentence* to be consistent with Vim's online help.
* ```{```/```}```: move backward/forward a *paragraph*.

You can also move forwards and backwards to the next or previous instance of a character you specify with:
* ```F```*x*/```f```*x*: move backwards/forwards to the next occurance of *x*
* ```T```*x*/```t```*x*: move backwards/forwards until the next occurance of *x* (leaves cursor one character short of *x*)

What makes these movements even faster is the standard movements (```h```,```j```,```k```,```l```) and moving by text objects can be preceeded by a number and the movement will be done that many times.  For example, ```3}``` goes forward (down) three paragraphs, ```4B``` goes backwards four WORDS, and ```9k``` goes up nine lines.

There are also some line movment commands that are useful:
 * ```0```: move to the first colmun of the line.
 * ```^```: move to the first printable character of a line (different that ```0``` if the line is indented with spaces or tabs).
 * ```$```: move to the end of the line

Lastly, you can also jump to the first character of line *x* with *x*```G```.  While there are other movements such as jumping to marks or moving relative to the screen rather than what is in the file, this is plenty of movement commands for now.

### Why movement is important
Many editors have keyboard shortcuts which you have to memorize such as Ctrl-x, Ctrl-c, and Ctrl-p for cut, copy and paste, respectively.  While these combined with cursor key movements might be faster than using a mouse in some cases, it is important to stress that Vim's normal mode is **not** a list of keyboard shortcuts to memorize.  The critical difference is keyboard shortcuts are standalone whereas Vim's normal mode keys are part of a grammar, an editing language you use to have a conversation with Vim.  You have already seen some of this above when we said you could precede a command with a number to have the movement done that many time.  For example, you will not find the string of characters to move up six paragraphs in a file above, but you should know how to do that because you know how to combine any number of repetitions with the backwards paragraph movement. Like learning a foreign language, you will need to memorize some vocabulary at first, but then you will be able to use that to string together your own sentences and, as you become proficient, you will be able to speak the language of Vim without thinking about it.

Let's expand our Vim vocabulary by learning about some common operator that make use of our movement vocabulary.
* ```y```*<movement>*: yank (copy) the text from the cursor to the end of *<movement>*
* ```d```*<movement>*: delete the text from the cursor to the end of *<movement>*
* ```c```*<movement>*: change the text from the cursor to the end of *<movement>*

Delete also puts the deleted text into a buffer (clipboard) just like yank.  Change is like a delete followed by an ```i``` to put you in insert mode where the previous text used to be.
With just the addition of these three operators, you can learn to get Vim to do all kinds of editing tasks.  For example, think about how you would do these tasks:

* Delete a method in your Python class (a paragraph) to move it to a new location
* Rewrite the text from your cursor to the end of the sentence
* Copy the name of the Bash variable the cursor is currently on

The last one assumes the cursor is at the beginning of the variable.  If the cursor was in the middle of the variable name, you could type ```bye``` or ```byw``` if you also wanted the trailing space. However, there is another modifier we can add to our volcabulary, ```i``` for "inner".  The "inner" modifier is handy when you are in the middle of a text object such as the middle of a word, a quoted string, or between HTML tags. Let's look at some examples:

<code>"This is a str<span style="text-decoration: underline">i</span>ng"</code>

With the cursor under the 'i' in "string", ```yiw``` would copy the word "string" to the paste buffer ```ci"``` would remove the entire string between the quotes and put you in insert mode so you could type a replacement.  When dealing with text objects, you can include the bounding delimiters by using ```a``` instead of ```i```.  For example:

<code>&lt;div&gt;&lt;span style="text-decoration: underline"&gt;some underl<span style="text-decoration: underline">i</span>ned text&lt;/span&gt;&lt;/div&gt;</code>

With the cursor under the 'i' again, ```yit``` would copy "some underlined text" to the paste buffer. ```yat``` would copy everything between &lt;div&gt; and &lt;/div&gt; and, by adding a repetition modifier, ```y2at``` would copy the &lt;div&gt; tags as well (two levels of tags).

## STEPS

Download the [```template.py```](template.py) file in this lab's directory, open it in Vim, and do the following:

1.  Go to line 33 with three keystrokes, jump to the semicolon with two keystrokes, and replace the semicolon with an apostrophe with two keystrokes.
1.  Go to line 7, remove the text been the triple double quotes (it's a Python docstring), and place yourself in insert mode so you can type a new docstring.  Do all this in just six keystrokes.
1.  Go to line 10, jump to the open parenthesis, copy all the text until the closing parenthesis (you can paste it to prove the copy worked and then undo)
1.  Starting with the cursor at the top of the file (```gg``` to go there), try to move the definition of the "usage" function above the "Greeter" class definition in ten keystrokes or fewer.

Use this file to practice moving by different text objects on your own until you are comfortable with it.  Then use different movement commands in conjunction with change, delete, and yank.

## CONFIRMATION

You will have completed this lab successfully when the following are true:

  1. You can start the vim editor with or without a file already loaded into the buffer.
  1. You can exit the vim editor with or without saving your changes.
  1. You can save the current buffer under a different file name.
  1. You are comfortable moving the cursor forwards and backwards by character, word, line, sentence, and paragraph.
  1. You can yank, change, and delete from within text objects.
  1. You can paste previously yanked or deleted text
  1. You can undo and redo changes you've made
  1. You can do simple find and replace operations

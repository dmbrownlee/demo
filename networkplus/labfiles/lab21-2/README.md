# LAB 21-2 Network troubleshooting practice

## OBJECTIVE

In this lab, you will practice troubleshooting a network problem.

## SETUP
This lab uses the [networkplus.test](https://github.com/dmbrownlee/demo/blob/release/networkplus/labfiles/README.md) network model.

This lab will intensionally break something in the network model to see if you can find where the problem lies.  Before beginning the lab, login to debian1, open a browser, and navigate to http://www.networkplus.test/.  You should see the default nginx web page.  If you do not, you have a problem that is not part of this lab and you should fix that first (bonus troubleshooting practice!) before continuing with the lab.  Remember, everytime you load the networkplus.test model you need to login to the control host as the ```ansible``` user and run the setup script to configure the network so do that first if you haven't already.

## STEPS

Here are the steps to begin the lab.

1. Change to the following directory:

  ```
  cd ~/labnetwork/playbooks/projects/networkplus
  ```

1. Run the breakfix script to setup up the lab:

  ```
  ansible-playbook -k -K -t 21-2 breakfix.yml
  ```

1. The command in the step above will break something and then print a description of the problem.

1. Use any tools you have to try to discover the root cause of the problem.  You do NOT have to fix the problem (although you can if you know how), just identify what is broken.

1.  When you think you have solved the problem, you can fix it by running the same command on the control host with the addition of "-e fix=true" to undo the change:

  ```
  ansible-playbook -k -K -e fix=true -t 21-2 breakfix.yml
  ```

## CONFIRMATION

You will know you have completed the lab successfully when then following are
true:

1. You have used your knowledge and tools to both discover the source of the problem and to verify the problem was fixed.

1. You may also read the comments in ```breakfix.yml``` to see if you were correct.

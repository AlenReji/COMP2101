#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

# Get the current hostname using the hostname command and save it in a variable

# Tell the user what the current hostname is in a human friendly way

# Ask for the user's student number using the read command

# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user

# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts

# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname

myhostname=$(hostname)
echo "The current hostname is $myhostname"

echo "Please enter your student number"
read studentnum
echo "Your student number is $studentnum"
desiredhostname="pc$studentnum"
echo "The desired hostname is $desiredhostname"
test $myhostname == $desiredhostname || (sudo sed -i "s/$myhostname/$desiredhostname/" /etc/hosts && echo "Hostname in /etc/hosts has been changed to $desiredhostname")
test $myhostname == $desiredhostname || (sudo hostnamectl set-hostname $desiredhostname && echo "The current hostname has been changed, please reboot the system to check the new hostname.")

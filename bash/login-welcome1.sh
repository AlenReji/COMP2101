#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
USER="Alen"
hostname=$(hostname)

day=$(date +%A)
hour=$(date +%I)
minute=$(date +%M)
echo "It is a $day at $hour:$minute"

if [ $day == "Monday" ];
then
  title="Monday might be hot"
elif [ $day == "Tuesday" ];
then
  title="Tuesdey might be a holiday"
elif [ $day == "Wednesday" ];
then
  title=" Wednesday might be cloudy "
elif [ $day == "THursday" ];
then
  title="Thursday might be rainy"
elif [ $day == "Friday" ];
then
  title=" Friday might be sunny"
elif [ $day == "Saturday" ];
then
  title="Saturday might be  cold"
else
  title="Sunday might be thunderstorm"
fi
##########################
message="Welcome to planet $hostname, $title, $USER"
cowsay "$message"
exit

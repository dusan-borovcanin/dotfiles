#!/bin/bash

option1="lock"
option2="logout"
option3="suspend"
option4="hibernate"
option5="reboot"
option6="shutdown"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

choice="$( echo -e "$options" | rofi -lines 7 -dmenu -p "Power: " -theme-str '
  #window {
    width: 700;
    border: 3px solid;
  }'
)"
echo $choice

case $choice in
    $option1) i3exit lock;;
    $option2) i3exit logout;;
    $option3) i3exit suspend;;
    $option4) i3exit hibernate;;
    $option5) i3exit reboot;;
    $option6) i3exit shutdown
esac
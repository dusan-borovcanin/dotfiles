#!/bin/bash

option1="(l)lock"
option2="(e)logout"
option3="(s)suspend"
option4="(h)hibernate"
option5="(r)reboot"
option6="(S)shutdown"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

choice="$( echo -e "$options" | rofi -lines 7 -dmenu -p "Power: " -theme-str '
  #window {
    width: 700;
    height: 230;
    border: 3px solid;
  }'
)"

case $choice in
    $option1) i3exit lock;;
    $option2) i3exit logout;;
    $option3) i3exit suspend;;
    $option4) i3exit hibernate;;
    $option5) i3exit reboot;;
    $option6) i3exit shutdown
esac
#!/bin/sh	

# Determine display size to set position and size of sticky terminal.
res=$(xrandr | grep '*' | awk '{ print $1 }')


st -n "sticky_term" &
# i3-msg -q exec "st -n 'sticky_term'"

pid="$!"

# Wait for the window to open and grab its window ID
sleep 0.2
size="1200 700"
position="715 55"
echo $res

case $res in
  "1920x1080") position="1010 60" size="900 550" ;;
  "1920x1200") position="715 55" size="1200 700" ;;
  "2560x1440") position="1115 60" size="800 500" ;;
  "3440x1440") position="1635 55" size="1800 1000" ;;
esac

i3-msg -q [instance="sticky_term"] resize set $size
i3-msg -q [instance="sticky_term"] move position $position

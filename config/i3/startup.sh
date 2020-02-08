#!/bin/sh

# Turn built-in monitor off if an external monitor(s) is connected.
count=$(xrandr | grep "DP-*. connected" | wc | awk '{print $1}')
[ count > 1 ] && xrandr --output eDP-1 --off

day=$(date '+%a')
# Start Slack only on workdays.
[ $day != "Sat" ] && [ $day != "Sun" ] && slack &

code &
brave &

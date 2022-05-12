#!/bin/sh

HEADPHONES="70:26:05:9C:BF:F2"
bluetoothctl power on &
bluetoothctl connect $HEADPHONES
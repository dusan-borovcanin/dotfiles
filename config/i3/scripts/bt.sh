#!/bin/sh

HEADPHONES="70:26:05:9C:BF:F2"
sudo systemctl restart bluetooth.service
bluetoothctl power on
bluetoothctl connect $HEADPHONES

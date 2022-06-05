#!/bin/sh
STATUS=$(bluetoothctl show | awk '/Powered/ { print $2}')
if [ "$STATUS" == 'yes' ]; then
  bluetoothctl power off
else
  bluetoothctl power on
fi

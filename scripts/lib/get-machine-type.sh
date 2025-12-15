#!/bin/bash
#
# Determines if the machine is a laptop or desktop.
# Outputs "laptop" or "desktop".

# Default to desktop
MACHINE_TYPE="desktop"

# Check for a battery, a strong indicator of a laptop
if [ -d /sys/class/power_supply/BAT* ]; then
    MACHINE_TYPE="laptop"
fi

echo "$MACHINE_TYPE"

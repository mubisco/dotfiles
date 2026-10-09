#!/usr/bin/env bash
CITY="${CITY:-}"
req=$(curl -s "wttr.in/${CITY}?format=%t|%l+(%c%f)+%h,+%C")
bar=$(echo "$req" | awk -F "|" '{print $1}')
tooltip=$(echo "$req" | awk -F "|" '{print $2}')
echo "{\"text\":\"$bar\", \"tooltip\":\"$tooltip\"}"

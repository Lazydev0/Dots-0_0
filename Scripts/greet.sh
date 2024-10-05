#!/bin/bash

# Get the current hour and remove leading zero if any
Check_time=$(date +%-H) # %-H ensures no leading zero in the hour

if [[ $Check_time -lt 5 ]]; then
  echo "Sleep Idiot"
elif [[ $Check_time -ge 5 && $Check_time -lt 12 ]]; then
  echo "GoodMorning $USER"
elif [[ $Check_time -ge 12 && $Check_time -lt 16 ]]; then
  echo "GoodAfternoon $USER"
elif [[ $Check_time -ge 16 && $Check_time -lt 19 ]]; then
  echo "GoodEvening $USER"
elif [[ $Check_time -ge 19 && $Check_time -lt 24 ]]; then
  echo "GoodNight $USER"
fi

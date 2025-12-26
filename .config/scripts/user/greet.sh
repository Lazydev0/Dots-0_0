#!/bin/bash

Check_time=$(date +%-H)

if [[ $Check_time -lt 5 ]]; then
  echo "Sleep Idiot"
elif [[ $Check_time -ge 5 && $Check_time -lt 12 ]]; then
  echo "Good Morning, $USER"
elif [[ $Check_time -ge 12 && $Check_time -lt 16 ]]; then
  echo "Good Afternoon, $USER"
elif [[ $Check_time -ge 16 && $Check_time -lt 19 ]]; then
  echo "Good Evening, $USER"
elif [[ $Check_time -ge 19 && $Check_time -lt 24 ]]; then
  echo "Good Night, $USER"
fi

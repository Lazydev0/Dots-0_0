#!/bin/bash

if pgrep -x waybar >/dev/null; then
  sleep 0.4
  pkill -x waybar
else
  sleep 0.4
  waybar &
fi

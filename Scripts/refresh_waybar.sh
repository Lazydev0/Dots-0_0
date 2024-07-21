#!/bin/bash

killall waybar

sleep 2

if [ "$USER" -eq "nyx" ]; then
	waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
else
	waybar &
fi

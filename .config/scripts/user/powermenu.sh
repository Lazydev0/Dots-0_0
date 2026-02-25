#!/usr/bin/env bash

lock=" "
logout=" "
shutdown=" "
reboot=" "
sleep=" "

selected_option=$(
  printf "%s\n" \
    "$lock" \
    "$logout" \
    "$sleep" \
    "$reboot" \
    "$shutdown" |
    rofi -dmenu -i -p "Power" \
      -theme ~/.config/rofi/powermenu.rasi \
      -normal-window
)

case "$selected_option" in
"$lock") hyprlock ;;
"$logout") hyprctl dispatch exit ;;
"$shutdown") mpv --no-video --quiet ~/.config/sounds/shutdown.mp3 && systemctl poweroff ;;
"$reboot") mpv --no-video --quiet ~/.config/sounds/shutdown.mp3 && systemctl reboot ;;
"$sleep") systemctl suspend ;;
*) exit 0 ;;
esac

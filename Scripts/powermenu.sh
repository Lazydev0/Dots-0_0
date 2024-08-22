#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/rofi"
theme='powermenu'

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options
shutdown='󰐥'
reboot='󰜉'
lock=''
suspend='󰤄'
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye ${USER}" \
    -mesg "Uptime: $uptime" \
    -theme ${dir}/${theme}.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  if [[ $1 == '--shutdown' ]]; then
    systemctl poweroff
  elif [[ $1 == '--reboot' ]]; then
    systemctl reboot
  elif [[ $1 == '--suspend' ]]; then
    systemctl suspend
  elif [[ $1 == '--logout' ]]; then
    hyprctl dispatch exit
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$lock)
  swaylock
  ;;
$suspend)
  run_cmd --suspend
  ;;
$logout)
  run_cmd --logout
  ;;
esac

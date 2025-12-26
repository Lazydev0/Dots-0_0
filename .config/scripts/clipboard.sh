#!/bin/bash

dir="$HOME/.config/rofi"
theme="clipboard"

## Run
rofi \
  -dmenu \
  -theme ${dir}/${theme}.rasi <<<"$(cliphist list)" | cliphist decode | wl-copy

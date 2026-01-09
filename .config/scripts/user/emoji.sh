#!/bin/bash

dir="$HOME/.config/rofi/"
theme='emoji'

## Run
rofimoji \
  --selector rofi \
  --max-recent 0 \
  --no-frecency \
  --selector-args "-theme ${dir}/${theme}.rasi"

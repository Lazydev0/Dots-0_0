#!/bin/bash

dir="$HOME/.config/rofi/"
theme='emoji'

## Run
rofi \
  -show emoji \
  -theme ${dir}/${theme}.rasi

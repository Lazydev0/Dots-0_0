#!/bin/bash

dir="$HOME/.config/rofi/"
theme='menu'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi

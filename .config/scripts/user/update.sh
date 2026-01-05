#!/bin/bash

dropTerm="wezterm start --class dropTerm"

uwsm app -- $dropTerm -e sh -c 'yay -Syu && exec $SHELL'

#!/bin/bash

dropTerm="wezterm start --class dropTerm"

uwsm app -- $dropTerm sh -c 'yay -Syu && exec $SHELL'

#!/bin/bash

dropTerm="wezterm start --class dropTerm"

uwsm app -- $dropTerm sh -c 'paru -Syu && exec $SHELL'

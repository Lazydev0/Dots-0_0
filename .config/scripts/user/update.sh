#!/bin/bash

uwsm app -- kitty --title kitten -e sh -c 'yay -Syu && exec $SHELL'

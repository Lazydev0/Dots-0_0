#!/bin/bash

tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
cwd=""

yazi "$@" --cwd-file="$tmp"

if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
  cd -- "$cwd"
fi

rm -f -- "$tmp"

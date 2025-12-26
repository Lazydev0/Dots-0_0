#!/bin/bash

has_param() {
  for arg; do [[ "$arg" == "$1" ]] && return 0; done
  return 1
}

wait_checkupdates() {
  while pgrep -x checkupdates >/dev/null; do
    sleep 1
  done
}

check_arch_updates() {
  command -v yay >/dev/null || exit 0

  if has_param "-tooltip" "$@"; then
    wait_checkupdates
    official=$(checkupdates 2>/dev/null)
    aur=$(yay -Qum 2>/dev/null)

    [[ -n "$official" ]] && {
      echo "pacman:"
      echo "$official"
    }
    [[ -n "$official" && -n "$aur" ]] && echo
    [[ -n "$aur" ]] && {
      echo "AUR:"
      echo "$aur"
    }
  else
    official=0
    aur=0
    has_param "-y" "$@" || official=$(checkupdates 2>/dev/null | wc -l)
    has_param "-p" "$@" || aur=$(yay -Qum 2>/dev/null | wc -l)
    echo $((official + aur))
  fi
}

case "$1" in
-arch) check_arch_updates "$@" ;;
*) echo 0 ;;
esac

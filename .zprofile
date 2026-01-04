if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  eval "$(ssh-agent -s)"
fi

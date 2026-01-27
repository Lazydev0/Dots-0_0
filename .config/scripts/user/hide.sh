stack_file="/tmp/hide_window_addr_stack.txt"
touch "$stack_file"

hide_window() {
  addr=$(hyprctl activewindow -j | jq -r '.address')
  [ -z "$addr" ] && exit 1

  hyprctl dispatch movetoworkspacesilent 88,address:$addr
  echo "$addr" >>"$stack_file"
}

show_window() {
  [ ! -s "$stack_file" ] && exit 0

  addr=$(tail -n 1 "$stack_file")
  sed -i '$d' "$stack_file"

  ws=$(hyprctl activeworkspace -j | jq -r '.id')
  hyprctl dispatch movetoworkspacesilent "$ws",address:$addr
}

case "$1" in
h) hide_window ;;
s) show_window ;;
esac

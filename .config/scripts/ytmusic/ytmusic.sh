#!/bin/bash

BASE_DIR="$HOME/.config/scripts/ytmusic"
MUSIC_DIR="$HOME/Music"

COOKIES="$BASE_DIR/cookies.txt"
PLAYLIST_FILE="$BASE_DIR/playlists.txt"

CATEGORIES=(
  "Bollywood"
  "Gloomy"
  "Instruments"
  "Japanese"
  "Melody"
  "Phonk"
  "Pop"
  "Sturdy"
)

command -v yt-dlp >/dev/null || {
  echo "yt-dlp not installed"
  exit 1
}
command -v ffmpeg >/dev/null || {
  echo "ffmpeg not installed"
  exit 1
}
[[ -f "$COOKIES" ]] || {
  echo "cookies.txt missing"
  exit 1
}
[[ -f "$PLAYLIST_FILE" ]] || {
  echo "playlists.txt missing"
  exit 1
}

mkdir -p "$MUSIC_DIR"

YTDLP_BASE=(
  --cookies "$COOKIES"
  --extract-audio
  --audio-format mp3
  --embed-thumbnail
  --add-metadata
  --ignore-errors
  --yes-playlist
  --sleep-interval 5
  --max-sleep-interval 10
  --concurrent-fragments 1
)

select_category() {
  echo "Select category:"
  for i in "${!CATEGORIES[@]}"; do
    echo "$((i + 1))) ${CATEGORIES[$i]}"
  done
  read -r idx
  echo "${CATEGORIES[$((idx - 1))]}"
}

download_playlist() {
  category="$1"
  url="$2"
  dest="$MUSIC_DIR/$category"
  mkdir -p "$dest"

  yt-dlp "${YTDLP_BASE[@]}" \
    -o "$dest/%(artist)s - %(title)s.%(ext)s" \
    "$url" </dev/null
}

echo "1) Download All playlists"
echo "2) Download One song"

read -r choice

case "$choice" in
1)
  echo "Downloading all playlists..."
  while IFS="|" read -r category url; do
    [[ -z "$category" || -z "$url" ]] && continue
    echo "→ $category"
    download_playlist "$category" "$url"
  done <"$PLAYLIST_FILE"
  ;;
2)
  read -p "Song URL: " url
  category="$(select_category)"
  mkdir -p "$MUSIC_DIR/$category"

  yt-dlp "${YTDLP_BASE[@]}" \
    -o "$MUSIC_DIR/$category/%(artist)s - %(title)s.%(ext)s" \
    "$url" </dev/null
  ;;
*)
  echo "Invalid option"
  exit 1
  ;;
esac

echo "Done."

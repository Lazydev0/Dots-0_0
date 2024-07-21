#!/bin/bash

# Function to check if any video is playing
is_video_playing() {
	if playerctl status &>/dev/null || brave_playing_video; then
		return 0
	fi
	return 1
}

# Function to check if Brave is playing a video
brave_playing_video() {
	if pidof -x "brave" &>/dev/null; then
		if pidof -f "brave --type=plugin" &>/dev/null; then
			return 0
		fi
	fi
	return 1
}

# Start the script at startup
swaylock_control() {
	while true; do
		if is_video_playing; then
			killall swayidle
		else
			swayidle -w timeout 1000 'swaylock -f'
		fi
		sleep 5
	done
}

# Run the function
swaylock_control &

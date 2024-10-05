TIME=$(date +"%H:%M")

# Extract the hours and minutes
HOURS=${TIME:0:2}
MINUTES=${TIME:3:2}

# Print them vertically
echo "$HOURS"

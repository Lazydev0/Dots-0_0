#!/bin/sh

# Send a notification if the laptop battery is either low, critical, fully charged, or just started charging/discharging.
# Set on a systemd timer (~/.config/systemd/user/battery-alert.timer).

# Environment variables for display and DBus session
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Battery percentage levels for notifications
WARNING_LEVEL=20
CRITICAL_LEVEL=5

# Icon paths
ICON_PATH="$HOME/.local/share/icons/Custom/"
ICON_FULL="$ICON_PATH/Battery_full.png"
ICON_MEDIUM="$ICON_PATH/Battery_low.png"
ICON_CRITICAL="$ICON_PATH/Battery_critical.png"
ICON_DISCHARGING="$ICON_PATH/Battery_discharging.png"
ICON_CHARGING="$ICON_PATH/Battery_charging.png"

# Notification files to prevent multiple notifications
FULL_FILE=/tmp/batteryfull
EMPTY_FILE=/tmp/batteryempty
CRITICAL_FILE=/tmp/batterycritical
DISCHARGING_FILE=/tmp/batterydischarging
CHARGING_FILE=/tmp/batterycharging

# Function to check for necessary commands
check_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: $1 command not found. Please install it." >&2
    exit 1
  fi
}

# Check necessary commands
check_command acpi
check_command dunstify

# Get battery information
BATTERY_INFO=$(acpi -b | grep "Battery 0")
BATTERY_DISCHARGING=$(echo "$BATTERY_INFO" | grep -c "Discharging")
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)')

# Reset notifications if the computer is charging/discharging
if [ "$BATTERY_DISCHARGING" -eq 1 ] && [ -f $FULL_FILE ]; then
  rm $FULL_FILE
elif [ "$BATTERY_DISCHARGING" -eq 0 ] && [ -f $EMPTY_FILE ]; then
  rm $EMPTY_FILE
fi

# Notification logic

# Check if the battery just started discharging
if [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $DISCHARGING_FILE ]; then
  dunstify "Battery Discharging" "The battery has started discharging." -i "$ICON_DISCHARGING" -r 9991 -u critical
  touch $DISCHARGING_FILE
  # Remove the charging file as the state has changed
  [ -f $CHARGING_FILE ] && rm $CHARGING_FILE
# Check if the battery just started charging
elif [ "$BATTERY_DISCHARGING" -eq 0 ] && [ ! -f $CHARGING_FILE ]; then
  dunstify "Battery Charging" "The battery has started charging." -i "$ICON_CHARGING" -r 9991 -u normal
  touch $CHARGING_FILE
  # Remove the discharging file as the state has changed
  [ -f $DISCHARGING_FILE ] && rm $DISCHARGING_FILE
fi

# If the battery is full and charging
if [ "$BATTERY_LEVEL" -gt 99 ] && [ "$BATTERY_DISCHARGING" -eq 0 ] && [ ! -f $FULL_FILE ]; then
  dunstify "Battery Fully Charged" "Battery is ${BATTERY_LEVEL}%" -i "$ICON_FULL" -r 9991 -u normal
  touch $FULL_FILE
# If the battery is low and discharging
elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $EMPTY_FILE ]; then
  dunstify "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -i "$ICON_MEDIUM" -r 9991 -u low
  touch $EMPTY_FILE
# If the battery is critical and discharging
elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $CRITICAL_FILE ]; then
  dunstify "Battery Critical" "The computer will shut down soon." -i "$ICON_CRITICAL" -r 9991 -u critical
  touch $CRITICAL_FILE
fi

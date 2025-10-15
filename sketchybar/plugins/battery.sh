#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/globals.sh" || exit 1

# Get battery percentage
BATTERY_PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

# Get battery status (charging, discharging, charged)
BATTERY_STATUS=$(pmset -g batt | grep -o "charging\|discharging\|charged")

# Define vertical bar characters (from lowest to highest)
BARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Calculate which bar to use (0-7 based on percentage)
BAR_INDEX=$(( (BATTERY_PERCENTAGE - 1) / 12 ))
if [ $BAR_INDEX -gt 7 ]; then BAR_INDEX=7; fi
if [ $BAR_INDEX -lt 0 ]; then BAR_INDEX=0; fi

# Create vertical line representation (single tall bar for better visibility)
VERTICAL_BAR="${BARS[$BAR_INDEX]}"

# Set color based on battery level and status
if [ "$BATTERY_STATUS" = "charging" ]; then
    COLOR="0xff00ff00"      # Bright green for charging
elif [ $BATTERY_PERCENTAGE -le 20 ]; then
    COLOR="0xffff0000"      # Bright red for low battery
elif [ $BATTERY_PERCENTAGE -le 50 ]; then
    COLOR="0xffffff00"      # Bright yellow for medium battery
else
    COLOR="0xff00ff00"      # Bright green for good battery
fi

# Update sketchybar
sketchybar --set battery \
    icon="$VERTICAL_BAR" \
    icon.color="$COLOR" \
    label="${BATTERY_PERCENTAGE}%" \
    label.color="$OX_DIM" \
    label.font.size=8
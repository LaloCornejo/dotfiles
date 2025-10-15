#!/bin/bash

# Pomodoro Decorative Dots - Visual timer representation
CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/globals.sh" || exit 1

# Pomodoro state file
STATE_FILE="/tmp/pomodoro_state"

# Initialize state if doesn't exist
if [[ ! -f "$STATE_FILE" ]]; then
    echo "work:1:$(date +%s)" > "$STATE_FILE"
fi

# Read current state
CURRENT_STATE=$(cat "$STATE_FILE")
MODE=$(echo "$CURRENT_STATE" | cut -d: -f1)
CYCLE=$(echo "$CURRENT_STATE" | cut -d: -f2)
START_TIME=$(echo "$CURRENT_STATE" | cut -d: -f3)

# Time constants (in seconds)
WORK_TIME=1500    # 25 minutes
BREAK_TIME=300    # 5 minutes
LONG_BREAK=900    # 15 minutes

# Calculate elapsed time
CURRENT_TIME=$(date +%s)
ELAPSED=$((CURRENT_TIME - START_TIME))

# Determine current session duration
if [[ "$MODE" == "work" ]]; then
    SESSION_DURATION=$WORK_TIME
else
    if [[ $((CYCLE % 4)) == 0 ]]; then
        SESSION_DURATION=$LONG_BREAK
    else
        SESSION_DURATION=$BREAK_TIME
    fi
fi

# Check if session is complete
if [[ $ELAPSED -ge $SESSION_DURATION ]]; then
    # Switch to next mode
    if [[ "$MODE" == "work" ]]; then
        NEW_MODE="break"
    else
        NEW_MODE="work"
        CYCLE=$((CYCLE + 1))
    fi
    echo "$NEW_MODE:$CYCLE:$CURRENT_TIME" > "$STATE_FILE"
    MODE=$NEW_MODE
    ELAPSED=0
fi

# Generate decorative dots based on progress
PROGRESS=$((ELAPSED * 100 / SESSION_DURATION))

# Create dot pattern (4 dots representing quarters)
DOTS=""
for i in {1..4}; do
    QUARTER_THRESHOLD=$(((i - 1) * 25))
    if [[ $PROGRESS -ge $QUARTER_THRESHOLD ]]; then
        if [[ "$MODE" == "work" ]]; then
            DOTS+="●"  # Filled dot for work time
        else
            DOTS+="◐"  # Half-filled dot for break time
        fi
    else
        DOTS+="○"      # Empty dot for remaining time
    fi
done

# Add cycle indicator (small number)
CYCLE_DISPLAY=$((CYCLE % 10))

# Set colors based on mode
if [[ "$MODE" == "work" ]]; then
    DOT_COLOR="$OX_MG"      # Pink for work
else
    DOT_COLOR="$OX_BLUE"    # Blue for break
fi

# Update SketchyBar
sketchybar --set pomodoro \
    icon="$DOTS" \
    icon.color="$DOT_COLOR" \
    label="$CYCLE_DISPLAY" \
    label.color="$OX_DIM" \
    label.font.size=8
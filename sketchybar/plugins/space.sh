#!/bin/bash

# Ultra-fast space plugin - minimal overhead
CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/globals.sh" || exit 1

# Cache current space in memory to avoid file I/O
SPACE_CACHE_FILE="/tmp/sb_space_cache"

# Lightning-fast space detection using shared memory
get_current_space() {
    # Try cache first (fastest)
    if [[ -f "$SPACE_CACHE_FILE" ]]; then
        local cached=$(cat "$SPACE_CACHE_FILE" 2>/dev/null)
        [[ "$cached" =~ ^[1-9]$|^10$ ]] && echo "$cached" && return
    fi
    
    # Fallback to Hammerspoon tracking
    local hs_file="$HOME/.hammerspoon/current_space"
    if [[ -f "$hs_file" ]]; then
        local hs_space=$(cat "$hs_file" 2>/dev/null)
        [[ "$hs_space" =~ ^[1-9]$|^10$ ]] && echo "$hs_space" || echo "1"
    else
        echo "1"
    fi
}

# Optimized batch update - single sketchybar call
update_spaces() {
    local current_space=$(get_current_space)
    
    # Only update if space actually changed
    [[ "$current_space" == "$LAST_SPACE" ]] && return
    export LAST_SPACE="$current_space"
    
    # Build efficient batch command
    local cmd="sketchybar"
    for i in {1..10}; do
        if [[ "$i" == "$current_space" ]]; then
            cmd+=" --set space.$i icon.color=$OX_MG"
        else
            cmd+=" --set space.$i icon.color=$OX_DIM"
        fi
    done
    
    # Single atomic update
    eval "$cmd" 2>/dev/null &
}

# Ultra-fast click handling
handle_click() {
    local space_num=${NAME#space.}
    [[ "$space_num" =~ ^[1-9]$|^10$ ]] || return
    
    # Immediate visual feedback
    sketchybar --set space.$space_num icon.color="$OX_MG" &
    
    # Cache the new space immediately
    echo "$space_num" > "$SPACE_CACHE_FILE" &
    
    # Direct macOS space switch (fastest method)
    local key_code=$((17 + space_num))
    [[ "$space_num" == "10" ]] && key_code=29
    
    # Background switch without delay
    osascript -e "tell application \"System Events\" to key code $key_code using control down" &
    
    # Update all spaces asynchronously
    update_spaces &
}

# Event handling
case "$SENDER" in
    "space_change") update_spaces ;;
    "mouse.clicked") handle_click ;;
    *) update_spaces ;;
esac
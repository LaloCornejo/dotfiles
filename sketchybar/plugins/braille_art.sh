#!/bin/bash

# Static ASCII Art Plugin for SketchyBar
# Shows =* Æ *=

# Exit early if globals not available
if [[ -z "$PINK" ]]; then
    source "$(dirname "$0")/../globals.sh" 2>/dev/null || exit 1
fi

# ASCII art pattern
ART="=* Æ *="

# Update the item
main() {
    sketchybar --set braille_art \
        label="$ART" \
        label.color=0xffff69b4 \
        label.font="Source Code Pro:Bold:14"
}

# Run only when called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi

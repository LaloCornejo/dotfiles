#!/bin/bash

# Get current application - more robust method
CURRENT_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)

# Fallback if osascript fails
if [[ -z "$CURRENT_APP" ]]; then
    CURRENT_APP=$(lsappinfo front | grep -o '"[^"]*"' | head -1 | tr -d '"' 2>/dev/null)
fi

# Second fallback
if [[ -z "$CURRENT_APP" ]]; then
    CURRENT_APP="Unknown"
fi



# Comprehensive app icon mapping using sketchybar-app-font
case "$CURRENT_APP" in
    # Terminals & Development (case-sensitive matching)
    "Ghostty"|"ghostty") APP_ICON=":ghostty:" ;;
    "Terminal") APP_ICON=":terminal:" ;;
    "iTerm2") APP_ICON=":iterm2:" ;;
    "Warp") APP_ICON=":warp:" ;;
    "Code") APP_ICON=":visual_studio_code:" ;;
    "Visual Studio Code") APP_ICON=":visual_studio_code:" ;;
    "Xcode") APP_ICON=":xcode:" ;;
    
    # Web Browsers
    "Zen Browser"|"Zen"|"zen") APP_ICON=":zen_browser:" ;;
    "Arc") APP_ICON=":arc:" ;;
    "Safari") APP_ICON=":safari:" ;;
    "Google Chrome") APP_ICON=":google_chrome:" ;;
    "Firefox") APP_ICON=":firefox:" ;;
    "Microsoft Edge") APP_ICON=":microsoft_edge:" ;;
    "qutebrowser") APP_ICON=":qutebrowser:" ;;
    
    # Development Tools
    "Docker Desktop") APP_ICON=":docker:" ;;
    "Postman") APP_ICON=":postman:" ;;
    "TablePlus") APP_ICON=":tableplus:" ;;
    "SF Symbols") APP_ICON=":sf_symbols:" ;;
    
    # Design & Creative
    "Pixelmator Pro") APP_ICON=":pixelmator_pro:" ;;
    "Adobe Photoshop 2024") APP_ICON=":adobe_photoshop:" ;;
    "Adobe Illustrator 2024") APP_ICON=":adobe_illustrator:" ;;
    "Figma") APP_ICON=":figma:" ;;
    "Pages") APP_ICON=":pages:" ;;
    
    # Communication
    "Discord") APP_ICON=":discord:" ;;
    "legcord") APP_ICON=":discord:" ;;
    "Slack") APP_ICON=":slack:" ;;
    "Messages") APP_ICON=":messages:" ;;
    "Mail") APP_ICON=":mail:" ;;
    "Zoom") APP_ICON=":zoom:" ;;
    "Microsoft Teams") APP_ICON=":microsoft_teams:" ;;
    "FaceTime") APP_ICON=":facetime:" ;;
    
    # Media & Entertainment
    "IINA") APP_ICON=":iina:" ;;
    "Music") APP_ICON=":music:" ;;
    "Spotify") APP_ICON=":spotify:" ;;
    "qBittorrent") APP_ICON=":qbittorrent:" ;;
    "OpenEmu") APP_ICON=":openemu:" ;;
    
    # Productivity & Notes
    "Obsidian") APP_ICON=":obsidian:" ;;
    "Notion") APP_ICON=":notion:" ;;
    "Notes") APP_ICON=":notes:" ;;
    "Goodnotes") APP_ICON=":goodnotes:" ;;
    "Calendar") APP_ICON=":calendar:" ;;
    "TextEdit") APP_ICON=":text_edit:" ;;
    "Preview") APP_ICON=":preview:" ;;
    
    # System & Utilities
    "Finder") APP_ICON=":finder:" ;;
    "System Preferences") APP_ICON=":system_preferences:" ;;
    "System Settings") APP_ICON=":system_preferences:" ;;
    "Activity Monitor") APP_ICON=":activity_monitor:" ;;
    "Calculator") APP_ICON=":calculator:" ;;
    "Raycast") APP_ICON=":raycast:" ;;
    "AltTab") APP_ICON=":alttab:" ;;
    
    # Default fallback
    *) 
        APP_ICON=":default:"
        # Try to get a generic icon based on app type
        if [[ "$CURRENT_APP" == *"Terminal"* ]] || [[ "$CURRENT_APP" == *"term"* ]]; then
            APP_ICON=":terminal:"
        elif [[ "$CURRENT_APP" == *"Browser"* ]] || [[ "$CURRENT_APP" == *"Web"* ]]; then
            APP_ICON=":safari:"
        fi
        ;;
esac



# Update the current app icon with error handling
if ! sketchybar --set current_app icon="$APP_ICON" label="" 2>/dev/null; then
    # Fallback to text if icon fails
    sketchybar --set current_app icon="" label="${CURRENT_APP:0:3}" 2>/dev/null
fi

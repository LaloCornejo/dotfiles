# Sketchybar Configuration

A comprehensive and feature-rich sketchybar configuration with system monitoring, productivity tools, and beautiful theming.

## Features

### Left Side Items
- **Clock** - Shows current time (updates every 10 seconds)
- **Pomodoro** - Pomodoro timer with click to toggle (hidden by default)  
- **Date** - Day, date, and month display
- **Spaces** - Workspace/desktop indicators with native macOS integration
- **Current App** - Shows the currently focused application
- **Music** - Now playing from Music app (shows when playing)

### Right Side Items
- **Weather** - Current temperature from wttr.in
- **Calendar** - Number of events today (click to open Calendar)
- **Network** - Network usage statistics
- **Uptime** - System uptime
- **CPU** - CPU usage percentage with color coding
- **Memory** - RAM usage percentage with color coding  
- **Disk** - Disk usage percentage with color coding
- **VPN** - VPN connection status
- **Bluetooth** - Bluetooth status and connected device count
- **WiFi** - WiFi connection status and network name
- **Battery** - Battery percentage with charging indicator
- **Volume** - System volume with mute indicator

## Color Coding

- 🟢 **Green**: Normal/Good (< 50% CPU/Memory, < 70% Disk)
- 🟡 **Yellow**: Warning (50-80% CPU/Memory, 70-90% Disk)  
- 🔴 **Red**: Critical (> 80% CPU/Memory, > 90% Disk)

## Click Actions

- **Pomodoro**: Toggle timer on/off
- **Music**: Play/pause current track
- **Volume**: Open Sound preferences
- **Bluetooth**: Open Bluetooth preferences  
- **Calendar**: Open Calendar app
- **Spaces**: Switch to workspace (native macOS Mission Control)

## Utility Commands

Use the included utility script for common operations:

```bash
# Toggle music display
~/.config/sketchybar/utils.sh toggle_music

# Toggle pomodoro timer
~/.config/sketchybar/utils.sh toggle_pomodoro

# Restart sketchybar
~/.config/sketchybar/utils.sh restart

# Reload configuration
~/.config/sketchybar/utils.sh reload

# Test color theme
~/.config/sketchybar/utils.sh test_colors

# Show help
~/.config/sketchybar/utils.sh help
```

## File Structure

```
~/.config/sketchybar/
├── sketchybarrc          # Main configuration file
├── globals.sh            # Global variables and theming
├── items.sh              # Item definitions and functions
├── utils.sh              # Utility functions
├── plugins/              # Plugin scripts directory
│   ├── battery.sh        # Battery status
│   ├── bluetooth.sh      # Bluetooth status
│   ├── calendar.sh       # Calendar events
│   ├── clock.sh          # Current time
│   ├── cpu.sh           # CPU usage
│   ├── current_app.sh   # Current application
│   ├── disk.sh          # Disk usage
│   ├── memory.sh        # Memory usage
│   ├── music.sh         # Now playing
│   ├── network.sh       # Network stats
│   ├── pomodoro.sh      # Pomodoro timer
│   ├── space.sh         # Workspace switching
│   ├── uptime.sh        # System uptime
│   ├── volume.sh        # System volume
│   ├── vpn.sh           # VPN status
│   ├── weather.sh       # Weather info
│   └── wifi.sh          # WiFi status
└── README.md            # This file
```

## Customization

### Colors
Edit `globals.sh` to modify the color scheme. Current theme features a **translucent design** with:
- **75% opacity background** with blur effect for readability
- **High contrast colors** optimized for translucent surfaces
- **Enhanced readability** with bright text on dark translucent background

### Adding Items
1. Create a new plugin script in `plugins/`
2. Add a function in `items.sh` 
3. Call the function in `sketchybarrc`

### Update Frequencies
Modify `update_freq` values in `items.sh` for each item as needed.

## Dependencies

- **sketchybar**: The status bar itself
- **AeroSpace** (recommended): For advanced workspace management (`brew install --cask aerospace`)
- **jq** (optional): For JSON parsing in some plugins
- **bc** (optional): For calculations in network plugin

## AeroSpace Integration

This configuration uses a **proven AeroSpace integration** based on a working implementation. The workspace switching integrates seamlessly with AeroSpace's workspace system using SketchyBar's native event system.

### Features:
- **Native `space_change` events** - Uses SketchyBar's built-in workspace detection
- **JSON info parsing** - Extracts workspace data from `$INFO` variable using `jq`
- **Real-time updates** - Responds to workspace changes automatically
- **Click-to-switch** - Click any workspace icon to switch instantly
- **Fallback detection** - Multiple methods to detect current workspace

### How it works:
1. **SketchyBar detects workspace changes** and triggers `space_change` events
2. **JSON parsing** extracts workspace ID from the `$INFO` variable
3. **Visual updates** highlight the active workspace and dim others
4. **Click handling** uses `aerospace workspace <number>` to switch spaces

### Setup:

1. **Install AeroSpace**:
   ```bash
   brew install --cask aerospace
   ```

2. **Install jq** (required for JSON parsing):
   ```bash
   brew install jq
   ```

3. **Start AeroSpace**:
   - Launch AeroSpace.app
   - Create your desired workspace layouts

### No additional configuration needed:
The implementation automatically detects workspace changes through SketchyBar's native event system. No helper processes or external event handlers required!

## Troubleshooting

1. **Items not showing**: Check plugin script permissions with `ls -la ~/.config/sketchybar/plugins/`
2. **Errors on reload**: Check syntax with `bash -n ~/.config/sketchybar/sketchybarrc`
3. **Performance issues**: Increase update frequencies in `items.sh`
4. **Colors not working**: Ensure proper hex format in `globals.sh`

## Performance Notes

- Weather updates every 10 minutes to avoid API limits
- System monitoring items update every 5-10 seconds
- Music and current app update every 2 seconds for responsiveness
- Calendar updates every 5 minutes

Enjoy your comprehensive sketchybar setup! 🎉

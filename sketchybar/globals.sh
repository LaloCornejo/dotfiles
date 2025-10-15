#!/bin/bash

export PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

# Color Theme - Ultra translucent background
export OX_BG="0x30000000"        # Ultra translucent background (19% opacity)
export OX_FG="0xffffffff"        # Pure white for better contrast
export OX_DIM="0xffb0b0b0"       # Light gray for dimmed text
export OX_MG="0xffff69b4"        # Bright magenta/Primary
export OX_ORG="0xff9966ff"       # Purple/Accent
export OX_RED="0xffff4444"       # Bright red/Error
export OX_GREEN="0xff44ccff"     # Bright blue/Success (was green)
export OX_YELLOW="0xff9966ff"    # Purple/Warning (was yellow)
export OX_BLUE="0xff6666ff"      # Bright blue/Info
export OX_SURFACE="0x40ffffff"   # More translucent white surface

# Workspace/Space Icons (matching AeroSpace workspace organization)
export SPACE_ICONS=("􀆔" "􀌃" "􁷿" "􀈖" "􀌯" "􀍕" "􀑪" "􀣋" "􀥭" "􀪴")

# Animation settings
export ANIMATE="on"

export SB_BAR=(
  position=left
  height=60
  sticky=on
  topmost=on
  shadow=on
  y_offset=10
  margin=10
  padding_left=16
  padding_right=16
  color=0x20000000
  border_color=0x20ffffff
  border_width=1
  corner_radius=12
  font_smoothing=on
  blur_radius=60
  notch_width=200
)

export SB_DEFAULT=(
  icon.font.family="SF Pro"
  icon.font.style="Medium"
  icon.font.size=12
  icon.color="$OX_FG"
  label.font="Source Code Pro"
  label.font.style="Medium"
  label.font.size=13
  label.color="$OX_FG"
  padding_left=10
  padding_right=10
  icon.padding_right=4
  icon.highlight_color="$OX_MG"
  background.drawing=off
  updates="when_shown"
  drawing="$ANIMATE"
)

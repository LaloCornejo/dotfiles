#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <on|off>"
    exit 1
fi

PRESENTATION=$1
CONFIG_FILE="/Users/lalocornejo/.dotfiles/aerospace/presentation.sh"

if [ "$PRESENTATION" == "on" ]; then
    sed -i "" "s/outer\.top = .*/outer.top = 40
    echo "Presentation mode enabled"
else
    sed -i "" "s/outer\.top = .*/outer.top = 40
    echo "Presentation mode disabled"
fi
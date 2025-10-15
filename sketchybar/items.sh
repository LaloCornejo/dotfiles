#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
. "$CONFIG_DIR/globals.sh"

sb_separator() {
	sepName="sep$RANDOM"
	sketchybar \
		--add item "$sepName" "$1" \
		--set "$sepName" \
			label="───────" \
			padding_left="$2" \
			padding_right="$3" \
			icon.drawing=off \
			label.font.size=9.0 \
			label.color="$OX_DIM"
}

sb_clock() {
	sketchybar \
		--add item clock "$1" \
		--set clock \
			update_freq=10 \
			label.font.size=14.0 \
			icon= \
			icon.drawing=off \
			drawing=on \
			script="$PLUGIN_DIR/clock.sh"
}



sb_date() {
	sketchybar \
		--add item day "$1" \
		--set day \
			update_freq=120 \
			icon.drawing=off \
			drawing=on \
			padding_right=4 \
			label="$(date '+%a')" \
			script="sketchybar --set \$NAME label=\"\$(date '+%a')\"" \
		--add item date "$1" \
		--set date \
			update_freq=120 \
			icon.drawing=off \
			drawing=on \
			padding_right=4 \
			label="$(date '+%d' | sed s/^0//)" \
			script="sketchybar --set \$NAME label=\"\$(date '+%d' | sed s/^0//)\"" \
		--add item month "$1" \
		--set month \
			update_freq=120 \
			icon.drawing=off \
			drawing=on \
			padding_right=4 \
			label="$(date '+%b')" \
			script="sketchybar --set \$NAME label=\"\$(date '+%b')\""
}

sb_spaces() {
	for i in "${!SPACE_ICONS[@]}"; do
		sid=$((i + 1))
		sketchybar \
			--add space space.$sid "$1" \
			--subscribe space.$sid space_change mouse.clicked \
			--set space.$sid \
				associated_space=$sid \
				icon="${SPACE_ICONS[i]}" \
				icon.font.size=14 \
				icon.padding_left=8 \
				icon.padding_right=8 \
				label.drawing=off \
				script="$PLUGIN_DIR/space.sh" \
				click_script="$PLUGIN_DIR/space.sh"
		
		if [[ $sid == 5 ]]; then 
			sb_separator left 14 14
		fi
	done
}

sb_current_app() {
	sketchybar \
		--add item current_app "$1" \
		--subscribe current_app front_app_switched \
		--set current_app \
			script="$PLUGIN_DIR/current_app.sh" \
			icon.font="sketchybar-app-font:Regular:16.0" \
			icon.color="$OX_MG" \
			label.drawing=off \
			padding_left=8 \
			padding_right=8
}

sb_pomodoro() {
	sketchybar \
		--add item pomodoro "$1" \
		--set pomodoro \
			update_freq=30 \
			script="$PLUGIN_DIR/pomodoro.sh" \
			icon.font.size=10 \
			icon.color="$OX_MG" \
			label.font.size=8 \
			label.color="$OX_DIM" \
			padding_left=8 \
			padding_right=8 \
			drawing=on
}

sb_braille_art() {
	sketchybar \
		--add item braille_art "$1" \
		--set braille_art \
			update_freq=1 \
			script="$PLUGIN_DIR/braille_art.sh" \
			icon.drawing=off \
			label.font.size=12 \
			label.color="$PINK" \
			padding_left=8 \
			padding_right=8 \
			drawing=on
}

sb_battery() {
	sketchybar \
		--add item battery "$1" \
		--set battery \
			update_freq=30 \
			script="$PLUGIN_DIR/battery.sh" \
			icon.font.size=20 \
			icon.color="$OX_GREEN" \
			label.font.size=10 \
			label.color="$OX_DIM" \
			padding_left=8 \
			padding_right=8 \
			drawing=on
}





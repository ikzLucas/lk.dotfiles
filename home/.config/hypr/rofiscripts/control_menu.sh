#!/usr/bin/env bash

print_menu() {
echo -e " Notification Center
 View Clipboard
 Load Monitor Configuration
 Exit Menu"
}

selection=$(print_menu | rofi -dmenu -i -format d -only-match -p "Hyprland Configurator")

if [ $selection == 1 ]; then
	./notifications.sh
elif [ $selection == 2 ]; then
	./clipboard.sh
elif [ $selection == 3 ]; then
	./monitor_select.sh
fi

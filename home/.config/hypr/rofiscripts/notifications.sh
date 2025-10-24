Script to pipe mako notificaitons to rofi
#!/usr/bin/env bash
makoctl history | rofi -dmenu -p "Notification History"

## Monitor Selection Script
## This will automatically work with any Hyprland monitor config placed in the /monitors directory
#!/usr/bin/env bash
selection=$(ls ../monitors | rofi -dmenu -p "Select a Monitor Config to Use")
sed -i "s,monitors/.*,monitors/$selection," ../hyprland.conf

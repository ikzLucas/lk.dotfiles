#!/bin/bash
if command -v systemctl 
then
	systemctl enable --user pipewire.service pipewire-pulse.service wireplumber.service
	systemctl start --user hyprpolkitagent.service
else
	rc-update add --user pipewire
	rc-update add --user pipewire-pulse
	rc-update add --user wireplumber
	/usr/libexec/hyprpolkitagent &
fi

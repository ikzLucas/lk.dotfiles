# Sway service handler for systemd and OpenRC
#!/usr/bin/env bash

if command -v systemctl >/dev/null 2>&1; then
   systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP WAYLAND_DISPLAY SWAYSOCK
fi




dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP XDG_SESSION_TYPE WAYLAND_DISPLAY

if command -v systemctl >/dev/null 2>&1; then
   systemctl --user restart xdg-desktop-portal-wlr.service
   systemctl --user restart xdg-desktop-portal-gtk.service
fi

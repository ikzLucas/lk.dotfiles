#!/usr/bin/env bash

# Universal *nix updater

if command -v sudo >/dev/null 2>&1; then
   ESCALTE="sudo"
elif command -v doas >/dev/null 2>&1; then
   ESCALTE="doas"
elif command -v run0 >/dev/null 2>&1; then
   ESCALTE="run0"
else
   echo "Please install a privledge escalation program"
   exit 0
fi

echo "Escalating using $ESCALTE"

# Update Gentoo packages
if command -v emerge >/dev/null 2>&1; then
   $ESCALTE emerge --ask --verbose --update --deep --changed-use @world
fi

# Update Homebrew packages
if command -v brew >/dev/null 2>&1; then
   brew update
   brew outdated
   brew upgrade
   brew cleanup
fi

# Update Flatpaks
if command -v flatpak >/dev/null 2>&1; then
   flatpak update
   flatpak uninstall --unused
fi

# Update Arch packages
if command -v pacman >/dev/null 2>&1; then
   $ESCALTE pacman -Syu
fi

# Update AUR packages with yay
if command -v yay >/dev/null 2>&1; then
   yay -Sua
fi

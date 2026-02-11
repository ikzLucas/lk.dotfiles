#!/usr/bin/env bash

# Todo: safe rewrite
# Make directories when needed
# start systemd services automagically

# WARNING: This script assumes it is working in the dotfiles directory it was cloned to. Moving it will probably blow something up

if ! command -v sudo >/dev/null 2>&1; then 
   echo "Install sudo you dipstick"
   exit 1
fi

# Configs specific to macOS + apps I use on my mac
# stows configs from darwin-home/dot-config to ~/.config/
install_darwin () {
   pushd darwin-home || return
   stow .
   popd || return
}

# Generic Linux dotfiles / configs
install_linux () {
   pushd linux-home || return
   stow .
   popd || return
   pushd linux-gnu || return
   sudo stow .
   popd || return
}

# System level configs for Gentoo (Kernel + Portage config)
install_gentoo () {
   if ! [ -d /etc/kernel/config.d ]; then 
      sudo mkdir /etc/kernel/config.d
   fi

   # Ensure git is installed before switching to git-based repositories
   if ! command -v git >/dev/null 2>&1; then
      sudo emerge --ask=n dev-vcs/git
   fi

   
   pushd gentoo-system || return
   
   # Install configs compatible with (most) computers
   # This will blow up systems with btrfs
   # They deserve it
   pushd universal || return
   sudo stow .
   popd || return
   
   # Configs for my desktop
   if [ "$(cat /etc/hostname)" = chi ]; then
      # Backup existing portage config
      pushd chi || return
      sudo stow .
      popd || return
   fi

   # Configs for my thinkpad
   if [ "$(cat /etc/hostname)" = raven ]; then
      pushd raven || return
      sudo stow .
      popd || return
   fi

   popd || return
}

if [[ $OSTYPE == *darwin* ]]; then
=======
install_arch () {
   if ! command -v git >/dev/null 2>&1; then
       sudo pacman -S --noconfirm git
   fi

   pushd arch-system || return
   sudo stow .
   popd || return
}

if [ "$OSTYPE" = "darwin" ]; then
   install_darwin
fi

if [ "$OSTYPE" = "linux-gnu" ]; then
   install_linux
   if [ $(cat /etc/os-release | grep ^ID) = 'ID=gentoo' ]; then
      install_gentoo
   fi
fi

=======
if [ "$(cat /etc/os-release | grep ^ID)" = 'ID=gentoo' ]; then
   install_gentoo
elif [ "$(cat /etc/os-release | grep ^ID)" = 'ID=arch' ]; then
   install_arch
fi

pushd universal-home || return
stow .
popd || return

pushd local-bin || return
chmod +x ./*
stow .
popd || return

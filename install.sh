#/usr/bin/env bash

# WARNING: This script assumes it is working in the dotfiles directory it was cloned to. Moving it will probably blow something up

if ! command -v sudo >/dev/null 2>&1; then 
   echo "Install sudo you dipstick"
   exit 1
fi

# Configs specific to macOS + apps I use on my mac
# stows configs from darwin-home/dot-config to ~/.config/
install_darwin () {
   pushd darwin-home
   stow .
   popd
}

# Generic Linux dotfiles / configs
install_linux () {
   pushd linux-home
   stow .
   popd
   pushd linux-gnu
   sudo stow .
   popd
}

# System level configs for Gentoo (Kernel + Portage config)
install_gentoo () {
   if ! [ -d /etc/kernel/config.d ]; then 
      sudo mkdir /etc/kernel/config.d
   fi

   # Ensure git is installed before switching to git-based repositories
   if ! command -v git >/dev/null 2>&1; then
      emerge --ask=n dev-vcs/git
   fi

   
   pushd gentoo-system
   
   # Install configs compatible with (most) computers
   # This will blow up systems with btrfs
   # They deserve it
   pushd universal
   sudo stow .
   popd
   
   # Configs for my desktop
   if [ $(cat /etc/hostname) = chi ]; then
      # Backup existing portage config
      if [ -f /etc/portage/make.conf ]; then
        sudo mv /etc/portage/make.conf /etc/portage/make.conf.old
      fi
      pushd chi
      sudo stow .
      popd
   fi

   # Configs for my thinkpad
   if [ $(cat /etc/hostname) = raven ]; then
      pushd raven
      sudo stow .
      popd
   fi

   popd
}

if [ $OSTYPE = darwin ]; then
   install_darwin
fi

if [ $OSTYPE = linux-gnu ]; then
   install_linux
fi

if [ $(cat /etc/os-release | grep ^ID) = 'ID=gentoo' ]; then
   install_gentoo
fi

pushd universal-home
stow .
popd

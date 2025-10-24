#/usr/bin/env bash

# WARNING: This script assumes it is working in the dotfiles directory it was cloned to. Moving it will probably blow something up

if ! command -v sudo >/dev/null 2>&1; then 
   echo "Install sudo you dipstick"
   exit 1
fi

# Install universal configs
install_universal () {
   pushd home
   stow .
   popd
}

install_gentoo () {
   pushd gentoo
   sudo stow .
   popd
}

if [ $OSTYPE = linux-gnu ]; then
	echo "detected generic loonix"
fi

if [ $(cat /etc/os-release | grep ^ID) = 'ID=gentoo' ]; then
   install_gentoo
fi



install_universal

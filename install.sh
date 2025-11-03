#/usr/bin/env bash

# WARNING: This script assumes it is working in the dotfiles directory it was cloned to. Moving it will probably blow something up

if ! command -v sudo >/dev/null 2>&1; then 
   echo "Install sudo you dipstick"
   exit 1
fi

# Configs specific to macOS + apps I use on my mac
install_darwin () {
   pushd darwin-home
   stow .
}


install_gentoo () {
   pushd gentoo
   vendor=$(awk -F: '/vendor_id/ { print $2; exit }' /proc/cpuinfo | tr -d ' \t')
   if [[ "$vendor" == "GenuineIntel" ]]; then
      pushd desktop
   elif [[ "$vendor" == "AuthenticAMD" ]]; then
      echo "CPU vendor: AMD"
      exit 1
   else
      echo "CPU vendor: Unknown ($vendor)"
      exit 1
   fi
   sudo stow .
   popd
   popd
}

if [ $OSTYPE = linux-gnu ]; then
	echo "detected generic loonix"
fi

if [ $(cat /etc/os-release | grep ^ID) = 'ID=gentoo' ]; then
   install_gentoo
fi

if [ $OSTYPE = darwin ]; then
	install_darwin
fi

#/usr/bin/env bash

# Install universal configs
pushd home
stow .
popd

if [ $OSTYPE = linux-gnu ]; then
	echo "detected generic loonix"
fi

if [ $(cat /etc/os-release | grep ^ID) = 'ID=gentoo' ]; then
	echo "im coooompiling"
fi

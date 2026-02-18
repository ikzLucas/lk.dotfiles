#!/usr/bin/env bash

# change as desired
DOTFILES=$HOME/.dotfiles

pushd $DOTFILES
git pull

SLOW=0 SLOW2=0 PAUSE=0 $DOTFILES/install.sh
popd

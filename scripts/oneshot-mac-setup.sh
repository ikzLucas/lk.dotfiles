#!/usr/bin/env bash  

# dont run this unless you want all the apps I like to have installed, fast key repeat, and dock on the left

# Install homebrew breh

if ! command -v brew; then
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
   echo 'Homebrew already installed'
fi

brew analytics off

# Ansible for setup
if ! command -v ansible; then
   brew install ansible
fi
ansible-galaxy collection install community.general
ansible-playbook -i ./ansible/inventory ./ansible/darwin.yml

# Install the dotfiles
PAUSE=0 ../install.sh

#update system using installed update script
up

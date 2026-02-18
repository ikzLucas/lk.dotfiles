#!/usr/bin/env bash

# pretty colors
INFO="\033[0;36mINFO:\033[0m"
WARNING="\033[41;37mWARNING:\033[0m"
SKIP="\033[0;33mSKIP:\033[0m"
INSTALL="\033[0;32mINSTALL:\033[0m"
MOVE="\033[0;35mMOVE:\033[0m"

DOTFILES_DIR=$(pwd)
OLD_FILES=$DOTFILES_DIR/.old

SLOW="${SLOW:-0.8}"
SLOW2="${SLOW:-0.1}"
PAUSE="${PAUSE:-1}"

echo -e "$WARNING This script's configs take precedent! It will move all of your old versions of its files to $DOTFILES_DIR/.old"
if [ "$PAUSE" -eq 1 ]; then
   read -p "Press Enter to continue, Ctrl+C to cancel..." -r
fi

# --- SETUP ---
echo -e "$INFO Dotfiles folder is: $DOTFILES_DIR"

sleep $SLOW
echo "Creating stash for old files"
mkdir -p $OLD_FILES

sleep $SLOW
echo -e "Creating ~/.local/bin"
mkdir -p $HOME/.local/bin

sleep $SLOW
SCRIPT_DIR=$DOTFILES_DIR/scripts
echo "Making scripts executable"
chmod +x $SCRIPT_DIR/*
if [ ! -L "$HOME/.local/bin/up" ]; then
   echo -e "$INSTALL $SCRIPT_DIR/update.sh -> $HOME/.local/bin/up"
   ln -s $SCRIPT_DIR/update.sh $HOME/.local/bin/up
fi

sleep $SLOW
# --- SHELL ---
SHELL_DIR=$DOTFILES_DIR/shell
SHELL_CONF=("bashrc" "zshrc" "zshenv" "zprofile")

echo -e "$INFO Linking shell configs"
sleep $SLOW
for f in "${SHELL_CONF[@]}"; do
   link="$HOME/.$f"
   target="$SHELL_DIR/$f"

   sleep $SLOW2
   if [ -L "$link" ]; then
      echo -e "$SKIP $link is already a symlink"
   elif [ -e "$link" ]; then
      echo -e "$MOVE $link backed up to $OLD_FILES"
      mv "$link" "$OLD_FILES"

      ln -s "$target" "$link"
      echo -e "$INSTALL $target -> $link"
   else
      ln -s "$target" "$link"
      echo -e "$INSTALL $target -> $link"
   fi
done

sleep $SLOW
# --- CONFIG ---
CONF_DIR="$DOTFILES_DIR/config"
CONF_TARGET="$HOME/.config"
CONFIGS=("tmux" "ghostty" "mpv" "yt-dlp" "nvim")

mkdir -p "$CONF_TARGET"
mkdir -p "$OLD_FILES"

echo -e "$INFO Linking dotfile configs"
sleep "$SLOW"

for d in "${CONFIGS[@]}"; do
  link="$CONF_TARGET/$d"
  target="$CONF_DIR/$d"

  sleep $SLOW2

  if [ -L "$link" ]; then
    echo -e "$SKIP $link is already a symlink"

  elif [ -e "$link" ]; then
    echo -e "$MOVE $link backed up to $OLD_FILES"
    mv "$link" "$OLD_FILES/"

    ln -s "$target" "$link"
    echo -e "$INSTALL $target -> $link"

  else
    ln -s "$target" "$link"
    echo -e "$INSTALL $target -> $link"
  fi
done

sleep $SLOW

echo -e "\033[0;32mDONE!\033[0m Please review any skipped links - old symlinks are not overridden automatically. You may update your system regardless of package manager using 'up'."

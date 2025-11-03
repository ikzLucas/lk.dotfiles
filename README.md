# Lucas's dotfiles

The install script will automatically detect macOS, Gentoo, and generic linux distros and attempt to install relevant configs for each.

### File Structure:

darwin-home -> macOS-specific user-level dotfiles

gentoo-system -> gentoo portage / kernel configs

linux-gnu -> linux-specific system-level configs

linux-gnu -> linux-specific user-level dotfiles

universal-home -> Mac/Linux agnostic dotfiles that work on both systems


Windows support in the future maybe

*Current contents:*

✅ - Fully Supported

⚠️ - Support WIP, incomplete, or reduced functionality

❌ - Unsupported or not working 

ℹ️ - Not Applicable

| Config           | MacOS | Gentoo |
|:----------------:|:-----:|:------:|
|Zsh               |✅     |⚠️      |
|Neovim            |✅     |✅      |
|Tmux              |✅     |✅      |
|Ghostty           |✅     |ℹ️      |
|sway              |ℹ️     |✅      |
|Niri              |ℹ️     |✅      |
|xdg-desktop-portal|ℹ️     |✅      |
|yt-dlp            |✅     |✅      |
|mpv               |✅     |✅      |

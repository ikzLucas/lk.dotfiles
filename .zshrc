# Lucas's Zsh config 
# Version 25.10.r1

PATH="$HOME/.local/bin:$PATH"

#########################
### Plugin Management ###
#########################
#--Install Zinit if it isn't already there
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

#--Plugins - Syntax Highlight, Completions, and Autosuggestions loaded with Zinit turbo mode
# bindkey ctrl+f accept suggestion added here to avoid conflict with async plugin loading
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start; bindkey '^f' autosuggest-accept" \
    zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit 

#############################
### Aliases and Functions ###
#############################

# Privledge escalation
if command -v sudo >/dev/null 2>&1; then
	ELEVATE=sudo
elif command -v doas >/dev/null 2>&1; then
	ELEVATE=doas
fi

# Shorthand for a couple things
alias c='clear'	# Or just press Ctrl + L!
alias ff='fastfetch'
alias cff='clear && fastfetch'
# Alias vim to the better vim
alias svim='/usr/bin/vim'
alias v='nvim'
alias vim='nvim'
alias sv="$ELEVATE nvim"
# Colors - from Debian 12 default .bashrc
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# Extra LS command shorthand
alias lah='ls -lAh'
# Easy cd by typing periods .
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
# Reload zsh easily
alias rz="source ~/.zshenv && source ~/.zprofile && source ~/.zshrc"
# Extra verbosity and interactivity in common file operation commands
rm() { command rm -vi "${@}"; }        # Interactive and verbose output for rm, cp, mv
cp() { command cp -vi "${@}"; }        # Prevents file overwrites and explains what is happening
mv() { command mv -vi "${@}"; }        # EX: mv file file2 outputs "renamed file -> file2"

alias up='brew update && brew outdated && brew upgrade && brew cleanup'

#####################
### Shell Options ###
#####################
setopt correctall 
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_find_no_dups

# Completion styling by dreamsofautonomy https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Zsh integrations with other stuff
eval "$(fzf --zsh)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

####################
### Shell Prompt ###
####################
# A zsh prompt loosely based off Gentoo prompt with a few mods:
# - Multicolor!
# - VCS info 
# - Tweaked path and select prompts
# zsh prompt vcs tutorial @: https://salferrarello.com/zsh-git-status-prompt/
lk_prompt_setup () {
prompt_gentoo_prompt=${1:-'blue'}
user_color=${2:-'132'}
divider_color=${3:-'222'}
hostname_color=${4:-'192'}
prompt_gentoo_root=${5:-'red'}

if [ "$USER" = 'root' ]
then
base_prompt="%B%F{$prompt_gentoo_root}%m%k "
else
# %B -> Bold %F -> color %n -> username %m -> short hostname
base_prompt="%B%F{$user_color}%n%F{$divider_color}@%F{$hostname_color}%m%k "
fi
post_prompt="%b%f%k"

# show VCS info in prompt
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
vcs_prompt='%F{red}${vcs_info_msg_0_}%f'

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       ' (%b%u%c)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c)'

path_prompt="%B%F{$prompt_gentoo_prompt}%1~"
PS1="$base_prompt$path_prompt$vcs_prompt %# $post_prompt"
PS2="$path_prompt %_> $post_prompt"
PS3="$path_prompt ?# $post_prompt"
}

lk_prompt_setup "$@"

# Enable vi mode for the shell
bindkey -v
# Search history with ctrl+p/n 
# Ex: typing echo will search history for only other echo commands
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

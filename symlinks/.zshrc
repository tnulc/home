#!/bin/bash

# make terminal support 256 colours
if [[ $TERM == xterm ]]; then
    TERM=xterm-256color
fi

# pretty theme
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then export LC_CTYPE=${LANG%%:*}; fi

# split paths at forward slashes
WORDCHARS=$WORDCHARS:s:/:

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# setup path
export PATH="$HOME/.local/bin:$DOTFILES/bin:$PATH"

# environment variables
for env in ~/.env*; do source $env; done;

# set prompt colours
autoload -U colors && colors
if [ $UID -eq 0 ]; then NCOLOR="017"; else NCOLOR="255"; fi
if [[ x$WINDOW != x ]]; then SCREEN_NO="%B$WINDOW%b "; else SCREEN_NO=""; fi

# load in config files
typeset -U config_files
config_files=($DOTFILES/config/**/*.zsh)
for file in $config_files; do source $file; done
unset config_files

# load in our custom functions/completions
fpath=($DOTFILES/functions $DOTFILES/completions $fpath)

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U $DOTFILES/functions/*(:t)
autoload -U $DOTFILES/completions/*(:t)
zmodload -i zsh/complist
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile
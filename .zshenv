#!/bin/sh

########################################################################
# non-interactive shell environment
########################################################################


########################################################################
# uncommitted sensitive environment
########################################################################

[[ -e "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"


########################################################################
# general settings
########################################################################

Z="$HOME/.local/etc/zsh"
SHARE="$HOME/.local/share"
LBIN="$HOME/.local/bin"

export LC_ALL="en_GB.UTF-8"
if [[ -e "/usr/share/zoneinfo/UTC" ]]; then
  export TZ=":/usr/share/zoneinfo/UTC"
else
  export TZ="UTC"
fi
export PAGER="less"
export LESS="CMifSR --tabs=4"
export LESSCHARSET="utf-8"
export EDITOR="vim"
export MLR_CSV_DEFAULT_RS="lf"

skip_global_compinit=1

# # split paths at forward slashes
WORDCHARS=$WORDCHARS:s:/:


########################################################################
# paths
########################################################################

[[ -d $LBIN ]] && export PATH="$LBIN:$PATH"


########################################################################
# SSH fixups
########################################################################

# fix up permissions every time, just in case
umask 002
if [[ -d "$HOME/.ssh" ]]; then
    chmod 700 "$HOME/.ssh" 2> /dev/null
    chmod 600 "$HOME/.ssh/*" 2> /dev/null
fi
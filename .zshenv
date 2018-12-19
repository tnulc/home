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

umask 002

export LC_ALL="en_GB.UTF-8"
if [[ -e "/usr/share/zoneinfo/UTC" ]]; then
  export TZ=":/usr/share/zoneinfo/UTC"
else
  export TZ="UTC"
fi
export PAGER="less"
export LESS="CMifSR --tabs=4"
export LESSCHARSET="utf-8"
export EDITOR="code"
export PROJECTS="$HOME/git"
export MLR_CSV_DEFAULT_RS="lf"

skip_global_compinit=1


########################################################################
# paths
########################################################################

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"


########################################################################
# SSH fixups
########################################################################

# fix up permissions every time, just in case
if [[ -d "$HOME/.ssh" ]]; then
    chmod 700 "$HOME/.ssh" 2> /dev/null
    chmod 600 "$HOME/.ssh/*" 2> /dev/null
fi

# Changing/making/removing directory

setopt autopushd  # automatically append dirs to the push/pop list
setopt pushdignoredups # and don't duplicate them
setopt pushdsilent # pushd will not print the directory stack after each invocation
setopt pushdminus # - and + are reversed after cd
setopt pushdtohome # pushd with no parameters acts like 'pushd $HOME'
setopt autocd # change to dirs without cd
setopt cdablevars # avoid the need for an explicit $

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

# List directory contents
if $(gls &>/dev/null)
then
  alias ls="gls -AF --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la="gls -A --color"
  alias lsd="gls -l --color | grep '^d'"
fi

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'
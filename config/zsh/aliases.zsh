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
alias rd='rmdir'
alias d='dirs -v | head -10'
alias pu='pushd'
alias po='popd'

if $(which gls &>/dev/null)
then
  alias ls="gls -AF --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la="gls -A --color"
  alias lsd="gls -l --color | grep '^d'"
fi

if $(which gsort &>/dev/null)
then
  alias sort="gsort"
fi

alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'
alias brew='nocorrect brew'

alias vi='vim'

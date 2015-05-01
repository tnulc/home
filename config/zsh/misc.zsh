## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

setopt localoptions # allow functions to have local options
setopt localtraps # allow functions to have local traps
setopt ignoreeof

## jobs
setopt longlistjobs
setopt nobgnice # run bg processes at full speed
setopt nocheckjobs # don't warn me about bg processes when exiting
setopt nohup # and don't kill them, either

## pager
export PAGER="less"
export LESS="-R"

## super user alias
alias _='sudo'
alias please='sudo'

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
  export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

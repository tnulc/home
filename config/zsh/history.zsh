export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE=$ZSH_VARDIR/.zsh_history

setopt appendhistory # append to history rather than overwrite
setopt extendedhistory # save beginning and ending timestamps to the history file
setopt incappendhistory # add immediately
setopt histexpiredupsfirst # remove oldest duplicate first
setopt histignorealldups  # don't record dupes in history
setopt histreduceblanks
setopt histignorespace # do not enter command lines into the history list if they begin with a blank
setopt histverify # don't execute the line directly; perform history substitution and reload line into the editing buffer
setopt incappendhistory # add new lines incrementally
setopt sharehistory # share command history data
setopt nohistbeep

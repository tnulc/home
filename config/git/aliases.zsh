# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
if (( $+commands[hub] ))
then
  hub_path=$(which hub)
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias gp='git push origin HEAD'
alias gd='git diff'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias ga="git add -A"
alias gc='git commit'
alias gcm='git commit -m'

#!/bin/bash

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
export CLICOLOR=true

# load prompts
autoload -U promptinit && promptinit

function curent_user() {
  echo "$FG[$NCOLOR]%B%n%b$FG[255]"
}

function hostname() {
  echo "$FG[009]%M$FG[255]"
}

function current_dir() {
  echo "$FG[004]%B%c/%b$FG[255]"
}

function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "$FG[004]($FG[255]$(ref)$(parse_git_rev_list)$(parse_git_dirty)$(parse_git_staged)$(parse_git_untracked)$FG[004])$FG[255] "
}

function ref() {
  echo "$FG[011]${ref#refs/heads/}$FG[255]"
}

function parse_git_dirty() {
  local STATUS=$(command git diff --name-only --word-diff=porcelain 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then echo "$FG[009]·$FG[255]"; fi
}

function parse_git_staged() {
  local DIFF=$(command git diff --name-only --staged --word-diff=porcelain 2> /dev/null | tail -n1)
  if [[ -n $DIFF ]]; then echo "$FG[010]·$FG[255]"; fi
}

function parse_git_untracked() {
  local LS=$(command git ls-files --others --exclude-standard 2> /dev/null | tail -n1)
  if [[ -n $LS ]]; then echo "$FG[009]+$FG[255]"; fi
}

function parse_git_rev_list() {
  local LEFT_AHEAD=$(command git rev-list --count origin/master..@ 2> /dev/null)
  local RIGHT_AHEAD=$(command git rev-list --count @..origin/master 2> /dev/null)
  if [[ $LEFT_AHEAD > 0 || $RIGHT_AHEAD > 0 ]]; then echo "[$(show_number $LEFT_AHEAD 010)…$(show_number $RIGHT_AHEAD 009)]"; fi
}

function show_number() {
  if [[ $1 != 0 ]]; then echo $FG[$2]$1$FG[255]; fi
}

function virtualenv_prompt_info() {
  if [[ -n $SANDBOX_INIT_PYENV ]]; then
    local VENV=$(command echo $VIRTUAL_ENV 2> /dev/null)
    if [[ $VENV ]]; then echo "$FG[011]`basename \"$VIRTUAL_ENV\"`$FG[255] "; fi
  fi
}

function node_prompt_info() {
  if [[ -n $SANDBOX_INIT_NVM ]] && which node &> /dev/null; then
    echo "$FG[010]${$(node -v)/v}($FG[009]$(npm -v)$FG[010])$FG[255] "
  fi
}

function cursor() {
  echo "%(!.#.$)"
}

function format_time() {
  echo $1ms
}

function start_timer() {
  timer=$(($(gdate +%s%N)/1000000))
}

function timer_info() {
  if [ $timer ]; then
    now=$(($(gdate +%s%N)/1000000))
    elapsed=$(($now-$timer))
    echo "$(format_time $elapsed)"
    unset timer
  fi
}

function set_prompt() {
  PROMPT="$(curent_user)@$(hostname):$(current_dir) $(git_prompt_info)$(cursor) "
  RPROMPT="$(node_prompt_info)$(virtualenv_prompt_info)$(timer_info)"
}

preexec_functions+=(start_timer)
precmd_functions+=(set_prompt)
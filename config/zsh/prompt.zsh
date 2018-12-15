#!/bin/sh

# load prompts
autoload -U promptinit && promptinit

function curent_user() {
  echo "$FG[$NCOLOR]$FX[bold]%n$FX[reset]"
}

function hostname() {
  echo "$FG[009]%M$FX[reset]"
}

function current_dir() {
  echo "$FG[004]%c$FX[reset]/"
}

function git_prompt_info() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "($(ref)$(parse_git_rev_list)$(parse_git_dirty)$(parse_git_staged)$(parse_git_untracked)) "
}

function ref() {
  echo "$FG[011]${ref#refs/heads/}$FX[reset]"
}

function parse_git_dirty() {
  local STATUS=$(command git diff --name-only --word-diff=porcelain 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then echo "$FG[009]·$FX[reset]"; fi
}

function parse_git_staged() {
  local DIFF=$(command git diff --name-only --staged --word-diff=porcelain 2> /dev/null | tail -n1)
  if [[ -n $DIFF ]]; then echo "$FG[010]·$FX[reset]"; fi
}

function parse_git_untracked() {
  local LS=$(command git ls-files --others --exclude-standard 2> /dev/null | tail -n1)
  if [[ -n $LS ]]; then echo "$FG[009]+$FX[reset]"; fi
}

function parse_git_rev_list() {
  local LEFT_AHEAD=$(command git rev-list --count origin/master..@ 2> /dev/null)
  local RIGHT_AHEAD=$(command git rev-list --count @..origin/master 2> /dev/null)
  if [[ $LEFT_AHEAD > 0 || $RIGHT_AHEAD > 0 ]]; then echo "[$(show_number $LEFT_AHEAD 010)…$(show_number $RIGHT_AHEAD 009)]"; fi
}

function show_number() {
  if [[ $1 != 0 ]]; then echo $FG[$2]$1$FX[reset]; fi
}

function virtualenv_prompt_info() {
  if [[ -n $SANDBOX_INIT_PYENV ]]; then
    local VENV=$(command echo $VIRTUAL_ENV 2> /dev/null)
    if [[ $VENV ]]; then echo "$FG[011]$(basename $VIRTUAL_ENV)$FX[reset] "; fi
  fi
}

function node_prompt_info() {
  if [[ -n $SANDBOX_INIT_NVM ]] && which node &> /dev/null; then
    echo "$FG[010]${$(node -v)/v}($FG[009]$(npm -v)$FG[010])$FX[reset] "
  fi
}

function cursor() {
  echo "%(!.#.$)"
}

function display_time() {
  local T=$1
  local D=$((T/1000/60/60/24))
  local H=$((T/1000/60/60%24))
  local M=$((T/1000/60%60))
  local S=$((T/1000%60))
  local MS=$((T%1000))

  (( $D > 0 )) && printf "%dd " $D
  (( $H > 0 )) && printf "%dh " $H
  (( $M > 0 )) && printf "%dm " $M
  (( $S > 0 )) && printf "%ds" $S
  (( $MS > 0 )) && printf "%dms" $MS
}

function start_timer() {
  timer=$(($(gdate +%s%N)/1000000))
}

function timer_info() {
  if [ $timer ]; then
    now=$(($(gdate +%s%N)/1000000))
    elapsed=$(($now-$timer))
    echo "$(display_time $elapsed)"
    unset timer
  fi
}

function exit_status() {
  if [[ $? == 0 ]]; then echo " $FG[010]✔$FX[reset]"; fi
  if [[ $? != 0 ]]; then echo " $FG[009]✗ ($?)$FX[reset]"; fi
}

function set_prompt() {
  PROMPT="$(curent_user)@$(hostname):$(current_dir) $(git_prompt_info)$(cursor) "
  RPROMPT="$(node_prompt_info)$(virtualenv_prompt_info)$(timer_info)$(exit_status)"
}

preexec_functions+=(start_timer)
precmd_functions+=(set_prompt)
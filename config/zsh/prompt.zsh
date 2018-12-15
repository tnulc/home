#!/bin/sh
export LS_COLORS='rs=0:di=00;34:ln=00;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
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
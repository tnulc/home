#!/bin/sh

########################################################################
# interactive shell configuration
########################################################################


########################################################################
# history
########################################################################

export HISTFILE="$HOME/.history"
export HISTFILESIZE=50000000
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE


########################################################################
# zsh
########################################################################

ZSH="$HOME/.local/etc/zsh"
SHARE="$HOME/.local/share"

typeset -U cdpath

cdpath=(
  $HOME
  $HOME/git
  $cdpath
)

typeset -U fpath
fpath=(
  $ZSH/functions
  $(brew --prefix)/share/zsh/site-functions
  $SHARE/zsh/zsh-completions/src
  $fpath
)

autoload -Uz compaudit compinit
autoload -Uz bashcompinit

# Only bother with rebuilding, auditing, and compiling the compinit
# file once a whole day has passed. The -C flag bypasses both the
# check for rebuilding the dump file and the usual call to compaudit.
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(#qN.m1); do
  compinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
done
unsetopt EXTENDEDGLOB
compinit -C

[[ -s "$ZSH/opts.zsh" ]] && source "$ZSH/opts.zsh"
[[ -s "$ZSH/completion.zsh" ]] && source "$ZSH/completion.zsh"
[[ -s "$ZSH/grep.zsh" ]] && source "$ZSH/grep.zsh"
[[ -s "$ZSH/functions.zsh" ]] && source "$ZSH/functions.zsh"
[[ -s "$ZSH/bindings.zsh" ]] && source "$ZSH/bindings.zsh"
[[ -s "$ZSH/prompt.zsh" ]] && source "$ZSH/prompt.zsh"


########################################################################
# colors
########################################################################

[[ $TERM == xterm ]] && TERM=xterm-256color

export BASE16_SHELL_SET_BACKGROUND=false
BASE16_SHELL="$SHARE/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

LS_COLORS='rs=0:di=00;34:ln=00;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arc=00;31:*.arj=00;31:*.taz=00;31:*.lha=00;31:*.lz4=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.tzo=00;31:*.t7z=00;31:*.zip=00;31:*.z=00;31:*.dz=00;31:*.gz=00;31:*.lrz=00;31:*.lz=00;31:*.lzo=00;31:*.xz=00;31:*.zst=00;31:*.tzst=00;31:*.bz2=00;31:*.bz=00;31:*.tbz=00;31:*.tbz2=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.war=00;31:*.ear=00;31:*.sar=00;31:*.rar=00;31:*.alz=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.cab=00;31:*.wim=00;31:*.swm=00;31:*.dwm=00;31:*.esd=00;31:*.jpg=00;35:*.jpeg=00;35:*.mjpg=00;35:*.mjpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.webm=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS


########################################################################
# coreutils
########################################################################

[[ -d "/usr/local/opt/coreutils/libexec/gnubin" ]] && \
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

[[ -d "/usr/local/opt/coreutils/libexec/gnuman" ]] && \
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"


########################################################################
# zsh-syntax-highlighting
########################################################################

[[ -s "$SHARE/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$SHARE/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(
  main
  brackets
  pattern
  cursor
)


########################################################################
# zsh-autosuggestions
########################################################################

[[ -s "$SHARE/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$SHARE/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
ZSH_AUTOSUGGEST_USE_ASYNC=1


########################################################################
# zsh-history-substring-search
########################################################################

[[ -s "$SHARE/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" ]] && \
  source "$SHARE/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"

[[ "${terminfo[kpp]}" != "" ]] && \
  bindkey "${terminfo[kpp]}" history-substring-search-up        # [PageUp]

[[ "${terminfo[knp]}" != "" ]] && \
  bindkey "${terminfo[knp]}" history-substring-search-down      # [PageDown]

[[ "${terminfo[kcuu1]}" != "" ]] && \
  bindkey "${terminfo[kcuu1]}" history-substring-search-up      # [Up-Arrow]

[[ "${terminfo[kcud1]}" != "" ]] && \
  bindkey "${terminfo[kcud1]}" history-substring-search-down    # [Down-Arrow]


########################################################################
# extra sources
########################################################################

# aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# sandbox
source "$SHARE/sandboxd/sandboxd"
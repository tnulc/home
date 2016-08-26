# use caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_VARDIR

# use ls-colors for path completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' insert-tab pending # pasting with tabs doesn't perform completion

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_VARDIR/cache
zstyle ':completion:*' special-dirs true

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# formatting and messages
zstyle ':completion:*:default' menu select = 2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format $fg_bold[red]'No matches for: %d'
zstyle ':completion:*:descriptions' format $fg_bold[white]'%U%d%b%u'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Use 'ps -au$USER' for fetch user process list
zstyle ':completion:*:processes' command 'ps -au$USER'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:(kill|killall):*' force-list always

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# don't want known_hosts.  Just use the /.ssh/config
zstyle ':completion:*:hosts' hosts

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle '*' single-ignored show

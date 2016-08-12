# ===== Basics
setopt nobeep # don't beep on errors
setopt nolistbeep # don't on ambiguous completion
setopt interactivecomments # Allow comments even in interactive shells

# ===== Expansion and Globbing
unsetopt nomatch # no error if glob fails to expand
unsetopt flowcontrol # turn off output flow control
unsetopt menucomplete # do not autoselect the first completion entry
setopt completealiases # don't expand aliases _before_ completion has finished like: git comm-[tab]
setopt extendedglob # in order to use #, ~ and ^ for filename generation
setopt recexact # recognise exact matches even if they're ambiguous
setopt autolist # automatically list choices on an ambiguous completion
setopt listpacked # pack the lists with variable width columns
setopt autoparamkeys autoparamslash autoremoveslash # be magic about adding/removing final characters on tab completion

# ===== Changing Directories
setopt autocd # change directory without cd
setopt cdablevars # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushdignoredups # don't push multiple copies of the same directory onto the directory stack
setopt chasedots # replace ../ by the right directory
setopt autopushd  # automatically append dirs to the push/pop list
setopt pushdignoredups # and don't duplicate them
setopt pushdsilent # pushd will not print the directory stack after each invocation
setopt pushdminus # - and + are reversed after cd
setopt pushdtohome # pushd with no parameters acts like 'pushd $HOME'

# ===== History
setopt appendhistory # append to history rather than overwrite
setopt extendedhistory # save beginning and ending timestamps to the history file
setopt incappendhistory # add immediately
setopt histexpiredupsfirst # remove oldest duplicate first
setopt histignorealldups  # don't record dupes in history
setopt histignorespace # remove command line from history list when first character on the line is a space
setopt histreduceblanks #remove extra blanks from each command line being added to history
setopt histverify # don't execute the line directly; perform history substitution and reload line into the editing buffer
setopt sharehistory # share command history data
setopt nohistbeep # don't beep for erroneous history expansions

# ===== Completion
setopt alwaystoend # when completing from the middle of a word, move the cursor to the end of the word
setopt automenu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt autonamedirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt completeinword # allow completion from within a word/phrase

# ===== Correction
unsetopt correctall # spelling correction for arguments
setopt correct # spelling correction for commands

# ===== Prompt
setopt promptsubst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt

# ===== Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted
setopt localoptions # allow functions to have local options
setopt localtraps # allow functions to have local traps
setopt ignoreeof # ignore EOF

# ===== Jobs
setopt longlistjobs # list jobs in long format
setopt nobgnice # run bg processes at full speed
setopt nocheckjobs # don't warn me about bg processes when exiting
setopt nohup # and don't kill them, either

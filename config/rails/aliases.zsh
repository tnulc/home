# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/rails/rails.plugin.zsh

alias rails="_rails_command"
alias rake="_rake_command"

alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

alias rc='rails console'
alias rcs='rails console --sandbox'
alias rd='rails destroy'
alias rdb='rails dbconsole'
alias rg='rails generate'
alias rgm='rails generate migration'
alias rp='rails plugin'
alias ru='rails runner'
alias rs='rails server'
alias rsd='rails server --debugger'
alias rsp='rails server --port'

alias rdm='rails db:migrate'
alias rdms='rails db:migrate:status'
alias rdr='rails db:rollback'
alias rdc='rails db:create'
alias rds='rails db:seed'
alias rdd='rails db:drop'
alias rdrs='rails db:reset'
alias rdtc='rails db:test:clone'
alias rdtp='rails db:test:prepare'
alias rdmtc='rails db:migrate db:test:clone'
alias rdsl='rails db:schema:load'
alias rlc='rails log:clear'
alias rn='rails notes'
alias rr='rails routes'
alias rrg='rails routes | grep'
alias rt='rails test'
alias rmd='rails middleware'
alias rsts='rails stats'

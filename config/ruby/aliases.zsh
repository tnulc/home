alias -g bi="bundle install --path=vendor"
alias -g be="bundle exec"
# alias -g rake="noglob bundle exec rake"
alias -g rs="bundle exec rails s"
alias -g rsp="bundle exec rspec"

alias -g flog="find app -name \*.rb | xargs flog"

alias rt="rake"

rtt() { rake TEST=$1 }
rttt() { rake TESTOPTS="--name=$1" }

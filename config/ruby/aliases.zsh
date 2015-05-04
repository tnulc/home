alias -g bi="bundle install --path=vendor"
alias -g be="bundle exec"
alias -g rake="noglob be rake"
alias -g rs="be rails s"
alias -g rsp="be rspec"

alias -g flog="find app -name \*.rb | xargs flog"
alias -g coverage="open -a \"Google Chrome\" coverage/index.html"
alias -g all="be rake && flog && rubocop -a"

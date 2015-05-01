alias bi="bundle install --path=vendor"
alias be="bundle exec"
alias rake="noglob be rake"
alias rs="be rails s"
alias rsp="be rspec"

alias flog="find app -name \*.rb | xargs flog"
alias coverage="open -a \"Google Chrome\" coverage/index.html"
alias all="be rake && flog && rubocop -a"

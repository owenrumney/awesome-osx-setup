export GOPATH='/home/ullaakut/Work/go'

# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

alias ne 'emacs -nw'
alias sne 'sudo emacs -nw'

alias make 'colormake'

alias ls 'ls --color -h'
alias ll 'ls -lah'
alias l 'ls -lah'

alias apt-get 'sudo apt-get'
alias update 'sudo apt-get update ; sudo apt-get upgrade'

alias diff 'colordiff'

alias h 'history'
alias j 'jobs -l'

alias ports 'netstat -tulanp'
alias ipt 'sudo /sbin/iptables'
alias iptlist 'sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin 'sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout 'sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw 'sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall iptlist

# Docker compose
alias dcps 'docker-compose ps'
alias dcl 'docker-compose logs -f'
alias dcup 'docker-compose up -d'
alias dcstop 'docker-compose stop'
alias dcrm 'docker-compose rm'
alias dcexec 'docker-compose exec'
alias dcb 'docker-compose build'

# Git stuff
alias gc 'git commit -m'
alias gs 'git status'
alias ga 'git add'
alias gps 'git push'
alias gpl 'git pull'
alias greb 'git rebase -i'
alias gcheck 'git checkout'
alias glog 'git log'
alias gdif 'git diff'

alias root 'sudo -i'
alias su 'sudo -i'
alias go 'grc go'

alias wget 'wget -c'

alias diff 'grc diff'
alias docker 'grc docker'
alias gcc 'grc gcc'
alias go 'grc go'
alias ifconfig 'grc ifconfig'
alias netstat 'grc netstat'
alias ping 'grc ping'
alias ps 'grc ps'

alias dstat 'dstat -cdngyt'
alias ngrep 'ngrep -d any'

alias node 'nodejs'

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/ullaakut/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set --erase fish_greeting

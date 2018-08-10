export GOPATH='/Users/ullaakut/Work/go'
set PATH $PATH $GOPATH/bin/

# Colorized outputs
alias ls 'grc ls -laF'
alias diff 'grc diff'
alias docker 'grc docker'
alias gcc 'grc gcc'
alias go 'grc go'
alias ifconfig 'grc ifconfig'
alias netstat 'grc netstat'
alias ping 'grc ping'
alias ps 'grc ps'

alias h 'history'
alias j 'jobs -l'

# Docker compose
alias dcps 'docker-compose ps'
alias dcl 'docker-compose logs -f'
alias dcup 'docker-compose up -d'
alias dcstop 'docker-compose stop'
alias dcrm 'docker-compose rm'
alias dcexec 'docker-compose exec'
alias dcb 'docker-compose build'
alias dcrestart 'docker-compose restart'
alias dcpause 'docker-compose pause'

# Dedicated servers
alias connectJooboo="ssh 5.135.158.2"
alias connectBoojoo="ssh 5.135.158.40"
alias updateJooboo="ssh 5.135.158.2 \"cd /usr/share/nginx/html && git pull\""
alias updateBoojoo="ssh 5.135.159.40 \"cd /usr/share/nginx/html && git pull\""

# Git stuff
alias gc 'git commit -m'
alias gs 'git status'
alias ga 'git add'
alias gps 'git push'
alias gcheck '/Users/ullaakut/utils/gcheck'
alias glog 'git log'
alias gdif 'git diff'

# Audio notifications
alias success 'say -v "Anna" "Prozess isten terminatet zucksesfully"'
alias failure 'say -v "Anna" "Redden alert, kritikal error heinst been detected"'

alias w 'cd /Users/ullaakut/Work'

# Logbook
function lb --description "Open my logbook of the day"
    if not test -e ~/logbook/(date '+%Y-%m-%d').md
        echo '# Logbook' > ~/logbook/(date '+%Y-%m-%d').md
    end
    code ~/logbook/(date '+%Y-%m-%d').md
end

# Make wget continue unfinished downloads
alias wget 'wget -c'

set fish_greeting ""

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ullaakut/Downloads/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/ullaakut/Downloads/google-cloud-sdk/path.fish.inc'; else; . '/Users/ullaakut/Downloads/google-cloud-sdk/path.fish.inc'; end; end

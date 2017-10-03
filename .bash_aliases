#!/bin/bash
# ~/.bash_aliases: executed by ~/.bashrc

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias rm='rm -i'
alias dinauz='ssh -t dinauz screen -r'
alias dinauzrd='ssh -t dinauz screen -rd'
alias dinauzx='ssh -t dinauz screen -x'
alias pidgin='ssh -t criteo screen -r pidgin'
alias pidginrd='ssh -t criteo screen -rd pidgin'
alias pidginx='ssh -t criteo screen -x pidgin'
alias chromium='chromium --auth-server-whitelist="*.hpc.criteo.prod,*.hpc.criteo.preprod"'
alias scrot='scrot "%Y-%m-%d_%H%M%S_\$wx\$h_scrot.png" -e "mv \$f ~/screenshots/"'

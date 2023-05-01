# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1="\[$(tput bold)\]\[$(tput setaf 3)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 5)\]\h:\[$(tput setaf 2)\]\w\[$(tput setaf 4)\] \\$\[$(tput sgr0)\] "

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"


# User-wide .bashrc file for interactive bash(1) shells.
# system
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:`basename $PWD`\007"'

# iterm terminal
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTIMEFORMAT="%m-%d %T "

# terminal color schema
export TERM=xterm-256color

# brew
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# python ide
export PYTHONIOENCODING=UTF-8

# node, npm
export NODE_PATH=/usr/local/lib/node_modules

# alias
alias ll='ls -alh'
alias grep='grep --color=auto'

# maven
export MAVEN_OPTS="-Xmx256m ”


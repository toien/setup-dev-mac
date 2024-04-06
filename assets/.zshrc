# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fnm
    docker
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


function set_proxy {
    local ip;
    ip=$(ipconfig getifaddr en0)

    local proxy;
    proxy="http://$ip:19826"

    export HTTP_PROXY=$proxy
    export http_proxy=$proxy
    export HTTPS_PROXY=$proxy
    export ALL_PROXY=$proxy
    # env will bypass to minikube
    export NO_PROXY=localhost,127.0.0.1,::1,192.168.50.0/24,10.44.0.0/23,10.96.0.0/12,192.168.49.0/24
}

function no_proxy {
    unset HTTP_PROXY http_proxy HTTPS_PROXY ALL_PROXY NO_PROXY
}

function show_proxy {
    env | grep -v CLASSPATH | grep -i proxy
}

export SETUP_HOME="$HOME/github/setup-dev-mac"

function test_proxy {
    local provider=$1

    if [ -z "$provider" ]; then
        bash $SETUP_HOME/assets/test-ss.sh
        bash $SETUP_HOME/assets/test-mj.sh
    else
        bash $SETUP_HOME/assets/test-$provider.sh
    fi
}


# FNM envs
eval "$(fnm env --use-on-cd)"

alias t='tmux'
alias tkub='kubectl --kubeconfig ~/.kube/config.a -n a'
alias ykub='kubectl --kubeconfig ~/.kube/config.b -n b'
alias ckub='kubectl --kubeconfig ~/.kube/config.c -n c'

# disable history share between sessions
unsetopt inc_append_history
unsetopt share_history

# auto complete with ssh hosts
zstyle ':completion:*:ssh:*' hosts

# fix display hidden cursor
alias cursor='tput cvvis; tput cnorm'

# auto load zsh completions
autoload -U compinit; compinit

# remove duplicate entries in $PATH
typeset -aU path

# ^U: delete from current position to begining of line
bindkey \^U backward-kill-line


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Pyenv Virtual env
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Go multi version
go17() {
    export PATH="/opt/homebrew/Cellar/go@1.17/1.17.13/bin:$PATH"
    typeset -aU path
}

go20() {
    export PATH="/opt/homebrew/Cellar/go/1.20.3/bin:$PATH"
    typeset -aU path
}

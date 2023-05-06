## iTerm2

- Settings -> Profiles -> Keys -> Load preset: Natual Text Editing

## Shell

### install ohmyzsh

### customize

`.zshrc`: 

```zsh
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
```

## Tmux

[~/.tmux.conf](../assets/.tmux.conf)

### plugin manager

[Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

## Homebrew

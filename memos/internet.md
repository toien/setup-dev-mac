## You know

### `.zshrc`

```zsh
# enable proxy
function setproxy {
    export HTTP_PROXY=socks5://127.0.0.1:1080
    export HTTPS_PROXY=socks5://127.0.0.1:1080
}

# disable proxy
function noproxy {
    unset HTTP_PROXY HTTPS_PROXY
}
```

### ssh proxy

`~/.ssh/config`

```
# Host *
#   ControlMaster auto
#   ControlPath ~/.ssh/ssh_mux_%h_%p_%r

Host *
    SendEnv LANG LC_*

Host github.com
    HostName github.com
    User git
    ProxyCommand nc -v -x 127.0.0.1:1080 %h %p
```
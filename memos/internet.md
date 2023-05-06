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
# Reuse connection
# Host *
#   ControlMaster auto
#   ControlPath ~/.ssh/ssh_mux_%h_%p_%r

Host *
    SendEnv LANG LC_*

# Use proxy when access github
Host github.com
    HostName github.com
    User git
    ProxyCommand nc -v -x 127.0.0.1:1080 %h %p
```

Refer: [给 Git 设置代理](https://toien.github.io/2019/07/16/using-git-with-proxy/)

## GoLang

### install

by homebrew

### multiple versions

[.zshrc](../assets/.zshrc): 

```zsh
# switch go version functions, by change env
go17() {
    export PATH="/opt/homebrew/Cellar/go@1.17/1.17.13/bin:$PATH"
    typeset -aU path
}

go20() {
    export PATH="/opt/homebrew/Cellar/go/1.20.3/bin:$PATH"
    typeset -aU path
}
```


### Shell

```
# zsh
ln -sf `pwd`/.zshrc ~/.zshrc

# bash
ln -sf `pwd`/.bash_profile ~/.bash_profile
```

### Git

`./git-setup`

### Tmux

```
# OSX: brew install tmux
ln -sf `pwd`/.tmux.conf ~/.tmux.conf
```

Refs:

- <https://www.youtube.com/watch?v=wKEGA8oEWXw>

### Hammerspoon

```
# OSX: brew install hammerspoon --cask
mkdir -p ~/.hammerspoon
ln -sf `pwd`/init.lua ~/.hammerspoon/init.lua
```

Refs:

- <https://github.com/fikovnik/ShiftIt/wiki/The-Hammerspoon-Alternative>

### SSH

`ssh-config-init.sh` 按需修改

```
cd ~/.ssh
mkdir sockets

cat >> ~/.ssh/config << 'EOF'
# SSH 连接保持及重用
Host *
ControlMaster auto
ControlPath ~/.ssh/sockets/master-%r%@h:%p
ControlPersist 600
ServerAliveInterval 50

# $ ssh dev
Host dev
User admin
# HostName <server-host>
UserKnownHostsFile /dev/null
StrictHostKeyChecking no
EOF
```

### Procs

```
# OSX: brew install procs
ln -sf `pwd`/.procs.toml ~/.procs.toml
```

### MyCLI

```
# Enable auto-refresh
ln -sf `pwd`/.my.cnf ~/.my.cnf

# Using mycli: https://github.com/dbcli/mycli
# OSX: brew install mycli
# pip install -U mycli
# sudo apt-get install mycli # Only on debian or ubuntu
```

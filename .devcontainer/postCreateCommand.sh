#!/usr/bin/env zsh
# Checkout devcontainer lifecycle for details

set -ex

# Brew formula
brew install \
   vim tmux autojump tree jq pstree htop fzf watch \
   bat cloc axel diff-so-fancy tldr dog ripgrep universal-ctags httpie

# Install vim-plug & plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Install oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# Customize git config
wget https://github.com/yaohui-wyh/dotfiles/raw/master/script/git-setup.sh -O - | sh 
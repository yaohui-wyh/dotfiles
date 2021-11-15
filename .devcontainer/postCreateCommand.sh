#!/usr/bin/env zsh
# Checkout devcontainer lifecycle for details

# Brew formula
brew install \
   vim tmux autojump tree jq pstree htop fzf watch \
   bat cloc axel diff-so-fancy tldr dog ripgrep universal-ctags httpie netcat gnu-sed

# Install vim-plug & plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Customize git config
wget https://github.com/yaohui-wyh/dotfiles/raw/master/script/git-setup.sh -O - | sh

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
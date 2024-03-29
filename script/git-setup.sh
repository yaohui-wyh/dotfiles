# Alias
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.sh stash
git config --global alias.pp 'pull --rebase'
git config --global alias.ll 'log --graph --date=short --pretty=format:"\%x1b[31m\%h\%x09\%x1b[32m\%d\%x1b[0m\%x20\%ad\%x1b[33m\%x20\%an\%x1b[0m\%x20\%s"'

# Set pager as less
git config --global core.pager 'less -r'

# Set editor and merge tool
git config --global core.editor vim
git config --global merge.tool meld

# Set output color
git config --global color.ui true

# Global gitignore file
echo '*.~' > ~/.gitignore
echo '*.swp' >> ~/.gitignore
echo '*.swa' >> ~/.gitignore
echo '.DS_Store' >> ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# brew install diff-so-fancy
# Configure git to use diff-so-fancy for all diff output:
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
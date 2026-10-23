# dotfiles

Restore on a new Ubuntu machine:
```
git clone git@github.com:xachdev/dotfiles.git ~/dotfiles
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
source ~/.bashrc
```
Never commit `~/ssh`, tokens, or passwords.

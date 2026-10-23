# dotfiles

Restore on a new Ubuntu machine:
```
git clone git@github.com:xachdev/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```
The script backs up any existing .bashrc, .gitconfig, .nanorc and .tmux.conf, then symlinks the ones from this repo.

Never commit `~/ssh`, tokens, or passwords.

# dotfiles

Restore on a new Ubuntu machine:
```
git clone git@github.com:xachdev/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```
The script backs up any existing .bashrc, .gitconfig, .nanorc, .tmux.conf, .gitignore_global, .vimrc and .inputrc, then symlinks the ones from this repo.

Never commit `~/ssh`, tokens, or passwords.

On a fresh machine, `~/dotfiles/bootstrap.sh` installs the packages.txt, then links everything.

## Commands

- `dotsync "msg"`: commit and push changes
- `dotpull`: pull the latest and relink
- `dotcheck`: verify the symlinks
- `make bootstrap`: set up a fresh machine

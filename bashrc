export PATH="$HOME/.local/bin:$PATH"
source <(proot-apps completion bash)
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

alias ll='ls -alFh'
alias gs='git status'
alias gl='git log --oneline --graph --decorate -20'
alias gc='git commit'
alias ..='cd ..'
alias update='sudo apt update && sudo apt upgrade -y'

parse_branch() { git branch 2>/dev/null | sed -n 's/^\* //p'; }
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\] $(parse_branch)\[\e[0m\]\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

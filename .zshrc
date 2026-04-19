
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/zed.app/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin
export PATH="$HOME/bin:$PATH"
PROMPT="%n@%m %~ ➜ "
ZSH_THEME="clean"
y() {
  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      yazi "$1"
    else
      yazi "$(zoxide query $1)"
    fi
  else
    yazi
  fi
    return $?
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions fzf)

source $ZSH/oh-my-zsh.sh

alias vim='nvim'
alias zedf='zed $(fzf --preview "batcat --color=always {}")'
alias f="fzf --preview 'bat --color=always {}'"
alias zedd='zed "/home/{username}/$(fdfind --type f -F --follow --base-directory /home/{username} | fzf)"'
alias ff="fdfind . / --type f 2>/dev/null | fzf --preview 'bat --color=always {}'"
alias fg='rg --no-heading --line-number --color=always "" . 2>/dev/null | fzf -e --ansi --delimiter ":" --preview "bat --color=always {1}" --preview-window=up:70% --bind "enter:execute(zed {1})"'
alias deploy='~/deploy.sh'
alias ex='exa --tree --level=3'

alias td='tmux detach'
alias ta='tmux a -t '
alias tl='tmux ls'
alias tc='tmux new-session -s '
alias tkill="tmux kill-server"
alias lbr="libreoffice"
alias c='clear'
alias ch='bat --line-range :50 ~/cheatsheet.md'
alias ch100='bat --line-range 50:100 ~/cheatsheet.md'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH=$PATH:$(go env GOPATH)/bin
eval "$(zoxide init zsh)"

export PATH="$HOME/.local/bin:$PATH"

eval $(thefuck --alias)

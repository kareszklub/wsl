# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # this has to be before zsh-history-substring-search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# prompt
eval "$(starship init zsh)"

# aliases
alias c="clear"
alias v="vim"
alias r="ranger"
alias rr="omz reload"

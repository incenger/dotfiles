# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    tmux
    vi-mode
    fzf

    # 3party plugins
    zsh-syntax-highlighting
    colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Forgit
export FORGIT_LOG_GRAPH_ENABLE=true
export FORGIT_FZF_DEFAULT_OPTS="--exact
--border
--cycle
--reverse
--height '80%'
"
source $HOME/.local/forgit/forgit.plugin.zsh


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

# Common aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias tmuxrc="nvim ~/.tmux.conf"
alias nv="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

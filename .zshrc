# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Download zoxide, if it's not there yet
if ! command -v zoxide 2>&1 >/dev/null
then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# Download fzf, if it's not there yet
if ! command -v fzf 2>&1 >/dev/null
then
  sudo apt install fzf
fi

# Download ripgrep, if it's not there yet
if ! command -v rg 2>&1 >/dev/null
then
  sudo apt install ripgrep
fi


# Export environment variables
export LC_ALL='en_US.UTF-8'
export TERM='xterm-256color'
export COLORTERM="truecolor"

export PATH='/home/ani/.local/bin':$PATH

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Source/Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/omp.toml)"

# Keybindings
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
set -o vi

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character
zstyle ':completion:*' use-compctl false

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/usr/local/cuda-12.6/bin"


if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Attempt to detect WSL
if [[ $(uname -r) =~ "microsoft" ]]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    export GIT_CONFIG_GLOBAL="$HOME/.gitconfig"
    alias ssh='ssh.exe'
    alias ssh-add='ssh-add.exe'
else
    export GIT_CONFIG_GLOBAL="$HOME/.config/git/gitconfig"
    fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Add ~/bin to PATH
if [ -d "${HOME}/bin" ]; then
    export PATH="${PATH}:${HOME}/bin"
fi

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.json)"
fi

# Keybindings
bindkey -e
#bindkey '^p' history-search-backward
#bindkey '^n' history-search-forward
#bindkey '^[w' kill-region

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

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'


# User configuration
# Alias vim and vi to nvim
if [ -f "$(which nvim)" ]; then
    alias vim="nvim"
    alias vi="nvim"
    alias vimdiff='nvim -d'
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# google-cloud-sdk
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then
    source "${HOME}/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then
    source "${HOME}/google-cloud-sdk/completion.zsh.inc"
fi

# Add ~/bin to PATH
if [ -d "${HOME}/local/bin" ]; then
    export PATH="${PATH}:${HOME}/local/bin"
fi

if [ -d "${HOME}/go/bin/" ]; then
    export PATH="${HOME}/go/bin:${PATH}"
fi

# fnm
FNM_PATH="/home/haaja/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/haaja/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd)"
fi

# If fnm exists
if [ -f "$(which fnm)" ]; then
    eval "$(fnm env --use-on-cd)"
fi

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

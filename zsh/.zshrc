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
    export GIT_CONFIG_GLOBAL="$HOME/.gitconfig"
    alias ssh='ssh.exe'
    alias ssh-add='ssh-add.exe'
else
    export GIT_CONFIG_GLOBAL="$HOME/.config/git/gitconfig"
    fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Add ~/bin to PATH
if [ -d "${HOME}/local/bin" ]; then
    export PATH="${HOME}/local/bin:${PATH}"
fi
if [ -d "${HOME}/bin" ]; then
    export PATH="${HOME}/bin:${PATH}"
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
HISTSIZE=15000
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
alias c='clear'

# Alias vim and vi to nvim
if command -v nvim &>/dev/null; then
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

if [ -d "${HOME}/go/bin/" ]; then
    export PATH="${HOME}/go/bin:${PATH}"
fi

# fnm
FNM_PATH="${HOME}/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd)"
fi


# Podman
export PODMAN_COMPOSE_WARNING_LOGS=false

# Build flags (macOS/Homebrew)
if [[ -d "/opt/homebrew/opt/libffi" ]]; then
    export LDFLAGS="-L/opt/homebrew/opt/libffi/lib -L/usr/local/opt/openssl/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libffi/include -I/usr/local/opt/openssl/include"
fi

if [ -d "${HOME}/.cargo/bin" ]; then
    export PATH="${HOME}/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.antigravity/antigravity/bin" ]; then
    export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi


export PATH="$HOME/.local/bin:$PATH"


# lean-ctx shell hook — transparent CLI compression (90+ patterns)
if [[ -x "$HOME/.cargo/bin/lean-ctx" ]]; then
    _lean_ctx_cmds=(git npm pnpm yarn cargo docker docker-compose kubectl gh pip pip3 ruff go golangci-lint eslint prettier tsc ls find grep curl wget php composer)

    _lc() {
        if [ -n "${LEAN_CTX_DISABLED:-}" ] || [ ! -t 1 ]; then
            command "$@"
            return
        fi
        "$HOME/.cargo/bin/lean-ctx" -c "$@"
        local _lc_rc=$?
        if [ "$_lc_rc" -eq 127 ] || [ "$_lc_rc" -eq 126 ]; then
            command "$@"
        else
            return "$_lc_rc"
        fi
    }

    lean-ctx-on() {
        for _lc_cmd in "${_lean_ctx_cmds[@]}"; do
            # shellcheck disable=SC2139
            alias "$_lc_cmd"='_lc '"$_lc_cmd"
        done
        alias k='_lc kubectl'
        export LEAN_CTX_ENABLED=1
        echo "lean-ctx: ON"
    }

    lean-ctx-off() {
        for _lc_cmd in "${_lean_ctx_cmds[@]}"; do
            unalias "$_lc_cmd" 2>/dev/null || true
        done
        unalias k 2>/dev/null || true
        unset LEAN_CTX_ENABLED
        echo "lean-ctx: OFF"
    }

    lean-ctx-raw() {
        LEAN_CTX_RAW=1 command "$@"
    }

    lean-ctx-status() {
        if [ -n "${LEAN_CTX_DISABLED:-}" ]; then
            echo "lean-ctx: DISABLED (LEAN_CTX_DISABLED is set)"
        elif [ -n "${LEAN_CTX_ENABLED:-}" ]; then
            echo "lean-ctx: ON"
        else
            echo "lean-ctx: OFF"
        fi
    }

    if [ -z "${LEAN_CTX_ACTIVE:-}" ] && [ -z "${LEAN_CTX_DISABLED:-}" ] && [ "${LEAN_CTX_ENABLED:-1}" != "0" ]; then
        lean-ctx-on
    fi
fi
# lean-ctx shell hook — end

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

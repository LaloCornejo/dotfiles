# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ---- FZF -----

# Lazy load fzf
fzf_load() {
  # Remove this function from the autoloads
  unfunction "$0"
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"
  # Load additional FZF configurations
  source ~/fzf-git.sh/fzf-git.sh
  # Run the command that invoked this function
  "$@"
}

# Create stub functions for fzf commands
for cmd in fzf fzf-tmux; do
  eval "function $cmd() { fzf_load $cmd \"\$@\" }"
done

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# ---- Eza (better ls) -----

alias ls="eza --color=always --long --git --icons=always"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Lazy load for thefuck
fuck() {
  unfunction "$0"
  eval $(thefuck --alias)
  eval $(thefuck --alias fk)
  $0 "$@"
}

# ---- Zoxide (better cd) ----
# Lazy load zoxide
z() {
  unfunction "$0"
  eval "$(zoxide init zsh)"
  $0 "$@"
}

alias cd="z"

# Golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

# Update PATH to include GOPATH and GOROOT binaries
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

alias nxdw="z /Users/lalocornejo/.dotfiles/nix-darwin/"

# Lazy load zsh-autosuggestions
zsh_autosuggestions_load() {
  source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd zsh_autosuggestions_load

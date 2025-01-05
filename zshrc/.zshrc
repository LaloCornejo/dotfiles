# Enable Powerlevel10k instant prompt

# Load instant prompt if available
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Load Powerlevel10k configuration if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh 

# Aliases for convenience
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.dotfiles/zshrc/.zshrc"
alias lg="lazygti"
alias nxdw="z /Users/lalocornejo/.dotfiles/nix-darwin/"
alias ls="eza --color=always --long --git --icons=always --sort=size --group-directories-first --time-style=long-iso"
alias cd="z"

# History setup
HISTFILE=~/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# Theme and plugins
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions)

# Load Oh My Zsh and plugins
source $ZSH/oh-my-zsh.sh

# Editor setup based on SSH connection
export EDITOR=${SSH_CONNECTION:+vim} || nvim

# FZF setup
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Lazy load for The Fuck and Zoxide
fuck() {
  unfunction "$0"
  eval $(thefuck --alias)
  eval $(thefuck --alias fk)
  $0 "$@"
}

z() {
  unfunction "$0"
  eval "$(zoxide init zsh)"
  $0 "$@"
}

# Ranger function for navigation
function ranger {
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  command ranger --cmd="map Q chain shell echo %d > \"$tempfile\"; quitall" "$@"
  
  if [[ -f "$tempfile" && "$(cat "$tempfile")" != "$(pwd)" ]]; then
    cd "$(cat "$tempfile")" || return
  fi
  
  command rm -f "$tempfile" 2>/dev/null
}
alias rr='ranger'

# Navigation shortcuts
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && ls; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy; }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)"; }

# Stow alias for dotfiles management
alias stow="stow --dir=$HOME/.dotfiles --target=$HOME/.config"

# Taskwarrior sync check to avoid unnecessary syncs
if [[ ! -f ~/tmp/.task_last_run || "$(date -r ~/tmp/.task_last_run +%Y%m%d)" != "$(date +%Y%m%d)" ]]; then
  task sync > /dev/null &
  task list
  touch ~/tmp/.task_last_run
fi

# Homebrew update check to avoid unnecessary updates
if [[ ! -f ~/.dotfiles/brew-list.txt || "$(date -r ~/.dotfiles/brew-list.txt +%Y%m%d)" != "$(date +%Y%m%d)" ]]; then
  (brew update > /dev/null && brew upgrade > /dev/null && brew cleanup > /dev/null) &
  brew list > ~/.dotfiles/brew-list.txt
fi

# Source Zsh autosuggestions and syntax highlighting if available
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh &>/dev/null &
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>/dev/null &

# Key bindings for autosuggestions and navigation enhancements
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# Add Cargo bin directory to PATH for Rust tools
export PATH="$HOME/.cargo/bin:$PATH"

# Twitch streaming function using Streamlink with ad disable option 
twitch() {
  streamlink --twitch-disable-ads twitch.tv/$1 best &
}


# Enable Powerlevel10k instant prompt
# Load instant prompt if available
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set Powerlevel10k instant prompt to quiet to suppress warnings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Load Powerlevel10k configuration if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh 

# Aliases for convenience
alias ls="eza --color=always --long --git --icons=always --sort=size --group-directories-first --time-style=long-iso"
alias zsh="source ~/.zshrc"
alias ezsh="nvim ~/.dotfiles/zshrc/.zshrc"
alias lg="lazygit"
alias cd="z"
alias yy="yazi"
alias st="speedtest"
alias c="clear"
alias l="ls"
alias v="nvim"
alias q="exit"
alias t="twitch"
alias mysql="/usr/local/mysql/bin/mysql -u root -p"
alias mampsql="/Applications/MAMP/Library/bin/mysql80/bin/mysql -u root -p"

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
function fuck {
  unfunction "$0"
  eval $(thefuck --alias)
  eval $(thefuck --alias fk)
  $0 "$@"
}

function z {
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
cx() { z "$@" && l; }
fcd() { z "$(find . -type d -not -path '*/.*' | fzf)" && ls; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy; }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)"; }

# Stow alias for dotfiles management
alias stow="stow --dir=$HOME/.dotfiles --target=$HOME/.config"

# Taskwarrior sync check to avoid unnecessary syncs
if [[ ! -f ~/tmp/.task_last_run || "$(date -r ~/tmp/.task_last_run +%Y%m%d)" != "$(date +%Y%m%d)" ]]; then
  # task sync > /dev/null 2>&1 &
  task list > /dev/null 2>&1 # Suppress output here as well.
  touch ~/tmp/.task_last_run
fi

# Homebrew update check to avoid unnecessary updates
if [[ ! -f ~/.dotfiles/brew-list.txt || "$(date -r ~/.dotfiles/brew-list.txt +%Y%m%d)" != "$(date +%Y%m%d)" ]]; then
  (brew update > /dev/null 2>&1 && brew upgrade > /dev/null 2>&1 && brew cleanup > /dev/null 2>&1 &
   brew list > ~/.dotfiles/brew-list.txt)
fi

# Source Zsh autosuggestions and syntax highlighting if available
if [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Key bindings for autosuggestions and navigation enhancements
bindkey '^l' autosuggest-accept
bindkey '^w' autosuggest-execute
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# Add Cargo bin directory to PATH for Rust tools 
export PATH="$HOME/.cargo/bin:$PATH"

# --- GO ---
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

# Update PATH to include GOPATH and GOROOT binaries 
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

# Twitch streaming function using Streamlink with ad disable option 
twitch() {
  if [[ -z "$1" ]]; then
    echo "Usage: twitch <channel>"
    return 1
  fi

  local quality="${2:-720p60}"
  
  streamlink --twitch-disable-ads --twitch-low-latency twitch.tv/$1 $quality > /dev/null 2>&1 &
}

# --- Obsidian ---
obsidian_base="'/Users/lalocornejo/Library/Mobile Documents/iCloud~md~obsidian/Documents/OwO '"

# bun completions
[ -s "/Users/lalocornejo/.bun/_bun" ] && source "/Users/lalocornejo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$PATH:/Applications/microchip/xc8/v3.00/bin"

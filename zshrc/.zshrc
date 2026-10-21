# Zsh configuration — keep API keys and other secrets out of this file.

# --- Paths and editor ---------------------------------------------------------

# `path` is zsh's list version of PATH. -U keeps entries unique on reload.
typeset -U path PATH
path=(
  "$HOME/.devcontainers/bin"
  "$HOME/.opencode/bin"
  "$HOME/.local/bin"
  "$HOME/.fzf/bin"
  /usr/lib/ccache
  $path
  /snap/bin
)
if [[ -r "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

export EDITOR=nvim
export VISUAL=nvim

# --- History ------------------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY      # Save timestamps with commands
setopt SHARE_HISTORY         # Share history between terminals
setopt HIST_IGNORE_SPACE     # Don't save commands starting with a space
setopt HIST_IGNORE_ALL_DUPS   # Keep only the latest occurrence of a command
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate commands to disk
setopt HIST_REDUCE_BLANKS     # Remove unnecessary whitespace

# --- Navigation and completion ------------------------------------------------

setopt AUTO_CD               # Enter a directory by typing its path
setopt INTERACTIVE_COMMENTS  # Allow # comments at the command line

# Ubuntu may already have initialized completion in /etc/zsh/zshrc.
autoload -Uz compinit
if ! typeset -f compdef > /dev/null; then
  compinit
fi
zmodload zsh/complist

zstyle ':completion:*' menu select
# Match lowercase input against uppercase names too.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# --- Keybindings --------------------------------------------------------------

# Escape enters vi command mode; i returns to insert mode.
bindkey -v
KEYTIMEOUT=10  # Wait 0.1 seconds after Escape
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^R' history-incremental-search-backward

# --- Colors and prompt --------------------------------------------------------

if command -v dircolors > /dev/null; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# Refresh the Git branch before each prompt.
autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'

_zsh_update_vcs() {
  vcs_info
}
add-zsh-hook precmd _zsh_update_vcs

setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f '             # User and hostname
PROMPT+='%F{blue}%~%f'                 # Current directory
PROMPT+='%F{yellow}${vcs_info_msg_0_}%f ' # Git branch
PROMPT+='%(?.%F{green}.%F{red})%#%f '  # Red prompt if the last command failed

# --- Aliases ------------------------------------------------------------------

# Files
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -l'
alias grep='grep --color=auto'

# Directories
alias ..='cd ..'
alias ...='cd ../..'

# Neovim
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

# --- Development environment --------------------------------------------------

# Add the local pkg-config directory only if it isn't already present.
case ":$PKG_CONFIG_PATH:" in
  *:/usr/local/lib/pkgconfig:*) ;;
  *) export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+$PKG_CONFIG_PATH:}/usr/local/lib/pkgconfig" ;;
esac

# ROS and camera settings
export ROS_DOMAIN_ID=27
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export DATASETS_DIR=/media/luka/SSD_2TB/
export SPINNAKER_GENTL64_CTI=/opt/ros/jazzy/lib/spinnaker-gentl/Spinnaker_GenTL.cti
# To load ROS automatically, uncomment its zsh setup (not setup.bash):
# [[ -r /opt/ros/jazzy/setup.zsh ]] && source /opt/ros/jazzy/setup.zsh

# --- Conda --------------------------------------------------------------------

# Use the zsh hook, with fallbacks if initialization fails.
if [[ -x "$HOME/miniconda3/bin/conda" ]]; then
  if __conda_setup="$("$HOME/miniconda3/bin/conda" shell.zsh hook 2>/dev/null)"; then
    eval "$__conda_setup"
  elif [[ -r "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
  else
    path=( "$HOME/miniconda3/bin" $path )
  fi
  unset __conda_setup
fi

# --- Shell tools --------------------------------------------------------------

# fzf: Ctrl-R searches history; Ctrl-T searches files.
if command -v fzf > /dev/null; then
  source <(fzf --zsh)
fi

# zoxide: use `z name` to jump to a frequently visited directory.
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# --- Optional plugins ---------------------------------------------------------

# Loaded only if installed through the system package manager.
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax highlighting should be loaded last.
if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

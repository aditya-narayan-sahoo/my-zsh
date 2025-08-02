# --- Completion Configuration ---
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-.]=** r:|=**'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/ans/.zshrc'

autoload -Uz compinit
compinit

if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    fastfetch
fi

# --- History Configuration ---
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# --- Basic Options ---
setopt autocd
bindkey -e

# --- Key Bindings ---
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word
bindkey "^H" backward-delete-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^Z" undo
bindkey "^Y" redo
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# --- Aliases ---
alias install="sudo dnf install"
alias uninstall="sudo dnf remove"
alias search='dnf search'
alias refreshcache='sudo dnf clean all && sudo dnf makecache'

alias md="mkdir -p"
alias rd="rm -rf"
alias dtop='cd ~/Desktop'

alias glog="git log --all --decorate --graph --abbrev-commit --format='%C(bold yellow)%h%d%C(reset) - %C(white)%s%C(reset)%n     %C(bold blue)%ar (%ai)%C(reset) %C(bold dim green)%an%C(reset)'"
alias adog="git log --all --decorate --oneline --graph"

alias big='rpm -qa --queryformat "%{SIZE} %{NAME}\n" | sort -n | numfmt --to=iec | nl'
alias histctx="grep -n '' ~/.histfile | fzf --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {1} ~/.histfile' --preview-window +{1}-/2"

# Reflector Alternatives (no reflector on Fedora)
# Use 'dnf config-manager' or 'dnf makecache' for repo updates if needed

drop-caches() {
  echo "⚠️ Flushing file system caches (pagecache, dentries, inodes)..."
  sync
  echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
  echo "✅ Memory caches dropped."
}

# --- Environment Variables ---
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
export VISUAL=micro
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND="find . ! \( -type d -path ./.git -prune \) ! -type d ! -name '*.tags' -printf '%P\n'"

# Fedora uses fastestmirror plugin. You can check or enable it:
# sudo dnf install dnf-plugins-core
# sudo nano /etc/dnf/dnf.conf  # and set fastestmirror=True

# --- Prompt Customization ---
source "$HOME/.zsh/git-prompt.zsh/git-prompt.zsh"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[green]%} )"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[green]%}"

PROMPT='%B%F{magenta}%n@%m:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{magenta}%f%b '
RPROMPT='%B%F{red}%(0?||Exit code: %?)%f%b'

# --- Plugins ---
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Fedora fzf integration
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/shell/completion.zsh ] && source /usr/share/fzf/shell/completion.zsh

# --- Custom Functions ---
[ -f "$HOME/.zsh_functions" ] && source "$HOME/.zsh_functions"

# --- ZLE bindkeys for search in history ---
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Add .local/bin to the PATH
export PATH=$HOME/.local/bin:$PATH

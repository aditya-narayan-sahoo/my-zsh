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

# Prevent duplicates in history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# --- Basic Options ---
setopt autocd # Automatically change directory when typing a directory name
bindkey -e # Use emacs key bindings

# --- Key Bindings ---
bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[F" end-of-line # END
bindkey "^[[3~" delete-char # DEL
bindkey "^[[3;5~" delete-word # CTRL+DEL - delete a whole word after cursor
bindkey "^H" backward-delete-word # CTRL+BACKSPACE - delete a whole word before cursor
bindkey "^[[1;5C" forward-word # CTRL+ARROW_RIGHT - move cursor forward one word
bindkey "^[[1;5D" backward-word # CTRL+ARROW_LEFT - move cursor backward one word
bindkey "^Z" undo # CTRL+Z
bindkey "^Y" redo # CTRL+Y
bindkey "^[[A" up-line-or-beginning-search # ARROW_UP
bindkey "^[[B" down-line-or-beginning-search # ARROW_DOWN

# --- Aliases ---
# System Aliases
alias install="sudo pacman -S"
alias uninstall="sudo pacman -Rcns"
alias search='pacman -Ss'

# Directory Aliases
alias md="mkdir -p"
alias rd="rm -rf"
alias dtop='cd ~/Desktop'

# Git Aliases
alias glog="git log --all --decorate --graph --abbrev-commit --format='%C(bold yellow)%h%d%C(reset) - %C(white)%s%C(reset)%n     %C(bold blue)%ar (%ai)%C(reset) %C(bold dim green)%an%C(reset)'"
alias adog="git log --all --decorate --oneline --graph"

# Utility Aliases
alias t="tere --filter-search"
alias big='expac -H M "%m\t%n" | sort -h | nl' # Sort installed packages according to size in MB (expac must be installed)
alias histctx="grep -n '' ~/.histfile | fzf --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {1} ~/.histfile' --preview-window +{1}-/2"

# Reflector Aliases
alias sortrate='sudo reflector --country India --protocol https --sort rate --save /etc/pacman.d/mirrorlist' # fastest download speed
alias sortscore='sudo reflector --country India --protocol https --sort score --save /etc/pacman.d/mirrorlist' # combine several factors
alias sortage='sudo reflector --country India --protocol https --sort age --save /etc/pacman.d/mirrorlist' # most synchronized
alias sortdelay='sudo reflector --country India --protocol https --sort delay --save /etc/pacman.d/mirrorlist' # low latency

# Rate-Mirror Alias
alias drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'

# --- Environment Variables ---
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
export VISUAL=micro
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name '\''*.tags'\'' -printf '\''%P\n'\'

tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

# --- Prompt Customization ---
source /usr/share/zsh/scripts/git-prompt.zsh
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[green]%} )"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[green]%}"

PROMPT='%B%F{magenta}%n@%m:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{magenta}%f%b ' # with hostname
RPROMPT='%B%F{red}%(0?||Exit code: %?)%f%b'

# --- Plugins ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/key-bindings.zsh
# Type ** and hit tab (eg. with the cd command; works with directories, files, process IDs, hostnames, environment variables)
source /usr/share/fzf/completion.zsh

# --- Custom Functions ---
source "${HOME}/.zsh_functions"

# --- ZLE bindkeys for search in history ---
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
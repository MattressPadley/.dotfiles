# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#ZSH_THEME="xiong-chiamiov-plus"

COMPLETION_WAITING_DOTS="true"
plugins=(git macos poetry poetry-env)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# # The following lines were added by compinstall
# zstyle ':completion:*' completer _complete _ignored _correct _approximate
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' '' '' ''
# zstyle ':completion:*' menu select=1
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl true
# zstyle :compinstall filename '/Users/mhadley/.zshrc'

# # Load Git completion
# zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
# fpath=(~/.zsh $fpath)

# autoload -Uz compinit
# compinit

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi

# End of lines added by compinstall
PATH="$PATH:~/.dotfiles/scripts"


# command changes or abbreviations
alias pip="pip3"
alias python="python3"
alias vi="nvim"
alias vim="nvim"
alias py="python3"
alias z="zed"
alias lg="lazygit"
alias home="cd ~"
alias dotfiles="cd ~/.dotfiles"
alias obsidian="cd /Users/mhadley/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal"
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"
alias lst="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions --tree"

Dev() {
    local dir
    dir=$(fd . ~/Dev --type d --exclude .git | fzf --preview 'eza --tree --level 1 --color=always {} | head -200')
    [[ -n "$dir" ]] && cd "$dir"
}

#scripts
alias ma3="sh ma3.sh"
alias upconf="zsh ~/.dotfiles/scripts/dotfiles-update.sh"
alias sophie="ssh mhadley@sophie.mattresspad.link"
alias totoro="ssh mhadley@totoro.mattresspad.link"
alias log="sh log.sh"


export PATH="/Users/mhadley/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


# ---- BAT -----
export BAT_THEME="Catppuccin Mocha"

# ---- Eza (better ls) -----

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# thefuck alias
eval $(thefuck --alias)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- Starship -----
eval "$(starship init zsh)" 
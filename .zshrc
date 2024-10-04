# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#ZSH_THEME="xiong-chiamiov-plus"

COMPLETION_WAITING_DOTS="true"
plugins=(git poetry poetry-env gh)

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit
setopt correct


# github
compctl -K _gh gh

PATH="$PATH:~/.dotfiles/scripts"


# command changes or abbreviations
alias pip="pip3"
alias python="python3"
alias vi="nvim"
alias vim="nvim"
alias py="python3"
alias lg="lazygit"
alias home="cd ~"
alias dotfiles="cd ~/.dotfiles"
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"
alias lst="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions --tree"

dev() {
    local dir
    dir=$(fd . ~/dev --type d --max-depth 1 --exclude .git --exclude Z_Archive -x echo {/} | fzf --preview 'eza --tree --level 1 --color=always ~/Dev/{} | head -200')
    if [[ -n "$dir" ]]; then
        cd ~/Dev/"$dir"
    fi
}

prod() {
    local dir
    dir=$(fd . ~/prod --type d --max-depth 1 --exclude .git -x echo {/} | fzf --preview 'eza --tree --level 1 --color=always ~/prod/{} | head -200')
    if [[ -n "$dir" ]]; then
        cd ~/prod/"$dir"
    fi
}

repo() {
  # Create an empty array to hold owners (your username and organizations)
  owners=('MattressPadley')  # Adds your username from your GitHub profile

  # Append organizations to the owners array
  while read -r org; do
    owners+=("$org")
  done < <(gh org list)

  # Loop through each specified owner and list their repositories
  for owner in "${owners[@]}"; do
    gh repo list $owner --json nameWithOwner | jq -r '.[].nameWithOwner'
  done | fzf \
    --preview 'gh repo view {} | glow ' \
    --preview-window up:70%:wrap \
    | {
      read -r nameWithOwner
      if [[ "$1" == "open" ]]; then
        gh repo view "$nameWithOwner" -w
      else
        gh repo view "$nameWithOwner" --json url -q .url
      fi
    }
}

#scripts
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

# -- Use fd instead of find --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    git)          repo                                     "$@" ;;  # Ensure 'repo' function is used for git
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


# Zshがインタラクティブシェルとして起動しているか確認
# if [[ $- == *i* ]]; then
#   # インタラクティブシェルの場合のみnushellを起動
#   exec nu
# fi

eval "$(/opt/homebrew/bin/brew shellenv)"

export VI_MODE_SET_CURSOR=true

path=(
  ~/.local/bin
  `$(brew --prefix rustup)/bin/rustc --print sysroot`/bin
  # $(brew --prefix rustup)/bin
  $(go env GOBIN)
  $path
  )

bindkey -e

# starship initialization
eval "$(starship init zsh)"

# zoxide initialization
eval "$(zoxide init zsh)"

# zabrze initialization
eval "$(zabrze init --bind-keys)"

eval "$(fnm env --use-on-cd --shell zsh)"

source <(fzf --zsh)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

FPATH=~/.local/share/zsh:$FPATH

export FZF_CTRL_R_OPTS="--height=40% --reverse --border"
export FZF_CTRL_T_OPTS="--height=40% --preview 'bat --color=always --style=header,grid --line-range :100 {}' --reverse --border --walker-skip Library,.git,node_modules,target,.cache"
export FZF_DEFAULT_OPTS="--height=40% --reverse --border"

export EDITOR=nvim

autoload -Uz compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt inc_append_history

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt auto_cd

# pnpm
export PNPM_HOME="/Users/seiji/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

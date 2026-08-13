export LANG=ja_JP.UTF-8
export GOENV=$HOME/.config/go/env

# Claude Code 関連の環境変数 (~/.claude.env が存在する場合のみ読み込む)
[[ -f "$HOME/.claude.env" ]] && source "$HOME/.claude.env"

# omp (Oh My Pi): 設定ルートを ~/.config/omp に置く (ホーム相対パス)
export PI_CONFIG_DIR=".config/omp"

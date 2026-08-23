-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.lazyvim_ts_lsp = "tsgo"

vim.o.sidescrolloff = 0

-- この設定を見てLazyVimでwrapとspellが設定されるautocmdの設定を変える（眠いので説明が適当
vim.g.md_wrap_spell = false

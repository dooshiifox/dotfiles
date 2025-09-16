-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.o.shell = "fish"

vim.cmd.aunmenu("PopUp.How-to\\ disable\\ mouse")
vim.cmd.aunmenu("PopUp.-2-")

vim.o.spelllang = "en_nz,en,en_us,en_gb"

-- Indicator lines every `n` characters
vim.o.colorcolumn = "80,120,200"

vim.o.termguicolors = true
vim.cmd.colorscheme("termtheme")

-- Don't convert tabs to spaces
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- vim.o.winborder = "rounded"

vim.g.lazyvim_php_lsp = "intelephense"

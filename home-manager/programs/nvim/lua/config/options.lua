-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.opt.shell = "fish"

vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
vim.cmd("aunmenu PopUp.-2-")
vim.opt.spelllang = "en_nz,en,en_us,en_uk"
-- Reload the spellcheck file when loading after a nix build
vim.cmd(":mkspell! %")

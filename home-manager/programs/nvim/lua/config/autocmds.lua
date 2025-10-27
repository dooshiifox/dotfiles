-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "php", "blade" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

local bladeGrp
vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.blade.php",
	group = bladeGrp,
	callback = function()
		vim.opt.filetype = "blade"
	end,
})

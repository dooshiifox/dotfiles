-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
map({ "n", "x", "v", "t" }, "<A-h>", "<Cmd>wincmd h<Cr>", { desc = "Go to Left Window" })
map({ "n", "x", "v", "t" }, "<A-a>", "<Cmd>wincmd j<Cr>", { desc = "Go to Lower Window" })
map({ "n", "x", "v", "t" }, "<A-e>", "<Cmd>wincmd k<Cr>", { desc = "Go to Upper Window" })
map({ "n", "x", "v", "t" }, "<A-i>", "<Cmd>wincmd l<Cr>", { desc = "Go to Right Window" })
map({ "n", "x", "v", "t" }, "<A-C-h>", "<Cmd>vert resize -1<Cr>", { desc = "Shrink horizontally" })
map({ "n", "x", "v", "t" }, "<A-C-a>", "<Cmd>resize -1<Cr>", { desc = "Shrink vertically" })
map({ "n", "x", "v", "t" }, "<A-C-e>", "<Cmd>resize +1<Cr>", { desc = "Grow vertically" })
map({ "n", "x", "v", "t" }, "<A-C-i>", "<Cmd>vert resize +1<Cr>", { desc = "Grow horizontally" })

-- Alt+t = Terminal
map("n", "<A-t>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Toggle terminal" })
map("t", "<A-t>", "<Cmd>close<Cr>", { desc = "Hide Terminal" })

map("v", "<C-d>", function()
	local mc = require("multicursor-nvim")
	mc.matchAddCursor(1)
end, { desc = "Add cursor for repeated selection" })

map({ "v", "n", "x" }, "\\", '<Cmd>lua require("precognition").peek()<Cr>', { desc = "Toggle precognition" })

map({ "n", "v", "x" }, "", '"+y')
map({ "n", "v", "x" }, "", '"+p')

map({ "n", "v", "x" }, "<Tab>", "<leader>bb", { desc = "Switch to previous buffer", remap = true })

map({ "i" }, "<C-Enter>", "<C-x><C-o>", { desc = "Open intellisense", remap = true })

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader><Tab>l")
vim.keymap.del("n", "<leader><Tab>o")
vim.keymap.del("n", "<leader><Tab>f")
vim.keymap.del("n", "<leader><Tab><Tab>")
vim.keymap.del("n", "<leader><Tab>]")
vim.keymap.del("n", "<leader><Tab>d")
vim.keymap.del("n", "<leader><Tab>[")
map("n", "<leader>ll", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader>lo", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader>lf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader>lt", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>l]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>ld", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>l[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map({ "n", "v", "x" }, "<leader><Tab>", function()
	Snacks.picker.buffers({
		hidden = true,
	})
end, { desc = "Buffers" })

map({ "n", "v", "x" }, "<Enter>", "/", { desc = "Grep" })
map({ "n", "v", "x" }, "<leader><Enter>", function()
	Snacks.picker.grep({
		hidden = true,
		ignored = false,
	})
end, { desc = "Grep all files" })

map({ "n" }, "<leader>or", function()
	-- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ recent_first = true })
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], "restart")
	end
end)

map("n", "<leader>cd", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end, { desc = "Line Diagnostics" })

-- vim.keymap.del("i", "<C-i>")
-- vim.keymap.del("i", "<C-d>")
map("i", "<C-i><C-d>", "<C-R>=strftime('%Y-%m-%d')<CR>", { desc = "Insert the current date" })
map("n", "<leader>id", "\"=strftime('%Y-%m-%d')<CR>p", { desc = "Insert the current date" })

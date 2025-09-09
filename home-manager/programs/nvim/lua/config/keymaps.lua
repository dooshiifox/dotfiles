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

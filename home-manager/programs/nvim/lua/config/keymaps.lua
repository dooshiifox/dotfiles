-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Super+Ctrl+Shift+Arrow = Resize window (plugins/init)
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
-- Ctrl+Super+Arrow = Move to window
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
map("n", "<C-S-A-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-S-A-a>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-S-A-e>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-S-A-i>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("t", "<C-S-A-h>", "<Cmd>wincmd h<Cr>", { desc = "Go to Left Window" })
map("t", "<C-S-A-a>", "<Cmd>wincmd j<Cr>", { desc = "Go to Lower Window" })
map("t", "<C-S-A-e>", "<Cmd>wincmd k<Cr>", { desc = "Go to Upper Window" })
map("t", "<C-S-A-i>", "<Cmd>wincmd l<Cr>", { desc = "Go to Right Window" })

-- Alt+Left/Right = Switch buffer
map("n", "<A-h>", "<S-h>", { remap = true, desc = "Switch to left buffer" })
map("n", "<A-i>", "<S-l>", { remap = true, desc = "Switch to right buffer" })
-- Alt+Up/Down = Move line
map("n", "<A-e>", "ddkP", { desc = "Move line up" })
map("n", "<A-a>", "ddp", { desc = "Move line down" })

-- Alt+Shift+Up/Down = Duplicate line
map("n", "<A-C-e>", "<Cmd>copy. -1<Cr>")
map("n", "<A-C-a>", "<Cmd>copy.<Cr>")

-- Alt+` = Terminal
map("n", "<A-S-C-t>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Toggle terminal" })
map("t", "<A-S-C-t>", "<Cmd>close<Cr>", { desc = "Hide Terminal" })

map("v", "<C-d>", function()
	local mc = require("multicursor-nvim")
	mc.matchAddCursor(1)
end, { desc = "Add cursor for repeated selection" })

map({ "v", "n", "x" }, "\\", '<Cmd>lua require("precognition").peek()<Cr>', { desc = "Toggle precognition" })

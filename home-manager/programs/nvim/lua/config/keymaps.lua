-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v", "o" }, "n", "h", { desc = "Left" })
map({ "n", "v", "o" }, "r", "j", { desc = "Down" })
map({ "n", "v", "o" }, "t", "k", { desc = "Up" })
map({ "n", "v", "o" }, "s", "l", { desc = "Right" })

map({ "n", "v", "o" }, "l", "n")
map({ "n", "v", "o" }, "k", "r")
map({ "n", "v", "o" }, "h", "t")
map({ "n", "v", "o" }, "j", "s")

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
map("n", "<C-D-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-D-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-D-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-D-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("t", "<C-D-Left>", "<Cmd>wincmd h<Cr>", { desc = "Go to Left Window" })
map("t", "<C-D-Down>", "<Cmd>wincmd j<Cr>", { desc = "Go to Lower Window" })
map("t", "<C-D-Up>", "<Cmd>wincmd k<Cr>", { desc = "Go to Upper Window" })
map("t", "<C-D-Right>", "<Cmd>wincmd l<Cr>", { desc = "Go to Right Window" })

-- Alt+Left/Right = Switch buffer
map("n", "<A-Left>", "<S-h>", { remap = true, desc = "Switch to left buffer" })
map("n", "<A-Right>", "<S-l>", { remap = true, desc = "Switch to right buffer" })
-- Alt+Up/Down = Move line
map("n", "<A-Up>", "ddkP", { desc = "Move line up" })
map("n", "<A-Down>", "ddp", { desc = "Move line down" })

-- Alt+Shift+Up/Down = Duplicate line
map("n", "<A-S-Up>", "<Cmd>copy. -1<Cr>")
map("n", "<A-S-Down>", "<Cmd>copy.<Cr>")

-- Alt+` = Terminal
map("n", "<A-`>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Toggle terminal" })
map("t", "<A-`>", "<Cmd>close<Cr>", { desc = "Hide Terminal" })

-- Ctrl+/ = Toggle comment
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
--Ctrl+Shift+/ = Toggle block comment
map("n", "<C-S-/>", "gbc", { remap = true, desc = "Toggle block comment" })
map("v", "<C-S-/>", "gb", { remap = true, desc = "Toggle block comment" })

-- map("n", "<C-D>", "viw", { desc = "Select word" })
map("v", "<C-D>", function()
	local mc = require("multicursor-nvim")
	mc.matchAddCursor(1)
end, { desc = "Add cursor for repeated selection" })

map({ "v", "n", "x" }, "\\", '<Cmd>lua require("precognition").peek()<Cr>', { desc = "Toggle precognition" })

local colors = require("colors")

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "termtheme",
			-- colorscheme = "tokyonight",
			news = {
				neovim = true,
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"folke/edgy.nvim",
		enabled = false,
		opts = {
			animate = { enabled = false },
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
			},

			on_colors = function(col)
				-- col.terminal = {
				-- 	white = colors.lightgray,
				-- 	yellow_bright = colors.yellow,
				-- 	white_bright = colors.white,
				-- 	red = colors.darkred,
				-- 	green_bright = colors.lime,
				-- 	cyan = colors.darkcyan,
				-- 	red_bright = colors.red,
				-- 	blue = colors.darkblue,
				-- 	cyan_bright = colors.cyan,
				-- 	yellow = colors.orange,
				-- 	magenta_bright = colors.magenta,
				-- 	green = colors.darkgreen,
				-- 	magenta = colors.darkcyan,
				-- 	black_bright = colors.dark_grey,
				-- 	blue_bright = colors.light_blue,
				-- 	black = colors.black,
				-- }
				-- col.terminal_black = colors.black
				--
				-- col.comment = colors.light_grey
				-- col.none = "NONE"
				--
				-- col.git = {
				-- 	ignore = colors.grey,
				-- 	delete = colors.red,
				-- 	add = colors.lime,
				-- 	change = colors.light_blue,
				-- }
				-- col.diff = {
				-- 	change = "#252a3f",
				-- 	add = "#273849",
				-- 	delete = "#3a273a",
				-- 	text = "#394b70",
				-- }
				--
				-- col.hint = colors.cyan
				-- col.info = colors.light_blue
				-- col.todo = colors.yellow
				-- col.warning = colors.orange
				-- col.error = colors.red
				--
				-- col.fg = colors.fg
				-- col.bg = colors.bg
				--
				-- col.fg_float = colors.fg
				-- col.bg_float = colors.bg_tertiary
				--
				-- col.fg_dark = colors.grey
				-- col.bg_dark = colors.bg_secondary
				-- col.bg_dark1 = colors.bg
				--
				-- col.bg_highlight = colors.dark_grey
				-- col.bg_search = colors.accent
				-- col.bg_statusline = colors.bg
				-- col.bg_popup = colors.bg_secondary
				-- col.bg_visual = colors.bg_tertiary
				--
				-- col.fg_sidebar = colors.fg_secondary
				-- col.bg_sidebar = colors.bg
				--
				-- col.fg_gutter = colors.border
				-- col.border = colors.border
				-- col.border_highlight = colors.accent
				--
				-- col.dark3 = colors.grey
				-- col.dark5 = colors.grey
				-- col.black = colors.black
				-- col.red = colors.red
				-- col.red1 = colors.dark_red
				-- col.orange = colors.orange
				-- col.yellow = colors.yellow
				-- col.green = colors.green
				-- col.green1 = colors.lime
				-- col.green2 = colors.green
				-- col.teal = colors.cyan
				-- col.cyan = colors.cyan
				-- col.blue = colors.light_blue
				-- col.blue0 = colors.dark_blue
				-- col.blue1 = colors.dark_blue
				-- col.blue2 = colors.light_blue
				-- col.blue5 = colors.light_blue
				-- col.blue6 = colors.light_blue
				-- col.blue7 = colors.dark_blue
				-- col.purple = colors.light_magenta
				-- col.magenta = colors.light_magenta
				-- col.magenta2 = colors.magenta
				-- col.rainbow = {
				-- 	colors.red,
				-- 	colors.yellow,
				-- 	colors.lime,
				-- 	colors.cyan,
				-- 	colors.light_blue,
				-- 	colors.magenta,
				-- }
				-- vim.notify(vim.inspect(col), "info")
				-- vim.notify(vim.inspect(colors), "info")
			end,
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					---@type snacks.dashboard.Item[]
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							action = "<leader>fp",
							desc = "Projects",
							icon = " ",
							key = "p",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
		},
	},
	{
		"dstein64/nvim-scrollview",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = {
					normal = {
						a = { bg = colors.light_blue, fg = colors.black, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.light_blue },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					insert = {
						a = { bg = colors.lime, fg = colors.black, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.lime },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					visual = {
						a = { bg = colors.light_magenta, fg = colors.black, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.light_magenta },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					replace = {
						a = { bg = colors.pink, fg = colors.black, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.pink },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					command = {
						a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.yellow },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					inactive = {
						a = { bg = colors.bg, fg = colors.black, gui = "bold" },
						b = { bg = colors.bg, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
				},
			},
			sections = {
				lualine_y = {},
				lualine_z = {
					{
						"location",
						padding = { left = 0, right = 1 },
					},
				},
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {
			ignore = "^\\s*$",
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			signature = {
				enabled = true,
			},
			completion = {
				list = {
					selection = { preselect = false },
				},
				menu = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
				documentation = {
					window = {
						border = "rounded",
					},
				},
			},
		},
	},

	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			set({ "n", "x" }, "me", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "x" }, "ma", function()
				mc.lineAddCursor(1)
			end)
			set({ "n", "x" }, "mE", function()
				mc.lineSkipCursor(-1)
			end)
			set({ "n", "x" }, "mA", function()
				mc.lineSkipCursor(1)
			end)

			set({ "n", "x" }, "mm", function()
				mc.matchAddCursor(1)
			end)
			set({ "n", "x" }, "mM", function()
				mc.matchAddCursor(-1)
			end)
			set({ "n", "x" }, "ms", function()
				mc.matchSkipCursor(1)
			end)
			set({ "n", "x" }, "mS", function()
				mc.matchSkipCursor(-1)
			end)

			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "m<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "m<right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({ "n", "x" }, "mx", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { reverse = true })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { reverse = true })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
	{
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { alt = { "todo" } },
			},
			highlight = {
				pattern = {
					[==[(KEYWORDS)\s*[:!(]]==],
				},
				comments_only = false,
			},
			search = {
				pattern = [==[(KEYWORDS)[:!(]]==],
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = false,
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			presets = {
				lsp_doc_border = true,
				inc_rename = true,
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
	},
	{
		"tris203/precognition.nvim",
		commit = "a0ed9c97b24002394201c39755e10495d47b2d3f",
		dependencies = {
			"chrisgrieser/nvim-spider",
		},
		config = function()
			local vanilla_motions = require("precognition.motions.vanilla_motions")
			local spider = require("spider.motion-logic")
			local globalOpts = require("spider.config").globalOpts

			require("precognition.motions").register_motions({
				next_word_boundary = function(str, cursorcol, linelen, big_word)
					if big_word then
						return vanilla_motions.next_word_boundary(str, cursorcol, linelen, big_word)
					end
					return spider.getNextPosition(str, cursorcol, "w", globalOpts) or 0
				end,
				end_of_word = function(str, cursorcol, linelen, big_word)
					if big_word then
						return vanilla_motions.end_of_word(str, cursorcol, linelen, big_word)
					end
					return spider.getNextPosition(str, cursorcol, "e", globalOpts) or 0
				end,
				prev_word_boundary = function(str, cursorcol, linelen, big_word)
					if big_word then
						return vanilla_motions.prev_word_boundary(str, cursorcol, linelen, big_word)
					end
					return spider.getNextPosition(str, cursorcol, "b", globalOpts) or 0
				end,
			})
		end,
	},
	-- {
	-- 	"sphamba/smear-cursor.nvim",
	-- 	opts = {
	-- 		stiffness = 1,
	-- 		trailing_stiffness = 0.8,
	-- 		never_draw_over_target = false,
	-- 		legacy_computing_symbols_support = true,
	-- 		damping = 1,
	-- 		trailing_exponent = 4,
	-- 		anticipation = 0.95,
	-- 		distance_stop_animating = 0.5,
	-- 		time_interval = 1000 / 120, -- 1s / 120fps
	-- 	},
	-- },
}

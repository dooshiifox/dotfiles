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
						a = { bg = colors.light_blue, fg = colors.bg, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.light_blue },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					insert = {
						a = { bg = colors.lime, fg = colors.bg, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.lime },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					visual = {
						a = { bg = colors.light_magenta, fg = colors.bg, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.light_magenta },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					replace = {
						a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
						b = { bg = colors.dark_grey, fg = colors.pink },
						c = { bg = colors.bg, fg = colors.light_grey },
					},
					command = {
						a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
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
			sources = {
				default = { "laravel", "lsp", "path", "snippets", "buffer" },
				providers = {
					laravel = {
						name = "laravel",
						module = "laravel.blink_source",
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
			servers = {
				-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#intelephense
				intelephense = {
					filetypes = { "php", "blade" },
					init_options = {
						licenceKey = "/home/dooshii/nixos/secrets/intelephense.txt",
						clearCache = true,
					},
				},
				html = {
					filetypes = { "html", "blade" },
					init_options = {
						-- configurationSection = { "html", "css", "javascript" },
						-- embeddedLanguages = {
						-- 	css = true,
						-- 	javascript = true,
						-- },
						provideFormatter = true,
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				php = { "pint", "php_cs_fixer" },
				blade = { "blade_formatter" },
			},
			formatters = {
				blade_formatter = {
					command = "blade-formatter",
					args = { "-w", "$FILENAME" },
					stdin = false,
				},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"pint",
			},
			ui = {
				border = "rounded",
			},
		},
	},
	{
		-- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"blade",
				"php_only",
				"php",
			})
		end,
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
	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			highlight = "VirtColumn",
		},
		-- config = function(_, opts)
		-- 	require("virt-column").setup(opts)
		-- end,
	},
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
			{ "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
			{ "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
			{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
			{ "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
			{ "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
			{ "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
			{
				"<leader>or",
				function()
					-- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task
					local overseer = require("overseer")
					local tasks = overseer.list_tasks({ recent_first = true })
					if vim.tbl_isempty(tasks) then
						vim.notify("No tasks found", vim.log.levels.WARN)
					else
						overseer.run_action(tasks[1], "restart")
					end
				end,
				desc = "Restart last action",
			},
			{
				"<leader>ot",
				function()
					local overseer = require("overseer")
					local tasks = overseer.list_tasks({ recent_first = true })
					if vim.tbl_isempty(tasks) then
						vim.notify("No tasks found", vim.log.levels.WARN)
					else
						overseer.run_action(tasks[1], "open hsplit")
					end
				end,
				desc = "Open terminal for last action",
			},
		},
	},
	{
		"nvim-mini/mini.snippets",
		opts = {
			snippets = {
				{
					prefix = "rtest",
					body = {
						"#[cfg(test)]",
						"mod test {",
						"\tuse super::*;",
						"",
						"\t#[test]",
						"\tfn test() {",
						"\t\t$0",
						"\t}",
						"}",
					},
				},
			},
		},
	},
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	opts = {
	-- 		region_check_events = "InsertEnter,InsertLeave",
	-- 		delete_check_events = "TextChanged,InsertLeave",
	-- 	},
	-- },
	{
		"adibhanna/laravel.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>la", ":Artisan<cr>", desc = "Laravel Artisan" },
			{ "<leader>lc", ":Composer<cr>", desc = "Composer" },
			{ "<leader>lr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
			{ "<leader>lm", ":LaravelMake<cr>", desc = "Laravel Make" },
		},
		config = function()
			require("laravel").setup()
		end,
	},
}

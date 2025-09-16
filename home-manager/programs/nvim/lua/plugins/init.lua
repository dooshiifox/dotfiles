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
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				php = { { "pint", "php_cs_fixer" } },
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
			})
		end,
		config = function(_, opts)
			vim.filetype.add({
				pattern = {
					[".*%.blade%.php"] = "blade",
				},
			})

			require("nvim-treesitter.configs").setup(opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			}
			local bladeGrp
			vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				pattern = "*.blade.php",
				group = bladeGrp,
				callback = function()
					vim.opt.filetype = "blade"
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			-- see: https://phpactor.readthedocs.io/en/master/usage/standalone.html#phar-installation
			-- lspconfig.phpactor.setup {}
			-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#intelephense
			-- $ npm install -g intelephense
			require("lspconfig").intelephense.setup({})
			-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html
			-- $ npm install -g vscode-langservers-extracted
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "blade" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
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
}

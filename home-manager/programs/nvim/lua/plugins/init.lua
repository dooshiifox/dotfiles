local colors = {
	bg = "#07070a",
	fg = "#c5c8c6",
	black = "#1f2024",
	gray = "#373b41",
	darkred = "#a54242",
	red = "#cc6666",
	darkgreen = "#8c9440",
	green = "#b5bd68",
	darkyellow = "#de935f",
	yellow = "#f0c674",
	darkblue = "#5f819d",
	blue = "#81a2be",
	darkpurple = "#85678f",
	purple = "#b294bb",
	darkcyan = "#5e8d87",
	cyan = "#8abeb7",
	lightgray = "#95a7be",
	white = "#c2d2d6",
}

return {
	{
		"folke/edgy.nvim",
		opts = function(_, opts)
			opts.keys = {
				["<C-S-D-Right>"] = function(win)
					win:resize("width", 2)
				end,
				["<C-S-D-Left>"] = function(win)
					win:resize("width", -2)
				end,
				["<C-S-D-Up>"] = function(win)
					win:resize("height", 2)
				end,
				["<C-S-D-Down>"] = function(win)
					win:resize("height", -2)
				end,
			}
		end,
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"dstein64/nvim-scrollview",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = {
					normal = {
						a = { bg = colors.blue, fg = colors.black, gui = "bold" },
						b = { bg = colors.darkgray, fg = colors.blue },
						c = { bg = colors.bg, fg = colors.lightgray },
					},
					insert = {
						a = { bg = colors.green, fg = colors.black, gui = "bold" },
						b = { bg = colors.darkgray, fg = colors.green },
						c = { bg = colors.bg, fg = colors.lightgray },
					},
					visual = {
						a = { bg = colors.purple, fg = colors.black, gui = "bold" },
						b = { bg = colors.darkgray, fg = colors.purple },
						c = { bg = colors.bg, fg = colors.lightgray },
					},
					replace = {
						a = { bg = colors.red, fg = colors.black, gui = "bold" },
						b = { bg = colors.darkgray, fg = colors.red },
						c = { bg = colors.bg, fg = colors.lightgray },
					},
					command = {
						a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
						b = { bg = colors.darkgray, fg = colors.yellow },
						c = { bg = colors.bg, fg = colors.lightgray },
					},
					inactive = {
						a = { bg = colors.bg, fg = colors.black, gui = "bold" },
						b = { bg = colors.bg, fg = colors.fg },
						c = { bg = colors.bg, fg = colors.lightgray },
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
		"folke/edgy.nvim",
		opts = {
			animate = {
				enabled = false,
			},
		},
	},
	{
		"numToStr/Comment.nvim",
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
			},
		},
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

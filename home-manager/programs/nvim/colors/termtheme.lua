local colors = require("colors")

local function color_to_term(color)
	local cterm = {
		-- https://neovim.io/doc/user/syntax.html#cterm-colors
		[colors.bg] = colors.is_dark and "Black" or "White",
		[colors.bg_raised] = colors.is_dark and "Black" or "White",
		[colors.bg_highlight] = colors.is_dark and "DarkGray" or "LightGray",
		[colors.grey] = colors.is_dark and "DarkGray" or "LightGray",
		[colors.fg_secondary] = colors.is_dark and "LightGray" or "DarkGray",
		[colors.fg] = colors.is_dark and "White" or "Black",
		[colors.fg_raised] = colors.is_dark and "White" or "Black",
		[colors.fg_highlight] = colors.is_dark and "White" or "Black",
		[colors.red] = "DarkRed",
		[colors.pink] = "LightRed",
		[colors.brown] = "DarkYellow",
		[colors.orange] = "DarkYellow",
		[colors.yellow] = "LightYellow",
		[colors.cream] = "LightYellow",
		[colors.green] = "DarkGreen",
		[colors.lime] = "LightGreen",
		[colors.dark_cyan] = "DarkCyan",
		[colors.cyan] = "LightCyan",
		[colors.dark_blue] = "DarkBlue",
		[colors.light_blue] = "LightBlue",
		[colors.magenta] = "DarkMagenta",
		[colors.light_magenta] = "LightMagenta",
		[colors.border] = colors.is_dark and "DarkGray" or "LightGray",
		[colors.border_active] = "LightBlue",
		[colors.accent] = "LightBlue",
		[colors.accent_fg] = "Black",
	}
	return cterm[color]
end

local function get_real_color(color, replace_table)
	if color == nil or color == "none" or string.sub(color, 1, 1) == "#" then
		return color
	end

	return replace_table[color]
end

local function set(name, dark_args, light_args)
	local args = dark_args
	if not colors.is_dark and light_args ~= nil then
		if light_args == "swap" then
			local x = args.bg
			args.bg = args.fg
			args.fg = x or colors.fg

			local x2 = args.ctermbg
			args.ctermbg = args.ctermfg
			args.ctermfg = x2

			if args.bold == nil then
				args.bold = true
			end
		else
			args = light_args
		end
	end

	if args.fg and not args.ctermfg then
		args.ctermfg = color_to_term(args.fg)
	end
	if args.bg and not args.ctermbg then
		args.ctermbg = color_to_term(args.bg)
	end

	args.fg = get_real_color(args.fg, colors.fg_color)
	args.bg = get_real_color(args.bg, colors.bg_color)
	args.sp = get_real_color(args.sp, colors.fg_color)

	vim.api.nvim_set_hl(0, name, args)
end

vim.cmd("highlight clear")
vim.cmd("syntax reset")

-- :lua Snacks.picker.highlights()

set("Normal", { bg = "none", fg = colors.fg })
set("NonText", { bg = "none", fg = colors.fg })
set("Whitespace", { bg = "none", fg = colors.bg_highlight })
set("Cursor", { bg = colors.fg, fg = colors.bg })
set("CursorLine", { bg = colors.bg_raised })
set("Folded", { bg = "none", sp = colors.bg_raised, underdotted = true })
set("LineNr", { fg = colors.grey, italic = true })
set("CursorLineNr", { fg = colors.fg, bold = true })
set("VirtColumn", { fg = colors.bg_raised }) -- the bar indicating 80/120 chars
set("StatusLine", { bg = "none", fg = colors.fg }) -- this is overridden by lualine but used sometimes
set("Directory", { fg = "dark_blue" })
set("Visual", { bg = colors.bg_highlight }, { fg = "magenta", bg = "magenta" })
set("Search", { bg = "yellow", fg = colors.bg, bold = true }, "swap")
set("CurSearch", { bg = "accent", fg = colors.bg, bold = true }, { bg = "accent", fg = colors.fg })
set("MatchParen", { bg = colors.bg_highlight, fg = colors.fg_raised, underline = true })
set("Pmenu", { bg = "none", fg = colors.fg }, { bg = colors.bg_raised, fg = colors.fg })
set("PmenuSel", { link = "CurSearch" })
set("PmenuSbar", { bg = colors.bg_raised, fg = colors.grey })
set("VertSplit", { fg = colors.border })
set("NormalFloat", { bg = "none", fg = colors.fg })
set("WinSeparator", { bg = "none", fg = colors.border })
set("FloatBorder", { link = "WinSeparator" })
set("PmenuBorder", { link = "FloatBorder" })
set("BlinkCmpMenuBorder", { link = "FloatBorder" })
set("BlinkCmpDocBorder", { link = "FloatBorder" })
set("BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })
set("FloatShadow", { bg = colors.bg_raised })
set("FloatShadowThrough", { bg = colors.bg_raised })
set("Title", { fg = colors.fg, bold = true })
set("Added", { fg = "lime" })
set("Changed", { fg = "yellow" })
set("Removed", { fg = "pink" })
set("Error", { bg = "red", bold = true })
set("Ignore", { fg = colors.grey }, "swap")
set("RenderMarkdownCodeInline", { italic = true, bg = colors.bg_highlight, fg = colors.fg })
set("RenderMarkdownH1Bg", { bg = colors.bg_highlight, bold = true, fg = colors.fg, sp = colors.grey, underline = true })
set(
	"RenderMarkdownH2Bg",
	{ bg = colors.bg_raised, bold = true, italic = true, fg = colors.fg, sp = colors.grey, underline = true }
)

set("ScrollView", { link = "Visual" }, { bg = colors.bg_raised })

set("DiagnosticHint", { fg = "light_blue" }, "swap")
set("DiagnosticInfo", { fg = "cyan" }, "swap")
set("DiagnosticOk", { fg = "lime" }, "swap")
set("DiagnosticWarn", { fg = "orange" }, "swap")
set("DiagnosticError", { fg = "pink" }, "swap")
set("DiagnosticSignHint", { fg = "light_blue" })
set("DiagnosticSignInfo", { fg = "cyan" })
set("DiagnosticSignOk", { fg = "lime" })
set("DiagnosticSignWarn", { fg = "orange" })
set("DiagnosticSignError", { fg = "pink" })
set("DiagnosticUnderlineHint", { sp = "light_blue", undercurl = true })
set("DiagnosticUnderlineInfo", { sp = "cyan", undercurl = true })
set("DiagnosticUnderlineOk", { sp = "lime", undercurl = true })
set("DiagnosticUnderlineWarn", { sp = "orange", undercurl = true })
set("DiagnosticUnderlineError", { sp = "pink", undercurl = true })
set("DiagnosticUnnecessary", { fg = colors.fg_secondary, sp = colors.fg_secondary, underdotted = true })

set("SnacksIndent", { fg = colors.bg_raised })
set("SnacksIndentScope", { fg = colors.bg_highlight })
set("SnacksPickerInputBorder", { fg = colors.border_active })
set("SnacksPickerIcon", { link = "SnacksPickerInputBorder" })
set("SnacksPickerPrompt", { link = "Title" })
set("SnacksPickerFile", { fg = colors.fg })
set("SnacksPickerGitStatusModified", { link = "Changed" }, { bg = "yellow" })
set("SnacksPickerGitStatusStaged", { fg = "light_blue" }, "swap")
set("SnacksPickerGitStatusIgnored", { link = "Ignore" })
set("SnacksPickerPathIgnored", { link = "Ignore" })
set("SnacksPickerGitStatusUntracked", { fg = "green" }, "swap")
set("SnacksPickerTree", { fg = colors.border })
set("SnacksDim", { fg = colors.fg_secondary })

set("NoiceCmdlinePopupBorder", { fg = "accent" }, "swap")
set("NoiceCmdlineIcon", { link = "SnacksPickerInputBorder" })

set("MiniIconsRed", { fg = "pink" })
set("MiniIconsOrange", { fg = "orange" })
set("MiniIconsYellow", { fg = "yellow" })
set("MiniIconsGreen", { fg = "lime" })
set("MiniIconsCyan", { fg = "cyan" })
set("MiniIconsBlue", { fg = "dark_blue" })
set("MiniIconsAzure", { fg = "light_blue" })
set("MiniIconsPurple", { fg = "light_magenta" })
set("MiniIconsGrey", { fg = "light_grey" })

set("Comment", { fg = "green", italic = true }, "swap") -- test
set("@comment.documentation", { link = "Comment" })
set("@lsp.mod.documentation", { link = "@comment.documentation" })
set("Delimiter", { fg = colors.fg })
set("@tag.delimiter", { link = "Delimiter" })
set("@punctuation.special", { fg = "yellow" }, "swap")
set("@constructor.lua", { link = "Delimiter" })
set("Constant", { fg = "orange" }, "swap")
set("@constant.builtin", { link = "Constant" })
set("@string.escape", { link = "Constant" })
set("Keyword", { fg = "light_magenta", italic = true }, "swap")
set("@tag.blade", { link = "Keyword" })
set("@function.macro.rust", { link = "Keyword" })
set("@lsp.type.modifier", { link = "Keyword" })
set("@lsp.type.lifetime", { link = "Keyword" })
set("@tag", { fg = "pink" }, "swap")
set("String", { fg = "lime" }, "swap")
set("Identifier", { fg = "cyan" }, "swap")
set("@variable", { link = "Identifier" })
set("@variable.member", { link = "Identifier" })
set("Function", { fg = "dark_blue" }, "swap")
set("@module", { fg = "dark_cyan" }, "swap")
set("Type", { fg = "orange" }, "swap")
set("@lsp.type.enumMember", { fg = "orange" }, "swap")
set("@type.builtin", { fg = "orange", italic = true }, "swap")
set("@tag.attribute", { fg = "orange", italic = true }, "swap")
set("Special", { fg = "cyan" }, "swap")
set("PreProc", { fg = "dark_blue", italic = true }, "swap")
set("@lsp.type.macro.rust", { link = "PreProc" })
set("@lsp.type.selfKeyword", { fg = "red", bold = true }, "swap")

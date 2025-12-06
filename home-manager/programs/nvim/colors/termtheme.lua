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

local function set(name, dark_args, light_args)
	local args = dark_args
	if not colors.is_dark and light_args ~= nil then
		args = light_args
	end

	if args.fg and not args.ctermfg then
		args.ctermfg = color_to_term(args.fg)
	end
	if args.bg and not args.ctermbg then
		args.ctermbg = color_to_term(args.bg)
	end

	vim.api.nvim_set_hl(0, name, args)
end

vim.cmd("highlight clear")
vim.cmd("syntax reset")

set("Normal", { bg = "none", fg = colors.fg })
set("NonText", { bg = "none", fg = colors.fg })
set("Whitespace", { bg = "none", fg = colors.bg_tertiary })
set("Cursor", { bg = colors.fg, fg = colors.bg })
set("CursorLine", { bg = colors.bg_secondary })
set("Folded", { bg = "none", sp = colors.bg_tertiary, underdotted = true })
set("LineNr", { fg = colors.grey, italic = true })
set("CursorLineNr", { fg = colors.fg, bold = true })
set("VirtColumn", { fg = colors.bg_secondary }) -- the bar indicating 80/120 chars
set("StatusLine", { bg = "none", fg = colors.fg }) -- this is overridden by lualine but used sometimes
set("Directory", { fg = colors.light_blue })
set("Visual", { bg = colors.bg_tertiary })
set("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
set("CurSearch", { bg = colors.accent, fg = colors.bg, bold = true })
set("MatchParen", { bg = colors.bg_tertiary, fg = colors.fg, underline = true })
set("Pmenu", { bg = "none", fg = colors.fg })
set("PmenuSel", { link = "CurSearch" })
set("PmenuSbar", { bg = colors.bg_secondary, fg = colors.grey })
set("VertSplit", { fg = colors.border })
set("NormalFloat", { bg = "none", fg = colors.fg })
set("WinSeparator", { bg = "none", fg = colors.border })
set("FloatBorder", { link = "WinSeparator" })
set("FloatShadow", { bg = colors.bg_secondary })
set("FloatShadowThrough", { bg = colors.bg_secondary })
set("Title", { fg = colors.fg, bold = true })
set("Added", { fg = colors.lime })
set("Changed", { fg = colors.yellow })
set("Removed", { fg = colors.pink })
set("Error", { bg = colors.red, bold = true })
set("RenderMarkdownCodeInline", { italic = true, bg = colors.bg_secondary, fg = colors.fg })

set("DiagnosticHint", { fg = colors.light_blue })
set("DiagnosticInfo", { fg = colors.cyan })
set("DiagnosticOk", { fg = colors.lime })
set("DiagnosticWarn", { fg = colors.orange })
set("DiagnosticError", { fg = colors.pink })
set("DiagnosticUnderlineHint", { sp = colors.light_blue, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = colors.cyan, undercurl = true })
set("DiagnosticUnderlineOk", { sp = colors.lime, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = colors.orange, undercurl = true })
set("DiagnosticUnderlineError", { sp = colors.pink, undercurl = true })
set("DiagnosticUnnecessary", { fg = colors.light_grey, sp = colors.light_grey, underdotted = true })

set("SnacksIndent", { fg = colors.bg_secondary })
set("SnacksIndentScope", { fg = colors.dark_grey })
set("SnacksPickerInputBorder", { fg = colors.border_active })
set("SnacksPickerIcon", { link = "SnacksPickerInputBorder" })
set("SnacksPickerPrompt", { link = "Title" })
set("SnacksPickerFile", { fg = colors.fg_secondary })
set("SnacksPickerGitStatusModified", { link = "Changed" })
set("SnacksDim", { fg = colors.light_grey })

set("NoiceCmdlinePopupBorder", { fg = colors.accent })
set("NoiceCmdlineIcon", { link = "SnacksPickerInputBorder" })

set("MiniIconsRed", { fg = colors.pink })
set("MiniIconsOrange", { fg = colors.orange })
set("MiniIconsYellow", { fg = colors.yellow })
set("MiniIconsGreen", { fg = colors.lime })
set("MiniIconsCyan", { fg = colors.cyan })
set("MiniIconsBlue", { fg = colors.dark_blue })
set("MiniIconsAzure", { fg = colors.light_blue })
set("MiniIconsPurple", { fg = colors.light_magenta })
set("MiniIconsGrey", { fg = colors.light_grey })

set("Comment", { fg = colors.light_grey, italic = true })
set("@comment.documentation", { fg = colors.green, italic = true })
set("@lsp.mod.documentation", { link = "@comment.documentation" })
set("Delimiter", { fg = colors.fg })
set("@tag.delimiter", { link = "Delimiter" })
set("@punctuation.special", { fg = colors.yellow })
set("@constructor.lua", { link = "Delimiter" })
set("Constant", { fg = colors.orange })
set("@constant.builtin", { link = "Constant" })
set("@string.escape", { link = "Constant" })
set("Keyword", { fg = colors.light_magenta, italic = true })
set("@tag.blade", { link = "Keyword" })
set("@function.macro.rust", { link = "Keyword" })
set("@lsp.type.modifier", { link = "Keyword" })
set("@lsp.type.lifetime", { link = "Keyword" })
set("@tag", { fg = colors.pink })
set("String", { fg = colors.lime })
set("Identifier", { fg = colors.cyan })
set("@variable", { link = "Identifier" })
set("@variable.member", { link = "Identifier" })
set("Function", { fg = colors.dark_blue })
set("@module", { fg = colors.dark_cyan })
set("Type", { fg = colors.orange })
set("@lsp.type.enumMember", { fg = colors.orange })
set("@type.builtin", { fg = colors.orange, italic = true })
set("@tag.attribute", { fg = colors.orange, italic = true })
set("Special", { fg = colors.cyan })
set("PreProc", { fg = colors.dark_blue, italic = true })
set("@lsp.type.macro.rust", { link = "PreProc" })
set("@lsp.type.selfKeyword", { fg = colors.red, bold = true })

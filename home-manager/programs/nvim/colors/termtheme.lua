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
		if light_args == "swap" then
			local x = args.bg or colors.fg
			local x2 = args.ctermbg
			args.bg = args.fg
			args.ctermbg = args.ctermfg
			args.fg = x
			args.ctermfg = x2
			args.bold = true
		else
			args = light_args
		end
	end

	-- if args.fg and not args.ctermfg then
	-- 	args.ctermfg = color_to_term(args.fg)
	-- end
	-- if args.bg and not args.ctermbg then
	-- 	args.ctermbg = color_to_term(args.bg)
	-- end

	vim.api.nvim_set_hl(0, name, args)
end

vim.cmd("highlight clear")
vim.cmd("syntax reset")

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
set("Directory", { fg = colors.light_blue })
set("Visual", { bg = colors.bg_highlight })
set("Search", { bg = colors.yellow, fg = colors.bg, bold = true })
set("CurSearch", { bg = colors.accent, fg = colors.bg, bold = true })
set("MatchParen", { bg = colors.bg_highlight, fg = colors.fg_raised, underline = true })
set("Pmenu", { bg = "none", fg = colors.fg })
set("PmenuSel", { link = "CurSearch" })
set("PmenuSbar", { bg = colors.bg_raised, fg = colors.grey })
set("VertSplit", { fg = colors.border })
set("NormalFloat", { bg = "none", fg = colors.fg })
set("WinSeparator", { bg = "none", fg = colors.border })
set("FloatBorder", { link = "WinSeparator" })
set("FloatShadow", { bg = colors.bg_raised })
set("FloatShadowThrough", { bg = colors.bg_raised })
set("Title", { fg = colors.fg, bold = true })
set("Added", { fg = colors.lime }, "swap")
set("Changed", { fg = colors.yellow }, "swap")
set("Removed", { fg = colors.pink }, "swap")
set("Error", { bg = colors.red, bold = true }, "swap")
set("RenderMarkdownCodeInline", { italic = true, bg = colors.bg_highlight, fg = colors.fg })
set("RenderMarkdownH1Bg", { bg = colors.bg_highlight, bold = true, fg = colors.fg, sp = colors.grey, underline = true })
set(
	"RenderMarkdownH2Bg",
	{ bg = colors.bg_raised, bold = true, italic = true, fg = colors.fg, sp = colors.grey, underline = true }
)

set("DiagnosticHint", { fg = colors.light_blue }, "swap")
set("DiagnosticInfo", { fg = colors.cyan }, "swap")
set("DiagnosticOk", { fg = colors.lime }, "swap")
set("DiagnosticWarn", { fg = colors.orange }, "swap")
set("DiagnosticError", { fg = colors.pink }, "swap")
set("DiagnosticUnderlineHint", { sp = colors.light_blue, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = colors.cyan, undercurl = true })
set("DiagnosticUnderlineOk", { sp = colors.lime, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = colors.orange, undercurl = true })
set("DiagnosticUnderlineError", { sp = colors.pink, undercurl = true })
set("DiagnosticUnnecessary", { fg = colors.fg_secondary, sp = colors.fg_secondary, underdotted = true }, "swap")

set("SnacksIndent", { fg = colors.bg_raised })
set("SnacksIndentScope", { fg = colors.bg_highlight })
set("SnacksPickerInputBorder", { fg = colors.border_active })
set("SnacksPickerIcon", { link = "SnacksPickerInputBorder" })
set("SnacksPickerPrompt", { link = "Title" })
set("SnacksPickerFile", { fg = colors.fg_secondary })
set("SnacksPickerGitStatusModified", { link = "Changed" })
set("SnacksDim", { fg = colors.fg_secondary })

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

set(
	"Comment",
	{ fg = colors.green, italic = true },
	{ bg = colors.green, italic = true, bold = true, fg = colors.bg_highlight }
) -- test
set("@comment.documentation", { link = "Comment" })
set("@lsp.mod.documentation", { link = "@comment.documentation" })
set("Delimiter", { fg = colors.fg })
set("@tag.delimiter", { link = "Delimiter" })
set("@punctuation.special", { fg = colors.yellow }, "swap")
set("@constructor.lua", { link = "Delimiter" })
set("Constant", { fg = colors.orange }, "swap")
set("@constant.builtin", { link = "Constant" })
set("@string.escape", { link = "Constant" })
set("Keyword", { fg = colors.light_magenta, italic = true }, "swap")
set("@tag.blade", { link = "Keyword" })
set("@function.macro.rust", { link = "Keyword" })
set("@lsp.type.modifier", { link = "Keyword" })
set("@lsp.type.lifetime", { link = "Keyword" })
set("@tag", { fg = colors.pink }, "swap")
set("String", { fg = colors.lime }, "swap")
set("Identifier", { fg = colors.cyan }, "swap")
set("@variable", { link = "Identifier" })
set("@variable.member", { link = "Identifier" })
set("Function", { fg = colors.dark_blue }, "swap")
set("@module", { fg = colors.dark_cyan }, "swap")
set("Type", { fg = colors.orange }, "swap")
set("@lsp.type.enumMember", { fg = colors.orange }, "swap")
set("@type.builtin", { fg = colors.orange, italic = true }, "swap")
set("@tag.attribute", { fg = colors.orange, italic = true }, "swap")
set("Special", { fg = colors.cyan }, "swap")
set("PreProc", { fg = colors.dark_blue, italic = true }, "swap")
set("@lsp.type.macro.rust", { link = "PreProc" })
set("@lsp.type.selfKeyword", { fg = colors.red, bold = true }, "swap")

-- BLOOM
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#422654 guifg=#ffffff')
vim.cmd('highlight NonText guibg=#422654 guifg=#422654')
vim.cmd('highlight CursorLine guibg=#553c65')
vim.cmd('highlight LineNr guifg=#c487a5')
vim.cmd('highlight CursorLineNr guifg=#dcb7c9')
vim.cmd('highlight SignColumn guibg=#422654')
vim.cmd('highlight StatusLine gui=bold guibg=#40576f guifg=#eab25f')
vim.cmd('highlight StatusLineNC gui=bold guibg=#40576f guifg=#958567')
vim.cmd('highlight Directory guifg=#d175d1')
vim.cmd('highlight Visual guibg=#7b6787')
vim.cmd('highlight Search guibg=#623050 guifg=#e1563e')
vim.cmd('highlight CurSearch guibg=#ffffff guifg=#40576f')
vim.cmd('highlight IncSearch gui=None guibg=#ffffff guifg=#40576f')
vim.cmd('highlight MatchParen guibg=#623050 guifg=#e1563e')
vim.cmd('highlight Pmenu guibg=#40576f guifg=#ffffff')
vim.cmd('highlight PmenuSel guibg=#eab25f guifg=#422654')
vim.cmd('highlight PmenuSbar guibg=#526880 guifg=#bf5f42')
vim.cmd('highlight VertSplit guifg=#40576f')
vim.cmd('highlight MoreMsg guifg=#db86df')
vim.cmd('highlight Question guifg=#db86df')
vim.cmd('highlight Title guifg=#de4f94')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#754b91 gui=italic')
vim.cmd('highlight Constant guifg=#e2a49d')
vim.cmd('highlight Identifier guifg=#de4f94')
vim.cmd('highlight Statement guifg=#db95ba')
vim.cmd('highlight PreProc guifg=#db95ba')
vim.cmd('highlight Type guifg=#f46666 gui=None')
vim.cmd('highlight Special guifg=#db86df')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#e2a49d')
vim.cmd('highlight Number guifg=#e2a49d')
vim.cmd('highlight Boolean guifg=#80a7d0')
vim.cmd('highlight Function guifg=#e67f94')
vim.cmd('highlight Keyword guifg=#eab25f gui=italic')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#de4f94')
vim.cmd('highlight @tag.delimiter guifg=#db86df')
vim.cmd('highlight @tag.attribute guifg=#80a7d0')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#d03535')
vim.cmd('highlight Error guifg=#d03535')
vim.cmd('highlight DiagnosticError guifg=#d03535')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#502851 guifg=#d03535')
vim.cmd('highlight WarningMsg guifg=#eab25f')
vim.cmd('highlight DiagnosticWarn guifg=#eab25f')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#533455 guifg=#eab25f')
vim.cmd('highlight DiagnosticInfo guifg=#7981ec')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#482f63 guifg=#7981ec')
vim.cmd('highlight DiagnosticHint guifg=#81b0ee')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#483463 guifg=#81b0ee')
vim.cmd('highlight DiagnosticOk guifg=#78ea61')

-- Common plugins
vim.cmd('highlight CopilotSuggestion guifg=#754b91') -- Copilot suggestion
vim.cmd('highlight TelescopeSelection guibg=#7b6787') -- Telescope selection

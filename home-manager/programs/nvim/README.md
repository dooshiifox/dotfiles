# My Neovim Config

## Required features

- Theme
- Rust LSP
- Svelte LSP
- Typescript LSP
- Javascript LSP
- React LSP
- HTML LSP
- TOML LSP
- JSON LSP
- Nix LSP
- PHP LSP
- Lua LSP
- Python LSP
- Tailwind
- File browser
- Tabs
- Keyboard shortcuts
- Terminal
- Search
- ESLint
- Prettier
- Commenting & uncommenting
- Multi-cursor editing
- Split windows
- Indent guide
- Code completion
- Diagnostics
- Git integration?

## Included Features

- Code completion
  - [Blink (Default)](https://www.lazyvim.org/extras/coding/blink)
  - [nvim-cmp](https://www.lazyvim.org/extras/coding/nvim-cmp)
- Snippets
  - [mini.snippets (Default)](https://www.lazyvim.org/extras/coding/mini-snippets)
  - [Luasnip](https://www.lazyvim.org/extras/coding/luasnip)
- Comments
  - [mini.comment (Default)](https://www.lazyvim.org/extras/coding/mini-comment)
- Surround
  - [mini.surround (Default)](https://www.lazyvim.org/extras/coding/mini-surround)
- Doc comments
  - [neogen (Default)](https://www.lazyvim.org/extras/coding/neogen)
- Cut + Paste
  - [yanky.nvim (Default)](https://www.lazyvim.org/extras/coding/yanky)
- Debugging
  - [nvim-dap (Default)](https://www.lazyvim.org/extras/dap/core)
    - Neovim Lua
      - [nvim-dap (Default)](https://www.lazyvim.org/extras/dap/nlua)
- Tasks
  - [overseer.nvim (Default)](https://www.lazyvim.org/extras/editor/overseer)
- Code declaration overview
  - [Aerial (Default)](https://www.lazyvim.org/extras/editor/aerial)
  - [outline.nvim](https://github.com/hedyhli/outline.nvim)
- Rename
  - [Inc-rename (Default)](https://www.lazyvim.org/extras/editor/inc-rename)
- Refactoring
  - [refactoring.nvim (Default)](https://www.lazyvim.org/extras/editor/refactoring)
- Word Highlight
  - Snacks[?] (Default)
  - [Illuminate](https://www.lazyvim.org/extras/editor/illuminate)
- Selection moving
  - [mini.move (Default)](https://github.com/echasnovski/mini.move)
- Statusline location
  - [nvim-navic (Default)](https://www.lazyvim.org/extras/editor/navic)
- Cursor smoothing
  - [smear-cursor.nvim](https://www.lazyvim.org/extras/ui/smear-cursor)
  - [mini.animate](https://www.lazyvim.org/extras/ui/mini-animate)
- Git diffing
  - [mini.diff (Default)](https://www.lazyvim.org/extras/editor/mini-diff)
- File search
  - Snacks (Default)
  - [Telescope](https://www.lazyvim.org/extras/editor/telescope)
  - [fzf-lua](https://www.lazyvim.org/extras/editor/fzf)
- File browser
  - [neo-tree (Default)](https://www.lazyvim.org/extras/editor/neo-tree)
  - [mini.files](https://github.com/echasnovski/mini.files)
- Formatting
  - [Black (Default)](https://www.lazyvim.org/extras/formatting/black)
  - [Prettier (Default)](https://www.lazyvim.org/extras/formatting/prettier)
- Linting
  - [ESLint (Default)](https://www.lazyvim.org/extras/linting/eslint)
- LSP
  - [none-ls (Default)](https://www.lazyvim.org/extras/lsp/none-ls)
- Testing
  - [neotest (Default)](https://www.lazyvim.org/extras/test/core)
- UI Greeter
  - [snacks.nvim (Default)](https://github.com/folke/snacks.nvim)
  - [alpha-nvim](https://www.lazyvim.org/extras/ui/alpha)
  - [dashboard-nvim](https://www.lazyvim.org/extras/ui/dashboard-nvim)
  - [mini.starter](https://github.com/echasnovski/mini.starter)
- UI Layout
  - [edgy.nvim (Default)](https://www.lazyvim.org/extras/ui/edgy)
- Indentation Guides
  - snacks.nvim (Default)
  - [indent-blankline.nvim](https://www.lazyvim.org/extras/ui/indent-blankline)
  - [mini.indentscope](https://github.com/echasnovski/mini.indentscope)
- Sticky Headers
  - [nvim-treesitter-context](https://www.lazyvim.org/extras/ui/treesitter-context)

## Keymaps

[Full list here](https://www.lazyvim.org/keymaps#snacksnvim)

| Keybind                       | Description                      | Mode |
| ----------------------------- | -------------------------------- | ---- |
| `<Space><Space>`              | File picker                      | n    |
| `<Space>,`                    | Buffer picker                    | n    |
| `<Space>/`                    | Grep picker for directory        | n    |
| `<Ctrl><Alt><Down>`           | Duplicate line down              | n    |
| `<Space>fn`                   | New file                         | n    |
| `gco`                         | New comment below                | n    |
| `gcO`                         | New comment above                | n    |
| `<Space>uh`                   | Inlay hints                      | n    |
| `<Space>us`                   | Toggle spellcheck                | n    |
| `<Space>uw`                   | Toggle wordwrapping              | n    |
| `<Space>qq`                   | Quit all                         | n    |
| `<Alt><Grave>`                | Focus/Toggle terminal            | n, t |
| `<Super><Ctrl><Shift><Arrow>` | Resize in direction              | n    |
| `<Super><Ctrl><Arrow>`        | Switch to window in direction    | n, t |
| `<Space>-`                    | Split down                       | n    |
| `<Space><Pipe>`               | Split right                      | n    |
| `<Space>wd`                   | Close window                     | n    |
| `<Alt><Left/Right>`           | Switch buffer left / right       | n    |
| `<Alt><Up/Down>`              | Move line up / down              | n    |
| `<Space>bp`                   | Pin buffer                       | n    |
| `<Space>bP`                   | Close non-pinned buffers         | n    |
| `<Space>[B`                   | Move buffer left                 | n    |
| `<Space>]B`                   | Move buffer right                | n    |
| `<Space>bd`                   | Close buffer                     | n    |
| `<Space>bD`                   | Close buffer and window          | n    |
| `<Space>cf`                   | Format file                      | n    |
| `<Space>cd`                   | Diagnostics                      | n    |
| `<Space>ud`                   | Toggle diagnostics               | n    |
| `<Space>ca`                   | Code action                      | n, v |
| `<Space>cr`                   | Rename                           | n    |
| `<Space>cR`                   | Rename file                      | n    |
| `gd`                          | Goto definition                  | n    |
| `gr`                          | List references                  | n    |
| `[[`                          | Previous Reference               | n    |
| `]]`                          | Next Reference                   | n    |
| `gI`                          | Goto implementation              | n    |
| `gy`                          | Goto type defintion              | n    |
| `gD`                          | Goto delcaration                 | n    |
| `K`                           | Hover                            | n    |
| `gK`                          | Signature help                   | n    |
| `<Ctrl>k`                     | Signature help                   | i    |
| `<Ctrl>/`                     | Toggle comment                   | n    |
| `<Ctrl><Shift>/`              | Toggle block comment             | n    |
| `>>`                          | Indent line                      | n    |
| `>[n]`                        | Indent next `n` lines            | n    |
| `>i}`                         | Indent all code until }          | n    |
| `<Space>oo`                   | Run task                         | n    |
| `s`                           | Quick jump                       | n    |
| `<Space>snt`                  | Search Neovim notifications      | n    |
| `<Ctrl><Space>`               | Increment selection region       | n    |
| `<bs>`                        | Decrement selection region       | x    |
| `cir`                         | Change word under cursor         | n    |
| `gsa`                         | Surround with content            | n, v |
| `gsaat?`                      | Surround tag with custom content | n    |
| `gsdt`                        | Delete tag on cursor             | n    |

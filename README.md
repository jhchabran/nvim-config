# Neovim 0.5 config

A very opinionated configuration, with strong reminiscence of [Doom-Emacs](https://github.com/hlissner/doom-emacs), written in Lua.

## Core Principles

1. Comfort: I use this everyday, it has to be nice and enjoyable.
2. Fast: it must be extremely responsive, period.
3. Discoverable: stuff I cannot discover has no value.
4. Modern: favour Lua as long as it doesn't go against the above principles.

## General overview

- Most of the bindings are behind `<leader>` which is set to `Space`. Relies on [WhichKeys](https://github.com/folke/which-key.nvim) for discoverability.
- Filetype specific bindings are behind `<leader><leader>`.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) and [FZF](https://github.com/junegunn/fzf.vim).
- [LSP](https://microsoft.github.io/language-server-protocol/) centric.
- [Treesitter](https://github.com/tree-sitter/tree-sitter) for syntax highlighting and manipulations.
- [Colemak](https://colemak.com) keyboard layout; nothing is moved, but [EasyMotion](https://github.com/easymotion/vim-easymotion) keys are using Colemak home row.
- `<C-g>` is often bound to get out of popups.
- Very basic notes support written in Markdown, centralized in a folder. See the `jh.notes` module of this repository.
- Organized as following:
  - `init.lua` basic options and sensible defaults. Other files are loaded from there.
  - `jh/plugins.lua` dependencies and their basic configuration.
  - `jh/mappings.lua` general mappings, independant of any filetype.
  - `jh/utils.lua` set of little functions used here and here across the configuration.
  - `jh/*.lua` domain or language specific configurations.

## Languages

List of languages that this configuration accomodates for:

- Go
- Lua
- Markdown 

## Aesthetics

- Theme: [monarized](https://github.com/jhchabran/monarized), a washed down Solarized theme with less colors being used, while retaining colors where it matters (diff, UI, errors).
- Font: `Jetbrains Mono Thin` for normal text and `Jetbrains Mono Light` for bold.
- Terminal: [Alacritty](https://github.com/alacritty/alacritty), minimalist feature-set and easy to configure, with true colors support.

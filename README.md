# Neovim 0.6 config

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
- Typescript (nothing fancy, just LSP)

## Aesthetics

![](./screenshot.jpg)

- Theme: [monarized](https://github.com/jhchabran/monarized), a washed down Solarized theme with less colors being used, while retaining colors where it matters (diff, UI, errors).
- Font: `Jetbrains Mono Thin` for normal text and `Jetbrains Mono Light` for bold.

## Custom mappings overview

Because without discoverability, it's a conscious and distracting effort to remember what is the binding for an action is, this configuration relies on [which-key](https://github.com/folke/which-key.nvim) to display
a popup with the available bindings that follow a given key. 

Common actions are prefixed by the `<leader>` key, which is set to `SPACE`. Filetype specific bindings are under `<leader>SPACE`, which translates to typing `SPACE SPACE` in normal mode.

So, it means that typing `SPACE` in normal mode will show the popup summing up all common bindings, allowing to explore the available actions.

Other than that, `C-g` is a sort of `ESC`, bound to close terminals and Telescope pickers.

### Leader mappings

How to read this: 

- `e`: something 
  - `f`: some action

The above means that typing `<space>ef` in normal mode will execute _some action_. 

---
  - `:`: Find recent command
  - `b`: **Buffers**
    - `x`: Open scratch buffer
    - `a`: Switch back to previous buffer
    - `b`: Find buffer
    - `<Tab>`: Switch back to previous buffer
    - `n`: Next buffer
    - `d`: Delete current buffer
    - `p`: Previous buffer
    - `w`: close and save current buffer
  - `z`: **Settings Toggles**
    - `Z`: Dim unfocused code
    - `z`: Zen Mode
    - `i`: Indent Guide
    - `b`: Closing brackets annotations
    - `l`: Line numbers visibility
    - `c`: Hex colors highlighting
  - `f`: **Files**
    - `r`: Recent files
  - `p`: **Project**
    - `x`: Open project notes
    - `p`: Find File
    - `t`: List project TODOs
    - `f`: Find File
  - `g`: **Git**
    - `G`: Current changes
    - `b`: Show branches
    - `f`: Git fetch
    - `C`: Git checkout -b
    - `l`: Git log
    - `B`: Git Blame
    - `P`: Git push
    - `d`: **Diffing**
      - `m`: current file with main branch
      - `d`: current file with current branch
      - `c`: last commit
    - `z`: **Stashes**
      - `z`: run git stash
      - `l`: List stashes
    - `p`: Git pull
    - `g`: Git status
    - `w`: Git add %
    - `c`: Git commit
  - `w`: Save current buffer
  - `c`: **Code / LSP**
    - `j`: Workspace symbols
    - `a`: Code actions
    - `R`: References
    - ` `: Treesitter jump
    - `l`: Loclist
    - `q`: **Quickfix**
      - `p`: Previous error
      - `n`: Next error
      - `q`: Quickfix
    - `r`: rename
    - `d`: Definitions
    - `h`: hover
    - `i`: Implementations
    - `e`: **diagnostic**
      - `d`: Document diagnostics
      - `p`: previous
      - `w`: Workspace diagnostics
      - `n`: next
    - `f`: formatting
    - `c`: Document symbols
  - `o`: **Others**
    - `p`: Open project drawer
    - `t`: Toggle terminal
    - `l`: Toggle Loclist
    - `q`: Toggle Quickfix
  - `<S-w>`: Save current buffer and quit
  - `t`: **Tabs**
    - `N`: Prev tab
    - `q`: Close tab
    - `c`: Create tab
    - `n`: Next tab
  - `n`: **Notes**
    - `f`: Find notes
  - `G`: **GitHub**
    - `i`: **issues**
      - `m`: Mentions me
      - `a`: Assigned to me
      - `n`: New issue
      - `c`: Created by me
    - `p`: **pull-requests**
      - `m`: Mentions me
      - `a`: Assigned to me
      - `n`: New issue
      - `c`: Created by me
  - `d`: **Debugger**
    - `o`: Step out
    - `q`: Quit debugging
    - `n`: Step over
    - `c`: Continue
    - `r`: Restart
    - `i`: Step into
    - `t`: Toggle Breakpoint
    - `p`: Pause
    - `s`: Stop
  - `;`: Find command
  - `h`: **Help and misc helpers**
    - `T`: Monarized styles
    - `m`: Man pages
    - `_`: Copy in the OS clipboard a markdown dump of all leader mappings
    - `R`: Reload a module
    - `r`: Reload 'jh.*' lua modules
    - `p`: **Packages**
      - `S`: List packages
      - `u`: Update packages
      - `c`: Clean packages
      - `s`: Install packages
    - `t`: Color schemes
    - `h`: Inline help
  - `<Enter>`: Resume last picker
  - `.`: open relative
  - `e`: **Easy movements**
    - `e`: Jump to words
    - `i`: Jump to characters
    - ` `: Jump to pattern
    - `n`: Jump to lines
  - `s`: **Search**
    - `p`: Find in project
    - `R`: Search and replace in current project
    - `b`: Fuzzy search in current buffer
    - `c`: Clear search
```

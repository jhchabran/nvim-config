# Neovim 0.6 config

A very opinionated configuration, with strong reminiscence of [Doom-Emacs](https://github.com/hlissner/doom-emacs), written in Lua.

The strongest opinion you'll find here is that I tend to bring features within Neovim rather than going back to the shell. I'd rather write Lua than shellscripts. That being said
you won't find big UI plugins either, they tend to be not very vim'ish enough to my taste.

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
  - `.`: open relative
  - `<Enter>`: Resume last picker
  - `:`: Find recent command
  - `o`: **Others**
    - `l`: Toggle Loclist
    - `t`: Toggle terminal
    - `p`: Open project drawer
    - `q`: Toggle Quickfix
  - `<S-w>`: Save current buffer and quit
  - `b`: **Buffers**
    - `w`: close and save current buffer
    - `n`: Next buffer
    - `b`: Find buffer
    - `<Tab>`: Switch back to previous buffer
    - `x`: Open scratch buffer
    - `a`: Switch back to previous buffer
    - `p`: Previous buffer
    - `d`: Delete current buffer
  - `h`: **Help and misc helpers**
    - `t`: Color schemes
    - `m`: Man pages
    - `_`: Copy in the OS clipboard a markdown dump of all leader mappings
    - `r`: Reload 'jh.*' lua modules
    - `R`: Reload a module
    - `h`: Inline help
    - `p`: **Packages**
      - `S`: List packages
      - `u`: Update packages
      - `c`: Clean packages
      - `s`: Install packages
    - `T`: Monarized styles
  - `t`: **Tabs**
    - `q`: Close tab
    - `c`: Create tab
    - `n`: Next tab
    - `N`: Prev tab
  - `w`: Save current buffer
  - `c`: **Code / LSP**
    - ` `: Treesitter jump
    - `R`: References
    - `i`: Implementations
    - `h`: hover
    - `l`: **Code Lens**
      - `l`: Run
      - `e`: Refresh
    - `t`: Go to type definition
    - `w`: Delete trailing whitespaces
    - `c`: Document symbols
    - `f`: formatting
    - `e`: **diagnostic**
      - `w`: Workspace diagnostics
      - `n`: next
      - `d`: Document diagnostics
      - `p`: previous
    - `L`: Loclist
    - `r`: rename
    - `d`: Definitions
    - `j`: Workspace symbols
    - `a`: Code actions
    - `k`: **Call tree**
      - `o`: Outgoing calls
      - `i`: Incoming calls
      - `k`: Symbols outline
    - `q`: **Quickfix**
      - `n`: Next error
      - `p`: Previous error
      - `q`: Quickfix
  - `f`: **Files**
    - `r`: Recent files
  - `z`: **Settings Toggles**
    - `l`: Line numbers visibility
    - `i`: Indent Guide
    - `b`: Closing brackets annotations
    - `Z`: Dim unfocused code
    - `c`: Hex colors highlighting
    - `z`: Zen Mode
    - `s`: Toggle status line
  - `e`: **Easy movements**
    - `l`: Jump to lines
    - `i`: Jump to characters
    - `e`: Jump to words
    - ` `: Jump to pattern
  - `s`: **Search**
    - `b`: Fuzzy search in current buffer
    - `R`: Search and replace in current project
    - `s`: Find in project
    - `c`: Clear search
    - `p`: Find in project
  - `p`: **Project**
    - `x`: Open project notes
    - `f`: Find File
    - `t`: List project TODOs
  - `d`: **Debugger**
    - `t`: Debug test
    - `o`: Step out
    - `i`: Step in
    - `b`: Toggle breakpoint
    - `u`: Toggle UI
    - `d`: Toggle debbuger
    - `n`: Step over
    - `c`: Continue or start debuggger
  - `g`: **Git**
    - `C`: Git checkout -b
    - `B`: Git Blame
    - `w`: Git add %
    - `c`: Git commit
    - `g`: Git status
    - `z`: **Stashes**
      - `l`: List stashes
      - `z`: run git stash
    - `P`: Git push
    - `p`: Git pull
    - `b`: Show branches
    - `f`: Git fetch
    - `G`: Current changes
    - `d`: **Diffing**
      - `C`: current branch against last commit
      - `d`: current file against current branch
      - `M`: current branch against main branch
      - `c`: current file against last commit
      - `m`: current file against main branch
      - `D`: current branch
    - `l`: Git log
  - `;`: Find command
  - `G`: **GitHub**
    - `i`: List issues
    - `b`: Open the current repo in a browser
    - `c`: Create a PR and open it in a browser
    - `o`: Open the PR in a browser
    - `p`: List PRs
  - `n`: **Notes**
    - `f`: Find notes
```

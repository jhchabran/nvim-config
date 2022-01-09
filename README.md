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
  - `n`: **Notes**
    - `f`: Find notes
  - `G`: **GitHub**
    - `o`: Open the PR in a browser
    - `p`: List PRs
    - `b`: Open the current repo in a browser
    - `i`: List issues
    - `c`: Create a PR and open it in a browser
  - `s`: **Search**
    - `R`: Search and replace in current project
    - `p`: Find in project
    - `c`: Clear search
    - `b`: Fuzzy search in current buffer
    - `s`: Find in project
  - `g`: **Git**
    - `z`: **Stashes**
      - `l`: List stashes
      - `z`: run git stash
    - `B`: Git Blame
    - `p`: Git pull
    - `f`: Git fetch
    - `P`: Git push
    - `c`: Git commit
    - `C`: Git checkout -b
    - `w`: Git add %
    - `G`: Current changes
    - `b`: Show branches
    - `d`: **Diffing**
      - `C`: current branch against last commit
      - `D`: current branch
      - `m`: current file against main branch
      - `d`: current file against current branch
      - `M`: current branch against main branch
      - `c`: current file against last commit
    - `l`: Git log
    - `g`: Git status
  - `w`: Save current buffer
  - `b`: **Buffers**
    - `n`: Next buffer
    - `p`: Previous buffer
    - `<Tab>`: Switch back to previous buffer
    - `w`: close and save current buffer
    - `b`: Find buffer
    - `d`: Delete current buffer
    - `x`: Open scratch buffer
    - `a`: Switch back to previous buffer
  - `h`: **Help and misc helpers**
    - `T`: Monarized styles
    - `p`: **Packages**
      - `S`: List packages
      - `u`: Update packages
      - `c`: Clean packages
      - `s`: Install packages
    - `t`: Color schemes
    - `m`: Man pages
    - `_`: Copy in the OS clipboard a markdown dump of all leader mappings
    - `h`: Inline help
    - `R`: Reload a module
    - `r`: Reload 'jh.*' lua modules
  - `z`: **Settings Toggles**
    - `Z`: Dim unfocused code
    - `z`: Zen Mode
    - `b`: Closing brackets annotations
    - `c`: Hex colors highlighting
    - `l`: Line numbers visibility
    - `i`: Indent Guide
  - `<Enter>`: Resume last picker
  - `<S-w>`: Save current buffer and quit
  - `f`: **Files**
    - `r`: Recent files
  - `c`: **Code / LSP**
    - `a`: Code actions
    - `j`: Workspace symbols
    - `w`: Delete trailing whitespaces
    - `q`: **Quickfix**
      - `p`: Previous error
      - `n`: Next error
      - `q`: Quickfix
    - `d`: Definitions
    - `l`: **Code Lens**
      - `l`: Run
      - `e`: Refresh
    - `r`: rename
    - `R`: References
    - `t`: Go to type definition
    - `c`: Document symbols
    - `k`: **Call tree**
      - `k`: Symbols outline
      - `i`: Incoming calls
      - `o`: Outgoing calls
    - `e`: **diagnostic**
      - `w`: Workspace diagnostics
      - `p`: previous
      - `d`: Document diagnostics
      - `n`: next
    - `h`: hover
    - ` `: Treesitter jump
    - `L`: Loclist
    - `i`: Implementations
    - `f`: formatting
  - `t`: **Tabs**
    - `n`: Next tab
    - `N`: Prev tab
    - `q`: Close tab
    - `c`: Create tab
  - `e`: **Easy movements**
    - `e`: Jump to words
    - ` `: Jump to pattern
    - `l`: Jump to lines
    - `i`: Jump to characters
  - `o`: **Others**
    - `q`: Toggle Quickfix
    - `p`: Open project drawer
    - `l`: Toggle Loclist
    - `t`: Toggle terminal
  - `:`: Find recent command
  - `p`: **Project**
    - `x`: Open project notes
    - `f`: Find File
    - `t`: List project TODOs
  - `;`: Find command
  - `d`: **Debugger**
    - `n`: Step over
    - `p`: Pause
    - `t`: Toggle Breakpoint
    - `s`: Stop
    - `q`: Quit debugging
    - `o`: Step out
    - `c`: Continue
    - `r`: Restart
    - `i`: Step into
  - `.`: open relative
```

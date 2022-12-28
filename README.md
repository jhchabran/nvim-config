# Neovim 0.8 config

A very opinionated configuration, with strong reminiscence of [Doom-Emacs](https://github.com/hlissner/doom-emacs), written in ~Lua~ Fennel.

## Core Principles

1. Comfort: I use this everyday, it has to be nice and enjoyable.
2. Fast: it must be extremely responsive, period.
3. Discoverable: stuff I cannot discover has no value.
4. Fun: I like Lisps. It's written in Fennel.

## Why is it written in Fennel?

There is not grand reason behind it, it's simply because it's so damn fun to write code in a Lisp-based language, at least for me. Lua is a great language, whose pragmatism and simplicity shares echoes Go which I use everyday at work. But when I'm hacking on my config, those are not the properties I'm looking for, I'm instead after joy and something refreshing so really separate it from work relaetd coding tasks. I love Lisps in general too, so there's that. 

So no, my config is not faster than writing it in Lua (though perhaps as I'm more motivated to tweak it I may fix things I wouldn't have otherwise?) and as long as starting a new Neovim session takes less than 500ms I'm happy. 

There are no external dependencies for fancy macros, first it would steal me half the fun of writing them and secondly I want to be make sure I fully own them, because if something goes wrong, I want to be able to understand them from top to bottom, which would be harder if I imported dozens of heavy macros from someone else.

If you want to use this config as a starting point to write your own in Fennel, there is no fancy module layout, it's plain a bunch of classic `require` calls. Code is separated in two buckets, `lib/*` which provides a bunch of macros and helpers and the rest is under `conf/*` which plugs everything in.

TL;DR It's fun, it's my little LISP haven.

## Installation

1. Clone the repo.
2. Start neovim, ignore the tons of error
3. Run `:PackerInstall`
4. Restart neovim (should get zero errors this time)
5. You're good to go :rainbow:

## General overview

- Most of the bindings are behind `<leader>` which is set to `Space`. Relies on [WhichKeys](https://github.com/folke/which-key.nvim) for discoverability.
- Filetype specific bindings are behind `<leader>m`.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) and [FZF](https://github.com/junegunn/fzf.vim).
- [LSP](https://microsoft.github.io/language-server-protocol/) centric.
- [Treesitter](https://github.com/tree-sitter/tree-sitter) for syntax highlighting and manipulations.
- [Colemak](https://colemak.com) keyboard layout; nothing is moved, but [EasyMotion](https://github.com/easymotion/vim-easymotion) keys are using Colemak home row.
- `<C-g>` is often bound to get out of popups.
- Organized as following:
  - `init.lua` bootstrap Packer and Hotpot then call `fnl/init.fnl`
  - `fnl/plugins.fnl` dependencies and their basic configuration.
  - `fnl/mappings.lua` general mappings, independant of any filetype.

## Languages

List of languages that this configuration accomodates for:

- Go
- Lua

## Aesthetics

- Themes: I change the default theme quite often.
- Font: `Jetbrains Mono Thin` for normal text and `Jetbrains Mono Light` for bold.

## Custom mappings overview

Because without discoverability, it's a conscious and distracting effort to remember what is the binding for an action is, this configuration relies on [which-key](https://github.com/folke/which-key.nvim) to display
a popup with the available bindings that follow a given key.

Common actions are prefixed by the `<leader>` key, which is set to `SPACE`. Filetype specific bindings are under `<leader>SPACE`, which translates to typing `SPACE SPACE` in normal mode.

So, it means that typing `SPACE` in normal mode will show the popup summing up all common bindings, allowing to explore the available actions.

Other than that, `C-g` is a sort of `ESC`, bound to close terminals and Telescope pickers.


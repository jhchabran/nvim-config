-- https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'mouse', 'a')                                -- Useful when browsing
opt('o', 'clipboard', 'unnamedplus')                  -- Put those yanks in my os clipboards
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for compe)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'incsearch', true)                           -- Make search behave like modern browsers
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 10)                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'list', false)                               -- Show some invisible characters (tabs...)
opt('w', 'number', false)                             -- Print line number
opt('w', 'relativenumber', false)                     -- Relative line numbers
opt('w', 'wrap', true)                                -- Enable line wrap
opt('o', 'cmdheight', 2)                              -- More space to display messages
opt('o', 'timeoutlen', 400)                           -- Don't wait more that 400ms for normal mode commands

vim.opt.shada = { "!", "'1000", "<50", "s10", "h" }   -- remember stuff across sessions
vim.api.nvim_command('noswapfile')                    -- I have OCD file saving issues anyway

vim.g['python3_host_prog'] = '~/.asdf/shims/python3'  -- Use this python binary

-- set leader to space early
vim.g.mapleader = ' '

require("jh.plugins")
require("jh.lsp")
require("jh.mappings")
require("jh.go")
require("jh.lua")
require("jh.markdown")

require('colorbuddy').colorscheme('monarized')

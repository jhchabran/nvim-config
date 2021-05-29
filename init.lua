-- helpers --
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local helpers = {}
helpers.find_files_in_directory_of_buffer = 
-- plugins --
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', run = fn['remote#host#UpdateRemotePlugins']}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'folke/which-key.nvim'}            -- I miss doom emacs
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}   -- is that really a TUI app?
paq {'tjdevries/colorbuddy.nvim'}       -- a theme engine
paq {'maaslalani/nordbuddy'}            -- a nice theme
paq {'kosayoda/nvim-lightbulb'}         -- display a lightbulb when there is a code action available
paq {'lewis6991/gitsigns.nvim'}         -- git gutter 

-- languages support
paq {'fatih/vim-go'}

g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup
g['python3_host_prog'] = '~/.asdf/shims/python3'

-- options -- 
require('colorbuddy').colorscheme('nordbuddy')

-- https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', 2)                             -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', 2)                                -- Number of spaces tabs count for
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )                             -- Lines of context
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
opt('w', 'wrap', false)                               -- Disable line wrap
opt('o', 'cmdheight', 2)                              -- More space to display messages

-- mappings --
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- set leader to space
map('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

local wk = require("which-key")
wk.register({
  w = { "<cmd>:w<CR>", "Save current buffer" },
  ["."] = { function() require('telescope.builtin').find_files({ cwd = vim.fn.expand("%:p:h") }) end, "open relative"},
  c = {
    name = "LSP",
    e = {
      name = "diagnostic",
      p = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "previous"},
      n = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next"},
    },
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "definition"},
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting"},
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover"},
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
    x = { "<cmd>lua vim.lsp.buf.references()<CR>", "references"},
    s = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "document symbol"},
  },
  p = {
    name = "project", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
--    n = { "New File" }, -- just a label. don't create any mapping
--    e = "Edit File", -- same as above
--    ["1"] = "which_key_ignore",  -- special label to hide it in the popup
--    b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
  h = {
    name = "helpers",
    p = {
      name = "packages",
      i = { "<cmd>PaqInstall<CR>", "Install packages" },
      u = { "<cmd>PaqUpdate<CR>", "Update packages" },
      c = { "<cmd>PaqClean<CR>", "Clean packages" },
      l = { "<cmd>PaqList<CR>", "List packages" }
    },
    },
}, { prefix = "<leader>" })

cmd(([[
autocmd FileType rst lua whichkeyrST()
autocmd FileType go lua whichkeyGo()
]]))

_G.whichkeyGo = function()
  local wk = require("which-key")
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    [" "] = {
      name = "Go",
      b = { "<cmd>GoBuild<CR>", "go build" },
      i = { "<cmd>GoInstall<CR>", "go install" },
      r = { "<cmd>GoRun<CR>", "go run" },
      r = { "<cmd>GoRun<CR>", "go run" },
      t = {
        name = "Test",
        a = { "<cmd>GoTest ./...<CR>", "go test ./..."},
        s = { "<cmd>GoTestFunc<CR>", "go test -s [current test]"},
      },
      c = {
        name = "Coverage",
        c = { "<cmd>GoCoverage<cmd>", "annotate with coverage"},
        t = { "<cmd>GoCoverageToggle", "toggle coverage display"},
        C = { "<cmd>GoCoverageClear<cmd>", "clear coverage"},
        b = { "<cmd>GoCoverageBrowser<cmd>", "open coverage in a browser"},
      },
      a = { "<cmd>GoAlternate<CR>", "alternate impl and test"},
    },
  }, { prefix = "<leader>"})
end

-- lsp --
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list


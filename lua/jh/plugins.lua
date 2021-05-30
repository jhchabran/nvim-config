vim.cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq      -- a convenient alias
paq {'savq/paq-nvim', opt = true}        -- paq-nvim manages itself

paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'hrsh7th/nvim-compe'}               -- autocompletion
paq {'hrsh7th/vim-vsnip'}                -- snippets
paq {'hrsh7th/vim-vsnip-integ'}          
paq {'junegunn/fzf', run = vim.fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'folke/which-key.nvim'}            -- discoverable bingings
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}   -- is that really a TUI app?
paq {'tjdevries/colorbuddy.nvim'}       -- a theme engine
paq {'jhchabran/monarized'}             -- my own theme
paq {'kosayoda/nvim-lightbulb'}         -- display a lightbulb when there is a code action available
paq {'lewis6991/gitsigns.nvim'}         -- git gutter 
paq {'numtostr/FTerm.nvim'}             -- floating terminal
paq {'tpope/vim-fugitive'}              -- git all the things
paq {'tpope/vim-commentary'}            
paq {'tpope/vim-repeat'}             
paq {'tpope/vim-vinegar'}
paq {'easymotion/vim-easymotion'}       -- jump everywhere like a madman
paq {'vimwiki/vimwiki'}
paq {'kyazdani42/nvim-web-devicons'}    -- all the icons
paq {'hoob3rt/lualine.nvim'}            -- status line with goodies

-- languages support
paq {'fatih/vim-go'}
require('lspconfig').gopls.setup{}
paq {'npxbr/glow.nvim', run = "go get github.com/charmbracelet/glow"}

require('telescope').setup({
  defaults = {
    prompt_position = "top",
  },
})

-- misc setups
require('FTerm').setup()

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = false;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

-- disable easy motion default mappings, they eat all leader keys otherwise
vim.g.EasyMotion_do_mapping = 0

-- Colemak user here, use my homerow and above
vim.g.EasyMotion_keys = 'tnseriaoplfuwydhpj'
vim.g.EasyMotion_smartcase = 1

-- Use markdown for vimwiki
vim.g.vimwiki_list = {{ path = '~/Notes', syntax = 'markdown', ext = '.md' }}

require('lualine').setup({options = {theme = 'solarized'}})

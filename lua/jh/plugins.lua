return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- incremental syntax parsing, the mother of modernity
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter.configs'
      ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}
    end
  }
  -- LSP goodies
  use {
    'onsails/lspkind-nvim', 'neovim/nvim-lspconfig', -- '~/projects/personal/lsp-status.nvim',
    'glepnir/lspsaga.nvim', -- 'folke/trouble.nvim'
  }
  -- Debugger
  use { 'puremourning/vimspector' }
  -- autocompletion
  use {
    'hrsh7th/nvim-compe',
    config = function()
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
        }
      }
    end
  }
  -- trailing whitespaces
  use {
    'ntpeters/vim-better-whitespace',
    config = function()
      -- strip only if I touched the line
      vim.g.strip_only_modified_lines = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
    end
  }

  -- snippets
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/vim-vsnip-integ'}
  use {'golang/vscode-go'}

  -- fast fuzzy finder
  use {'junegunn/fzf', run = vim.fn['fzf#install']}
  use {'junegunn/fzf.vim'}
  use {'ojroques/nvim-lspfuzzy'}

  -- discoverable bingings
  use {'folke/which-key.nvim'}
  -- config lua stuff for me please
  use {'folke/lua-dev.nvim'}
  -- A great UI plugin to pick things
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_position = "top",
          sorting_strategy = "ascending",
        },
      })
    end
  }
  -- a theme engine
  use {'tjdevries/colorbuddy.nvim'}
  -- display a lightbulb when there is a code action available
  use {'kosayoda/nvim-lightbulb'}
  -- git gutter
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }
  -- floating terminal
  use {
    'numtostr/FTerm.nvim',
    config = function()
      require('FTerm').setup()
    end
  }
  -- tpope, the legend
  use {'tpope/vim-fugitive'}   -- git
  use {'tpope/vim-commentary'} -- comments
  use {'tpope/vim-repeat'}     -- repeat commands
  use {'tpope/vim-vinegar'}    -- press - for local filebrowser
  use {'tpope/vim-surround'}   -- cs)] turns surrounding ) into ]

  -- kangaroo based motions, jump everywhere
  use {
    'easymotion/vim-easymotion',
    config = function()
      -- disable easy motion default mappings, they eat all leader keys otherwise
      vim.g.EasyMotion_do_mapping = 0
      -- Colemak user here, use my homerow and above
      vim.g.EasyMotion_keys = 'tnseriaoplfuwydhpj'
      vim.g.EasyMotion_smartcase = 1
    end
  }

  -- quickfix enhancements
  use { 'romainl/vim-qf' }

  -- File tree
  use {'kyazdani42/nvim-web-devicons'}
  use {'kyazdani42/nvim-tree.lua'}

  -- status line with goodies
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup({options = {theme = 'solarized'}})
    end
  }
  -- popup markdown preview
  use {'npxbr/glow.nvim', run = ":GlowInstall"}

  -- best language plugin ever created
  use {
    'fatih/vim-go',
    config = function()
      vim.g.go_auto_type_info = 1
    end
  }

  -- my stuff ----------------------------------
  -- theme
  use {'~/code/src/github.com/jhchabran/monarized'}
end)

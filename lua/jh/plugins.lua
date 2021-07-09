return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- incremental syntax parsing, the mother of modernity
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter.configs"
      ts.setup { ensure_installed = "maintained", highlight = { enable = true } }
    end,
  }
  -- LSP goodies
  use {
    "onsails/lspkind-nvim",
    "neovim/nvim-lspconfig", -- '~/projects/personal/lsp-status.nvim',
    "glepnir/lspsaga.nvim", -- 'folke/trouble.nvim'
  }
  -- Debugger
  use { "puremourning/vimspector" }
  -- autocompletion
  use {
    "hrsh7th/nvim-compe",
    config = function()
      require("compe").setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = { path = true, buffer = false, calc = true, nvim_lsp = true, nvim_lua = true, vsnip = true },
      }
    end,
  }
  -- trailing whitespaces
  use {
    "ntpeters/vim-better-whitespace",
    config = function()
      -- strip only if I touched the line
      vim.g.strip_only_modified_lines = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
    end,
  }

  -- align stuff
  use { 'junegunn/vim-easy-align' }

  -- snippets
  use { "hrsh7th/vim-vsnip" }
  use { "hrsh7th/vim-vsnip-integ" }
  use { "golang/vscode-go" }

  -- fast fuzzy finder
  use { "junegunn/fzf", run = vim.fn["fzf#install"] }
  use { "junegunn/fzf.vim" }
  use { "ojroques/nvim-lspfuzzy" }

  -- discoverable bingings
  use { "folke/which-key.nvim" }
  -- config lua stuff for me please
  use { "folke/lua-dev.nvim" }
  -- use {
  --   "lukas-reineke/format.nvim",
  --   config = function()
  --     require"format".setup { lua = { { cmd = { "lua-format -i" } } } }

  --     vim.cmd(([[
  --     autocmd BufWritePost * FormatWrite
  --     ]]))

  --   end,
  -- }

  -- A great UI plugin to pick things
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      local actions = require('telescope.actions')
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top"
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<c-g>"] = actions.close,
            },
            n = {
              ["<c-g>"] = actions.close,
            },
          }
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              }
            }
          }
        }
      })
    end,
  }
  -- a theme engine
  use { "tjdevries/colorbuddy.nvim" }
  -- a small plugin to HL hex colors on the fly, it makes it easier to tweak themes
  use { "chrisbra/Colorizer" }
  -- display a lightbulb when there is a code action available
  use { "kosayoda/nvim-lightbulb" }
  -- git stuff
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("gitsigns").setup() end,
  }
  use { 'TimUntersberger/neogit' }
  use { "tpope/vim-fugitive" }
  -- floating terminal
  use { "numtostr/FTerm.nvim", config = function() require("FTerm").setup() end }
  -- tpope, the legend
  use { "tpope/vim-commentary" } -- comments
  use { "tpope/vim-repeat" } -- repeat commands
  use { "tpope/vim-vinegar" } -- press - for local filebrowser
  use { "tpope/vim-surround" } -- cs)] turns surrounding ) into ]

  -- kangaroo based motions, jump everywhere
  use {
    "easymotion/vim-easymotion",
    config = function()
      -- disable easy motion default mappings, they eat all leader keys otherwise
      vim.g.EasyMotion_do_mapping = 0
      -- Colemak user here, use my homerow and above
      vim.g.EasyMotion_keys = "tnseriaoplfuwydhpj"
      vim.g.EasyMotion_smartcase = 1
    end,
  }

  -- Comment keywords
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        signs = false,
        keywords = {
          TODO = { icon = " ", color = "warning" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        highlight = { pattern = [[.*<(KEYWORDS)\s*]], keyword = "bg", after = "fg", comments_only = true },

        search = { pattern = [[\b(KEYWORDS)(\s+|$|\(\w+\))]] },
      })
    end,
  }

  -- Sessions
  use { "rmagatti/auto-session", config = function() require("auto-session").setup({}) end }
  use {
    "rmagatti/session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function() require("session-lens").setup({}) end,
  }

  -- quickfix enhancements
  use { "romainl/vim-qf" }

  -- File tree
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }

  -- status line with goodies
  use { "hoob3rt/lualine.nvim", config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = 'solarized',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 1, color = { fg = '#fff' }}, {'diff', colored = false }},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
      },
      extensions = {}
    })
  end}

  -- indent guide
  use { "lukas-reineke/indent-blankline.nvim", config = function() vim.g.indent_blankline_enabled = false end}

  -- popup markdown preview
  use { "npxbr/glow.nvim", run = ":GlowInstall" }
  -- do not lose me on ^D
  use { "psliwka/vim-smoothie" }

  -- Go stuff
  -- best language plugin ever created
  use { "fatih/vim-go", config = function() vim.g.go_auto_type_info = 1 end }
  -- linter that use the diagnostics api
  -- use { "mfussenegger/nvim-lint" }
  use { "/Users/tech/code/src/github.com/mfussenegger/nvim-lint" }

  -- my stuff ----------------------------------
  -- theme
  use { "~/code/src/github.com/jhchabran/monarized" }
  use 'marko-cerovac/material.nvim'
end)

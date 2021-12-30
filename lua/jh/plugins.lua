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
  -- language specific selections, based on treesitter
  use 'David-Kunz/treesitter-unit'
  -- Annotations on closing brackets
  use { 'code-biscuits/nvim-biscuits',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-biscuits').setup({
        cursor_line_only = true
      })
    end
  }
  -- LSP goodies
  use {
    "onsails/lspkind-nvim",
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim",
    -- 'jhchabran/litee.nvim', branch = 'keymaps',
    "~/play/litee.nvim",
    config = function()
      -- Litee bindings
      vim.cmd(([[
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "<Tab>", ":LTExpand<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "zo", ":LTExpand<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "zc", ":LTCollapse<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "zM", ":LTCollapseAll<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "<CR>", ":LTJump<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "t", ":LTJumpTab<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "v", ":LTJumpVSplit<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "s", ":LTJumpSplit<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "h", ":LTHover<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "q", ":q<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", "<", ":vert resize -10<CR>", {})
      autocmd Filetype litee lua vim.api.nvim_set_keymap("n", ">", ":vert resize +10<CR>", {})
      ]]))

    require('litee').setup({
      layout_size = 50,
      icons = "nerd",
      disable_default_keymaps = true,
    })
    end
  }
  -- Debugger
  -- use { "puremourning/vimspector" }
  -- autocompletion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      {"onsails/lspkind-nvim"},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lua'},
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        formatting = {
          format = lspkind.cmp_format(),
        },
        sources = {
          { name = 'buffer' },
          { name = 'path' },
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"]() == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-g>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
      })
    end
  }

  -- align stuff
  use { 'junegunn/vim-easy-align' }

  -- snippets
  -- use { "hrsh7th/vim-vsnip" }
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
  use { "nvim-telescope/telescope-file-browser.nvim", config = function()
    require("telescope").load_extension "file_browser"
  end}
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {
    'nvim-telescope/telescope-github.nvim',
    config = function()
      require('telescope').load_extension('gh')
    end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function() require('telescope').load_extension('fzf') end
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }

  -- stop firing vim within vim
  use "lambdalisue/guise.vim"

  -- a theme engine
  use { "tjdevries/colorbuddy.nvim" }
  -- a cool theme
  use 'folke/tokyonight.nvim'
  use 'shaunsingh/nord.nvim'
  use 'mhartington/oceanic-next'
  use 'luisiacc/gruvbox-baby'
  use 'kvrohit/substrata.nvim'

  -- a small plugin to HL hex colors on the fly, it makes it easier to tweak themes
  use { "chrisbra/Colorizer" }
  -- display a lightbulb when there is a code action available
  use { "kosayoda/nvim-lightbulb" }

  -- zen mode
  use { "folke/zen-mode.nvim", config = function()
    require("zen-mode").setup {}
  end}
  -- dim code that is not focused
  use { "folke/twilight.nvim", config = function()
    require("twilight").setup {}
  end}

  -- git stuff
  -- link to various forges
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require"gitlinker".setup() end
  }
  -- display status in the margin
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("gitsigns").setup() end,
  }

  -- I like neogit, because I'm a magit fan, but it's too young and fugitive rocks
  use { "tpope/vim-fugitive" }

  -- floating terminal
  use { "numtostr/FTerm.nvim" }

  -- comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- tpope, the legend
  use { "tpope/vim-repeat" } -- repeat commands
  use { "tpope/vim-vinegar" } -- press - for local filebrowser
  use { "tpope/vim-surround" } -- cs)] turns surrounding ) into ]

  -- kangaroo based motions, jump everywhere
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'arstneodhqwfpjluy' }
    end
  }

  -- quickfix enhancements
  use { "romainl/vim-qf" }

  -- File tree
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua", config = function()
    require'nvim-tree'.setup {
      diagnostics = { enable = false },
      update_focused_file = {
        enable = true,
      }
    }

    -- vim.cmd(([[
    -- let g:nvim_tree_icons = {
    -- \ 'default': '',
    -- \ 'symlink': '',
    -- \ 'git': {
    -- \   'unstaged': "✗",
    -- \   'staged': "✓",
    -- \   'unmerged': "",
    -- \   'renamed': "➜",
    -- \   'untracked': "﹖",
    -- \   'deleted': "",
    -- \   'ignored': "…"
    -- \  },
    -- \ 'folder': {
    -- \   'arrow_open': "",
    -- \   'arrow_closed': "",
    -- \   'default': "",
    -- \   'open': "",
    -- \   'empty': "",
    -- \   'empty_open': "",
    -- \   'symlink': "",
    -- \   'symlink_open': "",
    -- \   },
    -- \   'lsp': {
    -- \     'hint': "",
    -- \     'info': "",
    -- \     'warning': "",
    -- \     'error': "",
    -- \   }
    -- \ }
    -- ]]))
  end}

  -- status line with goodies
  use { "nvim-lualine/lualine.nvim", config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        -- theme = require('monarized.lualine'),
        theme = "auto",
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

  -- stop exiting vim because I deleted the last buffer
  use {'ojroques/nvim-bufdel'}

  -- indent guide
  use { "lukas-reineke/indent-blankline.nvim", config = function() vim.g.indent_blankline_enabled = false end}

  -- popup markdown preview
  use { "npxbr/glow.nvim" } -- , run = ":GlowInstall" }
  -- do not lose me on ^D
  use { "psliwka/vim-smoothie" }

  -- linter that use the diagnostics api
  use { "mfussenegger/nvim-lint" }
  -- Cue will save us from YAML
  use { 'jjo/vim-cue' }

  -- Browser stuff
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  use { 'camdencheek/sgbrowse' }

  -- my stuff ----------------------------------
  -- theme
  use { "~/perso/monarized", config = function()
    -- update lualine theme when changing styles
    vim.g.monarized_lualine = true
    -- update kitty background and foreground when changing styles
    vim.g.monarized_kitty_colors = true
    -- -- no italic for me
    vim.g.monarized_italic = nil

    require('telescope').load_extension("monarized")
  end}
  use 'marko-cerovac/material.nvim'
end)

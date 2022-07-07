-- Boostrap packer
local fn = vim.fn
local packer_bootstrap

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- incremental syntax parsing, the mother of modernity
  -- use {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   requires = {"nvim-treesitter/nvim-treesitter"},
  --   run = ":TSUpdate",
  --   config = function()
  --     require("nvim-treesitter.configs").setup {
  --       ensure_installed = "maintained",
  --       ignore_install = { "kotlin" },
  --       highlight = {
  --         enable = true
  --       },
  --       incremental_selection = {
  --         enable = true,
  --         keymaps = {
  --           -- mappings for incremental selection (visual mappings)
  --           init_selection = "gnn", -- maps in normal mode to init the node/scope selection
  --           node_incremental = "grn", -- increment to the upper named parent
  --           scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
  --           node_decremental = "grm" -- decrement to the previous node
  --         }
  --       },
  --       textobjects = {
  --         -- syntax-aware textobjects
  --         select = {
  --           enable = true,
  --           lookahead = true,
  --           keymaps = {
  --             ["af"] = "@function.outer",
  --             ["if"] = "@function.inner",
  --             ["aC"] = "@class.outer",
  --             ["iC"] = "@class.inner",
  --             ["ac"] = "@conditional.outer",
  --             ["ic"] = "@conditional.inner",
  --             ["ae"] = "@block.outer",
  --             ["ie"] = "@block.inner",
  --             ["al"] = "@loop.outer",
  --             ["il"] = "@loop.inner",
  --             ["is"] = "@statement.inner",
  --             ["as"] = "@statement.outer",
  --             ["ad"] = "@comment.outer",
  --             ["am"] = "@call.outer",
  --             ["im"] = "@call.inner"
  --           }
  --         }
  --       },
  --       move = {
  --         enable = true,
  --         set_jumps = true, -- whether to set jumps in the jumplist
  --         goto_next_start = {
  --           ["]m"] = "@function.outer",
  --           ["]]"] = "@class.outer",
  --         },
  --         goto_next_end = {
  --           ["]M"] = "@function.outer",
  --           ["]["] = "@class.outer",
  --         },
  --         goto_previous_start = {
  --           ["[m"] = "@function.outer",
  --           ["[["] = "@class.outer",
  --         },
  --         goto_previous_end = {
  --           ["[M"] = "@function.outer",
  --           ["[]"] = "@class.outer",
  --         },
  --       },
  --     }
  --
  --     -- use treesitter for the folds.
  --     vim.cmd(([[
  --     set foldmethod=expr
  --     set foldexpr=nvim_treesitter#foldexpr()
  --     ]]))
  --   end,
  -- }
  -- language specific selections, based on treesitter
  -- commented because I still don't really use it.
  -- use 'David-Kunz/treesitter-unit'
  -- Annotations on closing brackets
  use { 'code-biscuits/nvim-biscuits',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-biscuits').setup({
        cursor_line_only = true
      })
    end
  }
  use 'Olical/conjure'
  -- LSP goodies
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local ls = require("null-ls")
      ls.setup({
        sources = {
          ls.builtins.formatting.stylua,
          ls.builtins.completion.spell,
          ls.builtins.code_actions.proselint,
          ls.builtins.diagnostics.actionlint,
          ls.builtins.diagnostics.checkmake,
          ls.builtins.diagnostics.golangci_lint,
          ls.builtins.diagnostics.shellcheck,
          ls.builtins.formatting.goimports,
        },
      })
    end
  }
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
  use { 'mfussenegger/nvim-dap' }
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "leoluz/nvim-dap-go"}, config = function()
    require("dapui").setup()
    require('dap-go').setup()
  end }
  use { "theHamsta/nvim-dap-virtual-text", requires = {"mfussenegger/nvim-dap"}, config = function() require("nvim-dap-virtual-text").setup() end }
  -- use { 'Pocco81/DAPInstall.nvim' }

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
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
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
  use { 'ray-x/go.nvim', config = function()
    require('go').setup()
  end}

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
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
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
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              }
            }
          }
        },
        extensions = {
          frecency = {
            default_workspace = ':CWD:',
            workspaces = {
              ["work"] = "~/work",
              ["perso"] = "~/perso",
              ["play"] = "~/play",
            }
          }
        }
      })
    end,
  }
  use { "nvim-telescope/telescope-file-browser.nvim", config = function()
    require("telescope").load_extension("file_browser")
  end}

  use { "nvim-telescope/telescope-ui-select.nvim", config = function()
    require("telescope").load_extension("ui-select")
  end}

  use { "nvim-telescope/telescope-live-grep-args.nvim", config = function()
    require("telescope").load_extension("live_grep_args")
  end}

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

  use {
    'nvim-telescope/telescope-dap.nvim',
    config = function()
      require('telescope').load_extension('dap')
    end
  }

  -- This plugin allows you to select some text using Vim's visual mode, then hit * and # to search
  -- for it elsewhere in the file. For example, hit V, select a strange sequence of characters like "!",
  -- and hit star. You'll find all other runs of "!" in the file.
  use "bronson/vim-visual-star-search"

  -- stop firing vim within vim
  use "lambdalisue/guise.vim"

  -- a theme engine
  use { "tjdevries/colorbuddy.nvim" }
  use { "rktjmp/lush.nvim" }
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

  -- easily run tests
  use { "vim-test/vim-test", config = function()
    vim.cmd(([[
    let g:test#strategy = "neovim"
]]))
  end}

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
        theme = require('monarized.lualine'),
        -- theme = "auto",
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'%=', {'filename', path = 1, color = { fg = '#fff' }}, {'diff', colored = false }},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'%=', {'filename', path = 1}},
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
  use { "mfussenegger/nvim-lint", config = function()
    require("lint").linters_by_ft = { go = { "golangcilint" }, terraform = { "checkov" }, dockerfile = {"checkov"} }
    vim.cmd(([[
    au BufWritePost <buffer> lua require('lint').try_lint()
    ]]))
  end}
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
    vim.g.monarized_italic = true

    require('telescope').load_extension("monarized")
  end}

  if packer_bootstrap then
    require('packer').sync()
  end
end)

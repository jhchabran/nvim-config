(local packer (require :packer))
(import-macros {: opts!
               : sparse} :lib/table)
(import-macros {: do-req 
               : let-req} :lib/require)

(packer.startup 
  (fn [use] 
    ;; general utilities
    (use "wbthomason/packer.nvim")
    (use (opts! "rktjmp/hotpot.nvim" :branch "nightly"))
    (use "nvim-lua/plenary.nvim")
    (use "lambdalisue/guise.vim")
    (use "numtostr/FTerm.nvim")
    ;; vim-fu
    (use "tpope/vim-repeat")
    (use "tpope/vim-vinegar")
    (use "tpope/vim-surround")
    (use (opts! "phaazon/hop.nvim"
                :config (fn [] (do-req :hop :setup {:keys "arstneodhqwfpjluy"}))))
    (use "romainl/vim-qf")
    (use "ojroques/nvim-bufdel")
    ;; themes
    (use "folke/tokyonight.nvim")
    ;; fuzzy finders
    (use (opts! "junegunn/fzf" 
                :run (fn [] (let [install (. vim.fn "fzf#install")] 
                              (install)))))
    (use "junegunn/fzf.vim")
    (use "ojroques/nvim-lspfuzzy")
    (use "nvim-lua/popup.nvim")
    (use "nvim-telescope/telescope-live-grep-args.nvim")
    (use (opts! "nvim-telescope/telescope-file-browser.nvim"
                :config (fn [] (do-req :telescope :load_extension :file_browser))))
    (use (opts! "nvim-telescope/telescope-ui-select.nvim"
                :config (fn [] (do-req :telescope :load_extension :ui-select))))
    (use (opts! "nvim-telescope/telescope-live-grep-args.nvim"
                :config (fn [] (do-req :telescope :load_extension :live_grep_args))))
    (use (opts!"nvim-telescope/telescope-frecency.nvim"
           :config (fn [] (do-req :telescope :load_extension :frecency))
           :requires ["tami5/sqlite.lua"]))
    (use (opts! "nvim-telescope/telescope-dap.nvim"
                :config (fn [] (do-req :telescope :load_extension :dap))))
    (use (opts! "nvim-telescope/telescope.nvim"
                :requires ["nvim-lua/popup.nvim"
                           "nvim-lua/plenary.nvim"
                           "nvim-telescope/telescope-live-grep-args.nvim"]
                :config (require :conf/plugins/telescope)))
    ;; lisp utilities
    (use "gpanders/nvim-parinfer")
    (use "Olical/conjure")
    ;; languages support and context specific utilities
    (use (opts! "ziglang/zig.vim" :ft "zig"))
    (use (opts! "folke/lua-dev.nvim" :ft "lua"))
    (use (opts! "jjo/vim-cue" :ft "cue"))
    ;; LSP helpers
    (use "neovim/nvim-lspconfig")
    (use "onsails/lspkind-nvim")
    (use "ray-x/lsp_signature.nvim")
    (use (opts! "mfussenegger/nvim-lint"
                :config (fn []
                          (tset (require :lint) :linters_by_ft {:go [:golangcilint]})))) ;; TODO autocommand


    ;; language agnostic utilities
    (use (opts! 
           "nvim-treesitter/nvim-treesitter"
           :run (fn [] ((do-req :nvim-treesitter.install :update {:with_sync true}))) ;; TODO autocommand
           :config (fn [] 
                     (do-req :nvim-treesitter.configs
                             :setup
                             {:auto_install true
                             :sync_install false
                             :highlight {:enable true}
                             :ensure_installed [
                                                :go
                                                :gomod
                                                :lua
                                                :fennel
                                                :zig
                                                :rust
                                                :typescript
                                                :javascript
                                                :sql
                                                :make
                                                :bash
                                                :dockerfile
                                                :vim
                                                :json
                                                :markdown
                                                :html
                                                :toml
                                                :yaml]}))))


    (use "nvim-treesitter/nvim-treesitter-context")
    (use "code-biscuits/nvim-biscuits")
    (use (opts! "folke/trouble.nvim" 
                :requires "kyazdani42/nvim-web-devicons"
                :config (fn [] (do-req :trouble :setup))))

    (use "junegunn/vim-easy-align")
    (use "bronson/vim-visual-star-search")
    (use (opts! "cshuaimin/ssr.nvim"
                :config (fn [] (do-req :ssr :setup {:min_width 50
                                       :min_height 5
                                       :keymaps {:close "q"
                                       :next_match "n"
                                       :prev_match "N"
                                       :replace_all "<leader>sR"}}))))
    (use (opts! "numToStr/Comment.nvim"
                :config (fn [] (do-req :Comment :setup))))
    (use (opts! "vim-test/vim-test"
                :config (fn []
                          (tset _G :test#strategy "neovim"))))
    ;; snippets
    (use "hrsh7th/vim-vsnip")
    ;; auto-completion support
    (use (opts! "hrsh7th/nvim-cmp"
                :requires ["hrsh7th/cmp-nvim-lsp"
                           "hrsh7th/cmp-buffer"
                           "hrsh7th/cmp-vsnip"
                           "hrsh7th/cmp-path"
                           "hrsh7th/cmp-nvim-lua"]
                :config (require :conf/plugins/cmp))) 
    ;; Debugging utilities
    (use "mfussenegger/nvim-dap")
    (use (opts! "rcarriga/nvim-dap-ui"
                :requires ["mfussenegger/nvim-dap"] 
                "leoluz/nvim-dap-go"
                :config (fn [] 
                          (do-req :dap-ui :setup)
                          (do-req :dap-go :setup))))
    (use (opts! "theHamsta/nvim-dap-virtual-text"
                :requires "mfussenegger/nvim-dap"
                :config (fn [] (do-req :nvim-dap-virtual-text :setup))))
    ;; Git and Forge utilities
    (use "tpope/vim-fugitive")
    (use (opts! "ruifm/gitlinker.nvim"
                :config (fn [] (do-req :gitlinker :setup))))
    (use (opts! "lewis6991/gitsigns.nvim"
                :config (fn [] (do-req :gitsigns :setup))))

    ;; UI
    (use (opts! "folke/which-key.nvim" :lazy true))
    (use "kosayoda/nvim-lightbulb")
    (use (opts! "simrat39/inlay-hints.nvim"
                :config (fn [] (do-req :inlay-hints :setup {:renderer "inlay-hints/render/eol"
                                       :hints {:parameter {:show true
                                       :highlight "whitespace"}
                                       :type {:show true
                                       :highlight "whitespace"}}
                                       :only_current_line false
                                       :eol {:right_align true
                                       :right_align_padding 7
                                       :parameter {:separator ", "
                                       :format (fn [hints]
                                                 (string.format " <- (%s)"  hints))}
                                       :type {:separator ", "
                                       :format (fn [hints]
                                                 (string.format " => (%s)"  hints))}}}))))
    (use "nvim-tree/nvim-web-devicons")
    (use (opts! "nvim-tree/nvim-tree.lua" :tag "nightly" 
                :config (fn []
                          (do-req :nvim-tree :setup {:diagnostics {:enable false}
                                  :update_focused_file {:enable true}}))))
    (use (opts! "lukas-reineke/indent-blankline.nvim"
                :config (fn [] (tset _G :indent_blankline_enabled false))))
    (use "psliwka/vim-smoothie")
    (use (opts! "nvim-lualine/lualine.nvim"
                :config (require :conf/plugins/lualine)))))

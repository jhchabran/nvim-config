(local lazy (require :lazy))
(import-macros {: opts!
                : sparse} :lib/table)
(import-macros {: do-req 
                : let-req} :lib/require)

(lazy.setup [;; Fennel tooling, manually installed by the bootstrap script, but still 
             ;; added here so Lazy doesn't try to uninstall it and can update it as well.
             (opts! "rktjmp/hotpot.nvim" {:branch "nightly"}) 
             ;; general utilities
             "nvim-lua/plenary.nvim"
             "lambdalisue/guise.vim"
             "numtostr/FTerm.nvim"
             ;; vim-fu
             "tpope/vim-repeat"
             "tpope/vim-vinegar"
             "tpope/vim-surround"
             (opts! "phaazon/hop.nvim"
                    :config (fn [] (do-req :hop :setup {:keys "arstneodhqwfpjluy"})))
             "romainl/vim-qf" 
             "ojroques/nvim-bufdel"
             ;; themes
             "folke/tokyonight.nvim"
             "nyoom-engineering/oxocarbon.nvim"
             ;; fuzzy finders
             (opts! "junegunn/fzf" 
                    {:build (let [install (. vim.fn :fzf#install)] 
                              (install))})
             "junegunn/fzf.vim"
             "ojroques/nvim-lspfuzzy"
             (opts! "nvim-telescope/telescope.nvim"
                    {:dependencies ["nvim-lua/popup.nvim"
                                    "nvim-lua/plenary.nvim"
                                    "nvim-telescope/telescope-live-grep-args.nvim"]
                     :config (require :conf/plugins/telescope)})
             "nvim-lua/popup.nvim"
             "nvim-telescope/telescope-live-grep-args.nvim"
             (opts! "nvim-telescope/telescope-file-browser.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :file_browser))})
             (opts! "nvim-telescope/telescope-ui-select.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :ui-select))})
             (opts! "nvim-telescope/telescope-live-grep-args.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :live_grep_args))})
             (opts! "nvim-telescope/telescope-fzf-native.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :fzf))})
             (opts!"nvim-telescope/telescope-frecency.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :frecency))
                     :dependencies ["tami5/sqlite.lua"]})
             (opts! "nvim-telescope/telescope-dap.nvim"
                    {:config (fn [] (do-req :telescope :load_extension :dap))})
             ;; lisp utilities
             "gpanders/nvim-parinfer"
             "Olical/conjure"
             ;; languages support and context specific utilities
             (opts! "ziglang/zig.vim" :ft "zig")
             (opts! "folke/lua-dev.nvim" :ft "lua")
             (opts! "jjo/vim-cue" :ft "cue")
             ;; LSP helpers
             "neovim/nvim-lspconfig"
             "onsails/lspkind-nvim"
             "ray-x/lsp_signature.nvim"
             (opts! "mfussenegger/nvim-lint"
                    :config (fn []
                              (tset (require :lint) :linters_by_ft {:go [:golangcilint]}))) ;; TODO autocommand


             ;; language agnostic utilities
             (opts! 
               "nvim-treesitter/nvim-treesitter"
               :build (fn [] ((do-req :nvim-treesitter.install :update {:with_sync true}))) ;; TODO autocommand
               :config (fn [] 
                         (do-req :nvim-treesitter.configs
                                 :setup
                                  {:auto_install true}
                                  :sync_install false
                                  :highlight {:enabled true}
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
                                                     :yaml])))


             "nvim-treesitter/nvim-treesitter-context"
             "code-biscuits/nvim-biscuits"
             (opts! "folke/trouble.nvim" 
                    :dependencies "kyazdani42/nvim-web-devicons"
                    :config (fn [] (do-req :trouble :setup)))

             "junegunn/vim-easy-align"
             "bronson/vim-visual-star-search"
             (opts! "cshuaimin/ssr.nvim"
              {:config (fn [] (do-req :ssr :setup {:min_width 50
                                                   :min_height 5
                                                   :keymaps {:close "q"
                                                             :next_match "n"
                                                             :prev_match "N"
                                                             :replace_all "<leader>sR"}}))})
             (opts! "numToStr/Comment.nvim"
                    :config (fn [] (do-req :Comment :setup)))
             (opts! "vim-test/vim-test"
                    :config (fn []
                              (tset _G :test#strategy "neovim")))
             ;; snippets
             "hrsh7th/vim-vsnip"
             ;; auto-completion support
             (opts! "hrsh7th/nvim-cmp"
                    :dependencies ["hrsh7th/cmp-nvim-lsp"
                                    "hrsh7th/cmp-buffer"
                                    "hrsh7th/cmp-vsnip"
                                    "hrsh7th/cmp-path"
                                    "hrsh7th/cmp-nvim-lua"]
                    :config (require :conf/plugins/cmp)) 
                                                                       ;; Debugging utilities
             "mfussenegger/nvim-dap"
             (opts! "rcarriga/nvim-dap-ui"
                   :dependencies ["mfussenegger/nvim-dap"] 
                   "leoluz/nvim-dap-go"
                   :config (fn [] 
                            (do-req :dap-ui :setup)
                            (do-req :dap-go :setup)))
             (opts! "theHamsta/nvim-dap-virtual-text"
                   :dependencies "mfussenegger/nvim-dap"
                   :config (fn [] (do-req :nvim-dap-virtual-text :setup)))
             ;; Git and Forge utilities
             "tpope/vim-fugitive"
             (opts! "ruifm/gitlinker.nvim"
                    :config (fn [] (do-req :gitlinker :setup)))
             (opts! "lewis6991/gitsigns.nvim"
                    :config (fn [] (do-req :gitsigns :setup)))
              
             ;; UI
             (opts! "folke/which-key.nvim" :lazy true)
             "kosayoda/nvim-lightbulb"
             (opts! "simrat39/inlay-hints.nvim"
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
                                                                                       (string.format " => (%s)"  hints))}}})))
             "kyazdani42/nvim-web-devicons"
             (opts! "kyazdani42/nvim-tree.lua" {:config (fn []
                                                          (do-req :nvim-tree :setup {:diagnostics {:enable false}
                                                                                     :update_focused_file {:enable true}}))})
             (opts! "lukas-reineke/indent-blankline.nvim"
                    :config (fn [] (tset _G :indent_blankline_enabled false)))
             "psliwka/vim-smoothie"
             (opts! "nvim-lualine/lualine.nvim"
                    {:config (require :conf/plugins/lualine)})]) 


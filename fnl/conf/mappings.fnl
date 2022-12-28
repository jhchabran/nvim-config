(import-macros {: do-req 
                : let-req} :lib/require)

(local n (require :lib/nvim))
(local wk (require :which-key))

;; Convenient way to indent stuff in visual mode
(n.keymap [:v] "<" "<gv" {:noremap true})
(n.keymap [:v] ">" ">gv" {:noremap true})

(wk.register {"<C-g>" [(fn [] (do-req :FTerm :close))
                       "Close the terminal"
                       {:mode "t"}]})
;; Leader map 
(local 
  normal-map-leader 
  {"<Enter>" [(fn [] (do-req :telescope.builtin :resume))
              "Resume last picker"]
   "w" ["<cmd>:w<CR>"
        "Save current buffer"]
   "." [(fn [] ((-> (require :telescope)
                    (. :extensions)
                    (. :file_browser)
                    (. :file_browser))
                {:cwd (vim.fn.expand "%:p:h")}))
        "Open relative to curren buffer"]
   ":" ["<cmd>Telescope command_history<CR>"
        "Find recent commands"]
   ";" ["<cmd>Telescope commands<CR>"
        "Find commands"]
   
   "b" {:name "-> Buffers"
        :a ["<c-^"
            "Alternate buffer"]
        :b ["<cmd>Telescope buffers<CR>"
            "Find buffers"]
        :d ["<cmd>:BufDel<CR>"
            "Delete current buffer (but do not close nvim!"]
        :n ["<cmd>:bn<CR>"
            "Next buffer"]
        :p ["<cmd>:bp<CR>"
            "Previous buffer"]}
    "c" {:name "-> Code"
         " " ["cmd>Telescope treesitter<CR>"
              "Find a buffer symbol (treesitter)"]
         :a [(fn [] (vim.lsp.buf.code_action))
             "Open available code actions"]
         :c ["<cmd>Telescope lsp_document_symbols<CR>"
             "Find a document symbol (LSP)"]
         :d ["<cmd>Telescope lsp_definitions<CR>"
             "Find a definition (LSP)"]
         :e {:name "-> Errors and diagnostics"
             :d ["<cmd>Telescope lsp_document_diagnostics<CR>"
                 "Find a document diagnostics (LSP)"]
             :w ["<cmd>Telescope lsp_workspace_diagnostics<CR>"
                 "Find workspace diagnostics (LSP)"]
             :n [(fn [] (vim.diagnostics.goto_next))
                 "Go to next diagnostic"]
             :p [(fn [] (vim.diagnostics.goto_prev))
                 "Go to previous diagnostic"]}
          :f [(fn [] vim.lsp.buf.formatting)
              "Format buffer (LSP)"]
          :h [(fn [] vim.lsp.buf.hover)
              "Show hover popup"]
          :i ["<cmd>Telescope lsp_implementations<CR>"
              "Find implementations (LSP)"]
          :j ["<cmd>Telescope lsp_dynamic_workspace_symbols<CR>"
              "Find workspace symbol (LSP)"]
          :l {:name "Lens"
              :l [(fn [] (vim.lsp.codelens.refresh))
                  "Show code lens (LSP)"]}
          :r [(fn [] vim.lsp.buf.rename)
              "Rename buffer (LSP)"]
          :R ["<cmd>Telescope lsp_references<CR>"]
          :T [(fn [] (vim.lsp.buf.type_definition))
              "Go to type definition"]
          :w ["<cmd>:%s/\\s\\+$//<CR>:let @/=''<CR>``"
              "Delete trailing white spaces"]}
      "d" {:name "-> Debugger"
           :q [(fn [] (do-req :dap :terminate))
               "Quit debugging"]
           :c [(fn [] (do-req :dap :continue))
               "Continue"]
           :t [(fn [] (do-req :dap :toggle_breakpoint))
               "Toggle breakpoint"]
           :i [(fn [] (do-req :dap :step_into))
               "Step into"]
           :n [(fn [] (do-req :dap :step_over))
               "Step over"]
           :o [(fn [] (do-req :dap :step_out))
               "Step out"]
           :d [(fn [] (do-req :dapui :toggle))
               "Toggle UI"]}
      " " {:name "-> Movements"
           :p ["<cmd>HopPattern<CR>"
               "Hop to pattern"]
           :e ["<cmd>HopWord<CR>"
               "Hop to word"]
           :i ["<cmd>HopChar1<CR"
               "Hop to character"]
           :l ["<cmd>HopLineStart<CR>"
               "Hop to line start"]}
      "f" {:name "-> Files"
           :r ["<cmd>Telescope oldfiles<CR>"]}
      "g" {:name "-> Git"
           :b ["<cmd>Telescope git_branches<CR>"
               "Find branches"]
           :B ["<cmd>Telescope git_bcommits<CR>"
               "Git blame"]
           :c ["<cmd>:Git commit<CR>"
               "Commit"]
           :C [(fn [] (let [name (vim.fn.input "Branch name: " "")]
                        (vim.cmd (.. ":silent Gib cob " name))))
               "Create new branch"]
           :d {:name "-> Diffing"
               :c ["<cmd>Git diff HEAD~1<CR>"
                   "buffer against last commit"]
               :d ["<cmd>Git diff %<CR>"
                   "buffer against current current branch"]
               :D ["<cmd>Git diff<CR>"
                   "current branch"]
               :m ["<cmd>Git diff main %<CR>"
                   "buffer against main"]
               :M ["<cmd>Git diff main<CR>"
                   "current branch against main"]}
            :l ["<cmd>Telescope git_commits<CR>"
                "Log"]
            :g ["<cmd>:Git<CR>"
                "Status"]
            :f ["<cmd>:Git fetch<CR>"
                "Fetch"]
            :G ["<cmd>Telescope git_status<CR>"
                "Find in current changes"]
            :P ["<cmd>Git pull<CR>"
                "Pull"]
            :w ["<cmd>:Gw<CR>"
                "Add current buffer"]
            :z {:name "-> Stashes"
                :l ["<cmd>Telescope git_stash<CR>"
                    "List stashes"]
                :z ["<cmd>:Git stash<CR>"
                    "Stash"]}}
      "G" {:name "-> GitHub"
           :c ["<cmd>!gh pr create -w<CR>"
               "Create pull-request in a browser window"]
           :o ["<cmd>!gh pr view -w<CR>"
               "Open pull-request in a browser window"]
           :B ["<cmd>!gh browse<CR>"
               "Open repository in a browser window"]}
      "h" {:name "-> Help and utilities"
           :p ["<cmd>Lazy<CR>"
               "Open package manager"]
           :h ["<cmd>Telescope help_tags<CR>"
               "Vim help"]
           :m ["<cmd>Telescope man_pages<CR>"
               "Man pages"]
           :t ["<cmd>Telescope colorschemes<CR>"
               "Pick a theme"]
           :r [(fn [] (print "TODO"))
               "Reload config"]}
      "o" {:name "-> Other utilities"
           :t [(fn [] (do-req :FTerm :toggle))
               "Toggle floating terminal"]
           :o ["<cmd>:terminal<CR>"
               "Open new terminal"]
           :p ["<cmd>NvimTreeToggle<CR>"
               "Toggle file tree"]}
      "p" {:name "-> Project"
           :f ["<cmd>Telescope find_files<CR>"
               "Find files in project"]
           :t ["<cmd>TodoTelescope<CR>"
               "Find TODOs in project"]}
      "s" {:name "-> Search"
           :b ["<cmd>Telescope current_buffer_fuzzy_find<CR>"
               "Fuzzy search in current buffer"]
           :p ["<cmd>Telescope live_grep<CR>"
               "Find in project"]
           :s ["<cmd>Telescope live_grep search_dirs=%:p:h<CR>" 
               "Search in project"]
           :S [(fn [] ((-> (require :telescope) 
                          (. :extensions)
                          (. :live_grep_args)
                          (. :live_grep_args))))
               "ripgrep"]
           :c ["<cmd>let @/ = \"\"<CR>:echo 'Search highlight cleared'<CR>"
               "Clear search"]}
      "t" {:name "-> Tabs"
           :c ["<cmd>:tabnew<CR>"
               "Create tab"]
           :n ["<cmd>:tabn<CR>"
               "Next tab"]
           :N ["<cmd>:tabp<CR>"
               "Previous tab"]
           :p ["<cmd>:tabp<CR>"
               "Previous tab"]
           :q ["<cmd>:tabclose<CR>"
               "Close tab"]}
      "z" {:name "-> Toggle settings"
           :b [(fn [] (do-req :nvim-biscuits :toggle_biscuits))
               "Toggle brackets annotations"]
           :i ["<cmd>IndentBlankLineToggle!<CR>"
               "Toggle indent guides"]
           :l ["<cmd>set invnumber<CR>"
               "Toggle line numbers"]}})
             
(local normal-map-g {:a ["<cmd>Telescope lsp_code_actions<CR>"
                         "Code actions"]
                     :d [(fn [] (vim.lsp.buf.definition))
                         "Go to definition"]
                     :h [(fn [] (vim.lsp.buf.hover))
                         "Display hover popup"]
                     :i [(fn [] (vim.lsp.buf.implementation))
                         "Go to implementation"]
                     :t [(fn [] (vim.lsp.buf.type_definition))
                         "Go to type definition"]
                     :r ["<cmd>Telescope lsp_references<CR>"
                         "Find references"]})
                     

(wk.register normal-map-leader {:prefix "<leader>"})
(wk.register normal-map-g {:prefix "g"})

(n.autocmd "FileType" {:pattern "fugitiveblame" :command "nmap <buffer> q gq"})
(n.autocmd "FileType" {:pattern "fugitive" :command "nmap <buffer> q gq"})
(n.autocmd "FileType" {:pattern "fugitive" :command "nmap <buffer> <Tab> =]]"})

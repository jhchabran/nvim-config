(import-macros {: do-req 
                : let-req} :lib/require)
(import-macros {: opts!
                : sparse} :lib/table)

(local n (require :lib/nvim))
(local wk (require :which-key))

;; which-key mapspec v3 is defined as
;;  [1]: (string) lhs (required)
;;  [2]: (string|fun()) rhs (optional): when present, it will create the mapping
;;  desc: (string|fun():string) description (required for non-groups)
;;  group: (string|fun():string) group name (optional)
;;  mode: (string|string[]) mode (optional, defaults to "n")
;;  cond: (boolean|fun():boolean) condition to enable the mapping (optional)
;;  hidden: (boolean) hide the mapping (optional)
;;  icon: (string|wk.Icon|fun():(wk.Icon|string)) icon spec (optional)
;;  proxy: (string) proxy to another mapping (optional)
;;  expand: (fun():wk.Spec) nested mappings (optional)
;;  any other option valid for vim.keymap.set. These are only used for creating mappings.)
;; 
;; This isn't nice to use in Fennel, so instead we use a helper to build those.
(fn km [key opts what]
  (do (tset opts 1 key) (tset opts 2 what) opts))

;; Convenient way to indent stuff in visual mode
(n.keymap [:v] "<" "<gv" {:noremap true})
(n.keymap [:v] ">" ">gv" {:noremap true})
(n.keymap [:n] "<space>" "<NOP>" {:noremap true :silent true})

(wk.add [(km "<C-g>" {:desc "Hide term" :mode "t"} (fn [] (do-req :FTerm :close)))])

(wk.add [(km "<leader><Enter>" {:desc "Resume last picker"}
             (fn [] (do-req :telescope.builtin :resume)))
         (km "<leader>w" {:desc "Save current buffer"} 
             "<cmd>:w<CR>")
         (km "<leader>." {:desc "Open relative to current buffer"}
             "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>")
          
         (km "<leader>:" {:desc "Find recent commands"} 
             "<cmd>Telescope command_history<CR>")

         (km "<leader>;" {:desc "Find commands"} 
             "<cmd>Telescope commands<CR>")])

(wk.add [(km "<leader>a" {:group "AI"})
         (km "<leader>ap" {:desc "Paste selection in chat"} "<cmd>:GpChatPaste popup<CR>")
         (km "<leader>ar" {:desc "Rewrite selection based on prompt"} "<cmd>:GpRewrite<CR>")])

(wk.add [(km "<leader>b" {:group "Buffers"})
         (km "<leader>ba"    {:desc "Alternate buffer"} "<c-^>")
         (km "<leader>b<Tab>" {:desc "Alternate buffer"} "<c-^>")
         (km "<leader>bb"    {:desc "Find buffers"} "<cmd>Telescope buffers<CR>")
         (km "<leader>bd"    {:desc "Delete buffer"} "<cmd>:BufDel<CR>")
         (km "<leader>bn"    {:desc "Next buffer"} "<cmd>:bn<CR>")
         (km "<leader>bp"    {:desc "Prev buffer"} "<cmd>:bp<CR>")])

(wk.add [(km "<leader>c" {:group "Code"})
         (km "<leader>c " {:desc "Find symbol in buffer"} "cmd>Telescope treesitter<CR>")
         (km "<leader>ca" {:desc "Open code actions"} (fn [] (vim.lsp.buf.code_action)))
         (km "<leader>cc" {:desc "Find symbol in buffer"} "<cmd>Telescope lsp_document_symbols<CR>")
         (km "<leader>cd" {:desc "Find symbol definition"} "<cmd>Telescope lsp_definitions<CR>")

         (km "<leader>ce" {:group "Errors"})
         (km "<leader>ced" {:desc "Find document diagnostics"} "<cmd>Telescope lsp_document_diagnostics<CR>")
         (km "<leader>cew" {:desc "Find workspace diagnostics"} "<cmd>Telescope lsp_workspace_diagnostics<CR>")
         (km "<leader>cen" {:desc "Go to next diagnostic)"} (fn [] (vim.diagnostic.goto_next)))
         (km "<leader>cep" {:desc "Go to prev diagnostic)"} (fn [] (vim.diagnostic.goto_prev)))

         (km "<leader>cf" {:desc "Format buffer"} vim.lsp.buf.format)
         (km "<leader>ch" {:desc "Show hover popup"} vim.lsp.buf.hover)
         (km "<leader>ci" {:desc "Find implementations"} "<cmd>Telescope lsp_implementations<CR>")
         (km "<leader>cj" {:desc "Find symbol in workspace"} "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
         (km "<leader>cr" {:desc "Rename symbol"} vim.lsp.buf.rename)
         (km "<leader>cR" {:desc "Find references"} "<cmd>Telescope lsp_references<CR>")
         (km "<leader>ct" {:desc "Go to type def"} vim.lsp.buf.type_definition)
         (km "<leader>cw" {:desc "Delete trailing whitespaces"} "<cmd>:%s/\\s\\+$//<CR>:let @/=''<CR>``")])

(wk.add [(km "<leader>d" {:group "Debugger"})
         (km "<leader>db" {:desc "Toggle breakpoint"} (fn [] (do-req :dap :toggle_breakpoint)))
         (km "<leader>dc" {:desc "Continue"} (fn [] (do-req :dap :continue)))
         (km "<leader>dd" {:desc "Toggle UI"} (fn [] (do-req :dapui :toggle)))
         (km "<leader>di" {:desc "Step into"} (fn [] (do-req :dap :step_into)))
         (km "<leader>dn" {:desc "Step over"} (fn [] (do-req :dap :step_over)))
         (km "<leader>do" {:desc "Step out"} (fn [] (do-req :dap :step_out)))
         (km "<leader>dq" {:desc "Quit DAP"} (fn [] (do-req :dap :terminate)))])

(wk.add [(km "<leader> " {:group "Moves"})
         (km "<leader> e" {:desc "words"} "<cmd>HopWord<CR>")
         (km "<leader> i" {:desc "chars"} "<cmd>HopChar1<CR>")
         (km "<leader> l" {:desc "lines"} "<cmd>HopLineStart<CR>")
         (km "<leader> p" {:desc "pattern"} "<cmd>HopPattern<CR>")])

(wk.add [(km "<leader>f" {:group "Files"})
         (km "<leader>fr" {:desc "Find recent files"} "<cmd>Telescope oldfiles<CR>")
         (km "<leader>fy" {:desc "Yank current buffer relative path"} "<cmd>let @+ = expand(\"%\")<CR>")])

(wk.add [(km "<leader>g" {:group "Git"})
         (km "<leader>ga" {:desc "Amend"} "<cmd>:Git commit --amend<CR>")
         (km "<leader>gb" {:desc "Switch to branch"} "<cmd>Telescope git_branches<CR>")
         (km "<leader>gB" {:desc "Toggle blame"} "<cmd>:Git blame<CR>")
         (km "<leader>gc" {:desc "Commit"} "<cmd>:Git commit<CR>")
         (km "<leader>gC" {:desc "Create new branch"} (fn [] (let [name (vim.fn.input "branch name: " "")] 
                                                               (vim.cmd (.. ":silent Git cob " name)))))
         (km "<leader>gd" {:group "Diffing"})
         (km "<leader>gdc" {:desc "Buffer against last commit"} "<cmd>Git diff HEAD~1<CR>")
         (km "<leader>gdd" {:desc "Dirty (only current buffer)"} "<cmd>Git diff %<CR>")
         (km "<leader>gdD" {:desc "Dirty"} "<cmd>Git diff<CR>")
         (km "<leader>gdM" {:desc "Against main branch"} "<cmd>Git diff main<CR>")

         (km "<leader>gl" {:desc "Log"} "<cmd>Telescope git_commits<CR>")
         (km "<leader>gg" {:desc "Interactive (fugitive)"} "<cmd>:Git<CR>")
         (km "<leader>gp" {:desc "Push"} "<cmd>:Git push<CR>")
         (km "<leader>gP" {:desc "Pull"} "<cmd>:Git pull<CR>")
         (km "<leader>gs" {:desc "Find changes"} "<cmd>Telescope git_status<CR>")
         (km "<leader>gw" {:desc "Save and Git Add"} "<cmd>:Gw<CR>")
         (km "<leader>gz" {:group "Stashes"})
         (km "<leader>gzl" {:desc "List"} "<cmd>Telescope git_stash<CR>")
         (km "<leader>gzz" {:desc "Stash"} "<cmd>:Git stash<CR>")])

(wk.add [(km "<leader>G" {:group "GitHub"})
         (km "<leader>Gc" {:desc "Create pull-request"} "<cmd>!gh pr create -w<CR>")
         (km "<leader>Gf" {:desc "Open file in browser"} "<cmd>!gh browse %<CR>")
         (km "<leader>Go" {:desc "Open pull-request in browser"} "<cmd>!gh pr view -w<CR>")
         (km "<leader>Gr" {:desc "Open repo in browser"} "<cmd>!gh browse<CR>")])

(wk.add [(km "<leader>h" {:group "Help and utilities"})
         (km "<leader>ht" {:desc "Pick a theme"} "<cmd>Telescope colorscheme<CR>")
         (km "<leader>hm" {:desc "Man pages"} "<cmd>Telescope man_pages<CR>")
         (km "<leader>hh" {:desc "Vim help"} "<cmd>Telescope help_tags<CR>")])

(wk.add [(km "<leader>n" {:group "Notes"})
         (km "<leader>nd" {:desc "Dailies"} "<cmd>:ObsidianDailies<CR>")
         (km "<leader>nf" {:desc "Find"} "<cmd>:ObsidianQuickSwitch<CR>")
         (km "<leader>nl" {:desc "Links"} "<cmd>:ObsidianLinks<CR>")
         (km "<leader>nt" {:desc "Toggle checkbox"} "<cmd>:ObsidianToggleCheckbox<CR>")
         (km "<leader>ns" {:desc "Search"} "<cmd>:ObsidianSearch<CR>")])

(wk.add [(km "<leader>o" {:group "Others"})
         (km "<leader>oa" {:desc "Toggle Chat"} "<cmd>:GpChatToggle popup<CR>")
         (km "<leader>op" {:desc "File panel"} "<cmd>NvimTreeToggle<CR>")
         (km "<leader>ot" {:desc "Toggle floating term"} (fn [] (do-req :FTerm :toggle)))])

(wk.add [(km "<leader>p" {:group "Projects"})
         (km "<leader>pf" {:desc "Find file in project"} "<cmd>Telescope find_files<CR>")
         (km "<leader>pt" {:desc "Find TODOs in project"} "<cmd>TodoTelescope<CR>")])

(wk.add [(km "<leader>s" {:group "Search"})
         (km "<leader>sb" {:desc "Current buffer"} "<cmd>Telescope current_buffer_fuzzy_find<CR>")
         (km "<leader>sc" {:desc "Clear"} "<cmd>let @/ = \"\"<CR>:echo 'Search highlight cleared'<CR>")
         (km "<leader>sn" {:desc "Notes"} "<cmd>:ObsidianSearch<CR>")
         (km "<leader>sp" {:desc "Find in project"} "<cmd>Telescope live_grep<CR>")
         (km "<leader>ss" {:desc "Find (relative to buffer) in project"} "<cmd>Telescope live_grep search_dirs=%:p:h<CR>")
         (km "<leader>sS" {:desc "RipGrep"} (fn [] ((-> (require :telescope) 
                                                        (. :extensions) 
                                                        (. :live_grep_args)
                                                        (. :live_grep_args)))))]) 

(wk.add [(km "<leader>t" {:group "Tabs"})
         (km "<leader>tc" {:desc "Create"} "<cmd>:tabnew<CR>")
         (km "<leader>tn" {:desc "Next"} "<cmd>:tabn<CR>")
         (km "<leader>tp" {:desc "Prev"} "<cmd>:tabp<CR>")
         (km "<leader>tN" {:desc "Prev"} "<cmd>:tabp<CR>") ;; one might want to use tp here, but on Colemak it's horrible.
         (km "<leader>tq" {:desc "Close"} "<cmd>:tabclose<CR>")])

(wk.add [(km "<leader>z" {:group "Misc Toggles"})
         (km "<leader>zb" {:desc "Bracket annotations"} (fn [] (do-req :nvim-biscuits :toggle_biscuits)))
         (km "<leader>zi" {:desc "Indent guides"} "<cmd>IBLToggle<CR>")
         (km "<leader>zl" {:desc "Line numbers"} "<cmd>set invnumber<CR>")])

(wk.add [(km "gd" {:desc "Go to definition"} (fn [] (vim.lsp.buf.definition)))
         (km "gh" {:desc "Hover"} (fn [] (vim.lsp.buf.hover)))
         (km "gi" {:desc "Go to implementation"} (fn [] (vim.lsp.buf.implementation)))
         (km "gt" {:desc "Go to type def"} (fn [] (vim.lsp.buf.type_definition)))
         (km "gr" {:desc "Find references"} "<cmd>Telescope lsp_references<CR>")])

(n.autocmd "FileType" {:pattern "fugitiveblame" :command "nmap <buffer> q gq"})
(n.autocmd "FileType" {:pattern "fugitive" :command "nmap <buffer> q gq"})
(n.autocmd "FileType" {:pattern "fugitive" :command "nmap <buffer> <Tab> ="})

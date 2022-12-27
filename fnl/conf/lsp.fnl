(local lspfuzzy (require :lspfuzzy))
(local lspkind (require :lspkind))
(local lspconfig (require :lspconfig))
(local nvim (require :lib/nvim))
(load :lib/types)

(lspfuzzy.setup) ;; TODO do I need this?

(lspkind.init {:symbol_map {:Text ""
                            :Method "Ƒ"
                            :Function "ƒ"
                            :Constructor ""
                            :Variable ""
                            :Class ""
                            :Interface "ﰮ"
                            :Module ""
                            :Property ""
                            :Unit ""
                            :Value ""
                            :Enum "了"
                            :Keyword ""
                            :Snippet "﬌"
                            :Color ""
                            :File ""
                            :Folder ""
                            :EnumMember ""
                            :Constant ""
                            :Struct ""}})

(tset vim.lsp.handlers 
      :textDocument/hover 
      (vim.lsp.with vim.lsp.handlers.hover 
                    {:focusable false :border "rounded"}))

(fn lsp-format [bufnr]
  (vim.lsp.buf.format {:filter (fn [client]
                                 (if (= (vim.api.nvim_buf_get_option bufnr :filetype)
                                        "go")
                                     (= client.name "gopls")))
                       :bufnr bufnr}))                            

(fn goimports [wait-ms]
  (let [params (tset (vim.lsp.util.make_range_params) :context {:only [:source.organizeImports]})
        result (vim.lsp.buf_request_sync 0 :textDocument/codeAction params wait-ms)]
    (each [_ res (pairs (or result {}))]
      (each [_ r (pairs (or res.result {}))]
        (if (not= r.edit nil)
            (vim.lsp.util.apply_workspace_edit r.edit "utf-16")
            (vim.lsp.buf.execute_command r.command))))))

(fn format-lsp [bufnr]
  (vim.lsp.buf.format {:filter (fn [client] 
                                 (and (not= client.name :tsserver) ;; prettier/eslint will do it for us
                                      (not= client.name :sumneko_lua))) ;; TODO I don't remember why I need this one
                       :bufnr bufnr})) 

(local formatting-augroup (nvim.augroup :LspFormatting))

(lspconfig.gopls.setup 
  {:capabilities (do-req :cmp_nvim_lsp :default_capabilities (vim.lsp.protocol.make_client_capabilities))
   :codelens {:generate true :gc_details true}
   :semanticTokens true
   :experimentalPostfixCompletions true
   :hints {:assignVariablesTypes true
           :compositeLiteralFields true
           :parameterNames true
           :rangeVariableTypes true}
   :on_attach (fn [client bufnr]
                (let [filetype (vim.api.nvim_buf_get_option 0 "filetype")]
                  (if (client.supports_method "textDocument/formatting")
                      (do (nvim.clear-autocmds {:group formatting-augroup :buffer bufnr})
                          (nvim.autocmd ["BufWritePre"]
                                        {:group formatting-augroup
                                         :buffer bufnr
                                         :callback (fn []
                                                     (if (= filetype "go")
                                                         (goimports 2000)
                                                         (formap-lsp bufnr)))}))))
                (do-req :inlay-hints :on_attach client bufnr)
                (do-req :lsp_signature :on_attach {:hint_prefix " "
                                                   :zindex 50
                                                   :bind true
                                                   :handler_opts {:border :none}}))})


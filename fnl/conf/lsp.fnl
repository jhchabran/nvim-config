(local lspfuzzy (require :lspfuzzy))
(local lspkind (require :lspkind))
(local lspconfig (require :lspconfig))
(local cmp (require :cmp))
(local nvim (require :lib/nvim))
; (local sg (require :sg))
(local lsputil (require :lspconfig/util))

(import-macros {: do-req} :lib/require)

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

(fn goimports [wait-ms]
  (let [params (vim.lsp.util.make_range_params) 
         result (do
                 (tset params :context {:only [:source.organizeImports]})
                 (vim.lsp.buf_request_sync 0 :textDocument/codeAction params wait-ms))]
       (each [_ res (pairs (or result {}))]
         (each [_ r (pairs (or res.result {}))]
           (if r.edit
               (vim.lsp.util.apply_workspace_edit r.edit "utf-16")
               (vim.lsp.buf.execute_command r.command))))
   (vim.lsp.buf.format)))


(let [group (nvim.augroup "ft_go")]
  (nvim.autocmd ["BufEnter" "BufNewFile" "BufRead"] 
                {:group group :pattern "*.go" :command "setlocal formatoptions+=roq"})
  (nvim.autocmd ["BufEnter" "BufNewFile" "BufRead"] 
                {:group group :pattern "*.go" :command "setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist"}))

(local formatting-augroup (nvim.augroup :LspFormatting))

; (local lsp-capabilities
;   (do-req :cmp_nvim :default_capabilities (vim.lsp.protocol.make_client_capabilities)))

(fn on-attach [client bufnr]
              (let [filetype (vim.api.nvim_buf_get_option 0 "filetype")]
                (if (client.supports_method "textDocument/formatting")
                    (do (nvim.clear-autocmds {:group formatting-augroup :buffer bufnr})
                        (nvim.autocmd "BufWritePre"
                                      {:group formatting-augroup
                                       :buffer bufnr
                                       :callback (fn [_] (if (= filetype "go")
                                                             (goimports 2000)
                                                             (vim.lsp.buf.format {:bufnr bufnr})))})))
                (do-req :inlay-hints :on_attach client bufnr)
                (do-req :lsp_signature :on_attach {:hint_prefix " "
                                                   :zindex 50
                                                   :bind true
                                                   :handler_opts {:border :none}})))


(tset vim.lsp.config :gopls
  {:codelens {:generate true :gc_details true}
   :semanticTokens true
   :flags { :debounce_text_changes 200}
   :analyses {:unusedparams true
              :unusedvariables true
              :unusedwrite true
              :nilness true
              :unusedwrite true
              :useany true}
   :completeUnimported true
   :staticcheck true
   :experimentalPostfixCompletions true
   :hints {:constantValues true
           :functionTypeParameters true   
           :assignVariablesTypes true
           :compositeLiteralTypes true
           :compositeLiteralFields true
           :parameterNames true
           :rangeVariableTypes true}
   :on_attach on-attach})

(nvim.autocmd "FileType" {:pattern "go" 
                          :callback (fn [_] (let [cmp (require :cmp)]
                                              (cmp.setup.buffer {:sources [
                                                                           {:name "nvim_lsp"}]})))})
(nvim.autocmd "FileType" {:pattern "zig" 
                          :callback (fn [_] (let [cmp (require :cmp)]
                                              (cmp.setup.buffer {:sources [
                                                                           {:name "nvim_lsp"}]})))})
(nvim.autocmd "FileType" {:pattern "typescript" 
                          :callback (fn [_] (let [cmp (require :cmp)]
                                              (cmp.setup.buffer {:sources [
                                                                           {:name "nvim_lsp"}]})))})
(nvim.autocmd "FileType" {:pattern "rust" 
                          :callback (fn [_] (let [cmp (require :cmp)]
                                              (cmp.setup.buffer {:sources [
                                                                           {:name "nvim_lsp"}]})))})
                                                                           
(nvim.autocmd "FileType" {:pattern "python" 
                          :callback (fn [_] (let [cmp (require :cmp)]
                                              (cmp.setup.buffer {:sources [
                                                                           {:name "nvim_lsp"}]})))})
(local rt (require :rust-tools))
(rt.setup {:tools {:runnables {:use_telescope true}
                   :inlay-hints {:auto true}}
           :server {:settings {:rust-analyzer {:checkOnSave "clippy"
                                               :assist {:importEnforceGranularity true
                                                        :importPrefix true}
                                               :cargo {:allFeatures true}
                                               :completion {:autoimport {:enable true}}
                                               :inlayHints {:lifetimeElisionHints {:enable true
                                                                                   :useParameterNames true}}}}
                    ; :capabilities lsp-capabilities
                    :on_attach (fn [client bufnr]
                                 (do-req :inlay-hints :on_attach client bufnr)
                                 (do-req :lsp_signature :on_attach {:hint_prefix " "
                                                                     :zindex 50
                                                                     :bind true
                                                                     :handler_opts {:border :none}}))}})
(tset vim.lsp.config :ts_ls {:on_attach on-attach
                             :flags {:debounce_text_changes 200}
                             :root_dir (lsputil.root_pattern "tsconfig.json")})

(tset vim.lsp.config :zls {:on_attach on-attach})

(tset vim.lsp.config :starpls {})

(tset vim.lsp.config :pyright {:on_attach on-attach})

(vim.lsp.enable "pyright")
(vim.lsp.enable "gopls")
(vim.lsp.enable "starpls")
(vim.lsp.enable "zls")
(vim.lsp.enable "ts_ls")

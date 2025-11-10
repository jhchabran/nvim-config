(import-macros {: do-req
                : let-req} :lib/require)

(fn cmp-config []
  (let [cmp (require :blink.cmp)
        lspkind (require :lspkind)]
      (cmp.setup {
                  :sources {:default [:lsp :path :buffer]} 
                  :cmdline {:enabled false}
                  :completion {:trigger {:prefetch_on_insert false}}
                  :keymap {
                           :preset :enter
                           "<Tab>" [:fallback]}})))

cmp-config

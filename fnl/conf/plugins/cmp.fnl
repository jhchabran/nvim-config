(import-macros {: do-req
                : let-req} :lib/require)

(fn cmp-config []
  (let [cmp (require :blink.cmp)
        lspkind (require :lspkind)]
      (cmp.setup {
                  :sources {:default [:lsp :path :buffer] 
                            :providers {:minuet {:name :minuet 
                                                 :module :minuet.blink
                                                 :score_offset 100
                                                 :async true}}}
                  :completion {:trigger {:prefetch_on_insert false}}
                  :keymap {
                           :preset :enter
                           "<Tab>" [:fallback]
                           "<C-i>" [(fn [cmp] (cmp.show {:providers [:minuet]}))]}})))

cmp-config

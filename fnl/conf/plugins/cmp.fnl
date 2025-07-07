(import-macros {: do-req
                : let-req} :lib/require)

(fn feedkey [key mode]
  (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true) mode true))

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))
        cur-line (. (vim.api.nvim_buf_get_lines 0
                                          (- line 1)
                                          line
                                          true
                      1))]
    (and (not= col 0)
         (= (: (: cur-line :sub col col) :match "%s")
            nil))))

(fn tab [fallback]
  (let [cmp (require :blink.cmp)]
    (if (cmp.visible)
        (cmp.select_next_item
            (if (has-words-before)
                (cmp.complete)
                (fallback))))))
  
(fn stab []
  (let [cmp (require :blink.cmp)]
    (if (cmp.visible)
        (cmp.select_prev_item))))
                                                    
(fn cmp-config []
  (let [cmp (require :blink.cmp)
        lspkind (require :lspkind)]
      (cmp.setup {
                  :formatting {:format (fn [entry vim_item]
                                         (do
                                           (tset vim_item :menu entry.source.name)
                                           (let [f (lspkind.cmp_format {})]
                                             (f entry vim_item))))}
                                           
                  ; :performance {:fetching_timeout 2000}                        
                  ; :sources [{:name "buffer"} {:name :path}]
                  :sources {:default [:lsp :path :buffer]}
                  :completion {:completeopt "menu,menuone,noinsert"}
                  :keymap {
                           ; "<C-d>" (fn [cmp] cmp.mapping.scroll_docs -4)
                           ; "<C-u>" (fn [cmp] cmp.mapping.scroll_docs 4)
                           ; "<Up>" (fn [cmp] cmp.mapping (cmp.mapping.select_prev_item) [:i :c])
                           ; "<Down>" (fn [cmp] cmp.mapping (cmp.mapping.select_next_item) [:i :c]) 
                           ; "<C-g>" (fn [cmp] cmp.mapping.close)
                           "<C-i>" [(fn [cmp] cmp.show {:providers [:minuet]})]}})))
                           ; "<CR>" (fn [cmp] cmp.mapping.confirm {:select true})
                           ; "<Tab>" (fn [cmp] cmp.mapping tab [:i :s])
                           ; "<S-Tab>" (fn [cmp] cmp.mapping stab [:i :s])}})))

cmp-config

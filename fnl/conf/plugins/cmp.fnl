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

(fn expand [args]
  (let [vsnip (. vim.fn :vsnip#anonymous)]
     (vsnip args.body)))

(fn tab [fallback]
  (let [cmp (require :cmp)]
    (if (cmp.visible)
        (cmp.select_next_item)
        (let [available (. vim.fn :vsnip#available)]
          (if (= (available) 1)
              (feedkey "<Plug>(vsnip-expand-or-jump)" "")
              (if (has-words-before)
                  (cmp.complete)
                  (fallback)))))))
  
(fn stab []
  (let [cmp (require :cmp)]
    (if (cmp.visible)
        (cmp.select_prev_item)
        (if (let [jumpable (. vim.fn :vsnip#jumpable)]
              (= (jumpable -1) 1))
            (feedkey "<Plug>(vsnip-jump-prev" "")))))
                                                    

(fn cmp-config []
  (let [cmp (require :cmp)
        lspkind (require :lspkind)]
      (cmp.setup {:snippet {:expand expand}
                  :formatting {:format (lspkind.cmp_format)}
                  :sources [{:name "buffer"} {:name :path}]
                  :completion {:completeopt "menu,menuone,noinsert"}
                  :mapping {"<C-d>" (cmp.mapping.scroll_docs -4)
                            "<C-u>" (cmp.mapping.scroll_docs 4)
                            "<Up>" (cmp.mapping (cmp.mapping.select_prev_item) [:i :c])
                            "<Down>" (cmp.mapping (cmp.mapping.select_next_item) [:i :c]) 
                            "<C-g>" (cmp.mapping.close)
                            "<CR>" (cmp.mapping.confirm {:select true})
                            "<Tab>" (cmp.mapping tab [:i :s])
                            "<S-Tab>" (cmp.mapping stab [:i :s])}})))

cmp-config

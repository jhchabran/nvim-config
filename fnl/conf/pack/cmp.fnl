(local cmp (require "cmp"))
(local lspkind (require "lspkind"))

(lua 
  "local haswords = function() 
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match(\"%s\") == nil
  end")

(fn feedkey [key mode]
  (vim.api.nvim_feedkeys (vim.api.nvim_replace_termcodes key true true true) mode true))

(cmp.setup {:snippet {:expand (fn [args] 
                                (let [f (. vim.fn "vsnip#anonymous")]
                                  (f args.body)))}
            :formatting {:format (lspkind.cmp_format)}
            :sources [{:name "buffer"}
                      {:name "path"}]
            :completion {:completeopt "menu,menuone,noinsert"}
            :mapping {"<C-d>" (cmp.mapping.scroll_docs -4)
                      "<C-u>" (cmp.mapping.scroll_docs 4)
                      "<Up>" (cmp.mapping (cmp.mapping.select_prev_item) ["i" "c"])
                      "<Down>" (cmp.mapping (cmp.mapping.select_next_item) ["i" "c"])
                      "<Tab>" (cmp.mapping (fn [fallback]
                                             (if (cmp.visible)
                                                 (cmp.select_next_item)
                                                 (= ((. vim.fn "vsnip#available")) 1)
                                                 (feedkey "<Plug>(vsnip-expand-or-jump)" "")
                                                 (haswords)
                                                 (cmp.complete)
                                                 (fallback))
                                             ["i" "s"]))
                      "<S-Tab>" (cmp.mapping (fn []
                                               (if (cmp.visible)
                                                   (cmp.select_prev_item)
                                                   (= ((. vim.fn "vsnip#jumpable") -1) 1)))
                                             ["i" "s"])
                      "<C-g>" (cmp.mapping.close)
                      "<CR>" (cmp.mapping.confirm {:select true})}})

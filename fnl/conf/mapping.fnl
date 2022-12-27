(local wk (require "which-key"))
(local map wk.register)
;; (import-macros {: rfn} :lib/wk)

;; Convenient way to indent stuff in visual mode
(vim.api.nvim_set_keymap "v" "<" "<gv" {:noremap true})
(vim.api.nvim_set_keymap "v" ">" ">gv" {:noremap true})

(map {"<C-g>" 
      (fn [] (. require :FTerm) :toggle) "Close the terminal"
      {:mode "t"}})

;; vim.cmd(([[
;;            autocmd FileType fugitiveblame nmap <buffer> q gq
;;            autocmd FileType fugitive nmap <buffer> q gq
;;            autocmd FileType fugitive nmap <buffer> <Tab> =]]))


(map 
  {"<Enter>"
   [(. (require :telescope.builtin) :resume)
    "Resume last picker"]}
   ;; "w" ["<cmd>:w<CR>" "Save buffer"]}
  {:prefix "<leader>"})
  
   
     

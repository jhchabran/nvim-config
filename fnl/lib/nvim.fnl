(fn autocmd [events opts]
  "Create autocommand"
  (vim.api.nvim_create_autocmd events opts))

(fn augroup [name ?opts]
  "Create autocommand group"
  (vim.api.nvim_create_augroup name (or opts {})))

(fn keymap [mode lhs rhs ?opts]
  "Sets a global mapping for the given mode.
  Ex: `(keymap [:n :i] ...)`"
  (let [string-mode (table.concat mode)]
    (vim.api.nvim_set_keymap string-mode lhs rhs (or opts {}))))

{: autocmd
 : augroup
 : keymap}

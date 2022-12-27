(fn keymap [mode lhs rhs ?opts]
  "Sets a global mapping for the given mode.
  Ex: `(keymap [:n :i] ...)`"
  (let [string-mode (table.concat mode)]
    (vim.api.nvim_set_keymap string-mode lhs rhs (or opts {}))))

{: keymap}


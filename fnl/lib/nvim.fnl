(fn autocmd [events opts]
  "Create autocommand"
  (vim.api.nvim_create_autocmd events opts))

(fn clear-autocmds [opts]
  "Clear autocommands"
  (vim.api.nvim_clear_autocmds opts))

(fn augroup [name ?opts]
  "Create autocommand group"
  (vim.api.nvim_create_augroup name (or opts {})))

(fn keymap [mode lhs rhs ?opts]
  "Sets a global mapping for the given mode.
  Ex: `(keymap [:n :i] ...)`"
  (let [string-mode (table.concat mode)]
    (vim.api.nvim_set_keymap string-mode lhs rhs (or opts {}))))

(fn opt [key value]
  "Set a vim option"
  (tset vim.opt key value))

(fn g [key value]
  "Set a vim global"
  (tset vim.g key value))

(fn colorscheme [name]
  "Set the current colorscheme"
  (vim.cmd (.. "colorscheme " name)))

{: autocmd
 : clear-autocmds
 : augroup
 : keymap
 : opt
 : g
 : colorscheme}

vim.cmd(([[
autocmd FileType markdown lua whichkeyMarkdown()
]]))

_G.whichkeyMarkdown = function()
  local wk = require("which-key")
  wk.register({ [" "] = { p = { "<cmd>Glow<CR>", "preview" } } }, { prefix = "<leader>" })
end

vim.cmd(([[
autocmd FileType markdown lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'buffer' },
\   },
\ }
]]))

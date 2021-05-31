vim.cmd(([[
autocmd FileType markdown lua whichkeyMarkdown()
]]))

_G.whichkeyMarkdown = function()
  local wk = require("which-key")
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    [" "] = {
      p = { "<cmd>Glow<CR>", "preview" },
    },
  }, { prefix = "<leader>"})
end

local lspfuzzy = require "lspfuzzy"
lspfuzzy.setup {} -- Make the LSP client use FZF instead of the quickfix list

require("lspkind").init({
  symbol_map = {
    Text = "",
    Method = "Ƒ",
    Function = "ƒ",
    Constructor = "",
    Variable = "",
    Class = "",
    Interface = "ﰮ",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "了",
    Keyword = "",
    Snippet = "﬌",
    Color = "",
    File = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
  },
})

vim.cmd(([[
autocmd CursorHold * lua vim.lsp.buf.hover()
]]))

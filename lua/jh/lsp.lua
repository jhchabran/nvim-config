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

-- avoid accidently jumping to the hover window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false, border = "rounded" }
)
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
          if vim.api.nvim_buf_get_option(bufnr, 'filetype') == "go" then
            return client.name == "gopls"
          end
        end,
        bufnr = bufnr,
    })
end

return {
  lsp_formatting = lsp_formatting,
}

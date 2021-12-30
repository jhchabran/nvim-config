local lspconfig = require("lspconfig")

lspconfig.tsserver.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  -- on_attach = function(client)
    -- client.resolved_capabilities.document_formatting = false
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
      hint_prefix = " ",
      zindex = 50,
      bind = true,
      handler_opts = {
        border = "none"
      }
    })
  end
}

vim.cmd(([[
autocmd FileType typescript lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'nvim_lsp' },
\   },
\ }
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting()
]]))

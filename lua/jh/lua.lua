local lspconfig = require('lspconfig')

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {'sumneko_lua'},
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  },
})
-- TODO my lua config is broken at the moment
lspconfig.sumneko_lua.setup(luadev)

vim.cmd(([[
autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lua' },
\     { name = 'vsnip' },
\   },
\ }
]]))

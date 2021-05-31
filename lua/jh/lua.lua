local lspconfig = require('lspconfig')

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {'lua-language-server'}
  },
})
lspconfig.sumneko_lua.setup(luadev)

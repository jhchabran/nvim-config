local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

configs.zk = {
  default_config = {
    cmd = {'zk', 'lsp'},
    filetypes = {'markdown'},
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {}
  };
}

lspconfig.zk.setup({ on_attach = function(client, buffer) 
  -- Add keybindings here, see https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
end })

local lspconfig = require("lspconfig")
lspconfig.gopls.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  codelens = { generate = true, gc_details = true },
  experimentalWorkspaceModule = true,
  semanticTokens = true,
  experimentalPostfixCompletions = true,
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

_G.goimports = function(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end

  vim.lsp.buf.formatting_sync()
end

vim.cmd(([[
autocmd FileType go lua whichkeyGo()
autocmd FileType go lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'nvim_lsp' },
\   },
\ }
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(2000)
]]))

_G.whichkeyGo = function()
  local wk = require("which-key")
  -- local buf = vim.api.nvim_get_current_buf()
  wk.register({
    [" "] = {
      name = "Go",
      a = { "<cmd>GoAlt<CR>", "alternate impl and test" },
      i = { "<cmd>GoInstall<CR>", "go install" },
      b = { "<cmd>GoBuild<CR>", "go build" },
      d = { "<cmd>GoDoc<CR>", "go doc" },
      r = { "<cmd>GoRun<CR>", "go run" },
      t = {
        name = "Test",
        a = { "<cmd>GoTest ./...<CR>", "go test ./..." },
        s = { "<cmd>GoTestFunc<CR>", "go test -s [current test]" },
        d = { "<cmd>call vimspector#LaunchWithSettings( #{ configuration: 'single test', TestName: go#util#TestName() } )<CR>", "Debug current test" },
      },
      c = {
        name = "Coverage",
        c = { "<cmd>GoCoverage<CR>", "annotate with coverage" },
        t = { "<cmd>GoCoverageToggle<CR>", "toggle coverage display" },
        C = { "<cmd>GoCoverageClear<CR>", "clear coverage" },
        b = { "<cmd>GoCoverageBrowser<CR>", "open coverage in a browser" },
      },
      z = {
        name = "Toggles",
        -- m = { function() if vim.g.go_metalinter_autosave == 1 then vim.g.go_metalinter_autosave = 0 else vim.g.go_metalinter_autosave = 1 end, "Toggle metalinter" },
      },
    },
  }, { prefix = "<leader>" })
end

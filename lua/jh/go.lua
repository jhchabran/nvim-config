local lspconfig = require("lspconfig")
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local goimports = function(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
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

  vim.lsp.buf.format()
end

local format_lsp = function(bufnr)
  vim.lsp.buf.format {
    -- Never request tsserver for formatting, because we use prettier/eslint for that
    filter = function(client)
      return client.name ~= "tsserver" and client.name ~= "sumneko_lua"
    end,
    bufnr = bufnr,
  }
end

lspconfig.gopls.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  codelens = { generate = true, gc_details = true },
  -- experimentalWorkspaceModule = true,
  -- expandWorkspaceToModule = true,
  semanticTokens = true,
  experimentalPostfixCompletions = true,
  hints = { assignVariableTypes = true, compositeLiteralFields = true, parameterNames = true, rangeVariableTypes = true },
  on_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    -- formatting
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = formatting_augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_augroup,
        buffer = bufnr,
        callback = function()
          if filetype == "go" then
            goimports(2000)
          else
            format_lsp(bufnr)
          end
        end,
      })
    end
    require("inlay-hints").on_attach(client, bufnr)
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
autocmd BufWritePre *.go lua require('jh.lsp').lsp_formatting(0)
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
      p = { "<cmd>:e ~/play/foo/main.go<CR>", "open playground" },
      r = { "<cmd>GoRun<CR>", "go run" },
      t = {
        name = "Test",
        a = { "<cmd>GoTest ./...<CR>", "go test ./..." },
        s = { "<cmd>GoTestFunc<CR>", "go test -s [current test]" },
        d = { "<cmd>call vimspector#LaunchWithSettings( #{ configuration: 'single test', TestName: input('Enter test name: ') } )<CR>", "Debug current test" },
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

local lspconfig = require("lspconfig")
lspconfig.gopls.setup {}

vim.cmd(([[
autocmd FileType go lua whichkeyGo()
]]))

-- TODO(JH)

_G.whichkeyGo = function()
  local wk = require("which-key")
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    [" "] = {
      name = "Go",
      i = { "<cmd>GoInstall<CR>", "go install" },
      b = { "<cmd>GoBuild<CR>", "go build" },
      d = { "<cmd>GoDoc<CR>", "go doc" },
      r = { "<cmd>GoRun<CR>", "go run" },
      t = {
        name = "Test",
        a = { "<cmd>GoTest ./...<CR>", "go test ./..." },
        s = { "<cmd>GoTestFunc<CR>", "go test -s [current test]" },
      },
      c = {
        name = "Coverage",
        c = { "<cmd>GoCoverage<CR>", "annotate with coverage" },
        t = { "<cmd>GoCoverageToggle<CR>", "toggle coverage display" },
        C = { "<cmd>GoCoverageClear<CR>", "clear coverage" },
        b = { "<cmd>GoCoverageBrowser<CR>", "open coverage in a browser" },
      },
      a = { "<cmd>GoAlternate<CR>", "alternate impl and test" },
    },
  }, { prefix = "<leader>" })
end

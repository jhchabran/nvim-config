  vim.cmd(([[
  autocmd FileType go lua whichkeyGo()
  ]]))

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
          a = { "<cmd>GoTest ./...<CR>", "go test ./..."},
          s = { "<cmd>GoTestFunc<CR>", "go test -s [current test]"},
        },
        c = {
          name = "Coverage",
          c = { "<cmd>GoCoverage<cmd>", "annotate with coverage"},
          t = { "<cmd>GoCoverageToggle", "toggle coverage display"},
          C = { "<cmd>GoCoverageClear<cmd>", "clear coverage"},
          b = { "<cmd>GoCoverageBrowser<cmd>", "open coverage in a browser"},
        },
        a = { "<cmd>GoAlternate<CR>", "alternate impl and test"},
      },
    }, { prefix = "<leader>"})
  end

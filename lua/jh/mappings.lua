-- convenient helper to declare maps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- avoid clashing with leader as space
map("n", "<Space>", "<NOP>", { noremap = true, silent = true })

-- <Tab> to navigate the completion menu
-- map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
-- map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { expr = true })
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#confirm('<CR>')", { expr = true })
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

map("i", "<C-g>", "compe#close('<C-g>')", { expr = true, silent = true })

local wk = require("which-key")

-- terminal mode bindings
wk.register({ ["<C-g>"] = { "<cmd>lua require('FTerm').toggle()<CR>", "Close the terminal" } }, { mode = "t" })

-- fugitive additional mappings
vim.cmd(([[
autocmd FileType fugitiveblame nmap <buffer> q gq
autocmd FileType fugitive nmap <buffer> q gq
]]))

-- normal mode bindings
wk.register({
  w = { "<cmd>:w<CR>", "Save current buffer" },
  ["<S-w>"] = { "<cmd>:wq<CR>", "Save current buffer and quit" },
  ["."] = { function() require("telescope.builtin").file_browser({ cwd = vim.fn.expand("%:p:h") }) end, "open relative" },
  [":"] = { "<cmd>Telescope commands<CR>", "Find command" },
  b = {
    name = "Buffers",
    b = { "<cmd>Telescope buffers<CR>", "Find buffer" },
    a = { "<c-^>", "Switch back to previous buffer" },
    ["<Tab>"] = { "<c-^>", "Switch back to previous buffer" },
    w = { "<cmd>:bw<CR>", "close and save current buffer" },
    d = { "<cmd>:bd<CR>", "Delete current buffer" },
    x = { require("jh.notes").open_scratch, "Open scratch buffer" },
  },
  c = {
    name = "Code / LSP",
    [" "] = { "<cmd>Telescope treesitter<CR>", "Treesitter jump" },
    a = { "<cmd>Telescope lsp_code_actions<CR>", "Code actions" },
    c = { "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols" },
    d = { "<cmd>Telescope lsp_definitions<CR>", "Definitions" },
    e = {
      name = "diagnostic",
      d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Document diagnostics" },
      w = { "<cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace diagnostics" },

      p = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "previous" },
      n = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next" },
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover" },
    i = { "<cmd>Telescope lsp_implementations<CR>", "Implementations" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
    ["R"] = { "<cmd>Telescope lsp_references<CR>", "References" },
    q = { "<cmd>Telescope quickfix<CR>", "Quickfix" },
    l = { "<cmd>Telescope loclist<CR>", "Loclist" },
  },
  d = {
    name = "Debugger",
    q = { "<cmd>VimspectorReset<CR>", "Quit debugging" },
    -- e = { "<cmd>VimspectorEval<CR>", "Eval" },
    c = { "<cmd>call vimspector#Continue()<CR>", "Continue" },
    ["S"] = { "vimspector#Stop()<CR>", "Stop" },
    r = { "<cmd>call vimspector#Restart()<CR>", "Restart" },
    p = { "<cmd>call vimspector#Pause()<CR>", "Pause" },
    t = { "<cmd>call vimspector#ToggleBreakpoint()<CR>", "Toggle Breakpoint" },
    i = { "<cmd>call vimspector#StepInto()<CR>", "Step into" },
    n = { "<cmd>call vimspector#StepOver()<CR>", "Step over" },
    o = { "<cmd>call vimspector#StepOut()<CR>", "Step out" },
  },
  e = {
    name = "Easy motion",
    [" "] = { "<Plug>(easymotion-bd-jk)", "Jump Lines" },
    -- Colemak here, those are my hjkl keys
    ["n"] = { "<Plug>(easymotion-j)", "Jump to lines below" },
    ["e"] = { "<Plug>(easymotion-k)", "Jump to lines above" },
    ["h"] = { "<Plug>(easymotion-linebackward)", "Jump backward" },
    ["i"] = { "<Plug>(easymotion-lineforward)", "Jump forward" },
  },

  f = { name = "Files", r = { "<cmd>Telescope oldfiles<CR>", "Recent files" } },
  g = {
    name = "Git",
    a = { "<cmd>:Gw<CR>", "Git add current buffer" },
    b = { "<cmd>Telescope git_branches<CR>", "Show branches" },
    ["B"] = { "<cmd>Telescope git_bcommits<CR>", "Git Blame" },
    c = { "<cmd>:Git commit<CR>", "Git commit" },
    ["C"] = { "<cmd>Telescope git_commits<CR>", "Git log" },
    g = { "<cmd>:Git<CR>", "Git status" },
    G = { "<cmd>Telescope git_status<CR>", "Current changes" },
    -- ['M'] = TODO diff between this branch and main, with the above ui
    p = { "<cmd>:Git push<CR>", "Git push" },
    w = { "<cmd>:Gw<CR>", "Git add %" },
    z = {
      name = "Stashes",
      l = { "<cmd>Telescope git_stash<CR>", "List stashes" },
      z = { "<cmd>:Git stash<CR>", "run git stash" },
    },
  },
  h = {
    name = "Help and misc helpers",
    p = {
      name = "Packages",
      c = { "<cmd>PackerClean<CR>", "Clean packages" },
      s = { "<cmd>PackerSync<CR>", "Install packages" },
      u = { "<cmd>PackerUpdate<CR>", "Update packages" },
      ["S"] = { "<cmd>PackerStatus<CR>", "List packages" },
    },
    h = { "<cmd>Telescope help_tags<CR>", "Inline help" },
    m = { "<cmd>Telescope man_pages<CR>", "Inline help" },
    t = { "<cmd>Telescope colorscheme<CR>", "Inline help" },
    r = { require("jh.utils").reload_my_code, "Reload 'jh.*' lua modules" },
    ["R"] = { "<cmd>Telescope reloader<CR>", "Reload a module" },
  },
  n = { name = "Notes", f = { require("jh.notes").find_notes, "Find notes" } },
  o = {
    name = "Others",
    t = { "<cmd>lua require('FTerm').toggle()<CR>", "Toggle terminal" },
    q = { "<Plug>(qf_qf_toggle)<CR>", "Toggle Quickfix" },
    l = { "<Plug>(qf_loc_toggle)<CR>", "Toggle Loclist" },
    p = { "<cmd>NvimTreeToggle<CR>", "Open project drawer" },
  },
  p = {
    name = "Project", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    p = { "<cmd>Telescope session-lens search_session<cr>", "Find File" },
    t = { "<cmd>TodoTelescope<CR>", "List project TODOs" },
    x = { require("jh.notes").open_current_project_notes, "Open project notes" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy search in current buffer" },
    p = { "<cmd>Telescope live_grep<CR>", "Find in project" },
    c = { "<cmd>let @/ = \"\"<CR>:echo 'Search highlight cleared'<CR>", "Clear search" },
  },
  t = {
    name = "Tabs",
    t = { "<cmd>:tabnew<CR>", "New tab" },
    n = { "<cmd>:tabn<CR>", "Next tab" },
    N = { "<cmd>:tabp<CR>", "Prev tab" },
    d = { "<cmd>:tabclose<CR>", "Close tab" },
  },
  z = { name = "Settings Toggles", l = { "<cmd>set invnumber<CR>", "Line numbers" } },
}, { prefix = "<leader>" })

-- convenient helper to declare maps
local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- avoid clashing with leader as space
map('n', '<Space>', '<NOP>', {noremap = true, silent = true})

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- Close term with C-g when in terminal mode
map('t', '<C-g>', "<cmd>lua require('FTerm').toggle()<CR>")

local wk = require("which-key")
wk.register({
	w = { "<cmd>:w<CR>", "Save current buffer" },
	['<S-w>'] = { "<cmd>:wq<CR>", "Save current buffer and quit" },
	["."] = { function() require('telescope.builtin').file_browser({ cwd = vim.fn.expand("%:p:h") }) end, "open relative"},
  [":"] = { "<cmd>Telescope commands", "Find command" },
  b = {
    name = "Buffers",
    b = { "<cmd>Telescope buffers<CR>", "find buffer" },
    a = { "<c-^>", "switch back to previous buffer" },
    ['<Tab>'] = { "<c-^>", "switch back to previous buffer" },
    w = { "<cmd>:bw<CR>", "close and save current buffer" },
    d = { "<cmd>:bd<CR>", "delete current buffer" },
    -- =
    --
  },
	c = {
		name = "Code / LSP",
    [" "] = { "<cmd>Telescope treesitter<CR>", "Treesitter jump" },
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "action" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "definition"},
		e = {
			name = "diagnostic",
			p = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "previous"},
			n = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "next"},
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting"},
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover"},
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
		x = { "<cmd>lua vim.lsp.buf.references()<CR>", "references"},
		c = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "document symbol"},
    q = { "<cmd>Telescope quickfix<CR>", "Quickfix" },
    l = { "<cmd>Telescope quickfix<CR>", "Loclist" },
	},
  e = {
    name = "Easy motion",
    [' '] = {"<Plug>(easymotion-bd-jk)", "Jump Lines"},
    -- Colemak here, those are my hjkl keys
    ["n"] = { "<Plug>(easymotion-j)", "Jump to lines below" },
    ["e"] = { "<Plug>(easymotion-k)", "Jump to lines above" },
    ["h"] = { "<Plug>(easymotion-linebackward)", "Jump backward" },
    ["i>"] = { "<Plug>(easymotion-lineforward)", "Jump forward" },
  },

	f = {
		name = "Files",
    r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
  },
	g = {
		name = "Git",
    a = { "<cmd>:Gw<CR>", "Git add current buffer" },
    b = { "<cmd>Telescope git_branches<CR>", "Show branches" },
    ['<S-b>'] = { "<cmd>Telescope git_bcommits<CR>", "Git Blame" },
    c = { "<cmd>:Git commit<CR>", "Git commit" },
    ['<S-c>'] = { "<cmd>Telescope git_commits<CR>", "Git log" },
    g = { "<cmd>:Git<CR>", "Git status" },
    G = { "<cmd>Telescope git_status<CR>", "Current changes" },
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
			i = { "<cmd>PaqInstall<CR>", "Install packages" },
			u = { "<cmd>PaqUpdate<CR>", "Update packages" },
			c = { "<cmd>PaqClean<CR>", "Clean packages" },
			l = { "<cmd>PaqList<CR>", "List packages" }
		},
    h = { "<cmd>Telescope help_tags<CR>", "Inline help" },
    m = { "<cmd>Telescope man_pages<CR>", "Inline help" },
    t = { "<cmd>Telescope colorscheme<CR>", "Inline help" },
	},
  n = {
    name = "Notes"
  },
	o = {
		name = "Others",
		t = { "<cmd>lua require('FTerm').toggle()<CR>", "open terminal" },
	},
	p = {
		name = "Project", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
		--    n = { "New File" }, -- just a label. don't create any mapping
		--    e = "Edit File", -- same as above
		--    ["1"] = "which_key_ignore",  -- special label to hide it in the popup
		--    b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
	},
  s = {
    name = "Search",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy search in current buffer" },
    p = { "<cmd>Telescope live_grep<CR>", "Find in project" },
    c = { "<cmd>:nohlsearch<CR>:echo 'Search highlight cleared'<CR>", "Clear search" },
  },
  t = {
    name = "Tabs",
    t = { "<cmd>:tabnew<CR>", "New tab" },
    n = { "<cmd>:tabn<CR>", "Next tab" }, 
    N = { "<cmd>:tabp<CR>", "Prev tab" }, 
    d = { "<cmd>:tabclose<CR>", "Close tab" },
  }
}, { prefix = "<leader>" })

-- small global helper to inspect things
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end


local indent = 2
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.tabstop = indent -- Number of spaces tabs count for
vim.opt.mouse = "a" -- Useful when browsing
vim.opt.clipboard = "unnamedplus" -- Put those yanks in my os clipboards
vim.opt.completeopt = "menu,menuone,noselect" -- Completion options (for compe)
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.incsearch = true -- Make search behave like modern browsers
vim.opt.cursorline = true -- Display the current line
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true -- True color support
vim.opt.wildmode = "list:longest" -- Command-line completion mode
vim.opt.list = false -- Show some invisible characters (tabs...)
vim.opt.number = true -- Print line number
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.wrap = true -- Enable line wrap
vim.opt.cmdheight = 2 -- More space to display messages
vim.opt.timeoutlen = 400 -- Don't wait more that 400ms for normal mode commands
vim.opt.updatetime = 700 -- CursorHold use this value to known for how long the cursor is being held
vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,resize,winpos,terminal"
vim.opt.foldlevelstart=20
vim.opt.shada = { "!", "'1000", "<50", "s10", "h" } -- remember stuff across sessions
vim.api.nvim_command("set noswapfile") -- I have OCD file saving issues anyway
-- vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- restore cursor position
vim.cmd(([[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]))

-- recompile automatically when editing plugins.lua
vim.cmd(([[
autocmd BufWritePost plugins.lua PackerCompile
]]))

vim.g["python3_host_prog"] = "~/.asdf/shims/python3" -- Use this python binary

-- set leader to space early
vim.g.mapleader = " "

require("globals")
require("jh.plugins")
require("jh.lsp")
require("jh.mappings")
require("jh.go")
require("jh.typescript")
require("jh.lua")
require("jh.markdown")
require("jh.firenvim")
require("jh.zk")

-- tweaked version of the snippet at https://neovim.io/doc/user/tabpage.html
vim.cmd([[
	function MyTabLine()
	  let s = ''
	  for i in range(tabpagenr('$'))
	    " select the highlighting
	    if i + 1 == tabpagenr()
	      let s .= '%#TabLineSel#'
	    else
	      let s .= '%#TabLine#'
	    endif

	    " set the tab page number (for mouse clicks)
	    let s .= '%' . (i + 1) . 'T'

	    " the label is made by MyTabLabel()
	    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	  endfor

	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'

	  return s
	endfunction

	function MyTabLabel(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  return bufname(buflist[winnr - 1]) . '(' . tabpagewinnr(a:n, '$') . ')'
	endfunction

  set tabline=%!MyTabLine()
]])

-- require("colorbuddy").colorscheme("monarized")
-- require("monarized").set_style("dark")

-- vim.cmd[[colorscheme gruvbox]]
vim.cmd[[colorscheme oxocarbon]]
vim.cmd[[packadd cfilter]]

if vim.g.neovide then
  vim.g.neovid_cursor_aniimation_length = 0.01
  vim.g.neovide_cursor_trail_length = 0.05
  -- vim.g.neovide_cursor_antialiasing = true
  vim.cmd [[set guifont=DankMono\ Nerd\ Font:h16:l]]
end

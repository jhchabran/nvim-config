vim.cmd(([[
if exists('g:started_by_firenvim')
  set laststatus=0
  au BufEnter github.com_*.txt set filetype=markdown
  set guifont=GoMono\ Nerd\ Font:h16
endif
]]))

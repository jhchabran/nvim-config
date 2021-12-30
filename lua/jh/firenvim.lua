vim.cmd(([[
if exists('g:started_by_firenvim')

  let g:firenvim_config = { 
    \ 'localSettings': {
        \ '.*': {
            \ 'content': 'text',
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
  \ }

  au BufEnter github.com_*.txt set filetype=markdown
  set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h18

  let g:dont_write = v:false
  function! My_Write(timer) abort
    let g:dont_write = v:false
    write
  endfunction

  function! Delay_My_Write() abort
    if g:dont_write
      return
    end
    let g:dont_write = v:true
    call timer_start(10000, 'My_Write')
  endfunction

  au TextChanged * ++nested call Delay_My_Write()
  au TextChangedI * ++nested call Delay_My_Write()

  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endif
]]))

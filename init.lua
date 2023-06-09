-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- vim.cmd [[set whichwrap=<>[]hl,b,s]]
vim.cmd [[set whichwrap=<>[],b,s]]
vim.cmd([[
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:_,trail:-
highlight SpecialKey term=standout ctermbg=yellow " guibg=yellow
highlight RedundantSpaces term=standout ctermbg=Grey " guibg=#ffddcc
call matchadd('RedundantSpaces', '\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!')

highlight CursorLine term=none cterm=none gui=none
" Enable the curline and listchars only in the insert mode
function! EnterInsertMode()
    if &ft =~ 'NvimTree' || &ft =~ 'Telescope'
        return
    endif
    setlocal listchars-=eol:¬
    setlocal list
    highlight CursorLine term=underline cterm=underline gui=underline
    " setlocal cursorline
endfunction

function! ExitInsertMode()
    if &ft =~ 'NvimTree' || &ft =~ 'Telescope'
        return
    endif
    setlocal listchars+=eol:¬
    setlocal nolist
    highlight CursorLine term=none cterm=none gui=none
    " setlocal nocursorline
endfunction

augroup HighlightSpecialKeys
    au!
    au InsertEnter * call EnterInsertMode()
    au InsertLeave * call ExitInsertMode()
augroup END

function! EnableCursorLine()
    " Disable the cursorline for tagbar, because there is a great performance
    " hit if it is enabled.
    if &ft =~ 'tagbar'
        setlocal nocursorline
        return
    endif
    setlocal cursorline
endfunction

function! DisableCursorLine()
    if &ft =~ 'NvimTree'
        return
    endif
    setlocal nocursorline
endfunction

" Highlight the cursorline only in the active window.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * call EnableCursorLine()
    " au WinLeave * setlocal nocursorline
    au WinLeave * call DisableCursorLine()
augroup END
]])

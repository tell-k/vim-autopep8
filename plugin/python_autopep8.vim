
" This function saves the current window state, and executes Autopep8() with
" the user's existing options. After Autopep8 call, the initial window
" settings are restored. Undo recording is also paused during Autopep8 call
function! s:autopep8_on_save()
  if get(g:, "autopep8_on_save", 0)

    " Save cursor position and many other things.
    let l:curw = winsaveview()

    " stop undo recording
    try | silent undojoin | catch | endtry

    call Autopep8()

    " Restore our cursor/windows positions.
    call winrestview(l:curw)

  endif
endfunction

" During every save, also reformat the file with respect to the existing
" autopep8 settings.
augroup vim-python-autopep8
   autocmd!
   autocmd BufWritePre *.py call s:autopep8_on_save()
augroup END


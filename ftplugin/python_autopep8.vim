"=========================================================
" File:        python_autopep8.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 30-Dec-2013.
" Version:     1.0.3
" WebPage:     https://github.com/tell-k/vim-autopep8
" License:     MIT Licence
"==========================================================
" see also README.rst

" Only do this when not done yet for this buffer
if exists("b:loaded_autopep8_ftplugin")
    finish
endif
let b:loaded_autopep8_ftplugin=1

if !exists("*Autopep8()")
    function Autopep8()
        if exists("g:autopep8_cmd")
            let s:autopep8_cmd=g:autopep8_cmd
        else
            let s:autopep8_cmd="autopep8"
        endif

        if !executable(s:autopep8_cmd)
            echoerr "File " . s:autopep8_cmd . " not found. Please install it first."
            return
        endif

        if exists("g:autopep8_ignore")
            let s:autopep8_ignores=" --ignore=".g:autopep8_ignore
        else
            let s:autopep8_ignores=""
        endif

        if exists("g:autopep8_select")
            let s:autopep8_selects=" --select=".g:autopep8_select
        else
            let s:autopep8_selects=""
        endif

        if exists("g:autopep8_pep8_passes")
            let s:autopep8_pep8_passes=" --pep8-passes=".g:autopep8_pep8_passes
        else
            let s:autopep8_pep8_passes=""
        endif

        if exists("g:autopep8_max_line_length")
            let s:autopep8_max_line_length=" --max-line-length=".g:autopep8_max_line_length
        else
            let s:autopep8_max_line_length=""
        endif

        if exists("g:autopep8_aggressive")
            let s:autopep8_aggressive=" --aggressive "
        else
            let s:autopep8_aggressive=""
        endif

        let s:execmdline=s:autopep8_cmd.s:autopep8_pep8_passes.s:autopep8_selects.s:autopep8_ignores.s:autopep8_max_line_length.s:autopep8_aggressive
        let s:tmpfile = tempname()
        let s:tmpdiff = tempname()
        let s:index = 0
        try
            " current cursor
            let s:current_cursor = getpos(".")
            " write to temporary file
            silent execute "!". s:execmdline . " \"" . expand('%:p') . "\" > " . s:tmpfile
            if !exists("g:autopep8_disable_show_diff")
                silent execute "!". s:execmdline . " --diff  \"" . expand('%:p') . "\" > " . s:tmpdiff
            endif

            " current buffer all delete
            execute "%d"
            " read temp file. and write to current buffer.
            for line in readfile(s:tmpfile)
                call append(s:index, line)
                let s:index = s:index + 1
            endfor
            " remove last linebreak.
            silent execute ":" . s:index . "," . s:index . "s/\\n$//g"
            " restore cursor
            call setpos('.', s:current_cursor)

            " show diff
            if !exists("g:autopep8_disable_show_diff")
              botright new autopep8
              setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
              silent execute '$read ' . s:tmpdiff
              setlocal nomodifiable
              setlocal nu
              setlocal filetype=diff
            endif

            echo "Fixed with autopep8 this file."
        finally
            " file close
            if filewritable(s:tmpfile)
                call delete(s:tmpfile)
            endif
            if filewritable(s:tmpdiff)
                call delete(s:tmpdiff)
            endif
        endtry

    endfunction
endif

" Add mappings, unless the user didn't want this.
" The default mapping is registered under to <F8> by default, unless the user
" remapped it already (or a mapping exists already for <F8>)
if !exists("no_plugin_maps") && !exists("no_autopep8_maps")
    if !hasmapto('Autopep8(')
        noremap <buffer> <F8> :call Autopep8()<CR>
    endif
endif

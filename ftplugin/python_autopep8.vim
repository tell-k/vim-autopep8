"=========================================================
" File:        python_autopep8.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 20-Sep-2014.
" Version:     1.0.7
" WebPage:     https://github.com/tell-k/vim-autopep8
" License:     MIT Licence
"==========================================================
" see also README.rst

" Only do this when not done yet for this buffer
if exists("b:loaded_autopep8_ftplugin")
    finish
endif
let b:loaded_autopep8_ftplugin=1

if !exists("*Autopep8(...)")
    function Autopep8(...)

        let l:args = get(a:, 1, '')

        if exists("g:autopep8_cmd")
            let autopep8_cmd=g:autopep8_cmd
        else
            let autopep8_cmd="autopep8"
        endif

        if !executable(autopep8_cmd)
            echoerr "File " . autopep8_cmd . " not found. Please install it first."
            return
        endif

        if exists("g:autopep8_ignore")
            let autopep8_ignores=" --ignore=".g:autopep8_ignore
        else
            let autopep8_ignores=""
        endif

        if exists("g:autopep8_select")
            let autopep8_selects=" --select=".g:autopep8_select
        else
            let autopep8_selects=""
        endif

        if exists("g:autopep8_pep8_passes")
            let autopep8_pep8_passes=" --pep8-passes=".g:autopep8_pep8_passes
        else
            let autopep8_pep8_passes=""
        endif

        if exists("g:autopep8_max_line_length")
            let autopep8_max_line_length=" --max-line-length=".g:autopep8_max_line_length
        else
            let autopep8_max_line_length=""
        endif

        if exists("g:autopep8_aggressive")
            let autopep8_aggressive=" --aggressive "
        else
            let autopep8_aggressive=""
        endif
        
        if exists("g:autopep8_indent_size")
            let autopep8_indent_size=" --indent-size=".g:autopep8_indent_size
        else
            let autopep8_indent_size=""
        endif

        let execmdline=autopep8_cmd.autopep8_pep8_passes.autopep8_selects.autopep8_ignores.autopep8_max_line_length.autopep8_aggressive.autopep8_indent_size.l:args
        let tmpfile = tempname()
        let tmpdiff = tempname()
        let index = 0
        try
            " current cursor
            let current_cursor = getpos(".")
            " write to temporary file
            silent execute "!". execmdline . " \"" . expand('%:p') . "\" > " . tmpfile
            if !exists("g:autopep8_disable_show_diff")
                silent execute "!". execmdline . " --diff  \"" . expand('%:p') . "\" > " . tmpdiff
            endif

            " current buffer all delete
            silent execute "%d"
            " read temp file. and write to current buffer.
            for line in readfile(tmpfile)
                call append(index, line)
                let index = index + 1
            endfor
            " remove last linebreak.
            silent execute ":" . index . "," . index . "s/\\n$//g"
            " restore cursor
            call setpos('.', current_cursor)

            " show diff
            if !exists("g:autopep8_disable_show_diff")
              botright new autopep8
              setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
              silent execute '$read ' . tmpdiff
              setlocal nomodifiable
              setlocal nu
              setlocal filetype=diff
            else
              redraw!
            endif

            hi Green ctermfg=green
            echohl Green
            echon "Fixed with autopep8 this file."
            echohl

        finally
            " file close
            if filewritable(tmpfile)
                call delete(tmpfile)
            endif
            if filewritable(tmpdiff)
                call delete(tmpdiff)
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
        command! -nargs=? -bar Autopep8 call Autopep8(<f-args>) 
    endif
endif

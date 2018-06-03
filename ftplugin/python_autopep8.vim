"=========================================================
" File:        python_autopep8.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 3-Jun-2018.
" Version:     1.2.0
" WebPage:     https://github.com/tell-k/vim-autopep8
" License:     MIT Licence
"==========================================================
" see also README.rst

" Only do this when not done yet for this buffer
if exists("b:loaded_autopep8_ftplugin")
    finish
endif
let b:loaded_autopep8_ftplugin=1
let b:autopep8_current_cursor = [0, 1, 1, 0]

if !exists("*Autopep8(...)")
    function Autopep8(...) range

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

        let autopep8_range = ""
        let current_cursor = b:autopep8_current_cursor
        if l:args != ""
            let autopep8_range = " ".l:args
            let current_cursor = getpos(".")
        elseif a:firstline == a:lastline
            let autopep8_range = ""
            let current_cursor = [0, a:firstline, 1, 0]
        elseif a:firstline != 1 || a:lastline != line('$')
            let autopep8_range = " --range ".a:firstline." ".a:lastline
            let current_cursor = [0, a:firstline, 1, 0]
        endif

        if exists("g:autopep8_aggressive")
            if g:autopep8_aggressive == 2
               let autopep8_aggressive=" --aggressive --aggressive "
            else
               let autopep8_aggressive=" --aggressive "
            endif
        else
            let autopep8_aggressive=""
        endif

        if exists("g:autopep8_indent_size")
            let autopep8_indent_size=" --indent-size=".g:autopep8_indent_size
        else
            let autopep8_indent_size=""
        endif

        if exists("g:autopep8_diff_type") && g:autopep8_diff_type == "vertical"
            let autopep8_diff_type="vertical"
        else
            let autopep8_diff_type="horizontal"
        endif

        let execmdline=autopep8_cmd.autopep8_pep8_passes.autopep8_selects.autopep8_ignores.autopep8_max_line_length.autopep8_aggressive.autopep8_indent_size.autopep8_range

        " current cursor
        " show diff if not explicitly disabled
        if !exists("g:autopep8_disable_show_diff")
            let tmpfile = tempname()
            try
               " write buffer contents to tmpfile because autopep8 --diff
               " does not work with standard input
               silent execute "0,$w! " . tmpfile
               let diff_cmd = execmdline . " --diff \"" . tmpfile . "\""
               let diff_output = system(diff_cmd)
            finally
               " file close
               if filewritable(tmpfile)
                 call delete(tmpfile)
               endif
            endtry
        endif
        " execute autopep8 passing buffer contents as standard input
        silent execute "0,$!" . execmdline . " -"
        " restore cursor
        call setpos('.', current_cursor)

        " show diff
        if !exists("g:autopep8_disable_show_diff")
          if autopep8_diff_type == "vertical"
            vertical botright new autopep8
          else
            botright new autopep8
          endif
          setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
          silent execute ':put =diff_output'
          setlocal nomodifiable
          setlocal nu
          setlocal filetype=diff
        endif

        hi Green ctermfg=green
        echohl Green
        echon "Fixed with autopep8 this file."
        echohl

    endfunction
endif

if !exists("no_plugin_maps") && !exists("no_autopep8_maps")
    if !hasmapto('Autopep8(')
        command! -range=% -nargs=? -bar Autopep8 let b:autopep8_current_cursor = getpos(".") | <line1>,<line2>call Autopep8(<f-args>)
    endif
endif

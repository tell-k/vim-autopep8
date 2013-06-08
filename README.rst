========================
vim-autopep8
========================

vim-autopep8 is a Vim pluign that runs currentry open file throuh autopep8.
autopep8 automatically formats Python code to conform to the PEP 8 style guide.

Required
=====================

* `autopep8 <https://pypi.python.org/pypi/autopep8/>`_

Installation
=====================

simply put the contents of this repository in your ~/.vim/bundle directory.

Usage
=====================

1. Open Python file.
2. Press <F8> to run autopep8 on it

Customization
=====================

If you don't want to use the `<F8>` key for autopep8, simply remap it to
another key.  It autodetects whether it has been remapped and won't register
the `<F8>` key if so.  For example, to remap it to `<F3>` instead, use:

::

 autocmd FileType python map <buffer> <F3> :call Autopep8()<CR>

Do not fix these errors/warnings (default: E226,E24,W6)

::

 let g:autopep8_ignore="E501,W293"

Fix only these errors/warnings (e.g. E4,W)

::

 let g:autopep8_select="E501,W293"

Maximum number of additional pep8 passes (default: 100)

:: 

 let g:autopep8_pep8_passes=100

Set maximum allowed line length (default: 79)

:: 

 let g:autopep8_max_line_length=79

enable possibly unsafe changes (E711, E712) (default: non defined)

:: 

 let g:autopep8_aggresive=1

disable show diff window

:: 

 let g:autopep8_disable_show_diff=1

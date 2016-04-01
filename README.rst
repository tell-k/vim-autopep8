========================
vim-autopep8
========================

vim-autopep8 is a Vim plugin that applies autopep8 to your current file.
autopep8 automatically formats Python code to conform to the PEP 8 style guide.

Required
=====================

* `autopep8 <https://pypi.python.org/pypi/autopep8/>`_

Installation
=====================

Simply put the contents of this repository in your ~/.vim/bundle directory.

But on some platforms the following extra steps might be necessary to enable the plugin to be loaded in vim:

- ensure you have the `~/.vim/plugin` directory
- either copy or symlink the file `ftplugin/python_autopep8.vim` into the `~/.vim/plugin` directory

Documentation (Read The Docs)
==============================

* https://vim-autopep8.readthedocs.org/en/latest/

Usage
=====================

shortcut

1. Open Python file.
2. Press <F8> to run autopep8 on it

call function

:: 

 :Autopep8

with arguments

::

 :Autopep8 --range 1 5

 or 

 :call Autopep8(" --range 1 5")

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

Enable possibly unsafe changes (E711, E712) (default: non defined)

:: 

 let g:autopep8_aggressive=1 

Number of spaces per indent level (default: 4)

:: 

 let g:autopep8_indent_size=2

Disable show diff window

:: 

 let g:autopep8_disable_show_diff=1

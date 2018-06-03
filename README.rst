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

call function

:: 

 :Autopep8

with arguments

::

 :Autopep8 --range 1 5

 or 

 :call Autopep8(" --range 1 5")

range selection

::

 :'<,'>Autopep8


.. caution::

  This plugin remove default <F8> key mapping since v1.1.0.
  It is the user's business to decide which key to be mapped to.

Customization
=====================

For example, to map it to `<F8>`:

::

 autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>


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

 # add aggressive option (--aggressive)
 let g:autopep8_aggressive=1 

 # add more aggressive options (--aggressive --aggressive)
 let g:autopep8_aggressive=2

Number of spaces per indent level (default: 4)

:: 

 let g:autopep8_indent_size=2

Disable show diff window

:: 

 let g:autopep8_disable_show_diff=1

Chose diff window type. (default: horizontal)

:: 

 # default
 let g:autopep8_diff_type='horizontal'

 let g:autopep8_diff_type='vertical'


Automatically format every time saving a file.

::

 let g:autopep8_on_save = 1


Tips
=====================

If you want to use 「=」 with autopep8. It's good to set it as follows.
But please be careful as "vim-autopep8" setting will not be inherited.

::

 autocmd FileType python set equalprg=autopep8\ -


Author
==============================

* tell-k

License
==============================

* MIT License

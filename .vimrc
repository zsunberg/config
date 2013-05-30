" github.com/gmarik/vundle
set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Bundle 'sukima/xmledit'
Bundle 'kien/ctrlp.vim'

" to update run :BundleInstall

filetype plugin indent on

"colorscheme ron
" colorscheme custom
colorscheme desert256


inoremap <C-space> <C-p>

set smartindent
set number
set tabstop=4
set shiftwidth=4
set expandtab

set gfn=Monospace\ 10

" http://ubuntuforums.org/showthread.php?t=782136
" cmap w! ! %!sudo tee > /dev/null %

" http://statico.github.com/vim.html
nmap j gj
nmap k gk
nmap \e :NERDTreeToggle<CR>

"http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
" filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"http://facwiki.cs.byu.edu/nlp/index.php/Vim%2BLaTeX_on_Linux
let g:Tex_ViewRule_pdf = 'okular'

" tex specific wordwrap
au BufRead,BufNewFile *.tex set wrap|set linebreak|set nolist

"http://vim.sourceforge.net/scripts/script.php?script_id=13
au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 

au Filetype tex set spell

"http://statico.github.io/vim.html
:nmap ; :CtrlP .<CR>

"for DOS line endings
:nmap <C-m> :e ++ff=dos<CR>


" Vim with all enhancements
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set nocompatible              " be iMproved, required
filetype off                  " required

set pythonthreedll=python38.dll

let &pythonthreedll='C:\Users\joeka\AppData\Local\Programs\Python\Python38-32\python38.dll'

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.  Keep Plugin
" commands between vundle#begin/end.  plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html Plugin 'L9' Git plugin
" not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/joekanoza/path/to/plugin' The sparkup vim script is in
" a subdirectory of this repo called vim.  Pass the path to set the
" runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.  
Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Plugin vim-airline for a new interface
Plugin 'vim-airline/vim-airline'
"
"Install the Plugin for c.vim
Plugin 'c.vim'

"Install the Plugin for Auto Complete
Plugin 'taglist.vim'

" NerdTree
Plugin 'scrooloose/nerdtree'

" Powerline
"Plugin 'Lokaltog/Powerline', {'rtp': 'C:/User/joeka/.vim/bundle/powerline/powerline/bindings/vim/'}

" Ctrlp
Plugin 'kien/Ctrlp.vim'

"Install Nord Color scheme plugin
Plugin 'arcticicestudio/nord-vim'
"
"Install plugin "vim-color-solarized
Plugin 'altercation/vim-colors-solarized'

" Install Zenburn
Plugin 'jnurmine/Zenburn'

" Installs plugin for YouCompleteMe vim intellisense
"Plugin 'valloric/youcompleteme'

" Auto-Indentation plugin
Plugin 'vim-scripts/indentpython.vim'

" Python Syntax
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
  

" Line Numbers
set number relativenumber

augroup numbertoggle
   autocmd!
   autocmd BufEnter,FocusGained,InsertLeave   * set relativenumber
   autocmd BufLeave,FocusLost,InsertEnter     * set norelativenumber
augroup END

" Needed for syntax Highlighting and stuff
" filetype on
" filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" When opening a new line and no filetyoe-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc
set autoindent

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Better command-line completion
set wildmenu

" Spaces are better than a tab character
"set expandtab
"set smarttab

" Reduces the tab width from the default 8 spaces
set shiftwidth=3
set softtabstop=3

" Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Highlight search
set hlsearch

" Shows the typing as a command
set showcmd

" Shows the Matching Brackets
set showmatch

" Automatically save before commands like :next or :make
set autowrite

"Color scheme
" packadd! my-dracula-theme
if has('gui running')
   set background=dark
   colorscheme solarized
else
   colorscheme elflord
endif

call togglebg#map("<F5>")
let g:solarized_termcolors=256
" colorscheme solarized

" Setting the split screen options
set splitbelow
set splitright

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

"Enable folding with the spacebar
nnoremap <space> za

" Settings for Markdown
au BufRead,BufNewFile *.md,*.markdown
   \ set textwidth=79

" Set the proper PEP8 indentations for Python code
au BufNewFile,BufRead *.py
   \set tabstop=4 |
   \set softtabstop=4 |
   \set shiftwidth=4
   \set textwidth=79
   \set expandtab
   \set autoindent
   \set fileformat=dos

" Set full stack development
au BufNewFile,BufRead *.js, *.html, *.css
   \set tabstop=2
   \set softtabstop=2
   \set shiftwidth=2

" Flag extra whitespace for removal
highlight BadWhitespace ctermbg=red guibg=darkred
au BufNewFile,BufRead *.py,*pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8 Support
set encoding=utf-8

" YouCompleteMe customization
let g:ycm_autoclose_preview_window_after=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' == os.environ:
   project_base_dir = os.environ['VIRTUAL_ENV']
   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
   execfile(activate_this, dict(__file__=activate_this))
EOF

" Set GUI options
set go=egml
set guifont=Lucida_Console:h11


" let &PYTHONDLL='C:\Python27\'

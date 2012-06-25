" Plugin: Pathogen
" Plugins are installed by copying the plugin files into ~/.vim/bundle/plugin_name directory. 
" Download the plugin, extract it and move to ~/.vim/bundle/plugin_name
" Using git
" cd ~/.vim
" git submodule add git://github.com/tpope/vim-fugitive.git bundle/fugitive
" git submodule init && git submodule update
call pathogen#infect()

" choose no compatibility with legacy vi
set nocompatible
set history=10000
" always show the statusline
set laststatus=2
" Enable syntax highlighting
syntax on
set encoding=utf-8
set number						" turn on line numbers
set cursorline
set cmdheight=2
set numberwidth=5
set showtabline=2
set showcmd                     " display incomplete commands
set scrolloff=3					" provide some context when editing
set hidden                      " Allow backgrounding buffers without writing them, and remember marks/undo for backgrounded buffers
set tabstop=4 
set shiftwidth=4
set softtabstop=4
" Copy indent from current line when starting a new line
set autoindent                  
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" backspace through everything in insert mode
set backspace=indent,eol,start
" Searching
set showmatch
" highlight matches
set hlsearch                    
" incremental searching
set incsearch                   
" searches are case insensitive...
set ignorecase
" ... unless they contain at least one capital letter
set smartcase
" auto reload file when it is edited elsewhere
set autoread


" Appearance
colorscheme evening
if has("macunix") 
  set gfn=Monaco:h11
  set shell=/bin/bash
elseif has("win32") || has("win64")
  set gfn=Consolas:h10
elseif has("unix")
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if has("gui_running")
	set antialias
	set window=50
	set lines=52 
	set columns=120
end

if has("win32") || has("win64")
	set backupdir=~/vimfiles/_backup " where to put backup files.
	set directory=~/vimfiles/_temp " where to put swap files.
else
	set backupdir=~/.vim/_backup " where to put backup files.
	set directory=~/.vim/_temp " where to put swap files.
endif

" Autocommands
" =========================================================

if has("autocmd")
  filetype indent on
endif

" Reload vimrc on save
au! BufWritePost .vimrc source % 


" Keyboard mappings
" =========================================================
if has("gui_running")
	" need some work
	nmap <leader>1 :set lines=40 columns=100<CR><C-w>o
	nmap <leader>2 :set lines=50 columns=171<CR><C-w>v
end

" Windows Cut, Copy & Paste
imap <c-x> <Esc>"+xi
vmap <c-x> "+x
imap <c-c> <Esc>"+yi
vmap <c-c> "+y
imap <c-v> <Esc>"+gPi
nmap <c-v> "+gP
vmap <c-v> "+gP

" Ctrl+s to save
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Ctrl+w to delete current buffer
nmap <c-w> :bd<CR>
imap <c-w> <Esc>:bd<CR>i

" Ctr+tab to switch between buffers
nmap <C-tab> :bn<CR>
imap <C-tab> <ESC>:bn<CR>i
nmap <C-S-tab> bp<CR>
imap <C-S-tab> <ESC>:bp<CR>i

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Edit vimrc
nmap <c-_> :e ~/.vimrc<CR>

" Plugin: Command-T
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" Plugins: CloseTag
" Load only for html/xml like files
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
if has("win32") || has("win64")
	autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/vimfiles/bundle/closetag/plugin/closetag.vim
else
	autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
endif

" ctags
let Tlist_Ctags_Cmd='/opt/local/bin/ctags' 

" Javascript
autocmd BufWritePre *.js :%s/\s\+$//e       " remove trailing whitespace from the end of lines on save

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>



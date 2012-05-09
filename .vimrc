set nocompatible                " choose no compatibility with legacy vi
set laststatus=2				" always show the statusline
syntax enable
set encoding=utf-8

" Plugin: Pathogen
" Install plugins by copying the plugin files into ~/.vim/bundle/plugin_name
" Generally, you will download the plugin, extract it and move to ~/.vim/bundle/plugin_name.
" For example:
" cd ~/.vim
" git submodule add git://github.com/tpope/vim-fugitive.git bundle/fugitive
" git submodule init && git submodule update
call pathogen#runtime_append_all_bundles()	
call pathogen#helptags()

filetype plugin indent on       " load file type plugins + indentation

" Appearance
colorscheme evening
if has("macunix")
  set gfn=Monaco:h11
  set shell=/bin/bash
elseif has("win32") || has("win64")
  set guifont=Consolas:h9
elseif has("unix")
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if has("gui_running")
	set antialias
	set window=50
	set lines=51 columns=120
end

set number						" turn on line numbers
set cursorline
set showcmd                     " display incomplete commands
set scrolloff=3					" provide some context when editing

set hidden                      " Allow backgrounding buffers without writing them, and remember marks/undo for backgrounded buffers

if has("win32") || has("win64")
	set backupdir=~/vimfiles/_backup " where to put backup files.
	set directory=~/vimfiles/_temp " where to put swap files.
else
	set backupdir=~/.vim/_backup " where to put backup files.
	set directory=~/.vim/_temp " where to put swap files.
endif

" Whitespace
set autoindent                  " Copy indent from current line when starting a new line
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is four spaces (or set this to 4)
set noet                        " don't expand tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set autoread					" auto reload file when it is edited elsewhere

" Reload vimrc on save
au! BufWritePost .vimrc source % 

" Keyboard mappings
" Ctrl+s to save
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Ctr+tab to switch between buffers
nmap <C-tab> :bn<CR>
imap <C-tab> <ESC>:bn<CR>i
nmap <C-S-tab> bp<CR>
imap <C-S-tab> <ESC>:bp<CR>i

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Plugin: Command-T
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" Plugin: CloseTab
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



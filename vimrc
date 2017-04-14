" ============================================================================= Setup =============================================================================
"

" Allow the neovim Python plugin to work inside a virtualenv, by manually
" specifying the path to python2. This variable must be set before any calls to
" `has('python')`.
if has('nvim')
  let s:uname = system('echo -n "$(uname)"')
  if s:uname == 'Linux'
    let g:python_host_prog='/usr/bin/python2.7'
    let g:python3_host_prog='/usr/bin/python3'
  else
    let g:python_host_prog='/usr/local/bin/python'
    let g:python3_host_prog='/usr/local/bin/python3'
  end
  set inccommand=nosplit
end

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set lazyredraw
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set autowrite                   "Automatically :write before runnning commands
set clipboard=unnamedplus

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into <Space>x
" The mapleader has to be set before plug starts loading all
" the plugins.
let mapleader="\<Space>"
set ttimeout
set ttimeoutlen=-1
set ttyfast

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" folds
set fdm=syntax
set foldnestmax=10
set nofoldenable

filetype plugin indent on

" Display tabs and trailing spaces visually
set list listchars=tab:»·,trail:·,nbsp:·

" set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.nvim/backups > /dev/null 2>&1
  set undodir=~/.nvim/backups
  set undofile
endif

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ The Silver Searcher ==============

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ================ Plugins ==========================
" Autoinstall vim-plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.nvim/plugged') " Plugins initialization start
call plug#end() " Plugins initialization end

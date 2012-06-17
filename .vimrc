set number
set showmode
set title
set ruler
set showcmd
set showmatch
set laststatus=2
set cursorline

set scrolloff=5

set noswapfile
set autoread

syntax on
set smartindent

set expandtab
set ts=4 sw=4 sts=0

set ignorecase
set smartcase
set wrapscan

set hlsearch
set incsearch

set tags=tags,~/tags/rails2,~/tags/android,./tags

colorscheme desert

filetype off
""" pathogen をコメントアウト
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
 
""" Vundle '''
set rtp+=~/.vim/vundle.git/
call vundle#rc()
  
" 利用中のプラグインをBundle
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimproc'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'kana/vim-fakeclip'
Bundle 'taglist.vim'
Bundle 'trinity.vim'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'scala.vim'
Bundle 'open-browser.vim'
Bundle 'Markdown-syntax'
"Bundle 'javaimports.vim'
"Bundle 'javap.vim'
Bundle 'Lokaltog/vim-powerline' 
Bundle 'minibufexpl.vim'
Bundle 'changelog'
Bundle 'snipMate'
Bundle 'ZenCoding.vim'
Bundle 'vim-coffee-script'
Bundle 'rails.vim'

""" Vundle 設定終了
filetype plugin indent on

source ~/dotfiles/.vimrc.statusline

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,euc-jp,utf-8
"set fileencodings+=,ucs-2le,ucs-2,cp932,euc-jp

au BufNewFile,BufRead *.scala set filetype=scala

" coffee script
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command': 'coffee', 'exec': ['%c -bp %s']}
let g:quickrun_config['markdown'] = {'outputter': 'browser'}
let g:quickrun_config['cs'] = {'command': 'dmcs', 'exec':['%c %o %s -out:%s:p:r.exe', 'mono %s:p:r.exe %a', 'rm -f %s:p:r.exe'], 'tempfile': '%{tempname()}.cs'}
let g:quickrun_config['sql'] = {'command': 'sqlite3', 'exec': ['%c ~/db/temp.db < %s']}

let g:ref_alc_encoding = 'utf-8'
let g:ref_alc_start_linenumber = 44

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &binary=1
  au BufReadPost * if &binary | silent %!xxd
  au BufReadPost * set ft=xxd | endif
  au BufWritePre * if &binary | %!xxd -r
  au BufWritePre * endif
  au BufWritePost * if &binary | silent %!xxd
  au BufWritePost * set nomod | endif
augroup END

" augroup cch
"   autocmd! cch
"   autocmd WinLeave * set nocursorline
"   autocmd WinEnter,BufRead * set cursorline
" augroup END

" hi clear CursorLine
" hi CursorLine gui=underline cterm=underline
" highlight CursorLine ctermbg=red guibg=red


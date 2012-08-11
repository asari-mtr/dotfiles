set autoread
set autochdir
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noswapfile
set number
set ruler
set scrolloff=5
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set tags=tags,~/tags/rails2,~/tags/android,./tags
set title
set ts=4 sw=4 sts=0
set wrapscan
set nobackup
set hidden
set visualbell
set t_vb=

syntax on

colorscheme desert

filetype off
""" pathogen をコメントアウト
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
 
""" Vundle '''
set rtp+=~/.vim/vundle.git/
call vundle#rc()
 
Bundle 'gmarik/vundle'

" 利用中のプラグインをBundle
Bundle 'Lokaltog/vim-powerline' 
Bundle 'Markdown-syntax'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'ZenCoding.vim'
Bundle 'changelog'
Bundle 'log.vim'
"Bundle 'javaimports.vim'
"Bundle 'javap.vim'
Bundle 'kana/vim-fakeclip'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'minibufexpl.vim'
Bundle 'open-browser.vim'
Bundle 'rails.vim'
Bundle 'scala.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'snipMate'
Bundle 'taglist.vim'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'trinity.vim'
Bundle 'vim-coffee-script'

Bundle 'groenewege/vim-less'
"Bundle 'skammer/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'

Bundle 'maven2.vim'
Bundle 'perl.vim'
Bundle 'python.vim'
Bundle 'php.vim'
Bundle 'ruby.vim'
Bundle 'csharp.vim'
Bundle 'node.js'

Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'motemen/hatena-vim'

Bundle 'hiroro/vimdoc_ja'

""" Vundle 設定終了
filetype plugin indent on

source ~/dotfiles/.vimrc.statusline

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp,euc-jp,utf-8
"set fileencodings+=,ucs-2le,ucs-2,cp932,euc-jp

au BufNewFile,BufRead *.scala set filetype=scala

" coffee script
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner': 'vimproc'}
let g:quickrun_config['coffee'] = {
\  'command': 'coffee',
\  'exec': ['%c -bp %s'],
\  'outputter/filetype': 'javascript'
\}
let g:quickrun_config['less'] = {
\  'command': 'lessc',
\  'exec': ['%c %s'],
\  'outputter/filetype': 'css'
\}
let g:quickrun_config['cs'] = {
\  'command': 'dmcs',
\  'exec': [
\    '%c %o %s -out:%s:p:r.exe',
\    'mono %s:p:r.exe %a',
\    'rm -f %s:p:r.exe'
\  ],
\  'tempfile': '%{tempname()}.cs'
\}
let g:quickrun_config['markdown'] = {'outputter': 'browser'}
" let g:quickrun_config['sql'] = {'command': 'sqlite3', 'exec': ['%c ~/db/temp.db < %s']}

let g:ref_alc_encoding = 'utf-8'
let g:ref_alc_start_linenumber = 44

" Gist
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

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

autocmd BufWritePre * :%s/\s+$//ge
autocmd BufWritePre * :%s/\t/  /ge

" RSpec
let g:quickrun_config['ruby.rspec'] = {'command' : 'rspec'}
augroup MyRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_rspec.rb set filetype=ruby.rspec
augroup END
autocmd BufWinEnter,BufNewFile *.coffee set filetype=coffee
autocmd BufWinEnter,BufNewFile *.less set filetype=less

autocmd QuickfixCmdPost vimgrep cw

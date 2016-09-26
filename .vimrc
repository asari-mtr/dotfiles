set autoread
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
set mouse=a

colorscheme desert

filetype off
""" pathogen をコメントアウト
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
 
""" Vundle '''
set rtp+=~/.vim/vundle.git/
call vundle#begin()
 
Plugin 'gmarik/vundle'

" 利用中のプラグインをPlugin
Plugin 'powerline/powerline' 
Plugin 'Markdown-syntax'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc'
Plugin 'Shougo/vimshell'
Plugin 'Shougo/neomru.vim'
Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'ZenCoding.vim'
Plugin 'changelog'
Plugin 'log.vim'
"Plugin 'javaimports.vim'
"Plugin 'javap.vim'
Plugin 'kana/vim-fakeclip'
"Plugin 'mattn/gist-vim'
"Plugin 'mattn/webapi-vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'open-browser.vim'
Plugin 'rails.vim'
Plugin 'scala.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'thinca/vim-quickrun'
Plugin 'thinca/vim-ref'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails'
Plugin 'trinity.vim'
Plugin 'vim-coffee-script'

Plugin 'groenewege/vim-less'
"Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'

Plugin 'maven2.vim'
Plugin 'perl.vim'
Plugin 'python.vim'
Plugin 'php.vim'
Plugin 'ruby.vim'
Plugin 'csharp.vim'
Plugin 'node.js'

Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'motemen/hatena-vim'

"Plugin 'hiroro/vimdoc_ja'
Plugin 'tpope/vim-obsession'

Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'

""" Vundle 設定終了
call vundle#end()
syntax enable
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

" autocmd BufWritePre * :%s/\s+$//ge
" autocmd BufWritePre * :%s/\t/  /ge

" RSpec
let g:quickrun_config['ruby.rspec'] = {'command' : 'rspec'}
augroup MyRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_rspec.rb set filetype=ruby.rspec
augroup END
autocmd BufWinEnter,BufNewFile *.coffee set filetype=coffee
autocmd BufWinEnter,BufNewFile *.less set filetype=less

augroup SetTagsFile
  autocmd!
  autocmd FileType scala set tags=~/github/Play20/tags,~/github/scala/tags
augroup END

autocmd QuickfixCmdPost vimgrep cw

" tagbar
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

"""" unite key map
" インサートモードで開始
let g:unite_enable_start_insert = 1
" ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable = 1
" prefix key の設定
nmap <Space> [unite]

nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>histroy/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>

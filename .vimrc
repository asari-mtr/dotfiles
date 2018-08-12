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
set ttymouse=xterm2
set clipboard+=unnamed

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
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/vimproc'
Plugin 'Shougo/vimshell'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/neoyank.vim'
Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'ZenCoding.vim'
Plugin 'changelog'
Plugin 'log.vim'
"Plugin 'javaimports.vim'
"Plugin 'javap.vim'
Plugin 'kana/vim-fakeclip'
"Plugin 'mattn/gist-vim'
"Plugin 'mattn/webapi-vim'
"Plugin 'fholgado/minibufexpl.vim'
Plugin 'open-browser.vim'
Plugin 'rails.vim'
Plugin 'scala.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'
Plugin 'thinca/vim-quickrun'
Plugin 'thinca/vim-ref'
Plugin 'yuku-t/vim-ref-ri'
Plugin 'tsukkee/unite-tag'
"Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rails'
Plugin 'vim-coffee-script'

Plugin 'groenewege/vim-less'
"Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'

Plugin 'maven2.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'python.vim'
Plugin 'ruby.vim'
Plugin 'node.js'
Plugin 'rust-lang/rust.vim'
Plugin 'digitaltoad/vim-pug'

Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'

"Plugin 'hiroro/vimdoc_ja'
Plugin 'tpope/vim-obsession'

Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim.git'

Plugin 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime        = 1
let g:gitgutter_eager           = 1

Plugin 'taglist.vim'

Plugin 'luochen1990/rainbow'

Plugin 'bronson/vim-trailing-whitespace'

Plugin 'alpaca-tc/alpaca_tags'
Plugin 'tpope/vim-endwise'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'

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

let g:ref_open = 'vsplit'
let g:ref_use_vimproc = 1

let g:ref_refe_cmd = "/usr/local/var/rbenv/shims/refe"
let g:ref_ri_cmd = $PWD."/bin/bundle exec ri"

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
" prefix key の設定
nmap <Space> [unite]

nnoremap <silent> [unite]f :<C-u>Unite -direction=belowright<Space>buffer file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite -direction=belowright<Space>directory<CR>
nnoremap <silent> [unite]b :<C-u>Unite -direction=belowright<Space>buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite -direction=belowright<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite -direction=belowright<Space>tag<CR>
nnoremap <silent> [unite]h :<C-u>Unite -direction=belowright<Space>history/unite<CR>
nnoremap <silent> [unite]y :<C-u>Unite -direction=belowright<Space>history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite -direction=belowright -winheight=10<Space>outline<CR>
nnoremap <silent> [unite]<CR> :<C-u>Unite -direction=belowright<Space>file_mru file_rec/git:--cached:--others:--exclude-standard<CR>
"nnoremap <silent> [unite]<CR> :<C-u>Unite -direction=belowright<Space>file_rec<CR>
nnoremap <silent> [unite]g :<C-u>Unite -direction=belowright grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]n :<C-u>Unite -direction=belowright grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> [unite]gr :<C-u>UniteResume -direction=belowright search-buffer<CR>
nnoremap <silent> rr :<C-U>Unite ref/refe<CR>
nnoremap <silent> ri :<C-U>Unite ref/ri<CR>

nmap s <Plug>(easymotion-w)
nmap S <Plug>(easymotion-b)

noremap j gj
noremap k gk

" unite tag用
autocmd BufEnter *
            \  if empty(&buftype)
            \|   nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag <CR>
            \| endif
autocmd BufEnter *
            \  if empty(&buftype)
            \|   nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
            \| endif

" 行末の半角スペースを削除
autocmd BufWritePre *.rb :FixWhitespace

" neocompleteを有効
let g:neocomplete#enable_at_startup = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets/'

" prevent conflict between neocomplete and vim-multiple-cursors
"
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'ctermfgs': ['blue', 'yellow', 'red', 'green', 'magenta', 'cyan']
\}

" rust
let g:rustfmt_autosave = 1

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

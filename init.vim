if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/mitsuteru.asari/.config/nvim/dein.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/mitsuteru.asari/.config/nvim/dein.vim')
  call dein#begin('/Users/mitsuteru.asari/.config/nvim/dein.vim')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/mitsuteru.asari/.config/nvim/dein.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  call dein#add('Shougo/denite.nvim')

  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('tpope/vim-fugitive')

  call dein#add('terryma/vim-multiple-cursors')

  call dein#add('airblade/vim-gitgutter')
  let g:gitgutter_highlight_lines = 0
  let g:gitgutter_realtime        = 1
  let g:gitgutter_eager           = 1

  call dein#add('luochen1990/rainbow')
  call dein#add('Lokaltog/vim-easymotion')

  call dein#add('deresmos/denite-gitdiff')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

set autoread
set cursorline
set clipboard=unnamed
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
set tags=tags,~/tags/rails2,~/tags/android,./tags,~/.alpaca_tags
set title
set ts=2 sw=2 sts=0
set wrapscan
set nobackup
set hidden
set visualbell
set mouse=a
set clipboard+=unnamed
set virtualedit=all
set inccommand=split

let mapleader = "\<Space>"

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

nnoremap <silent> <Leader>f :Denite file/rec<CR>
nnoremap <silent> <Leader>f :Denite file/rec<CR>
nnoremap <silent> <Leader>df :Denite gitdiff_file<CR>
nnoremap <silent> <Leader>n :NERDTree<CR>
nnoremap <silent> <Leader>sc :source ~/.config/nvim/init.vim<CR>

nmap s <Plug>(easymotion-w)
nmap S <Plug>(easymotion-b)

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \  'ctermfgs': ['blue', 'yellow', 'red', 'green', 'magenta', 'cyan']
\}

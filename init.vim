if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state("$HOME/.cache/dein")
  call dein#begin("$HOME/.cache/dein")

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Dark powered asynchronous unite all interfaces for Neovim/Vim8
  call dein#add('Shougo/denite.nvim')

  " A tree explorer plugin for vim
  call dein#add('preservim/nerdtree')
  " A plugin of NERDTree showing git status
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  " fugitive.vim: A Git wrapper so awesome, it should be illegal
  call dein#add('tpope/vim-fugitive')

  " True Sublime Text style multiple selections for Vim 
  call dein#add('terryma/vim-multiple-cursors')

  " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks
  call dein#add('airblade/vim-gitgutter')

  " Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration
  call dein#add('luochen1990/rainbow')
  " Vim motions on speed! 
  call dein#add('easymotion/vim-easymotion')

	" Manger list of git objects with interface of denite.nvim
  call dein#add('neoclide/denite-git')

  " Terraform
  call dein#add('hashivim/vim-terraform')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Typescript syntax files for Vim
  call dein#add('leafgarland/typescript-vim')

  " lean & mean status/tabline for vim that's light as air<Paste>
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
	" Adds file type glyphs/icons to popular Vim plugins: NERDTree, vim-airline,
  " Powerline, Unite, vim-startify and more
  call dein#add('ryanoasis/vim-devicons')

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

" for dev icons
set encoding=UTF-8
set guifont=Hack\ Nerd\ Font:h11
let g:airline_powerline_fonts = 1

set autoread
set cursorline
highlight CursorLine guifg=#E19972
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

set ttimeoutlen=10

let mapleader = "\<Space>"

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

nnoremap <silent> <Leader>f :Denite -auto-action=preview -vertical-preview file/rec<CR>
nnoremap <silent> <Leader>gl :Denite -auto-action=preview -vertical-preview gitlog<CR>
nnoremap <silent> <Leader>gla :Denite -auto-action=preview -vertical-preview gitlog::all<CR>
nnoremap <silent> <Leader>gs :Denite -auto-action=preview -vertical-preview gitstatus<CR>
nnoremap <silent> <Leader>gf :Denite -auto-action=preview -vertical-preview gitfiles<CR>
nnoremap <silent> <Leader>gc :Denite -auto-action=preview -vertical-preview gitchange<CR>
nnoremap <silent> <Leader>n :NERDTree<CR>
nnoremap <silent> <Leader>- :Denite -auto-action=preview -vertical-preview -resume<CR>
nnoremap <silent> <Leader>sc :source ~/.config/nvim/init.vim<CR>

" easymotion
nmap s <Plug>(easymotion-w)
nmap S <Plug>(easymotion-b)

" Nerd toggle_window
let g:toggle_window_size = 0
function! ToggleWindowSize()
  NERDTreeToggle()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
  endif
endfunction
nnoremap <C-w>z :call ToggleWindowSize()<CR>

" Terraform
let g:terraform_fmt_on_save = 1

" gitgutter
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime        = 1
let g:gitgutter_eager           = 1

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
  \  'ctermfgs': ['blue', 'yellow', 'red', 'green', 'magenta', 'cyan']
\}

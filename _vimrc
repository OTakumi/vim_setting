" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

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

syntax enable

" settings "
set encoding=utf-8
let $LANG='en_US.UTF-8'
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" view "
set title
set number
set cursorline
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
set listchars=tab:^\ ,trail:~
set clipboard=unnamed,autoselect
set guioptions+=all
set textwidth=80
set colorcolumn=80
set background=dark
highlight CursorLine guibg=#006f6f ctermbg=black

" tab "
set expandtab
set tabstop=4
set shiftwidth=4

" search "
set ignorecase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> : nohlsearch<CR><Esc>j


if has('autocmd')
    "ファイルタイプの検索を有効にする
    filetype plugin on
    "ファイルタイプに合わせたインデントを利用
    filetype indent on
    "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
    autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
    autocmd FileType ts          setlocal sw=2 sts=2 ts=2 et
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
    autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType yml         setlocal sw=2 sts=2 ts=2 et
endif

" Plugins
packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'https://github.com/dense-analysis/ale'
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Jetpack 'itchyny/lightline.vim'
Jetpack 'rakr/vim-one'
Jetpack 'jacoborus/tender.vim'
Jetpack 'tpope/vim-fugitive'
Jetpack 'scrooloose/nerdtree'
call jetpack#end()

let g:lightline = {
            \ 'colorscheme': 'tender',
            \}

if (has("termguicolors"))
    set termguicolors
endif

colorscheme tender

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

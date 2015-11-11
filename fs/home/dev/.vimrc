set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" custom plugins
Plugin 'majutsushi/tagbar'
Plugin 'shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mbbill/undotree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'milkypostman/vim-togglelist'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'phildawes/racer'
Plugin 'rust-lang/rust.vim'

" all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" general customizations
syntax on
set ts=4
set sw=4
set number
set cursorline
set scrolloff=999
set encoding=utf-8
set hidden
set incsearch
colorscheme molokai

" rust customizations
autocmd BufNewFile,BufRead *.rs set formatprg=rustfmt

" plugin customizations
" neocomplete
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.rust = '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'

" rust.vim
au FileType rust compiler cargo

" racer
let g:racer_cmd = "/usr/local/bin/racer"

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'

" tagbar
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

" nerdcommenter
let g:NERDCustomDelimiters = {
        \ 'rust': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
    \ }

" togglelist
let g:toggle_list_copen_command = 'botright copen'

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/]target\/(debug|release)$'

" shortcuts remap
" rust specific
autocmd FileType rust nmap <Leader>r :make run<CR>
autocmd FileType rust nmap <Leader>b :make build<CR>
autocmd FileType rust nmap <Leader>t :make test<CR>

" generic
nmap <F2> :tabnew<CR>
nmap <F3> :tabclose<CR>
nmap <F4> :call ToggleQuickfixList()<CR>
nmap <F5> :UndotreeToggle<CR>
nmap <F7> :NERDTreeTabsToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>
nmap <C-Down> :bprev<CR>
nmap <C-Up> :bnext<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

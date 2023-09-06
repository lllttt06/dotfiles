syntax on
syntax enable
set number
set cursorline
set smartindent
set showmatch
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set smartcase
set laststatus=2
set expandtab
set background=dark
set listchars=tab:-\ ,trail:_,eol:$
set clipboard+=unnamed

let macvim_skip_colorscheme=1

" colorscheme (everforest)
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
let g:everforest_disable_terminal_colors = 1
colorscheme everforest

autocmd FileType vue syntax sync fromstart
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html
autocmd BufNewFile,BufRead *.c set tabstop=2
autocmd BufNewFile,BufRead *.c set shiftwidth=2
autocmd BufNewFile,BufRead *.js set tabstop=2
autocmd BufNewFile,BufRead *.js set shiftwidth=2
autocmd BufNewFile,BufRead *.jsx set tabstop=2
autocmd BufNewFile,BufRead *.jsx set shiftwidth=2

map <C-n> :NERDTreeToggle<CR>
map <C-t> :bo terminal ++rows=15<CR>

" Plugin SetUp
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'szw/vim-tags'
Plug 'cohama/lexima.vim'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'fatih/vim-go'
Plug 'Shougo/unite.vim'
Plug 'Quramy/tsuquyomi'
Plug 'Yggdroot/indentLine'
Plug 'udalov/kotlin-vim'
" ddc.vim本体
Plug 'Shougo/ddc.vim'
" DenoでVimプラグインを開発するためのプラグイン
Plug 'vim-denops/denops.vim'
" ポップアップウィンドウを表示するプラグイン
Plug 'Shougo/pum.vim'
" カーソル周辺の既出単語を補完するsource
Plug 'Shougo/ddc-around'
" ファイル名を補完するsource
Plug 'LumaKernel/ddc-file'
" 入力中の単語を補完の対象にするfilter
Plug 'Shougo/ddc-matcher_head'
" 補完候補を適切にソートするfilter
Plug 'Shougo/ddc-sorter_rank'
" 補完候補の重複を防ぐためのfilter
Plug 'Shougo/ddc-converter_remove_overlap'

Plug 'jacoborus/tender.vim'

Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-rails'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ruby-formatter/rufo-vim'
Plug 'hashivim/vim-terraform'
Plug 'Shougo/ddc-ui-native'

" Markdonw用のプラグイン
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'previm/previm'
let g:vim_markdown_folding_disabled = 1
let g:previm_enable_realtime = 1
let g:previm_open_cmd = 'open -a Google\ Chrome'
call plug#end()

let g:lightline = {
    \ 'colorscheme': 'everforest',
    \ 'active': {
    \    'left': [ [ 'mode', 'paste' ], ['gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
    \ },
    \ 'component_function': {
    \ 'gitbranch': 'FugitiveHead'
    \ },
    \ }

imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-a> <C-o>^
imap <C-e> <C-o>$
imap <silent> jj <ESC>

nnoremap d "_d
nnoremap x "_x
xnoremap x "_x
xnoremap d "_d
xnoremap p "_dP

nnoremap <space>h <C-o>^
nnoremap <space>l <C-o>$



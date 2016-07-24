syntax on
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set smartindent
set autoindent
set expandtab
set foldmethod=syntax
set foldlevelstart=99
set hlsearch
set incsearch
set hidden
set splitright
set splitbelow
set scrolloff=3
set nojoinspaces
set autoread
set go-=r
let mapleader=","
set shell=bash

" hebrew {{{
map ק e
map ר r
map א t
map ט y
map ו u
map ן i
map ם o
map פ p
map ש a
map ד s
map ג d
map כ f
map ע g
map י h
map ח j
map ל k
map ך l
map ז z
map ס x
map ב c
map ה v
map נ b
map מ n
map צ m
" }}}

map <leader>src :so ~/.vimrc \| so ~/.gvimrc<CR>
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y
map Y y$

" buffers {{{
map gn :bn<CR>
map gb :bp<CR>
map <leader>e :bn<CR>
map <leader>w :bp<CR>
map <leader>dd :bd<CR>
map <leader>ds :bun<CR>
map <leader>DD :bd!<CR>

" map :q<CR> :bd<CR>
" }}}

" map f5
map <M-r> <F5>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-c><C-c> <C-\><C-n>:bd!<CR>
map <leader>X :split term://node\ index.js<CR>
map <leader><leader>X :split term://node\ index.js
map <leader>T :split term://npm\ test<CR>
map <leader><leader>T :split term://DEBUG=joe*\ npm\ test<CR>
inoremap ,,f function() {<CR>}<Esc>O

"foldcolumn=1
hi FoldColumn ctermbg=Black ctermfg=Black
hi Folded ctermfg=6 ctermbg=9
map <leader>l<space> :!<space>
inoremap <leader>,p <Esc>"+pi
inoremap <leader>,P <Esc>"+Pi
map <leader>,p <Esc>"+p
map <leader>,P <Esc>"+P
map <C-o> :NERDTreeToggle<CR>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
vmap <leader>ty !pygmentize -f rtf -O 'fontface=Source Code Pro for Powerline,fontsize=40' -l js \| pbcopy<CR>

noremap <C-left> <C-w>h
noremap <C-right> <C-w>l
noremap <C-up> <C-w>k
noremap <C-down> <C-w>j

nmap <leader>c :!gcc %<CR>

nmap <leader>q :noh<CR>
nmap <leader>rc :vs ~/.vimrc<CR>
inoremap jj <Esc>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" map <C-right> :tabn<CR>
" map <C-left> :tabp<CR>
" map <C-n> :tabnew<CR>
" map <C-w> :tabclose<CR>
" map <C-t> :tabnew<CR>
map <leader>z za
map <leader>f :set syntax=
map # ^
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

map j gj
map k gk

autocmd FileType javascript,javascript.jsx,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e


set wildmode=longest,list
set wildmenu
set ignorecase smartcase
set incsearch
set cursorline
set showmatch

imap <C-up> <Esc>:m .-2<CR>i
imap <C-down> <Esc>:m .+1<CR>i
imap <C-t> <Esc><C-t>

map <leader>lk :! npm test<CR>
map <leader>lw :! webpack<CR>
let base16colorspace=256  " Access colors present in 256 colorspace

" let mapleader=','


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'chriskempson/base16-vim'
Plugin 'mxw/vim-jsx'
Plugin 'moll/vim-node'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-dispatch'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'benekastah/neomake'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'zerowidth/vim-copy-as-rtf'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
let indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
" hi IndentGuidesOdd  guibg=0   ctermbg=8
" hi IndentGuidesEven guibg=darkgrey ctermbg=0

let javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_expandabbr_key='<C-e>'   "This maps the expansion to Ctrl-space

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore node_modules
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

"displayyy
set background=dark
colorscheme base16-eighties
let macvim_skip_colorscheme = 1

" font
set guifont=Sauce\ Code\ Powerline:h13

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" syntastic
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_eslint_exec='/bin/echo'
"/Users/schniz/.nvm/versions/node/v0.12.2/bin/eslint_d'

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set number
nmap <leader>R :set relativenumber!<CR>

" Markdown
let g:markdown_fenced_languages = ['html', 'css', 'erb=eruby', 'javascript.jsx', 'javascript', 'js=javascript.jsx', 'json=javascript', 'ruby', 'xml']

let g:neomake_javascript_eslint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ 'exe': 'eslint',
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
let g:html_use_css = 1

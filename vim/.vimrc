syntax on
set relativenumber
set backspace=indent,eol,start
set tabstop=2
set shiftwidth=2
set smartindent
set autoindent
set hlsearch
set expandtab
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
set complete+=kspell
set noswapfile
set mouse=nicr
set re=1

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
map <leader>= gg=G``
map <leader>/ gcc
map <leader>. :CtrlPTag<CR>
map <leader>WW :w<CR>:e!<CR>
map <leader>] :lnext<CR>
map <leader>[ :lprev<CR>
nnoremap <CR> :noh<CR><CR>
map <leader>t :w\|call RunRubyTest()<CR>
map <leader>p :CtrlPTag<CR>
map <leader>T :call CallPrettier()<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <leader>gd g<C-]>

function! CallPrettier()
  execute "%!prettier --print-width 120"
endfunction

inoremap <leader><leader>c<CR> export default class MyComponent extends React.Component {<CR>render() {<CR>return ();<CR>}<CR>}<Up><Up><End><Left><Left>

" Ruby spec toggles {{{
function! SpecPath()
  if expand('%.') =~ "^spec\/"
    return expand('%')
  elseif expand('%.') =~ "^app\/"
    return "spec/" . strpart(expand('%:r'), 4) . "_spec.rb"
  else
    return "spec/" . expand('%:r') . "_spec.rb"
  endif
endfunction

function! RubyImplPath()
  let tmp_part = strpart(expand('%:r'), 5)
  let tmp_without_spec = strpart(tmp_part, 0, len(tmp_part) - 5) . ".rb"

  if expand('%') =~ "^spec\/lib\/"
    return tmp_without_spec
  else
    return "app/" . tmp_without_spec
  endif
endfunction

function! ToggleSpec()
  if expand('%:r') =~ "^spec\/"
    execute "edit " . RubyImplPath()
  else
    execute "edit " . SpecPath()
  endif
endfunction

function! RunSpec()
  "execute "vs term://rspec\\ " . SpecPath()
  execute "!rspec --color " . t:last_test_file
endfunction

function! RunCucumber()
  execute "!cucumber " . expand('%')
endfunction

function! RunRubyTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|test_.*\.py\|_test.py\)$') != -1

  if !in_test_file && !exists('t:last_test_file')
    return
  elseif in_test_file
    let t:last_test_file = expand("%")
  end

  if match(t:last_test_file, '\.feature$') != -1
    execute "!cucumber " . t:last_test_file
    normal i
  else
    call RunSpec()
    normal i
  endif
endfunction
" }}}

" RAILS
map <leader><leader>rel :RExtractLet<CR>
noremap <leader>jed "jyiwGoexport default <C-R>j;<Esc>
noremap <leader>bo :BufOnly<CR>

" tern
" map <leader>gd :TernDefPreview<CR>

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
" map <leader>T :split term://npm\ test<CR>
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
vmap <leader>ty !pygmentize -f rtf -O 'fontface=Source Code Pro for Powerline,fontsize=40' -l js \| pbcopy<CR>

noremap <C-left> <C-w>h
noremap <C-right> <C-w>l
noremap <C-up> <C-w>k
noremap <C-down> <C-w>j

nmap <leader>c :!gcc %<CR>

nmap <leader>q :noh<CR>
nmap <leader>rc :vs ~/.vimrc<CR>
inoremap jk <Esc>
map ; :
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" map <C-right> :tabn<CR>
" map <C-left> :tabp<CR>
" map <C-n> :tabnew<CR>
" map <C-w> :tabclose<CR>
" map <C-t> :tabnew<CR>
map <leader>z za
map <leader>or :e <C-R>=expand('%:p:h') . '/'<CR>
map <leader>os <leader>orstyle.css<CR><CR>
map <leader>oi <leader>orindex.js<CR><CR>
map <leader>f :set syntax=
map # ^
noremap <Backspace> <C-^>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

map j gj
map k gk

function! RemoveTrailingWhitespace()
  %s/\s\+$//e
endfunction

autocmd FileType python,markdown,javascript,javascript.jsx,c,cpp,java,php,ruby autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()

set wildmode=longest,list
set wildmenu
set ignorecase smartcase
set incsearch
set cursorline
set showmatch

imap <C-up> <Esc>:m .-2<CR>i
imap <C-down> <Esc>:m .+1<CR>i
imap <C-t> <Esc><C-t>

map <leader>lk :! DEBUG=joe* npm test<CR>
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
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'chriskempson/base16-vim'
Plugin 'mxw/vim-jsx'
Plugin 'moll/vim-node'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'dag/vim-fish'
" Plugin 'ternjs/tern_for_vim'
Plugin 'tpope/vim-rails'
Plugin 'jparise/vim-graphql'
Plugin 'flowtype/vim-flow'
Plugin 'raimondi/delimitmate'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'schickling/vim-bufonly'
Plugin 'guns/xterm-color-table.vim'
Plugin 'chrisbra/Colorizer'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'reasonml-editor/vim-reason'
Plugin 'mileszs/ack.vim'
Plugin 'bumaociyuan/vim-swift'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'rhysd/vim-crystal'
Plugin 'AndrewRadev/splitjoin.vim'

call vundle#end()            " required
filetype plugin indent on    " required

source ~/.vim/bundle/ack.vim/autoload/ack.vim
source ~/.vim/bundle/ack.vim/plugin/ack.vim

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

let g:sql_type_default = 'pgsql'

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

let g:ctrlp_root_markers = ['Gemfile', '.git']
let g:ctrlp_cmd = 'CtrlP'

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

" " syntastic
" " let g:syntastic_javascript_checkers = ['eslint']
" "let g:syntastic_eslint_exec='/bin/echo'
" "/Users/schniz/.nvm/versions/node/v0.12.2/bin/eslint_d'
" let g:syntastic_javascript_checkers = ['eslint', 'flow']
" let g:syntastic_javascript_eslint_exec = 'eslint'
" let g:syntastic_javascript_flow_exe = 'flow status --show-all-errors --json'

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" " let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

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

let g:flow#enable = 0


" return to last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if exists("*WriteCreatingDirs") == 0
  function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
  endfunction

  command W call WriteCreatingDirs()
endif

if exists("*ToggleBackground") == 0
  function ToggleBackground()
    if &background == "dark"
      set background=light
    else
      set background=dark
    endif
  endfunction

  command BG call ToggleBackground()
endif

" delimitMate

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" highlight css colors
let g:colorizer_auto_filetype='css,html,js,javascript.jsx'

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()

" SPECS
function! GetJSAlternateFile()
  if expand('%:r') =~ '\.spec$'
    return expand('%:r:r') . '.js'
  else
    return expand('%:r') . '.spec.js'
  endif
endfunction

function! GoToAlternateFile()
  if expand('%') =~ '\.rb$'
    call ToggleSpec()
    return
  endif

  execute 'edit' GetJSAlternateFile()
endfunction

map <leader>oa :call GoToAlternateFile()<CR>
imap <leader><leader>cf <C-R>=expand('%:p:h:t')<CR>

command! -nargs=* Yarn execute "!yarn " . <q-args>
command! -nargs=* Npm execute "!npm " . <q-args>
command! -nargs=* Grip execute "!grip -b " . <q-args>

" Reason
" let g:vimreason_extra_args_expr_reason = '"--print-width " . ' . "(winwidth('.') - 4)"

function! TestOnDockerCompose()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|test_.*\.py\|_test.py\)$') != -1

  if !in_test_file && !exists('t:last_test_file')
    return
  elseif in_test_file
    let t:last_test_file = expand("%")
  end

  let test_cmd = "echo nothing to do"

  if match(t:last_test_file, '\.feature$') != -1
    let test_cmd = "cucumber " . t:last_test_file
  else
    let test_cmd = "rspec " . t:last_test_file
  endif

  execute "!docker-compose exec kms bash -c 'echo " . test_cmd . " >> tmp/test_watch.sock'"
endfunction

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:markdown_fenced_languages += ['python', 'py=python']

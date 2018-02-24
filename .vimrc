""" Base
set nocompatible
let base16colorspace=256  " Access colors present in 256 colorspace


" fix for warning about imp module -> https://github.com/vim/vim/issues/3117#issuecomment-402622616
if has('python3')
  silent! python3 1
endif

" Allow syntax highlighting (duh)
syntax on

" Needle Cursor in Insert
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"

" Vim conf
let mapleader=","
let maplocalleader="\\"
set termguicolors " 24-bit colors in terminal (iTerm support this)
set number " hybrid
set guifont=Sauce\ Code\ Powerline:h13 " Set for MacVim/GVim
set ignorecase smartcase
set wildmenu wildmode=longest,list
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
set shell=zsh
set complete+=kspell
set noswapfile
set mouse=a " nicr
" set re=1
set exrc
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=


""" Plugins

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

" Looks
Plug 'chriskempson/base16-vim' " Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides' " Adds indentation guides

Plug 'tpope/vim-commentary'   " Comment/uncomment
Plug 'tpope/vim-surround'     " Add surroundings
Plug 'raimondi/delimitmate'   " Adds closing parens
Plug 'tpope/vim-repeat'
Plug 'schickling/vim-bufonly' " Close everything but this buffer
Plug 'sgur/vim-editorconfig'  " .editorconfig file
Plug 'pbrisbin/vim-mkdir'     " Create new directories if needed

Plug 'junegunn/fzf.vim'    " Fuzzy file finder with fzf
Plug 'airblade/vim-rooter' " Find the project root
Plug 'w0rp/ale'            " Linter
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Language Server Client
Plug 'SirVer/ultisnips'    " Snippets for LSP

" Git
Plug 'tpope/vim-fugitive'     " Git functions
Plug 'airblade/vim-gitgutter' " Shows git changes in file

" Swift
Plug 'keith/swift.vim'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'

" Markdown
Plug 'jtratner/vim-flavored-markdown'
Plug 'tpope/vim-markdown'
Plug 'jez/vim-github-hub'
Plug 'jxnblk/vim-mdx-js'

" " Ruby
" Plug 'tpope/vim-rails'

" " Golang
" Plug 'fatih/vim-go'

" Fish
Plug 'dag/vim-fish'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/jsonc.vim'

" Reason
Plug 'jordwalke/vim-reasonml'
Plug 'figitaki/vim-dune'

" " Elixir
" Plugin 'elixir-editors/vim-elixir'

" " Crystal
" Plugin 'rhysd/vim-crystal'

" GraphQL
Plug 'jparise/vim-graphql'

" TOML
Plug 'cespare/vim-toml'

call plug#end()

let g:polyglot_disabled = ['javascript']

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#languageclient#enabled = 0

" " Automatically remove trailing whitespace
" function! RemoveTrailingWhitespace()
"   %s/\s\+$//e
" endfunction

autocmd BufNewFile,BufRead Brewfile set ft=ruby
autocmd FileType json set ft=jsonc
" autocmd FileType python,markdown,javascript,javascript.jsx,c,cpp,java,php,ruby,yaml autocmd BufWritePre <buffer> call RemoveTrailingWhitespace()

""" Basic keymaps

" Reset vim state
function! ResetVimState()
  set cmdheight=1
  pclose
  if exists(":MerlinClearEnclosing")
    MerlinClearEnclosing
  endif
  echo 'Vim is ready for your command <3'
endfunction

" Keymaps: basic
noremap <backspace> <C-^>
noremap # ^
nnoremap <leader>rc :vs ~/.vimrc<CR>
nnoremap <leader>src :source ~/.vimrc<CR>
nnoremap ; :
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <leader>q :noh<CR>:call ResetVimState()<CR>
nnoremap <silent> <CR> :call ResetVimState()<CR><CR>
nnoremap <silent> <C-c> :call ResetVimState()<CR><Esc>
inoremap <silent> <C-c> <Esc>
nnoremap <leader>= gg=G``zz
noremap Y y$
noremap <leader>or :e <C-R>=expand('%:p:h') . '/'<CR>

" Keymaps: windows
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-l> <C-w>l

" Keymaps: buffers
nnoremap <silent> <leader>e :bn<CR>
nnoremap <silent> <leader>w :bp<CR>
nnoremap <silent> <leader>dd :bd<CR>
nnoremap <silent> <leader>DD :bd!<CR>
nnoremap <silent> <leader>bo :BufOnly<CR>

" Keymaps: ALE
noremap <leader>T :ALEFix<CR>

" Keymaps: FZF
noremap <C-p> :Files<CR>
noremap <leader><tab> :Buffers<CR>
noremap <localleader>P :GFiles<CR>
noremap <leader>ss :Ag <C-r>\\b<C-r><C-w>\b<CR>

" Keymaps: for git
autocmd FileType conf inoremap <buffer> <leader>jt <C-r>=system('jt')<CR>

" FZF configuration
let $FZF_DEFAULT_COMMAND = 'ag --ignore "*.lock" -g ""'

" ALE conf
let g:ale_linters = {
\   'typescript': ['tsserver'],
\   'rust': ['cargo'],
\   'ruby': ['standardrb', 'ruby', 'solargraph']
\}

let g:ale_fixers = {
      \   'sh': [
      \       'shfmt',
      \   ],
      \   'ruby': [
      \       'standardrb',
      \   ],
      \   'reason': [
      \       'refmt',
      \   ],
      \   'markdown': [
      \       'prettier',
      \   ],
      \   'html': [ 'prettier' ],
      \   'typescript': [
      \       'tslint',
      \   ],
      \   'javascript': [
      \       'eslint',
      \   ],
      \   'scss': [
      \       'stylelint',
      \   ],
      \   'css': [
      \       'stylelint',
      \   ],
      \   'swift': [
      \       'swiftformat',
      \   ],
      \   'go': [
      \       'goimports',
      \   ],
      \   'sql': [
      \       'sqlfmt',
      \   ],
      \   'rust': ['rustfmt'],
      \   'elixir': ['mix_format']
      \}
" let g:ale_completion_enabled = 1
" let b:ale_set_balloons = 1
let g:elixir_elixir_ls_release = '/Users/galsc/Code/forks/elixir-ls/rel'

" Vim-Rooter
let g:rooter_patterns = ['package.json', 'Rakefile', 'Makefile', 'shard.yml', 'requirements.txt', 'Gemfile', 'mix.exs', 'Cargo.toml', '.git/']

" Rust
autocmd FileType rust nnoremap <buffer> <leader>t :<C-u>call CocAction('doHover')<CR>
autocmd FileType rust nnoremap <buffer> <leader>gd *``:<C-u>call CocAction('jumpDefinition')<CR>
autocmd FileType rust nnoremap <buffer> <leader>cr *``:<C-u>call CocAction('rename')<CR>

" Typescript
function! ShowTypescriptTypeHint()
  let l:ts_hint = tsuquyomi#hint()
  execute 'set cmdheight=' . len(split(l:ts_hint, '\n'))
  echo l:ts_hint
endfunction

" Configure prettier if eslint isn't found
function! IsEslintConfigured()
  return system('is-eslint-configured') == "1"
endfunction

function! IsTslintConfigured()
  return system('is-tslint-configured') == "1"
  return filereadable('package.json') && filereadable('tslint.json')
endfunction

function! ConfigureJSALE()
  let l:tslint = trim(tolower(system('which_js_formatter tslint')))
  let l:eslint = trim(tolower(system('which_js_formatter eslint')))
  let g:ale_fixers.typescript = [l:tslint]
  let g:ale_fixers.javascript = [l:eslint]
endfunction

" autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx,json,jsonc call ConfigureJSALE()
call ConfigureJSALE()

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
" autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nmap <buffer> <leader>t :<C-u>call ShowTypescriptTypeHint()<CR>
" autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nmap <buffer> <leader>gd *``:<C-u>call tsuquyomi#definition()<CR>
autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nnoremap <buffer> <leader>t :call CocAction("doHover")<CR>
autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nnoremap <buffer> <leader>gd *``:<C-u>call CocAction('jumpDefinition')<CR>
autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nnoremap <buffer> <leader>gr *``:<C-u>call CocAction('jumpReferences')<CR>
autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx nnoremap <buffer> <leader>cr *``:<C-u>call CocAction('rename')<CR>
" autocmd FileType typescript,javascript,typescript.jsx,javascript.jsx set omnifunc=tsuquyomi#complete
let g:tsuquyomi_javascript_support = 0 "1

" Elixir

autocmd FileType elixir nnoremap <buffer> <leader>gd <Plug>(coc-definition)
autocmd FileType elixir nnoremap <buffer> <leader>t :call CocAction("doHover")<CR>

" Reason

autocmd FileType reason nnoremap <buffer> <leader>t :call CocAction("doHover")<CR>
autocmd FileType reason nnoremap <buffer> <leader>gd *``:<C-u>call CocAction('jumpDefinition')<CR>
autocmd FileType reason nnoremap <buffer> <leader>gr *``:<C-u>call CocAction('jumpReferences')<CR>
autocmd FileType reason nnoremap <buffer> <leader>cr *``:<C-u>call CocAction('rename')<CR>

" autocmd FileType reason nnoremap <buffer> <leader>t :<C-u>call LanguageClient#textDocument_hover()<CR>
" autocmd FileType reason nnoremap <buffer> <leader>gd *``:<C-u>call LanguageClient#textDocument_definition()<CR>
" autocmd FileType reason nnoremap <buffer> <leader>t :<C-u>MerlinTypeOf<CR>
autocmd FileType reason nnoremap <buffer> <leader>gd *``:<C-u>call CocAction('jumpDefinition')<CR>

" Crystal
autocmd FileType crystal nnoremap <buffer> <leader>oa :<C-u>CrystalSpecSwitch<CR>
autocmd FileType crystal nnoremap <buffer> <leader>T :<C-u>CrystalFormat<CR>

" Javascript config
let javascript_enable_domhtmlcss = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Vim-emmet
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_expandabbr_key='<C-e>'   "This maps the expansion to Ctrl-space

" Markdown
let g:markdown_fenced_languages = ['html', 'css', 'erb=eruby', 'javascript.jsx', 'json', 'javascript', 'js=javascript.jsx', 'json=javascript', 'ruby', 'xml', 'reason.hover.type=reason', 'reason=reason', 'ts=typescript', 'typescript', 'rust']

" Return to the last position on editor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Colorscheme settings
set background=dark
silent! colorscheme base16-eighties
let macvim_skip_colorscheme = 1
highlight Search guibg=NONE guifg=NONE ctermfg=NONE ctermbg=NONE cterm=underline gui=undercurl
highlight IndentGuidesOdd ctermbg=NONE guibg=#333333
highlight IndentGuidesEven ctermbg=NONE guibg=#403737

" No warnings, no problems!
highlight ALEWarning guibg=NONE

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1

" let g:deoplete#enable_at_startup = 1

inoremap <expr> <TAB> "\<C-y>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

""" Base
set nocompatible
let base16colorspace=256  " Access colors present in 256 colorspace


" " fix for warning about imp module -> https://github.com/vim/vim/issues/3117#issuecomment-402622616
" if has('python3')
"   silent! python3 1
" endif

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
set undofile
set undodir=~/.vim/undodir
set foldmethod=syntax foldlevel=99999
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

if exists("g:neovide")
  set guifont=FiraCode\ Nerd\ Font:h16
endif

" Set Coc.nvim global extensions
let g:coc_global_extensions = [
  \ '@yaegassy/coc-tailwindcss3',
  \ 'coc-deno',
  \ 'coc-emoji',
  \ 'coc-eslint',
  \ 'coc-go',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-prettier',
  \ 'coc-prisma',
  \ 'coc-rust-analyzer',
  \ 'coc-toml',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ ]

""" Plugins

call plug#begin('~/.vim/plugged')

" Looks
Plug 'chriskempson/base16-vim' " Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides' " Adds indentation guides
Plug 'norcalli/nvim-colorizer.lua'

" Tree sitter!
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'JoosepAlviste/nvim-ts-context-commentstring' " manipulate commentstring with tree-sitter context
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-commentary'   " Comment/uncomment
Plug 'tpope/vim-surround'     " Add surroundings
Plug 'raimondi/delimitmate'   " Adds closing parens
Plug 'tpope/vim-repeat'
Plug 'schickling/vim-bufonly' " Close everything but this buffer
Plug 'sgur/vim-editorconfig'  " .editorconfig file
Plug 'pbrisbin/vim-mkdir'     " Create new directories if needed
Plug 'aserowy/tmux.nvim' " Move around with tmux

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'    " Fuzzy file finder with fzf
Plug 'airblade/vim-rooter' " Find the project root
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Language Server Client
" Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'    " Snippets for LSP
Plug 'github/copilot.vim'

" Database
" Plug 'tpope/vim-dadbod'   " Comment/uncomment
Plug 'pantharshit00/vim-prisma' " Prisma 2

" web servers
Plug 'chr4/nginx.vim'
Plug 'isobit/vim-caddyfile'

" Svelte
Plug 'leafOfTree/vim-svelte-plugin'

" Git
Plug 'tpope/vim-fugitive'     " Git functions
Plug 'tpope/vim-rhubarb'      " GitHub integration for fugitive.vim
Plug 'airblade/vim-gitgutter' " Shows git changes in file

" Swift
Plug 'keith/swift.vim'

" JavaScript
Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'moll/vim-node'
Plug 'Quramy/vim-js-pretty-template'

" Markdown
Plug 'jtratner/vim-flavored-markdown'
Plug 'tpope/vim-markdown'
Plug 'jez/vim-github-hub'
Plug 'jxnblk/vim-mdx-js'

" " Ruby
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'vim-test/vim-test'
Plug 'jebaum/vim-tmuxify'

" " Golang
" Plug 'fatih/vim-go'

" Fish
Plug 'dag/vim-fish'

" TypeScript
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/jsonc.vim'

" " Reason
" Plug 'jordwalke/vim-reasonml'
Plug 'figitaki/vim-dune'
Plug 'reasonml-editor/vim-reason-plus'

" " Elixir
" Plugin 'elixir-editors/vim-elixir'

" " Crystal
" Plugin 'rhysd/vim-crystal'

" GraphQL
Plug 'jparise/vim-graphql'

" TOML
Plug 'cespare/vim-toml'

" HTTP
Plug 'nvim-lua/plenary.nvim'
Plug 'NTBBloodbath/rest.nvim'

call plug#end()

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#languageclient#enabled = 0

" Vim test
let test#strategy = "neovim"
let test#ruby#use_spring_binstub = 1

" " Automatically remove trailing whitespace
" function! RemoveTrailingWhitespace()
"   %s/\s\+$//e
" endfunction

autocmd BufNewFile,BufRead Brewfile set ft=ruby
autocmd FileType json set ft=jsonc

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
inoremap <C-c> <ESC>
nnoremap <leader>= gg=G``zz
noremap Y y$
noremap <leader>or :e <C-R>=expand('%:p:h') . '/'<CR>
noremap <leader>o<C-r> :call fzf#vim#files(getcwd(), { 'options': ['--query', expand('%:h'), '--preview', 'bat {} --color always'] })<CR>
noremap <leader>f za

" CoC
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
noremap <leader>a <plug>(coc-codeaction-cursor)
noremap <leader>t :<C-u>call CocAction('doHover')<CR>
noremap <leader>gd *``:<C-u>call CocAction('jumpDefinition')<CR>
" noremap <leader>gd <Plug>(coc-definition)
noremap <leader>cr <Plug>(coc-rename)
noremap <leader>l :CocDiagnostics<CR>
noremap <leader>gr *``:<C-u>call CocAction('jumpReferences')<CR>
noremap <leader>T :call CocAction('format')<CR>

" rest.nvim
autocmd FileType http nnoremap <buffer> <leader><cr> <Plug>RestNvim
autocmd FileType http nnoremap <buffer> <leader><s-cr> <Plug>RestNvimPreview

" Ctrl-Space for autocomplete
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Keymaps: windows
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k
noremap <silent> <C-l> <C-w>l
tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l

" Keymaps: buffers
nnoremap <silent> <leader>e :bn<CR>
nnoremap <silent> <leader>w :bp<CR>
nnoremap <silent> <leader>dd :bd<CR>
nnoremap <silent> <leader>DD :bd!<CR>
nnoremap <silent> <leader>bo :BufOnly<CR>

" Keymaps: FZF
noremap <C-p> :Files<CR>
noremap <leader><tab> :Buffers<CR>
noremap <localleader>P :GFiles<CR>
noremap <leader>ss :Rg <C-r>\\b<C-r><C-w>\b<CR>

" FZF configuration
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/"'

" Vim-Rooter
let g:rooter_patterns = ['package.json', 'Rakefile', 'Makefile', 'shard.yml', 'requirements.txt', 'Gemfile', 'mix.exs', 'Cargo.toml', 'go.mod', '.git/']

" Typescript
function! ShowTypescriptTypeHint()
  let l:ts_hint = tsuquyomi#hint()
  execute 'set cmdheight=' . len(split(l:ts_hint, '\n'))
  echo l:ts_hint
endfunction

autocmd BufNewFile,BufRead .eslintrc set syntax=json
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
let g:tsuquyomi_javascript_support = 0 "1

" Ruby
autocmd FileType ruby nnoremap <buffer> <leader>A :execute "e " . rails#buffer().alternate()<CR>

" Javascript config
let javascript_enable_domhtmlcss = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

call jspretmpl#register_tag('ruby', 'ruby')
call jspretmpl#register_tag('css', 'css')
call jspretmpl#register_tag('sql', 'sql')
autocmd FileType javascript JsPreTmpl
autocmd FileType javascript.jsx JsPreTmpl
autocmd FileType typescript JsPreTmpl
autocmd FileType typescriptreact JsPreTmpl

" Vim-emmet
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_expandabbr_key='<C-e>'   "This maps the expansion to Ctrl-space

" Markdown
let g:markdown_fenced_languages = ['html', 'css', 'erb=eruby', 'javascript.jsx', 'json=jsonc', 'javascript', 'js=javascript.jsx', 'json=javascript', 'ruby', 'xml', 'ts=typescript', 'typescript', 'rust', 'tsx=typescriptreact', 'yaml', 'sh-session=bash']

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

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1

" let g:deoplete#enable_at_startup = 1

inoremap <expr> <TAB> "\<C-y>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Projectionist

noremap <leader>A :A<CR>
let g:projectionist_heuristics = {
      \ "package.json": {
      \   "*.spec.ts": {
      \     "alternate": "{}.ts",
      \     "template": ["import {open}{close} from \"./{basename}\";"]
      \   },
      \   "*.e2e.ts": {
      \     "alternate": "{}.ts",
      \     "type": "e2e"
      \   },
      \   "*.ts": {"alternate": "{}.spec.ts"},
      \   "*.spec.tsx": {
      \     "alternate": "{}.tsx",
      \     "template": ["import {open}{close} from \"./{basename}\";"]
      \   },
      \   "*.tsx": {"alternate": "{}.spec.tsx"},
      \ }}

" lua <<EOF
" local lspconfig = require('lspconfig')
" lspconfig.tsserver.setup {}
" lspconfig.rust_analyzer.setup {
"   -- Server-specific settings. See `:help lspconfig-setup`
"   settings = {
"     ['rust-analyzer'] = {},
"   },
" }
" EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true
  }
}

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require'colorizer'.setup()
EOF

vnoremap <leader>j :move '>+1<CR>gv
vnoremap <leader>k :move '<-2<CR>gv
nnoremap <leader>j :move .+1<CR>
nnoremap <leader>k :move .-2<CR>

lua <<EOF
  require'tmux'.setup({
      -- overwrite default configuration
      -- here, e.g. to enable default bindings
      copy_sync = {
          -- enables copy sync and overwrites all register actions to
          -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
          enable = false,
      },
      navigation = {
          -- enables default keybindings (C-hjkl) for normal mode
          enable_default_keybindings = true,
      },
      resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = true,
      }
  })
EOF

" Skip the annoying SQL C-c binding
let g:omni_sql_no_default_maps = 1

" copilot
let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ }

" open fzf with directory of current file
noremap <leader>of :Files %:h<CR>
noremap <silent> <leader>od :call fzf#run(fzf#wrap({'source': 'dfile-list', 'options': '-m --preview "diff-for-file {}"'}))<CR>

" Command-line mapping for text movement
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" coc.nvim colors
highlight CocMenuSel ctermfg=18 ctermbg=16 guifg=#393939 guibg=#f99157


vim.o.termguicolors = true -- 24-bit colors in terminal
vim.o.number = true        -- hybrid
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.wildmenu = true
vim.o.wildmode = "longest,list"
vim.o.backspace = "indent,eol,start"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.hlsearch = true
vim.o.expandtab = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 3
vim.o.joinspaces = false
vim.o.autoread = true
--vim.o.go:remove { r }
vim.o.shell = "zsh"
-- set complete+=kspell
vim.o.swapfile = false
vim.o.mouse = "a"
-- " set re=1
-- set exrc
vim.o.enc = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf8,prc"
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- set foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=9999
-- " Prevent Vim from clobbering the scrollback buffer. See
-- " http://www.shallowsky.com/linux/noaltscreen.html
-- set t_ti= t_te=
-- vim.o.t_ti = nil
-- vim.o.t_te = nil

-- Set filetype SQL to stop forcing me to press Ctrl-C twice
-- see https://unix.stackexchange.com/questions/150093/vim-delay-when-using-ctrlc-but-only-in-sql-files
vim.g.ftplugin_sql_omni_key = '<C-j>'

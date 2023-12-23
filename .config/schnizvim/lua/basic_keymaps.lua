vim.keymap.set("n", "<backspace>", "<C-^>")
vim.keymap.set("n", "#", "^")
vim.keymap.set("n", "<leader>rc", ":vs ~/.vimrc<CR>")
vim.keymap.set("n", " <leader>src", ":source ~/.vimrc<CR>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "<leader>q", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<C-c>", ":noh<CR><Esc>", { silent = true })
vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "<leader>or", ":e <C-R>=expand('%:p:h') . '/'<CR>")
vim.keymap.set("n", "<leader>o<C-r>",
  ":call fzf#vim#files(getcwd(), { 'options': ['--query', expand('%:h'), '--preview', 'bat {} --color always'] })<CR>")
vim.keymap.set("n", "<leader>f", "za")

-- windows

vim.keymap.set("n", "<leader>e", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>dd", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>DD", ":bd!<CR>", { silent = true })
vim.keymap.set("n", "<leader>bo", ":BufOnly<CR>", { silent = true })

vim.keymap.set("n", "<leader>di", function()
  vim.diagnostic.open_float(nil)
end, { silent = true })

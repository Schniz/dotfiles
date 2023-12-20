return {
  "junegunn/fzf.vim",
  dependencies = {
    "junegunn/fzf"
  },
  init = function()
    vim.cmd("let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob \"!.git/\"'")
    vim.keymap.set("n", "<C-p>", ":Files<CR>")
    vim.keymap.set("n", "<leader><tab>", ":Buffers<CR>")
    vim.keymap.set("n", "<localleader>P", ":GFiles<CR>")
    vim.keymap.set("n", "<leader>ss", ":Rg <C-r>\\b<C-r><C-w>\\b<CR>")
  end
}

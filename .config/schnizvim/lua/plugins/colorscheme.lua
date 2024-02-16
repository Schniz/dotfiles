return {
  "RRethy/nvim-base16",
  config = function()
    vim.cmd.colorscheme("base16-eighties")
    vim.cmd [[highlight NonText guifg=#444444]]
  end
}

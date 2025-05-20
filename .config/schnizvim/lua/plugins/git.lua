return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb", "airblade/vim-gitgutter" },
  init = function()
    vim.g.gitgutter_show_msg_on_hunk_jumping = 0
  end,
}

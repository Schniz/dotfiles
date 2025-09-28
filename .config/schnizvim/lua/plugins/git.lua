return {
  "tpope/vim-fugitive",
  dependencies = { "tpope/vim-rhubarb", "airblade/vim-gitgutter" },
  init = function()
    vim.g.gitgutter_show_msg_on_hunk_jumping = 0
    -- define Browse command
    -- see https://vi.stackexchange.com/questions/38447/vim-fugitive-netrw-not-found-define-your-own-browse-to-use-gbrowse
    vim.api.nvim_create_user_command("Browse", function(opts)
      vim.fn.system({ "open", opts.fargs[1] })
    end, { nargs = 1 })
  end,
}

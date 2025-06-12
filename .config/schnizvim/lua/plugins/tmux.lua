-- Allow <C-hjkl> to move between panes

return {
  "aserowy/tmux.nvim",
  opts = {
    copy_sync = { enable = false },
    navigation = { enable_default_keybindings = true },
    resize = { enable_default_keybindings = true },
  },
}

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>oa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = "n",
      desc = "Toggle Code Companion chat",
      noremap = true,
      silent = true,
    },
    {
      "<leader>oa",
      ":CodeCompanion<cr>",
      mode = "v",
      desc = "Prompt Code Companion on the current selection",
      noremap = true,
      silent = true,
    },
  },
  opts = {
    strategies = {
      chat = {
        keymaps = {
          send = {
            modes = { i = "<C-;>" },
          },
          close = {
            modes = { n = "<C-s>", i = "<C-s>" },
          },
        },
      },
    },
  },
}

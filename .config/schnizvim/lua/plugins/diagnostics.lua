return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  init = function()
    local trouble = require("trouble")
    vim.keymap.set("n", "<leader>l", trouble.toggle)
  end
}

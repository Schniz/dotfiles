return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
  opts = {
    theme = "base16",
    tabline = {
      lualine_a = {
        {
          "buffers",
          show_filename_only = false,
        },
      },
    },
    sections = {
      lualine_c = {},
      lualine_x = {
        "searchcount",
        {
          require("statusline.lsp_status"),
          icon = { "", align = "left" },
        },
        "diagnostics",
      },
    },
  },
  init = function()
    vim.o.cmdheight = 0
  end,
}

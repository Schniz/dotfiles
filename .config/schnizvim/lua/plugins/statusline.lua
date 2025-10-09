return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "linrongbin16/lsp-progress.nvim",
  },
  opts = {
    options = {
      section_separators = "",
    },
    tabline = {
      lualine_a = {
        {
          "buffers",
          show_filename_only = false,
          active = { underline = true },
          buffers_color = {
            -- active = "lualine_{section}_normal", -- Color for active buffer.
            inactive = "Conceal", -- Color for inactive buffer.
          },
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
    -- vim.o.cmdheight = 0
  end,
}

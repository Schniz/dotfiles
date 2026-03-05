local profile = require("schniz.profile")

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  enabled = not profile.talking(),
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
            -- inactive = "Conceal", -- Color for inactive buffer.
          },
        },
      },
    },
    sections = {
      lualine_c = {},
      lualine_x = {
        "searchcount",
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return ""
            end
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            return table.concat(names, ", ")
          end,
          icon = { "", align = "left" },
        },
        "diagnostics",
      },
    },
  },
}

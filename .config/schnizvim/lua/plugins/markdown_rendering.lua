return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "RRethy/nvim-base16",
  }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    latex = { enabled = false },
    heading = {
      left_margin = 0,
      position = "inline",
      icons = {},
      backgrounds = {
        "MarkdownH1Bg",
        "MarkdownH2Bg",
        "MarkdownH3Bg",
        "MarkdownH4Bg",
        "MarkdownH5Bg",
        "MarkdownH6Bg",
      },
      -- The 'level' is used to index into the list using a clamp
      -- Highlight for the heading and sign icons
      foregrounds = {
        "@markup.heading.1.markdown",
        "@markup.heading.2.markdown",
        "@markup.heading.3.markdown",
        "@markup.heading.4.markdown",
        "@markup.heading.5.markdown",
        "@markup.heading.6.markdown",
      },
    },
  },
  init = function()
    local colors = require("render-markdown.colors")
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        local colorscheme = require("base16-colorscheme")
        vim.api.nvim_set_hl(
          0,
          "@markup.heading.2.markdown",
          { fg = colorscheme.colors.base0F, bg = "" }
        )
      end,
    })
  end,
}

-- return {
--   "github/copilot.vim",
--   -- cmd = { "Copilot" },
--   -- event = { "BufReadPost" },
--   init = function()
--     vim.g.copilot_filetypes = {
--       markdown = true,
--       yaml = true,
--     }
--   end
-- }
return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "zbirenbaum/copilot-cmp"
  },
  build = function()
    vim.cmd("Copilot auth")
  end,
  opts = {},
  config = function(_, opts)
    require("copilot").setup(opts)
    require("copilot_cmp").setup()
  end
}

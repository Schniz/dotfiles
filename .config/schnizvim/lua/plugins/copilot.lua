return {
  "github/copilot.vim",
  -- cmd = { "Copilot" },
  -- event = { "BufReadPost" },
  init = function()
    vim.g.copilot_filetypes = {
      markdown = true,
      yaml = true,
    }
  end
}

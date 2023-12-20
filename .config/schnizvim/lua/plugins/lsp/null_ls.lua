-- taken from https://github.com/javivelasco/dotfiles/blob/main/nvim/.config/nvim/after/plugin/null-ls.lua

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      debug = true,
      sources = {
        formatting.prettier,
        diagnostics.eslint,
        code_actions.eslint,
      },
    })
  end
}

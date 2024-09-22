-- taken from https://github.com/javivelasco/dotfiles/blob/main/nvim/.config/nvim/after/plugin/null-ls.lua

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      debug = true,
      sources = {
        formatting.sqlfmt,
        -- formatting.eslint_d,
        formatting.swiftlint,
        -- code_actions.eslint_d,
        code_actions.eslint_d,
        diagnostics.swiftlint,
        diagnostics.eslint_d.with({
          filter = function(diagnostic)
            -- If ESLint is not configured, don't show the error
            if string.match(diagnostic.message, "Error: No ESLint configuration found in") then
              return false
            end

            return true
          end,
        }),
      },
    })
  end,
}

-- based on https://github.com/javivelasco/dotfiles/blob/main/nvim/.config/nvim/after/plugin/null-ls.lua

local biomejs = require("schniz.biomejs")

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  init = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local helpers = require("null-ls.helpers")

    local is_eslint_enabled = helpers.cache.by_bufnr(function(params)
      if biomejs.is_biome_project(params.bufnr) then
        return false
      end

      local executable_exists = vim.fn.executable("eslint") == 1

      return executable_exists
    end)

    null_ls.setup({
      debug = true,
      sources = {
        formatting.sqlfmt,
        formatting.swiftlint,
        require("none-ls.code_actions.eslint").with({
          runtime_condition = is_eslint_enabled,
        }),
        require("none-ls.formatting.eslint").with({
          runtime_condition = is_eslint_enabled,
        }),
        require("none-ls.diagnostics.eslint").with({
          runtime_condition = is_eslint_enabled,
          filter = function(diagnostic)
            -- ignore eslint 8.x not configured
            if string.match(diagnostic.message, "Error: No ESLint configuration found in") then
              return false
            end

            -- ignore eslint 9.x not configured
            if string.match(diagnostic.message, "ESLint couldn't find a configuration file") then
              return false
            end

            return true
          end,
        }),
      },
    })
  end,
}

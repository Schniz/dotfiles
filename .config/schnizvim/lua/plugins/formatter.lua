local formatters = {
  lua = { "stylua" },
  python = { "isort", "black" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  css = { "prettier" },
  html = { "prettier" },
  sh = { "shfmt" },
  toml = { "prettier" },
  rust = { "rustfmt" },
  go = { "goimports", "gofmt" },
  nix = { "nixpkgs_fmt" },
  terraform = { "terraform_fmt" },
}

return {
  'stevearc/conform.nvim',
  ---@type conform.setupOpts
  opts = {
    lsp_fallback = true,
    formatters_by_ft = formatters,
    formatters = {
      [formatters.lua[1]] = {
        ---@diagnostic disable-next-line: unused-local
        condition = function(self, ctx)
          if string.match(ctx.dirname, "/vercel/proxy/") then
            return false
          end

          return true
        end
      }
    },
    format_after_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_fallback = true, async = true, formatters_by_ft = formatters }
    end,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end
}

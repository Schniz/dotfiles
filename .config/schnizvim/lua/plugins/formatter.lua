return {
  'stevearc/conform.nvim',
  opts = {
    lsp_fallback = true,
    formatters_by_ft = {
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
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      async = true,
      lsp_fallback = true,
    },
  },
}

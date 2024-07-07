return {
  vercel_lsp = {
    filetypes = { "json", "jsonc" },
    command = { "/Users/schniz/Code/vercel/vercel_lsp/target/debug/vercel_lsp" }
  },

  sourcekit_lsp = {
    filetypes = { "swift" },
    command = { "xcrun", "sourcekit-lsp" }
  },

  -- git_lsp = {
  --   command = { "/Users/schniz/Code/git_lsp/target/debug/git_lsp" },
  -- }
}

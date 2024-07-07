return {
  'saecki/crates.nvim',
  event = { "BufRead Cargo.toml" },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('crates').setup {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    }
  end,
}

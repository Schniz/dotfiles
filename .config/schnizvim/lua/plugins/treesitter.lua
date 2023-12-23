return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring"
  },
  build = function()
    vim.cmd(":TSUpdate")
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      ignore_install = { "phpdoc" },      -- List of parsers to ignore installing
      highlight = {
        enable = true,                    -- false will disable the whole extension
        disable = { "c", "rust", "lua" }, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }

    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    parser_configs.http = {
      install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = { "src/parser.c" },
        branch = "main",
      },
    }
  end
}

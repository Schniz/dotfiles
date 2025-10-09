return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "JoosepAlviste/nvim-ts-context-commentstring", opts = {} },
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = { max_lines = 3, multiline_threshold = 1 },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- non-ts syntax highlights
    { "isobit/vim-caddyfile" },
  },
  build = function()
    vim.cmd(":TSUpdate")
  end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "typescript",
        "vimdoc",
        "javascript",
        "rust",
        "lua",
        "go",
        "tsx",
        "vim",
        "python",
        "yaml",
        "toml",
        "prisma",
        "jsdoc",
      },
      ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "c", "rust", "lua" }, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = {
              query = { "@function.outer", "@assignment.outer" },
              desc = "Next item start",
            },
          },
          goto_previous_start = {
            ["[["] = {
              query = { "@function.outer", "@assignment.outer" },
              desc = "Previous item start",
            },
          },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aa"] = "@assignment.outer",
            ["ia"] = "@assignment.inner",
          },
        },
      },
    })

    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    parser_configs.http = {
      install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = { "src/parser.c" },
        branch = "main",
      },
    }
    ---@type ParserInfo
    parser_configs.plantuml = {
      filetype = "plantuml",
      maintainers = {},
      install_info = {
        url = "https://github.com/lyndsysimon/tree-sitter-plantuml",
        files = { "src/parser.c" },
        branch = "main",
      },
    }
  end,
}

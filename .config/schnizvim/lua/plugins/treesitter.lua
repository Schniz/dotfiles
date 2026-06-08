---@type LazyPluginSpec
local languages = {
  "go",
  "html",
  "javascript",
  "jsdoc",
  "lua",
  "markdown",
  "markdown_inline",
  "prisma",
  "python",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = { enable_autocmd = false },
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      enabled = not require("schniz.profile").talking(),
      opts = { max_lines = 3, multiline_threshold = 1 },
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      config = function()
        require("nvim-treesitter-textobjects").setup({
          move = {
            set_jumps = true,
          },
          select = {
            lookahead = true,
          },
        })

        local select = require("nvim-treesitter-textobjects.select")
        vim.keymap.set({ "x", "o" }, "af", function()
          select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Select outer function" })
        vim.keymap.set({ "x", "o" }, "if", function()
          select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Select inner function" })
        vim.keymap.set({ "x", "o" }, "aa", function()
          select.select_textobject("@assignment.outer", "textobjects")
        end, { desc = "Select outer assignment" })
        vim.keymap.set({ "x", "o" }, "ia", function()
          select.select_textobject("@assignment.inner", "textobjects")
        end, { desc = "Select inner assignment" })

        local move = require("nvim-treesitter-textobjects.move")
        local item = { "@function.outer", "@assignment.outer" }
        vim.keymap.set({ "n", "x", "o" }, "]]", function()
          move.goto_next_start(item, "textobjects")
        end, { desc = "Next item start" })
        vim.keymap.set({ "n", "x", "o" }, "[[", function()
          move.goto_previous_start(item, "textobjects")
        end, { desc = "Previous item start" })
      end,
    },
    -- non-ts syntax highlights
    { "isobit/vim-caddyfile" },
  },
  build = function()
    require("nvim-treesitter").install(languages):wait(300000)
    require("nvim-treesitter").update(languages):wait(300000)
  end,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      group = vim.api.nvim_create_augroup("SchnizTreesitterParsers", { clear = true }),
      callback = function()
        local parsers = require("nvim-treesitter.parsers")
        parsers.http = {
          install_info = {
            url = "https://github.com/NTBBloodbath/tree-sitter-http",
            files = { "src/parser.c" },
            branch = "main",
          },
        }
        parsers.plantuml = {
          install_info = {
            url = "https://github.com/lyndsysimon/tree-sitter-plantuml",
            files = { "src/parser.c" },
            branch = "main",
          },
        }
        vim.treesitter.language.register("plantuml", "plantuml")
      end,
    })
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("SchnizTreesitterStart", { clear = true }),
      pattern = {
        "go",
        "html",
        "javascript",
        "javascriptreact",
        "jsdoc",
        "markdown",
        "python",
        "toml",
        "typescript",
        "typescriptreact",
        "vim",
        "vimdoc",
        "yaml",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

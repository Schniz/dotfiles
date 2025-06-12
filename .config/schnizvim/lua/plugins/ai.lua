---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>oa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = "n",
      desc = "Toggle Code Companion chat",
      noremap = true,
      silent = true,
    },
    {
      "<leader>oa",
      ":CodeCompanion<cr>",
      mode = "v",
      desc = "Prompt Code Companion on the current selection",
      noremap = true,
      silent = true,
    },
  },
  opts = {
    adapters = {
      ---@return CodeCompanion.Adapter
      devstral = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "devstral",
          schema = {
            model = {
              default = "devstral:24b",
            },
          },
        })
      end,
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-sonnet-4",
            },
          },
        })
      end,
      ---@return CodeCompanion.Adapter
      v0 = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://api.v0.dev",
            api_key = "cmd:op read op://Projects/v0/credential --no-newline",
          },
          schema = {
            model = {
              default = "v0-1.0-md",
            },
          },
        })
      end,
    },
    strategies = {
      inline = {
        adapter = "copilot",
      },
      chat = {
        adapter = "copilot",
        keymaps = {
          send = {
            modes = { i = "<C-;>" },
          },
          close = {
            modes = { n = "<C-s>", i = "<C-s>" },
          },
        },
      },
    },
  },
}

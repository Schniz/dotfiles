return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
  build = function()
    vim.cmd("Copilot auth")
  end,
  ---@type copilot_config
  opts = {
    -- use fnm to find the node binary (`fnm exec --using=default "$@"`)
    -- ../../../../bin/default-node
    copilot_node_command = "default-node",
    filetypes = {
      ["*"] = true,
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
    require("copilot_cmp").setup()
  end,
}

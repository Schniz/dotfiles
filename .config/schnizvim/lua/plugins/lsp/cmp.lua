return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
  },
  init = function()
    -- Taken from @javivelasco
    local lspkind = require("lspkind")
    local cmp = require("cmp")
    cmp.setup({
      preselect = cmp.PreselectMode.None,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "copilot" },
        { name = "crates" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        -- ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        -- ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    })
  end,
}

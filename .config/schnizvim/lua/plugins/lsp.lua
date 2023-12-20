local function set_lsp_keymaps(client, buffer)
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x'
    },
    {
      'folke/neodev.nvim',
      opts = {}
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" },     -- Required
    { "lvimuser/lsp-inlayhints.nvim" },
    { import = "plugins.lsp" },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {
      "kosayoda/nvim-lightbulb",
      opts = {
        autocmd = { enabled = true }
      }
    }
  },
  config = function(_, opts)
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "<leader>t", vim.lsp.buf.hover, { buffer = bufnr })

      require("lsp-inlayhints").on_attach(client, bufnr)
    end)

    vim.api.nvim_create_user_command("LspFormat", function(_)
      vim.lsp.buf.format()
    end, {
      desc = "LSP: Format document"
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = opts.ensure_installed,
      handlers = { lsp_zero.default_setup },
    })

    for server_name, options in pairs(opts.servers) do
      require("lspconfig")[server_name].setup(options)
    end

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = opts.autoformat,
    })
  end,
  opts = {
    ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "prismals" },
    autoformat = {
      ['null-ls'] = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
      ['lua_ls'] = { 'lua' },
      ['rust_analyzer'] = { 'rust' },
      ['prismals'] = { 'prisma' },
    },
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    },
    inlay_hints = true,
    servers = {
      tsserver = {
        -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      }
    }
  }
}

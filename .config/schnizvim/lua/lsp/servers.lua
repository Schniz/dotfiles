local servers = {
  ts_ls = {
    settings = {
      init_options = {
        maxTsServerMemory = 12288,
        preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          -- includeInlayParameterNameHints = 'all',
          -- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
    on_attach = function(client, bufnr)
      require("twoslash-queries").attach(client, bufnr)
    end,
  },

  jsonls = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end,

  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        lens = { enable = true },
        procMacro = { enable = true },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
      },
    },
  },

  prismals = {},

  tailwindcss = {},

  yamlls = {
    settings = {
      ["yaml.schemaStore.enable"] = true,
    },
  },

  taplo = {},
  sqlls = {},

  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
      },
    },
  },

  copilot = {},

  terraformls = {},

  gleam = {},

  biome = {},

  bashls = {},

  buf_ls = {},

  zls = {},

  oxlint = {
    cmd = { "oxlint", "--lsp" },
  },
}

return servers

local servers = {
  ts_ls = {
    init_options = {
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
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },

  prismals = {},

  tailwindcss = {},

  yamlls = {
    ["yaml.schemaStore.enable"] = true,
  },

  taplo = {},

  sqlls = {},

  sourcekit_lsp = {},

  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
      },
    },
  },

  terraformls = {},

  gleam = {},

  biome = {},

  bashls = {},

  buf_ls = {},
}

return servers

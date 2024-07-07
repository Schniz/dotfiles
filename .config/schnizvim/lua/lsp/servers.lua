return {
  tsserver = {
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
  },

  jsonls = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
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
      }
    }
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },

  vercel_lsp = {},

  prismals = {},

  tailwindcss = {},

  yamlls = {
    ["yaml.schemaStore.enable"] = true,
  },

  taplo = {},

  sqlls = {},

  sourcekit_lsp = {},

  gopls = {},

  nil_ls = {},

  terraformls = {},

  -- git_lsp = {},
}

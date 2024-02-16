--- @param client lsp.Client
local function setup_lsp_keymaps(client, bufnr)
  local telescope = require("telescope.builtin")

  if client.supports_method("textDocument/signatureHelp") then
    vim.api.nvim_create_autocmd("CursorHoldI", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.signature_help()
      end
    })
  end

  vim.keymap.set("i", "<c-;>", vim.lsp.buf.signature_help, { buffer = bufnr, silent = true })
  vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions, { buffer = bufnr })
  vim.keymap.set("n", "<leader>gr", telescope.lsp_references, { buffer = bufnr })
  vim.keymap.set("n", "<leader>t", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set("n", "<leader>h", function()
    if vim.lsp.inlay_hint.is_enabled(bufnr) then
      vim.lsp.inlay_hint.enable(bufnr, false)
    else
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end, { buffer = bufnr })
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
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
    { "L3MON4D3/LuaSnip" },
    { import = "plugins.lsp" },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "VeryLazy",
    --   opts = {},
    -- },
    {
      "kosayoda/nvim-lightbulb",
      opts = {
        autocmd = { enabled = true }
      }
    },
    {
      "j-hui/fidget.nvim",
      opts = {
        progress = {
          ignore = { "null-ls" }
        }
      }
    },
    {
      -- For autocompleting JSON files
      'b0o/schemastore.nvim'
    },
    {
      -- using twoslash queries in typescript
      'marilari88/twoslash-queries.nvim'
    }
  },
  config = function(_, opts)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { focus = false, anchor_bias = "above" }
    )

    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      setup_lsp_keymaps(client, bufnr)

      require("twoslash-queries").attach(client, bufnr)
    end)

    vim.api.nvim_create_user_command("LspFormat", function(_)
      vim.lsp.buf.format({ async = true })
    end, {
      desc = "LSP: Format document"
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = opts.ensure_installed,
    })

    for server_name, options in pairs(opts.custom_servers) do
      local configs = require("lspconfig.configs")
      configs[server_name] = {
        default_config = {
          cmd = options.command,
          filetypes = options.filetypes,
          root_dir = require('lspconfig').util.root_pattern('.git'),
        }
      }
    end

    for server_name, options in pairs(opts.servers) do
      if type(options) == "function" then
        options = options(server_name)
      end
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
    ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "prismals", "tailwindcss", "jsonls" },
    autoformat = {
      ['null-ls'] = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'json', 'jsonc', 'yaml', 'markdown', 'sql', 'swift' },
      ['lua_ls'] = { 'lua' },
      ['rust_analyzer'] = { 'rust' },
      ['prismals'] = { 'prisma' },
      ['jsonls'] = { 'json', 'jsonc' },
      ['taplo'] = { 'toml' },
      ['gopls'] = { 'go' },
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
    servers = require("lsp.servers"),
    custom_servers = require('lsp.custom'),
  }
}

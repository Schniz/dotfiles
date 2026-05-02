--- @param client vim.lsp.Client
local function setup_lsp_keymaps(client, bufnr)
  if client:supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.keymap.set("i", "<c-[>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
  vim.keymap.set("n", "<leader>gd", function()
    require("telescope.builtin").lsp_definitions()
  end, { buffer = bufnr, desc = "Go to definition" })
  vim.keymap.set("n", "<leader>gr", function()
    require("telescope.builtin").lsp_references()
  end, { buffer = bufnr, desc = "Find references" })
  vim.keymap.set("n", "<leader>t", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>h", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { buffer = bufnr, desc = "Toggle inlay hints" })
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })

  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, {
    desc = "Go to next diagnostic",
  })
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, {
    desc = "Go to previous diagnostic",
  })
  vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, {
    desc = "Open floating diagnostic message",
    remap = false,
  })
end

-- ignore "No information available" in vim.notify
-- this is because it is wrongly used in some LSPs
local banned_messages = { "No information available" }
local notify = vim.notify
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return notify(msg, ...)
end

--- @param client vim.lsp.Client
--- @param bufnr number
local function on_attach(client, bufnr)
  setup_lsp_keymaps(client, bufnr)
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
        automatic_enable = false,
        automatic_installation = true,
      },
    },
    { "L3MON4D3/LuaSnip" },
    { import = "plugins.lsp" },
    {
      "kosayoda/nvim-lightbulb",
      opts = {
        autocmd = { enabled = true },
      },
    },
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
        progress = {
          ignore = { "null-ls" },
        },
      },
    },
    {
      -- For autocompleting JSON files
      "b0o/schemastore.nvim",
    },
    {
      -- using twoslash queries in typescript
      "marilari88/twoslash-queries.nvim",
    },
  },
  config = function(_, opts)
    -- Configure floating window borders globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "single"
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { focus = false, anchor_bias = "above" })

    vim.api.nvim_create_user_command("LspFormat", function(_)
      vim.lsp.buf.format({ async = true })
    end, {
      desc = "LSP: Format document",
    })

    -- mason-lspconfig is set up via its own opts in dependencies

    for server_name, options in pairs(opts.custom_servers) do
      local configs = require("lspconfig.configs")
      configs[server_name] = {
        default_config = {
          cmd = options.command,
          filetypes = options.filetypes,
          root_dir = require("lspconfig").util.root_pattern(".git"),
        },
      }
    end

    for server_name, options in pairs(opts.servers) do
      if type(options) == "function" then
        options = options(server_name)
      end
      local previous_on_attach = options.on_attach
      local new_on_attach = on_attach
      if previous_on_attach then
        new_on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          previous_on_attach(client, bufnr)
        end
      end
      options.on_attach = new_on_attach
      vim.lsp.config(server_name, options)
      vim.lsp.enable(server_name)
    end

    vim.lsp.set_log_level("off")
  end,
  opts = {
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "ts_ls",
      "tailwindcss",
      "bashls",
      "yamlls",
      "prismals",
      "jsonls",
    },
    autoformat = {
      ["null-ls"] = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "sql",
        "swift",
      },
      ["lua_ls"] = { "lua" },
      ["rust_analyzer"] = { "rust" },
      ["prismals"] = { "prisma" },
      -- ['jsonls'] = { 'json', 'jsonc' },
      -- ['taplo'] = { 'toml' },
      ["gopls"] = { "go" },
      ["terraformls"] = { "terraform", "terraformvars" },
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
    custom_servers = require("lsp.custom"),
  },
}

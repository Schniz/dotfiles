local function biome_or_prettier(bufnr)
  local biome_json = vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    stop = vim.loop.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]

  if biome_json then
    return { "biome" }
  else
    return { "prettier" }
  end
end

local formatters = {
  lua = { "stylua" },
  python = { "isort", "black" },
  javascript = biome_or_prettier,
  javascriptreact = biome_or_prettier,
  typescript = biome_or_prettier,
  typescriptreact = biome_or_prettier,
  css = biome_or_prettier,
  html = biome_or_prettier,
  json = biome_or_prettier,
  jsonc = biome_or_prettier,
  sh = { "shfmt" },
  toml = { "taplo" },
  rust = { "rustfmt" },
  go = { "goimports", "gofmt" },
  nix = { "nixpkgs_fmt" },
  terraform = { "terraform_fmt" },
}

---@param bufnr buffer_nr
local function is_ignored_from_autosave(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local basename = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  if string.match(basename, "%.lua$") and string.match(dirname, "/vercel/proxy/") then
    return true
  end

  return false
end

return {
  "stevearc/conform.nvim",
  ---@type conform.setupOpts
  opts = {
    lsp_fallback = true,
    formatters_by_ft = formatters,
    format_after_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if is_ignored_from_autosave(bufnr) then
        return
      end
      return { timeout_ms = 1000, lsp_fallback = true, async = true, formatters_by_ft = formatters }
    end,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    local conform = require("conform")
    vim.keymap.set({ "n", "v" }, "<leader>T", conform.format)
  end,
}

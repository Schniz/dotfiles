local colors = require("schniz.colors")

---@param background "light" | "dark" | string
---@param on_done fun() | nil
local function set_colorscheme(background, on_done)
  if vim.opt.background == background then
    return
  end

  vim.defer_fn(function()
    colors.set_colorscheme(background)
    if on_done then
      on_done()
    end
  end, 1)
end

---@type LazySpec
return {
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    dependencies = {
      { "vinitkumar/monokai-pro-vim", lazy = false },
      "folke/snacks.nvim",
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LumenColorscheme", { clear = true })

      -- Set initial colorscheme immediately (default to dark, lumen will correct if needed)
      colors.set_colorscheme(vim.o.background == "light" and "light" or "dark")

      vim.api.nvim_create_autocmd("User", {
        pattern = "LumenLight",
        desc = "Set light colorscheme",
        group = augroup,
        callback = function()
          set_colorscheme("light")
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "LumenDark",
        desc = "Set dark colorscheme",
        group = augroup,
        callback = function()
          set_colorscheme("dark")
        end,
      })
    end,
  },
  {
    -- Separate vim-lumen plugin, loaded lazily after startup
    "vimpostor/vim-lumen",
    lazy = true,
    init = function()
      -- Defer lumen loading until after startup to avoid 45ms blocking
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          vim.defer_fn(function()
            require("lazy").load({ plugins = { "vim-lumen" } })
            vim.fn["lumen#init"]()
          end, 50)
        end,
      })
    end,
  },
}

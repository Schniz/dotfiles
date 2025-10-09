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
  "RRethy/nvim-base16",
  lazy = false,
  priority = 1000,
  dependencies = {
    { "vinitkumar/monokai-pro-vim", lazy = false },
    "folke/snacks.nvim",
    { "vimpostor/vim-lumen", lazy = true },
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LumenColorscheme", { clear = true })

    if vim.o.background == "dark" then
      colors.set_colorscheme("dark")
    else
      colors.set_colorscheme("light")
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LumenLight",
      desc = "Set light colorscheme",
      group = augroup,
      callback = function()
        vim.notify("LumenLight")
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

    vim.fn["lumen#init"]()
  end,
}

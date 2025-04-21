local function set_colorscheme()
  local background = vim.api.nvim_get_option("background") or "unknown"
  vim.notify("using " .. vim.inspect(background) .. " theme")
  if background == "light" then
    -- nothing
  else
    vim.cmd([[highlight NonText guifg=#444444]])
  end
  vim.cmd([[highlight Normal guibg=None]])
end

---@type LazySpec
return {
  "RRethy/nvim-base16",
  dependencies = {
    -- will switch `set bg` depending on the MacOS appearance
    {
      "vimpostor/vim-lumen",
      lazy = false,
    },
    "folke/snacks.nvim",
  },
  init = function()
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = set_colorscheme,
    })
  end,
}

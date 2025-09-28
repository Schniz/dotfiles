local colorschemes = {
  dark = "base16-eighties",
  light = "monokai-pro-light",
}

local function set_colorscheme()
  local background = vim.api.nvim_get_option("background") or "unknown"

  vim.notify("using " .. vim.inspect(background) .. " theme", "info", {
    id = "colorscheme_appearance",
  })

  if background ~= "dark" and background ~= "light" then
    vim.notify("unknown background: " .. vim.inspect(background), "warn", {
      id = "colorscheme_appearance",
    })
    background = "dark"
  end

  if vim.g.colors_name == colorschemes[background] then
    return
  end

  vim.cmd.colorscheme(colorschemes[background])
  if background == "light" then
    vim.cmd([[highlight LspReferenceText guibg=#ffdddd]])
    vim.cmd([[highlight RenderMarkdownCode guibg=#ffeeee]])
  else
    vim.cmd([[highlight NonText guifg=#444444]])
  end
  vim.cmd([[highlight Normal guibg=None]])
end

function force_update_background_value()
  if vim.fn.has("mac") == 1 then
    local is_dark = string.match(
      vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):lower(),
      "dark"
    )
    if is_dark then
      vim.o.background = "dark"
    else
      vim.o.background = "light"
    end

    set_colorscheme()
  end
end

---@type LazySpec
return {
  "RRethy/nvim-base16",
  dependencies = {
    "vinitkumar/monokai-pro-vim",
    "folke/snacks.nvim",
  },
  init = function()
    local augroup = vim.api.nvim_create_augroup("ColorschemeAppearance", { clear = true })

    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = set_colorscheme,
      group = augroup,
    })

    -- run set_colorscheme on focus
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = force_update_background_value,
      group = augroup,
    })

    -- run set_colorscheme on focus
    vim.api.nvim_create_autocmd("VimResume", {
      callback = force_update_background_value,
      group = augroup,
    })

    set_colorscheme()
  end,
}

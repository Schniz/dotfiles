local colorschemes = {
  dark = "monokai-pro",
  light = "monokai-pro-light",
}

local function set_dark_colorscheme()
  vim.defer_fn(function()
    vim.cmd.colorscheme(colorschemes.dark)
    vim.cmd([[highlight! NonText guifg=#666666]])
    vim.cmd([[highlight! Normal guibg=None]])
    vim.cmd([[highlight LspReferenceText guibg=None gui=underline]])
    vim.cmd([[highlight RenderMarkdownCode guibg=NvimDarkGray2]])
    vim.cmd([[highlight! NormalFloat guifg=NvimLightGray2 guibg=NvimDarkGray2]])
    vim.cmd([[highlight Comment guifg=NvimLightGray3]])
    vim.cmd([[highlight Type guifg=#9cbffe]])
  end, 1)
  -- vim.cmd([[highlight Visual guibg=None guifg=None gui=reverse]])
end

local function set_light_colorscheme()
  vim.defer_fn(function()
    vim.cmd.colorscheme(colorschemes.light)
    vim.cmd([[highlight! NonText guifg=#CCCCCC]])
    vim.cmd([[highlight! Normal guibg=None]])
    vim.cmd([[highlight LspReferenceText guibg=#ffdddd]])
    vim.cmd([[highlight RenderMarkdownCode guibg=NvimLightGray2]])
    vim.cmd([[highlight! NormalFloat guibg=NvimLightGray1 guifg=NvimDarkGray2]])
    vim.cmd([[highlight Type guifg=#4169E1]])
    -- vim.cmd([[highlight Visual guibg=None guifg=None gui=reverse]])
  end, 1)
end

---@param name "dark" | "light" | string
local function set_colorscheme(name)
  if name == "dark" then
    set_dark_colorscheme()
    return colorschemes.dark
  elseif name == "light" then
    set_light_colorscheme()
    return colorschemes.light
  else
    return nil
  end
end

return {
  set_dark_colorscheme = set_dark_colorscheme,
  set_light_colorscheme = set_light_colorscheme,
  colorschemes = colorschemes,
  set_colorscheme = set_colorscheme,
}

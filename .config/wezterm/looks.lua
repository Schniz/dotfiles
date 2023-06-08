local wezterm = require 'wezterm'

local function with_looks(config)
  config.color_scheme = 'Eighties (base16)'
  config.hide_tab_bar_if_only_one_tab = true
  config.window_decorations = "RESIZE"
  config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  }

  config.font = wezterm.font {
    family = "FiraCode Nerd Font Mono",
  }

  config.font_size = 16.0
end

return with_looks

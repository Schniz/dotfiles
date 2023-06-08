local wezterm = require 'wezterm'

local act = wezterm.action
local tmux_binding = act.SendKey { key = 's', mods = 'CTRL' }
local escape_key = act.SendKey { key = 'Escape' }

local function key(k)
  return act.SendKey { key = k }
end

local function with_keybindings(config)
  config.keys = {
    { mods = 'SUPER|CTRL', key = 'f', action = wezterm.action.ToggleFullScreen },

    { mods = 'SUPER', key = 't', action = act.Multiple { tmux_binding, key('c') } },
    { mods = 'SUPER', key = 'w', action = act.Multiple { tmux_binding, key('x') } },

    { mods = 'SUPER|SHIFT', key = 'Return', action = act.Multiple { tmux_binding, key('z') } },

    { mods = "SUPER", key = ',', action = act.Multiple { tmux_binding, key('>') } },
    { mods = "SUPER|SHIFT", key = '<', action = act.Multiple { tmux_binding, key('<') } },

    -- pane switching
    { mods = "SUPER", key = "]", action = act.Multiple { escape_key, key('t') } },
    { mods = "SUPER", key = "[", action = act.Multiple { escape_key, key('T') } },

    -- tab switching
    -- this is repeated many times because of a MacOS issue in WezTerm.
    -- see: https://github.com/wez/wezterm/issues/3508
    { mods = 'SUPER|SHIFT', key = ']', action = act.Multiple { tmux_binding, key('n') } },
    { mods = 'SUPER',       key = '}', action = act.Multiple { tmux_binding, key('n') } },
    { mods = 'SUPER|SHIFT', key = '}', action = act.Multiple { tmux_binding, key('n') } },
    { mods = 'SUPER|SHIFT', key = '[', action = act.Multiple { tmux_binding, key('p') } },
    { mods = 'SUPER',       key = '{', action = act.Multiple { tmux_binding, key('p') } },
    { mods = 'SUPER|SHIFT', key = '{', action = act.Multiple { tmux_binding, key('p') } },

    -- splits
    { mods = "SUPER", key = "d", action = act.Multiple { tmux_binding, key('%') } },
    { mods = "SUPER", key = "D", action = act.Multiple { tmux_binding, key('"') } },
  }
end

return with_keybindings

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

-- config.font = wezterm.font 'IosevkaTerm Nerd Font'

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 15000

config.max_fps = 240

config.leader = { key = 'w', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    mods = 'LEADER',
    key = 'z',
    action = wezterm.action.TogglePaneZoomState
  },
  { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollToPrompt(1) }
}



-- and finally, return the configuration to wezterm
return config



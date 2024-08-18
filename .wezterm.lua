local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'nord'

config.font = wezterm.font('RobotoMono Nerd Font', { weight = 'Light' })
config.font_size = 11

config.line_height = 1.1

config.enable_tab_bar = false

config.window_decorations = 'RESIZE'

config.window_padding = {
  left = 40,
  right = 40,
  top = 40,
  bottom = 40,
}

return config

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { 'C:/Program Files/Git/bin/bash.exe', '--login', '-i' }

config.launch_menu = {
  {
    label = 'CMD',
    args = { 'cmd.exe' },
  },
  {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  },
  {
    label = 'Git Bash',
    args = { 'C:/Program Files/Git/bin/bash.exe', '--login', '-i' },
  },
}

config.keys = {
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' },
  },
}

return config

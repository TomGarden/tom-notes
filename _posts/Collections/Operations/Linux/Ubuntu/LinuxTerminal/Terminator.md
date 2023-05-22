Terminator 修改默认窗口大小：


```
[global_config]
  dbus = False
  enabled_plugins = CustomCommandsMenu, TerminalShot, LaunchpadCodeURLHandler, APTURLHandler, Logger, LaunchpadBugURLHandler
  inactive_color_offset = 1.0
  title_font = Ubuntu Light Italic 11
  title_inactive_bg_color = "#320c26"
  title_inactive_fg_color = "#ffffff"
  title_receive_bg_color = "#340e28"
  title_transmit_bg_color = "#d9d1c8"
  title_transmit_fg_color = "#320c26"
  title_use_system_font = False
[keybindings]
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      profile = default
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
      size = 900, 600
[plugins]
[profiles]
  [[default]]
    background_color = "#320c26"
    cursor_color = "#aaaaaa"
    font = Monospace 11
    foreground_color = "#ffffff"
    use_system_font = False
```

1. `size = 900, 600` 这一行是新加的，其余未做改动
2. 上述文件位置 `～/.config/terminator`




- https://www.netroby.com/view/3897

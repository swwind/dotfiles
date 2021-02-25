local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local tools = require('layout.tools')

return function (s)

  -- Create the wibox
  local mywibox = awful.wibar {
    position = "top",
    screen   = s,
    opacity  = 0.9,
    height   = 25
  }

  -- Add widgets to the wibox
  mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    { -- Left widget
      layout = wibox.layout.fixed.horizontal,
      tools.volume,
      tools.player_controls,
      tools.player
    },
    { -- Middle widgets
      layout = wibox.layout.flex.horizontal,
      tools.lyric_widget
    },
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      tools.power_status,
    }, -- Right widgets
  }
end

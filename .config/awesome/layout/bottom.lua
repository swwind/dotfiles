local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local tools = require('layout.tools')

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

return function (s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  local mylayoutbox = awful.widget.layoutbox(s)
  mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  local mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons,
    style   = {
      bg_occupied = '#222222',
      bg_urgent   = '#f44336',
      bg_focus    = '#2196f3',
      font        = 'DejaVuSansMono Nerd Font Mono 12',
    },
  }

  -- Create the wibox
  local mywibox = awful.wibar {
    position = "bottom",
    screen   = s,
    opacity  = 0.9,
    height   = 25
  }

  -- Add widgets to the wibox
  mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mytaglist,
    },
    nil, -- Middle widget
    { -- Right widgets
      tools.temperature,
      tools.cpu_usage,
      tools.memory_usage,
      tools.date_time,
      mylayoutbox,
      spacing = 15,
      layout = wibox.layout.fixed.horizontal,
    },
  }
end

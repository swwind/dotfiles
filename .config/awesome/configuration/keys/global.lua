local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').mod_key
local apps = require('configuration.apps')

local tools = require('layout.tools')

local floating_resize_amount = 50
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
  if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
    if direction == "up" then
      c:relative_move(0, 0, 0, -floating_resize_amount)
    elseif direction == "down" then
      c:relative_move(0, 0, 0, floating_resize_amount)
    elseif direction == "left" then
      c:relative_move(0, 0, -floating_resize_amount, 0)
    elseif direction == "right" then
      c:relative_move(0, 0, floating_resize_amount, 0)
    end
  else
    if direction == "up" then
      awful.client.incwfact(-tiling_resize_factor)
    elseif direction == "down" then
      awful.client.incwfact(tiling_resize_factor)
    elseif direction == "left" then
      awful.tag.incmwfact(-tiling_resize_factor)
    elseif direction == "right" then
      awful.tag.incmwfact(tiling_resize_factor)
    end
  end
end

local globalkeys = gears.table.join(
  awful.key(
    { modkey },
    "F1",
    hotkeys_popup.show_help,
    { description="show help", group="normal - awesome" }
  ),
  awful.key(
    { modkey },
    "[",
    awful.tag.viewprev,
    { description = "view previous", group = "normal - tag" }
  ),
  awful.key(
    { modkey },
    "]",
    awful.tag.viewnext,
    { description = "view next", group = "normal - tag" }
  ),
  awful.key(
    { modkey },
    "Escape",
    awful.tag.history.restore,
    { description = "go back", group = "normal - tag" }
  ),
  awful.key(
    { modkey },
    "h",
    function ()
      awful.client.focus.bydirection("left")
    end,
    { description = "focus left by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "j",
    function ()
      awful.client.focus.bydirection("down")
    end,
    { description = "focus down by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "k",
    function ()
      awful.client.focus.bydirection("up")
    end,
    { description = "focus up by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "l",
    function ()
      awful.client.focus.bydirection("right")
    end,
    { description = "focus right by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "h",
    function ()
      awful.client.swap.bydirection("left")
    end,
    { description = "swap left by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "j",
    function ()
      awful.client.swap.bydirection("down")
    end,
    { description = "swap down by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "k",
    function ()
      awful.client.swap.bydirection("up")
    end,
    { description = "swap up by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "l",
    function ()
      awful.client.swap.bydirection("right")
    end,
    { description = "swap right by direction", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "u",
    awful.client.urgent.jumpto
    { description = "jump to urgent client", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "Tab",
    function ()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by inedx", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "Tab",
    function ()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "Return",
    function ()
      awful.spawn(apps.default.terminal)
    end,
    { description = "open a terminal", group = "normal - launcher" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "r",
    awesome.restart,
    { description = "reload awesome", group = "normal - awesome" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "e",
    awesome.quit,
    { description = "exit awesome", group = "normal - awesome" }
  ),
  awful.key(
    { modkey },
    "space",
    function ()
      awful.layout.inc(1)
    end,
    { description = "select next layout", group = "normal - layout" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "space",
    function ()
      awful.layout.inc(-1)
    end,
    { description = "select previous layout", group = "normal - layout" }
  ),
  awful.key(
    { modkey, 'Control' },
    "h",
    function (c)
      resize_client(client.focus, "left")
    end,
    { description = "resize towards left", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Control' },
    "j",
    function (c)
      resize_client(client.focus, "down")
    end,
    { description = "resize towards down", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Control' },
    "k",
    function (c)
      resize_client(client.focus, "up")
    end,
    { description = "resize towards up", group = "normal - client" }
  ),
  awful.key(
    { modkey, 'Control' },
    "l",
    function (c)
      resize_client(client.focus, "right")
    end,
    { description = "resize towards right", group = "normal - client" }
  ),
  awful.key(
    { modkey },
    "o",
    function ()
      root.keys(require('configuration.keys.open_mode'))
    end,
    { description = "enter open mode", group = "normal - awesome" }
  ),
  awful.key(
    { modkey },
    "w",
    function ()
      awful.spawn(apps.default.web_browser)
    end,
    { description = "open default browser", group = "normal - launcher" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "n",
    function ()
      local c = awful.client.restore(nil)
      if c then
        client.focus = c
        c:raise()
      end
    end,
    { description = "restore minimize", group = "global - client" }
  ),
  awful.key(
    { modkey },
    "a",
    function ()
      awful.tag.incnmaster(1)
    end,
    { description = "increase the number of master clients", group = "normal - layout" }
  ),
  awful.key(
    { modkey },
    "s",
    function ()
      awful.tag.incnmaster(-1)
    end,
    { description = "decrease the number of master clients", group = "normal - layout" }
  ),
  awful.key(
    { modkey },
    "z",
    function ()
      awful.tag.incncol(1)
    end,
    { description = "increase the number of columns", group = "normal - layout" }
  ),
  awful.key(
    { modkey },
    "x",
    function ()
      awful.tag.incncol(-1)
    end,
    { description = "decrease the number of columns", group = "normal - layout" }
  ),
  awful.key(
    {},
    "XF86MonBrightnessDown",
    function ()
      awful.util.spawn("brightnessctl s 10%-")
    end,
    { description = "decrease the brightness", group = "normal - util" }
  ),
  awful.key(
    {},
    "XF86MonBrightnessUp",
    function ()
      awful.util.spawn("brightnessctl s +10%")
    end,
    { description = "increase the brightness", group = "normal - util" }
  ),
  awful.key(
    {},
    "XF86AudioLowerVolume",
    function ()
      awful.util.spawn("pulsemixer --change-volume -5")
    end,
    { description = "volume up", group = "normal - util" }
  ),
  awful.key(
    {},
    "XF86AudioRaiseVolume",
    function ()
      awful.util.spawn("pulsemixer --change-volume +5")
    end,
    { description = "volume down", group = "normal - util" }
  ),
  awful.key(
    {},
    "XF86AudioMute",
    toggle_mute,
    { description = "toggle mute", group = "normal - util" }
  ),
  awful.key(
    {},
    "Print",
    function ()
      awful.util.spawn("flameshot gui")
    end,
    { description = "take a screen shot", group = "normal - util" }
  ),
  awful.key(
    { modkey },
    "d",
    function ()
      awful.util.spawn("rofi -modi drun -show drun")
    end,
    { description = "open rofi", group = "normal - launcher" }
  )
)

for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
           tag:view_only()
        end
      end,
      { description = "view tag #"..i, group = "normal - tag" }
    ),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "normal - tag" }
    ),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
            tag:view_only()
          end
        end
      end,
      { description = "move focused client to tag #"..i, group = "normal - tag" }
    )
  )
end

return globalkeys

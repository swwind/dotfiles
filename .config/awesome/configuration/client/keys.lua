local gears = require("gears")
local awful = require("awful")

local modkey = require('configuration.keys.mod').mod_key

local clientkeys = gears.table.join(
  awful.key(
    { modkey },
    "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "global - client" }
  ),
  awful.key(
    { modkey, 'Shift' },
    "q",
    function (c)
      c:kill()
    end,
    { description = "close", group = "global - client" }
  ),
  awful.key(
    { modkey, 'Control' },
    "space",
    function (c)
      c.floating = not c.floating
    end,
    { description = "toggle floating", group = "global - client" }
  ),
  awful.key(
    { modkey },
    "t",
    function (c)
      c.ontop = not c.ontop
    end,
    { description = "toggle keep on top", group = "global - client" }
  ),
  awful.key(
    { modkey },
   "n",
    function (c)
      c.minimized = true
    end,
    { description = "minimize", group = "global - client" }
  ),
  awful.key(
    { modkey },
    "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "toggle maximize", group = "global - client" }
  )
)

return clientkeys

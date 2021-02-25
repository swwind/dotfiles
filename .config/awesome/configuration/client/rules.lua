local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

local rules = {
  {
    rule = { },
    except_any = {
      name = {
       "Media viewer",
      }
    },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hints_honor = false,
    },
  },

  {
    rule_any = {
      instance = {
        "pinentry",
      },
      class = {
        "Blueman-manager",
        "Blueman-adapters",
        "Viewnior",
        "Wpa_gui",
      },
      name = {
        "Media viewer"
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = {
      floating = true,
    },
  },

  {
    rule_any = {
      type = {
        "normal",
        "dialog",
      },
    },
    properties = {
      titlebars_enabled = true,
    },
  },

  {
    rule_any = {
      name = {
        "Media viewer"
      }
    },
    properties = {
      fullscreen = true,
    }
  },

  {
    rule_any = {
      properties = {
        floating = true,
      },
    },
    properties = {
      placement = awful.placement.centered+awful.placement.no_offscreen,
    }
  }
}

return rules

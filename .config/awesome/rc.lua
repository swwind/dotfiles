--
--   __ ___      _____  ___  ___  _ __ ___   ___
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|
--
--
-- completely configured by timber3252

-- ============================================================
-- Initialization
-- ============================================================

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")
require('util.error-handling')

-- ============================================================
-- Shell
-- ============================================================

awful.util.shell = 'bash'

-- ============================================================
-- Theme
-- ============================================================

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.get().wallpaper = '/home/swwind/Pictures/wallpaper.jpg'
gears.wallpaper.maximized(beautiful.wallpaper, nil, true)

-- ============================================================
-- Layout
-- ============================================================

local layout = require('layout')

-- ============================================================
-- Configurations
-- ============================================================

local keys = require('configuration.keys')
local buttons = require('configuration.buttons')
local client = require('configuration.client')

root.keys(keys.global)
root.buttons(buttons)
awful.rules.rules = client.rules

-- ============================================================
-- Utils
-- ============================================================
require('util.autostart')

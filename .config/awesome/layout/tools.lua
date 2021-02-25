local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local timer = require('util.timer')
local sh = require('util.sh')
local lyrics = require('util.lyrics')

local tools = {}

-- ===============
--      watch
-- ===============

-- 
-- sensors | grep temp1 | awk 'NR==1{print $2}' | tail -c+1
tools.temperature = awful.widget.watch('bash -c "sensors | grep temp1 | awk \'NR==1{print $2}\' | tail -c+2 | head -c-4"', 2, function (widget, stdout)
  local temp = tonumber(stdout)
  if temp < 30 then
    widget.markup = " " .. temp .. "°C"
  elseif temp < 45 then
    widget.markup = " " .. temp .. "°C"
  elseif temp < 60 then
    widget.markup = " " .. temp .. "°C"
  elseif temp < 80 then
    widget.markup = " " .. temp .. "°C"
  else
    widget.markup = "<span color=\"#f44336\"> " .. temp .. "°C</span>"
  end
end, wibox.widget {
  font   = 'DejaVuSansMono Nerd Font Mono 12',
  widget = wibox.widget.textbox
})

-- grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f%%", usage}'
tools.cpu_usage = awful.widget.watch('bash -c "grep \'cpu \' /proc/stat | awk \'{usage=($2+$4)*100/($2+$4+$5)} END {printf \\"%.0f%%\\", usage}\'"', 2, function (widget, stdout)
  widget.markup = " " .. stdout
end, wibox.widget {
  font   = 'DejaVuSansMono Nerd Font Mono 12',
  widget = wibox.widget.textbox
})

-- 
-- upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}' | head -c-2
tools.power_status = awful.widget.watch('bash -c "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk \'{print $2}\' | head -c-2"', 2, function (widget, stdout)
  sh.execWithShell("upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{print $2}'", function (state)
    local charging = state == "charging\n"
    local power = tonumber(stdout)
    if charging then
      widget.markup = "  " .. power .. "% "
    elseif power < 15 then
      widget.markup = "<span color=\"#f44336\">  " .. power .. "% </span>"
    elseif power < 25 then
      widget.markup = "  " .. power .. "% "
    elseif power < 35 then
      widget.markup = "  " .. power .. "% "
    elseif power < 45 then
      widget.markup = "  " .. power .. "% "
    elseif power < 55 then
      widget.markup = "  " .. power .. "% "
    elseif power < 65 then
      widget.markup = "  " .. power .. "% "
    elseif power < 75 then
      widget.markup = "  " .. power .. "% "
    elseif power < 85 then
      widget.markup = "  " .. power .. "% "
    elseif power < 95 then
      widget.markup = "  " .. power .. "% "
    else
      widget.markup = "  " .. power .. "% "
    end
  end)
end, wibox.widget {
  font   = 'DejaVuSansMono Nerd Font Mono 12',
  widget = wibox.widget.textbox
})

-- free -m | awk 'NR==2{print $3}'
tools.memory_usage = awful.widget.watch('bash -c "free -m | awk \'NR==2{print $3 \\"MB\\"}\'"', 2, function (widget, stdout)
  widget.markup = " " .. stdout
end, wibox.widget {
  font   = 'DejaVuSansMono Nerd Font Mono 12',
  widget = wibox.widget.textbox
})

-- date '+%Y-%m-%d %H:%M:%S'
tools.date_time = awful.widget.watch('bash -c "date \'+%Y-%m-%d %H:%M:%S\'"', 1, function (widget, stdout)
  widget.markup = " " .. stdout
end, wibox.widget {
  font   = 'DejaVuSansMono Nerd Font Mono 12',
  widget = wibox.widget.textbox
})

-- ===============
--    playerctl
-- ===============

-- playerctl metadata title 1>/dev/null 2>/dev/null; if [[ $? -ne 0 ]]; then echo Free; else echo $(playerctl metadata title) - $(playerctl metadata artist); fi
tools.player = awful.widget.watch('bash -c "echo -n $(playerctl metadata title) - $(playerctl metadata artist)"', 1, function (widget, stdout)
  if widget.text ~= stdout then
    widget.text = stdout
    lyrics.fetch_lyric()
  end
end, wibox.widget {
  font = 'WenQuanYi Micro Hei 12',
  widget = wibox.widget.textbox
})

local pause_button, play_button

local function set_player_state(paused)
  pause_button.visible = not paused
  play_button.visible = paused
end

local function play_music()
  sh.exec('playerctl play')
  set_player_state(false)
end
local function pause_music()
  sh.exec('playerctl pause')
  set_player_state(true)
end

pause_button = wibox.widget {
  text    = '  ',
  buttons = gears.table.join(awful.button({ }, 1, pause_music)),
  font    = 'DejaVuSansMono Nerd Font Mono 12',
  widget  = wibox.widget.textbox
}

play_button = wibox.widget {
  text    = '  ',
  buttons = gears.table.join(awful.button({ }, 1, play_music)),
  visible = false,
  font    = 'DejaVuSansMono Nerd Font Mono 12',
  widget  = wibox.widget.textbox
}

tools.player_controls = {
  {
    text    = ' 玲 ',
    buttons = gears.table.join(
      awful.button({ }, 1, function ()
        sh.exec('playerctl prev')
      end)
    ),
    font   = 'DejaVuSansMono Nerd Font Mono 12',
    widget = wibox.widget.textbox
  },
  pause_button,
  play_button,
  {
    text = ' 怜  ',
    buttons = gears.table.join(
      awful.button({ }, 1, function ()
        sh.exec('playerctl next')
      end)
    ),
    font   = 'DejaVuSansMono Nerd Font Mono 12',
    widget = wibox.widget.textbox
  },
  layout = wibox.layout.fixed.horizontal,
}

-- sync
timer.setInterval(function ()
  sh.exec('playerctl status', function (stdout, code)
    if code == 0 and stdout == "Playing\n" then
      set_player_state(false)
    else
      set_player_state(true)
    end
  end)
end, 1)

tools.lyric_widget = wibox.widget {
  text   = '',
  font   = 'WenQuanYi Micro Hei 12',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

timer.setInterval(function ()
  lyrics.get_lyric(function (text)
    tools.lyric_widget.text = text
  end)
end, 0.2)

-- ================
--    pulsemixer
-- ================

volume_icon = wibox.widget {
  text   = ' 墳 ',
  font   = 'DejaVuSansMono Nerd Font Mono 16',
  widget = wibox.widget.textbox
}

local muted = false

local function update_volume_icon()
  if muted then
    volume_icon.text = ' 婢 '
  else
    volume_icon.text = ' 墳 '
  end
end

function toggle_mute()
  sh.exec('pulsemixer --toggle-mute')
  muted = not muted
  update_volume_icon()
end

-- initialize
sh.exec('pulsemixer --get-mute', function (stdout)
  if stdout == "0\n" then
    muted = false
  else
    muted = true
  end
  update_volume_icon()
end)

tools.volume = {
  layout = wibox.layout.fixed.horizontal,
  buttons = gears.table.join(
    awful.button({ }, 1, toggle_mute),
    awful.button({ }, 4, function ()
      sh.exec("pulsemixer --change-volume +5")
    end),
    awful.button({ }, 5, function ()
      sh.exec("pulsemixer --change-volume -5")
    end)
  ),
  volume_icon
}

return tools

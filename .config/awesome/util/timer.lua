local gears = require('gears')

local timer = {}

function timer.setInterval(fn, interval)
  gears.timer {
    timeout   = interval,
    call_now  = true,
    autostart = true,
    callback  = fn
  }
end

return timer

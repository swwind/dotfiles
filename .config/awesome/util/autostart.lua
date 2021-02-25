local awful = require('awful')
local naughty = require('naughty')
local apps = require('configuration.apps')

debug_mode = false

local run_once = function(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.easy_async_with_shell(
    string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd),
    function(stdout, stderr)
      if not stderr or stderr == '' or not debug_mode then
        return 
      end
      naughty.notify({
        app_name = 'Start-up Applications',
        title = '<b>Oof! Error detected when starting an application!</b>',
        message = stderr:gsub('%\n', ''),
        timeout = 20,
        icon = require('beautiful').awesome_icon
      })
    end
  )
end

for _, app in ipairs(apps.autostart) do
  run_once(app)
end


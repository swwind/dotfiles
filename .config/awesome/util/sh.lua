local awful = require('awful')

local sh = {}

function sh.exec(cmd, callback)
  return awful.spawn.easy_async(
    cmd,
    function (stdout, _, _, exit_code)
      if callback then
        callback(stdout, exit_code)
      end
    end
  )
end

function sh.execWithShell(cmd, callback)
  return awful.spawn.easy_async_with_shell(
    cmd,
    function (stdout, _, _, exit_code)
      if callback then
        callback(stdout, exit_code)
      end
    end
  )
end

return sh

local json = require('util.json')
local sh = require('util.sh')

local naughty = require('naughty')

local lrcs = {}

local function handle_lyric(lyric)
  for line in string.gmatch(lyric, '[^\n+]+') do
    if #line > 0 then
      local m, s, text = string.match(line, '%[(%d+):(%d+%.%d+)%](.*)')
      local time = tonumber(m) * 60 + tonumber(s)
      lrcs[#lrcs+1] = { time = time, text = text }
    end
  end
end

local lyrics = {}

local function fetch_netease_lyric(id)
  sh.exec('curl "https://music.163.com/api/song/lyric?lv=-1&kv=-1&tv=-1&os=pc&id=' .. id .. '"', function (data, exitcode)
    if exitcode ~= 0 then return end
    local result = json.parse(data)
    if result.lrc == nil or result.lrc.lyric == nil then return end
    handle_lyric(result.lrc.lyric)
  end)
end

-- invoke this every time music changes
-- playerctl metadata mpris:trackid | head -c-2 | tail -c+26
function lyrics.fetch_lyric()
  lrcs = {}

  sh.execWithShell('playerctl -p ElectronNCM metadata mpris:trackid | head -c-2 | tail -c+26', function (stdout, exitcode)
    if exitcode ~= 0 or #stdout == 0 then return end
    id = tonumber(stdout)
    fetch_netease_lyric(id)
  end)

  -- FIXME: spotify does not support mpris position
  -- sh.exec('playerctl -p spotify metadata title', function (title, exitcode)
  --   if exitcode ~= 0 or #title == 0 then return end
    
  --   sh.execWithShell('curl "http://music.163.com/api/search/get/web" --data-urlencode "csrf_token=hlpretag=" --data-urlencode "hlposttag=" --data-urlencode "s=$(playerctl -p spotify metadata title) $(playerctl -p spotify metadata artist)" --data-urlencode "type=1" --data-urlencode "offset=0" --data-urlencode "total=true" --data-urlencode "limit=1"', function (data, exitcode)
  --     if exitcode ~= 0 or #data == 0 then return end
  --     local result = json.parse(data)
  --     if result.result == nil or result.result.songs[1] == nil then return end
  --     if result.result.songs[1].name .. "\n" == title then
  --       naughty.notify({
  --         app_name = 'spotify',
  --         title = "Synced lyrics from NCM (" .. result.result.songs[1].name .. " - " .. result.result.songs[1].artists[1].name .. ")[" .. result.result.songs[1].id .. "]",
  --         timeout = 5
  --       })
  --       fetch_netease_lyric(result.result.songs[1].id)
  --     end
  --   end)
  -- end)
end

function lyrics.get_lyric(callback)
  sh.exec('playerctl position', function (stdout, exitcode)
    if exitcode ~= 0 or #stdout == 0 then return end
    local time = tonumber(stdout) - 0.1
    for i = #lrcs, 1, -1 do
      if lrcs[i].time < time then
        callback(lrcs[i].text)
        return
      end
    end
    callback('')
  end)
end

return lyrics

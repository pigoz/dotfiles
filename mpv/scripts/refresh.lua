msg = require 'mp.msg'
utils = require 'mp.utils'

-- local p = {}
-- p["cancellable"] = false
-- p["args"] = {}
-- p["args"][1] = "xrandr"
-- p["args"][2] = "-q"
-- local res = utils.subprocess(p)

function chomp(string)
  return string.gsub(string, "\n$", "")
end

function hostname()
  local p = {}
  p["cancellable"] = false
  p["args"] = {}
  p["args"][1] = "hostname"
  local res = utils.subprocess(p)
  return chomp(res["stdout"])
end

function set_fps(fps)
  local p = {}
  p["cancellable"] = false
  p["args"] = {}
  p["args"][1] = "screenresolution"
  p["args"][2] = "set"

  if fps > 23 and fps < 24 then
    p["args"][3] = "2560x1440x32@24"
  else
    p["args"][3] = "2560x1440x32@60"
  end

  utils.subprocess(p)
end

function fps_changed()
  local fps = mp.get_property_native("fps")
  if fps then
    msg.warn("detected FPS change to: " .. fps)
    set_fps(fps)
  end
end

function reset_fps()
  set_fps(60)
end

local host = hostname()

if host == "NAVi" then
  msg.warn("installing fps_changed handler")
  mp.observe_property("fps", "native", fps_changed)
  mp.register_event("shutdown", reset_fps)
else
  msg.warn("hostname <".. host .. "> doesn't match. skipping...")
end

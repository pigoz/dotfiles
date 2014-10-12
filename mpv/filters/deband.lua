-- install f3kdb to make this work: brew install f3kdb
if not plugin_loaded then
  plugin_loaded = true
  invoke("std", "LoadPlugin", {path = "/usr/local/lib/libf3kdb.dylib"})
end

clip = video_in

clip = invoke("std", "Trim", {
  clip     = clip,
  i_first  = 0,
  i_length = 500000})

clip = invoke("f3kdb", "Deband", {
  clip           = clip,
  i_grainy       = 0,
  i_grainc       = 0,
  i_output_depth = 16})

video_out = clip

var x = mp.utils.subprocess_detached({
  args: ["/Users/pigoz/dev/lat/bin/lat-mpv"]
});
if (x) {
  mp.msg.warn("started lat-mpv");
}

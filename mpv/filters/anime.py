import vapoursynth as vs
core = vs.get_core()

core.std.LoadPlugin(path="/usr/local/lib/libmvtools.dylib")
core.std.LoadPlugin(path="/usr/local/lib/libf3kdb.dylib")

clip = video_in

# Skip interpolation for >1080p or 60 Hz content due to performance
if not (clip.width > 1920 or clip.height > 1080 or container_fps > 59):
    # Needed because clip FPS is missing
    clip = core.std.AssumeFPS(clip, fpsnum = int(container_fps * 1e8), fpsden = int(1e8))
    # sup = core.mv.Super(clip, pel=2, hpad=0, vpad=0)
    sup = core.mv.Super(clip, pel=2, hpad=16, vpad=16)
    bvec = core.mv.Analyse(sup, blksize=16, isb=True,  chroma=True, search=3, searchparam=1)
    fvec = core.mv.Analyse(sup, blksize=16, isb=False, chroma=True, search=3, searchparam=1)
    clip = core.mv.BlockFPS(clip, sup, bvec, fvec, num=60000, den=1001, mode=3, thscd2=12)

clip = core.std.Trim(clip = clip, first = 0, length = 500000)
clip = core.f3kdb.Deband(clip = clip, grainy = 0, grainc = 0, output_depth = 16)

clip.set_output()

# /tmdb-movies

Clean up movie filenames by removing piracy tags, adding TMDB IDs, and standardizing naming conventions. This command only acts on files that need cleanup and also handles external subtitle files.

## Usage Examples

```bash
# Clean up all movie files in the current directory
/tmdb-movies

# Clean up a single movie file
/tmdb-movies "/path/to/movies/Brazil (1985) DC Criterion (1080p BluRay x265 10bit Tigole).mkv"

# Clean up all movie files in a directory
/tmdb-movies "/path/to/movies"

# Dry run to see what would be changed
/tmdb-movies --dry-run "/path/to/movies"
```

## What It Does

1. **Removes piracy tags** from filenames:
   - Release group names: `CHD`, `Tigole`, `Erai-raws`, `LostYears`, `dougal`, etc.
   - Video format tags: `DC Criterion`, `1080p BluRay x265 10bit`, `720p DTS x264`
   - Resolution tags: `1080p`, `720p`, `4K`, `2160p`, `1440p`
   - Source tags: `BluRay`, `BD`, `WEB`, `DVD`, `HDRip`, `WEBRip`, `HDTV`
   - Codec tags: `HEVC`, `x264`, `x265`, `10bit`, `8bit`, `H265`, `AAC2.0`

2. **Adds TMDB IDs** to filenames using the format `{tmdb-XXXXX}`

3. **Standardizes filenames** to the format: `Title of the Movie (YYYY) {tmdb-XXXXX}.ext`

4. **Matches external subtitles** by renaming subtitle files to match their corresponding movie files

## Examples (Before → After)

### Movie Cleanup
```
Brazil (1985) DC Criterion (1080p BluRay x265 10bit Tigole).mkv
→ Brazil (1985) {tmdb-68}.mkv

Himitsu.No.Akko.Chan.2012.BluRay.720p.DTS.x264-CHD.mkv
→ Himitsu no Akko-chan (2012) {tmdb-108241}.mkv

Rinko.Eighteen.2009.1080p.HDTV.AAC2.0.H265.10bit-dougal.mkv
→ Rinko Eighteen (2009) {tmdb-567678}.mkv
```

### Subtitle Matching
```
Himitsu.No.Akko.Chan.2012.BluRay.720p.DTS.x264-CHD.srt
→ Himitsu no Akko-chan (2012) {tmdb-108241}.srt

Rinko.Eighteen.2009.1080p.HDTV.AAC2.0.H265.10bit-dougal.ass
→ Rinko Eighteen (2009) {tmdb-567678}.ass

Rinko.Eighteen.2009.1080p.HDTV.AAC2.0.H265.10bit-dougal.srt
→ Rinko Eighteen (2009) {tmdb-567678}.srt
```

### Already Clean Files
```
The Shawshank Redemption (1994) {tmdb-278}.mkv
→ No changes needed (already clean)
```

## Implementation Details

This command is **idempotent** - running it on already cleaned files will do nothing. It checks for:
- Filenames containing piracy tags
- Filenames missing TMDB IDs
- External subtitle files that need to match movie names

## Algorithm

1. Scan directory for movie files (mkv, mp4, avi, mov, wmv)
2. For each movie file, check if cleanup is needed
3. Search TMDB for the movie title and year to get ID
4. Rename movie file with clean name + TMDB ID
5. Find and rename matching subtitle files (srt, ass, sub, vtt)
6. Verify no changes needed for already clean files

## Supported Patterns

**Tags to remove:**
- Release groups: `CHD`, `Tigole`, `dougal`, `Erai-raws`, `LostYears`, `Judas`, `SubsPlease`
- Editions: `DC Criterion`, `Extended`, `Directors Cut`, `Unrated`, `Special Edition`
- Video specs: `1080p`, `720p`, `480p`, `4K`, `2160p`, `1440p`
- Sources: `BluRay`, `BD`, `WEB`, `DVD`, `HDRip`, `WEBRip`, `HDTV`, `WEB-DL`
- Codecs: `HEVC`, `x264`, `x265`, `10bit`, `8bit`, `H265`, `H264`, `AAC2.0`, `DTS`, `AC3`
- Other tags: `REMUX`, `REPACK`, `PROPER`, `RERIP`, `Dubbed`, `Subbed`

**Subtitle extensions:**
- `.srt`, `.ass`, `.sub`, `.vtt`, `.ssa`

## Few-Shot Examples

### Example 1: Complex case with multiple tags
```
Input: The.Dark.Knight.2008.1080p.BluRay.x264-REFiNED.mkv
Process:
1. Extract title: "The Dark Knight"
2. Extract year: 2008
3. Search TMDB: Found {tmdb-155}
4. Clean filename: "The Dark Knight (2008) {tmdb-155}.mkv"
5. Rename matching subtitle: "The.Dark.Knight.2008.1080p.BluRay.x264-REFiNED.srt" → "The Dark Knight (2008) {tmdb-155}.srt"
```

### Example 2: Simple case with year
```
Input: Inception.2010.720p.BrRip.x264.YIFY.mp4
Process:
1. Extract title: "Inception"
2. Extract year: 2010
3. Search TMDB: Found {tmdb-27205}
4. Clean filename: "Inception (2010) {tmdb-27205}.mp4"
```

### Example 3: Already clean file
```
Input: Her (2013) {tmdb-152601}.mkv
Process:
1. Check filename: Already has TMDB ID
2. Check for tags: No piracy tags found
3. Result: No changes needed
```

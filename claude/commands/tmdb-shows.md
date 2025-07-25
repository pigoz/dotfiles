# /tmdb-shows

Clean up TV show directory and filenames by removing piracy tags, adding TMDB IDs to directories, and standardizing naming conventions. This command only acts on files that need cleanup.

## Usage Examples

```bash
# Clean up all directories in the current directory which is a TV Shows folder
/tmdb-shows

# Clean up a single TV show directory
/tmdb-shows "/path/to/TV Shows/[Judas] Bocchi the Rock! (Season 01) [BD 1080p][HEVC x265 10bit][Multi-Sub]"

# Clean up all directories in a TV Shows folder
/tmdb-shows "/path/to/TV Shows"

# Dry run to see what would be changed
/tmdb-shows --dry-run "/path/to/TV Shows"
```

## What It Does

1. **Removes piracy tags** from directory and filenames:
   - Sub group names: `[Judas]`, `[SubsPlease]`, `[HorribleSubs]`, etc.
   - Video format tags: `[BD 1080p]`, `[HEVC x265 10bit]`, `[Multi-Sub]`
   - Resolution tags: `1080p`, `720p`, `4K`
   - Source tags: `WEB`, `BluRay`, `BD`, `DVD`

2. **Adds TMDB IDs** to directory names using the format `{tmdb-XXXXXX}`

3. **Standardizes filenames** to match Infuse/plex naming conventions:
   - Clean show name + season/episode format
   - Removes all piracy-related tags

## Examples (Before → After)

### Directory Cleanup
```
[Judas] Bocchi the Rock! (Season 01) [BD 1080p][HEVC x265 10bit][Multi-Sub]
→ Bocchi the Rock! {tmdb-119100}

[SubsPlease] Horimiya (Season 1) [1080p][HEVC x265 10bit][Multi-Subs]
→ Horimiya {tmdb-110070}

[HorribleSubs] Attack on Titan S04 [1080p]
→ Attack on Titan {tmdb-1429}
```

### File Cleanup
```
[Judas] Bocchi the Rock! - S01E01.mkv
→ Bocchi the Rock! - S01E01.mkv

[SubsPlease] Horimiya - 01.mkv
→ Horimiya - S01E01.mkv

[HorribleSubs] Attack on Titan - 75.mkv
→ Attack on Titan - S04E16.mkv
```

## Implementation Details

This command is **idempotent** - running it on already cleaned directories will do nothing. It checks for:
- Directory names containing piracy tags
- Directory names missing TMDB IDs
- Filenames containing piracy tags
- Incorrect episode numbering formats

## Algorithm

1. Scan directory for TV show folders
2. For each folder, check if cleanup is needed
3. Search TMDB for the show name to get ID
4. Rename directory with clean name + TMDB ID
5. Rename all video files to match clean naming convention
6. Verify no changes needed for already clean directories

## Supported Patterns

**Tags to remove:**
- `[Judas]`, `[SubsPlease]`, `[HorribleSubs]`, `[Erai-raws]`, `[LostYears]`
- `BD`, `BluRay`, `WEB`, `DVD`, `HDRip`, `WEBRip`
- `1080p`, `720p`, `480p`, `4K`, `2160p`, `1440p`
- `HEVC`, `x264`, `x265`, `10bit`, `8bit`
- `Multi-Sub`, `Dual-Audio`, `Eng Sub`, `Eng Dub`
- `(Season 01)`, `S01`, `Complete`, `Batch`

**Episode patterns to standardize:**
- `01` → `S01E01`
- `S1E01` → `S01E01`
- `E01` → `S01E01`

## Few-Shot Examples

### Example 1: Complex case with multiple tags
```
Input: [Judas] Kaguya-sama wa Kokurasetai S03 [1080p][HEVC x265 10bit][Multi-Sub]
Process: 
1. Extract show name: "Kaguya-sama wa Kokurasetai"
2. Search TMDB: Found {tmdb-83097}
3. Clean directory: "Kaguya-sama wa Kokurasetai {tmdb-83097}"
4. Clean files: "Kaguya-sama wa Kokurasetai - S03E01.mkv"
```

### Example 2: Simple season folder
```
Input: Attack on Titan Season 1/
Process:
1. Extract show name: "Attack on Titan"
2. Search TMDB: Found {tmdb-1429}
3. Clean directory: "Attack on Titan {tmdb-1429}"
4. Clean files: "Attack on Titan - S01E01.mkv"
```

### Example 3: Already clean directory
```
Input: Attack on Titan {tmdb-1429}/
Process:
1. Check directory name: Already has TMDB ID
2. Check filenames: Already clean format
3. Result: No changes needed
```

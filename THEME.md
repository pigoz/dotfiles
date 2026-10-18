Theme
=====

Colors I can read all day, with astigmatism and myopia: OneDark at night and
One Light by day, both with the contrast recalibrated, everywhere following
the macOS light/dark mode.

Why
---

The old setup was iTerm2's default xterm palette on pure black, with onedark
in nvim:

- dark blue `#0000bb` on black was 1.7:1, practically invisible (lazygit's
  key hints); red 3.1:1, bright black, the color of dim text, 2.8:1
- light text on pure black: a dark screen opens the pupil, which makes
  astigmatism blur more, so letters bloom
- black terminal, `#282c34` nvim and Claude Code's own colors: the background
  changed at every switch
- onedark's comments `#5c6370` were 2.3:1

Measuring contrast
------------------

WCAG 2 ratios (4.5:1, 7:1) treat light and dark backgrounds alike and ignore
the font size. [APCA](https://github.com/Myndex/apca-w3) (0.0.98G, the
candidate for WCAG 3) reports perceived contrast as Lc 0–106 and does account
for polarity: 6:1 is Lc 78 on a light background but only Lc 42 on a dark one,
where Lc 78 takes about 12.5:1. All the numbers below are APCA.

What the research says:

- reading speed grows with contrast until the text is a few times above the
  visibility threshold (the "contrast reserve"), then it flattens: past that,
  more contrast doesn't read faster and can tire (glare, blooming)
- dark text on light reads better in a lit room, also because the smaller
  pupil blurs less with astigmatism
- APCA asks about Lc 75 for continuous reading; at 24px, Lc 60 is enough for
  text that's read but not in long blocks

What I picked
-------------

By comparing full screen previews in iTerm2, with Hack at 24pt and the
current thin strokes setting. Font weight changes the perceived contrast, so
a new font means checking these levels again: Modus' screenshots looked much softer than
Modus in my terminal only because of their thin font, where just 10% of the
glyph pixels reach the nominal color.

- maximum contrast (Modus, Lc ~100) was too much: text between Lc 70 and 78
  on light, no difference noticed on dark
- light themes look dull when their colors are pushed to high contrast: on a
  light background colored text has to be dark, and dark colors can't be
  saturated. Keeping the syntax colors at Lc 60–71 leaves room for lighter,
  livelier ones
- comments at Lc 60 stood out too much in practice: onedark's are grey, so
  only their lightness sets them apart from the text. Line numbers too, at 45

| role                                          | Lc     |
|-----------------------------------------------|--------|
| text                                          | 74     |
| syntax colors                                 | 60–71  |
| comments                                      | 48     |
| borders, ANSI bright black                    | 45     |
| line numbers, listchars (`¬ · ▸`)             | 30     |
| faint text (SGR 2, used a lot by Codex)       | 60     |

The colors keep OneDark's and One Light's hue and chroma: only the OKLCH
lightness moves until the APCA level is met, and a syntax color already
inside 60–71 is left alone. The one hue change is One Light's types: its dark
yellow `#986801` was already as saturated as a yellow that dark can be (dark
yellow turns olive), while an orange `#d7660b` (OKLCH hue 50°) is much more
saturated at the same contrast.

The backgrounds are the themes' own. Near white is better than a grey
background, which would need darker, duller text colors for the same Lc:
glare is for the screen brightness to handle.

Palettes
--------

onedark.nvim palette keys, with the original values:

| key          | dark      | was               | light     | was               |
|--------------|-----------|-------------------|-----------|-------------------|
| background   | `#282c34` |                   | `#fafafa` |                   |
| fg           | `#c9d1de` | `#abb2bf` Lc 56   | `#676a72` | `#383a42` Lc 93   |
| purple       | `#e79cfe` | `#c678dd` Lc 42   | `#b537b2` | `#a626a4` Lc 76   |
| green        | `#99c57a` | `#98c379` Lc 59   | `#479847` | `#50a14f` Lc 56   |
| orange       | `#e6ad79` | `#d19a66` Lc 49   | `#b57c0b` | `#c18401` Lc 56   |
| blue         | `#73bffd` | `#61afef` Lc 51   | `#4078f2` |                   |
| yellow       | `#e5c07b` |                   | `#d7660b` | `#986801` Lc 70   |
| cyan         | `#66c6d2` | `#56b6c2` Lc 51   | `#0184bc` |                   |
| red          | `#fe9da1` | `#e86671` Lc 39   | `#e45649` |                   |
| comments     | `#9ca3b1` | `#5c6370` Lc 17   | `#9fa0a5` | `#a0a1a7` Lc 47   |
| grey         | `#969dac` | `#5c6370` Lc 17   | `#a4a5ac` | `#a0a1a7` Lc 47   |
| light_grey   | `#a3abb8` | `#848b98` Lc 36   | `#96999d` | `#818387` Lc 63   |
| line numbers, listchars | `#787f8d` | `#5c6370` Lc 17 | `#c0c1c8` | `#a0a1a7` Lc 47 |

The iTerm2 ANSI colors are the same as nvim's. Bright colors sit on the edge
of the band (Lc 71 on dark, 60 on light), and on light ANSI yellow is the
amber `#b57c0b`, since there it marks branches and warnings rather than types.
Black is `#3f4451` on dark and the Lc 85 `#4d4f58` on light, white the text
color on dark and the Lc 30 `#c0c1c8` on light.

Where
-----

- iTerm2 (`config/iterm2`): separate colors for light and dark mode. Bold
  text isn't brightened, faint text is drawn at alpha 0.854 on dark and 0.788
  on light to sit at Lc 60
- nvim (`config/nvim/lua/user/theme.lua`): onedark.nvim with the palettes
  above, comments not italic. Reads the mode from macOS at startup and when
  it gets focus, so nvim-qt follows it too
- starship and lazygit use ANSI color names, so they follow the terminal.
  The `»` is red only after a failed command, lazygit's selected line is
  reversed since its default blue background hides the text
- Claude Code: `auto`, switching between its own light and dark themes
- Codex: draws with the terminal's palette and faint text, nothing to set

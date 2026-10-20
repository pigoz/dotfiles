Theme
=====

Colors I can read all day, with astigmatism and myopia: OneDark at night and
One Light by day, everywhere following the macOS light/dark mode. The
terminal's colors have the contrast recalibrated, nvim's are onedarkpro.nvim's
own.

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

iTerm2's colors keep OneDark's and One Light's hue and chroma: only the OKLCH
lightness moves until the APCA level is met, and a color already inside 60–71
is left alone.

Not in nvim, though. Calibrating each color on its own flattens a theme's
balance: onedarkpro keeps types, symbols and punctuation quieter than the
text on purpose, and lifted into the band they all competed with it. A theme
is better taken as it comes, chosen by its overall level, and onedarkpro's
One Light already has the text at Lc 74 and comments at 49 (line numbers 24).

The backgrounds are the themes' own. Near white is better than a grey
background, which would need darker, duller text colors for the same Lc:
glare is for the screen brightness to handle.

Terminal palette
----------------

iTerm2's colors, from OneDark and Atom's One Light:

| color        | dark      | light     |
|--------------|-----------|-----------|
| background   | `#282c34` | `#fafafa` |
| text         | `#c9d1de` | `#676a72` |
| black        | `#3f4451` | `#4d4f58` |
| red          | `#fe9da1` | `#e45649` |
| green        | `#99c57a` | `#479847` |
| yellow       | `#e5c07b` | `#b57c0b` |
| blue         | `#73bffd` | `#4078f2` |
| magenta      | `#e79cfe` | `#b537b2` |
| cyan         | `#66c6d2` | `#0184bc` |
| white        | `#c9d1de` | `#c0c1c8` |
| bright black | `#969dac` | `#a4a5ac` |

Bright colors sit on the edge of the band (Lc 71 on dark, 60 on light). On
light yellow is an amber, since there it marks branches and warnings, black
is Lc 85 and white Lc 30.

Where
-----

- iTerm2 (`config/iterm2`): separate colors for light and dark mode. Bold
  text isn't brightened, faint text is drawn at alpha 0.854 on dark and 0.788
  on light to sit at Lc 60
- nvim (`config/nvim/lua/user/theme.lua`): onedarkpro.nvim as it comes,
  which also colors LSP semantic tokens and has per-language rules (Ruby
  among them) from VS Code's One Dark Pro. Reads the mode from macOS at
  startup and when it gets focus, so nvim-qt follows it too
- starship and lazygit use ANSI color names, so they follow the terminal.
  The `»` is red only after a failed command, lazygit's selected line is
  reversed since its default blue background hides the text
- Claude Code: `auto`, switching between its own light and dark themes
- Codex: draws with the terminal's palette and faint text, nothing to set

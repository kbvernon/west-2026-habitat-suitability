# CLAUDE.md

See @README.md for project overview.

Note: this repository is primarily aimed at rendering a RevealJS HTML slide deck 
for a talk using Quarto and markdown.

## Workflow

Slides are rendered using `quarto render index.qmd`.

## Directory structure

Main folders:
- `_extensions/` — Quarto extensions (mcanouil/iconify for icon support)
- `figures/` — slide images and SVGs
- `fonts/` — Noto Sans and Source Code Pro variable fonts

Main files in root:
- `.gitignore`
- `cricket.R` — R script for generating cricket-related figures
- `custom.scss` — custom RevealJS theme styles
- `index.qmd` — main slide deck source
- `README.md`
- `CLAUDE.md`

Generating files:
- `index-files/` — Quarto build artifacts
- `index.html` — rendered slide deck

## Claude rules

- Your main job is to help with writing Quarto markdown and CSS.
- You may also be asked to help with writing R code, particularly generating
  graphics with base R.
# Lab Report Template

See [report.pdf](./report.pdf).

## Goals

This project aims to be a flexible typst template for writing lab reports.

## TODO

- Packages to evaluate: [pillar](https://typst.app/universe/package/pillar), [hydra](https://typst.app/universe/package/hydra), [algorythmst](https://typst.app/universe/package/algorythmst), [theorion](https://typst.app/universe/package/theorion)
- Breakable math blocks

## Branches

- `main`: Default template.
- `feee`: Pre-configured for HCMUT Khoa Điện – Điện tử guidelines (see [doc/hcmut-styling-reference.md](./doc/hcmut-styling-reference.md)).

## Project Structure

```
.
├── report.typ                       # Entry point
├── metadata.typ                     # Report configuration (lang, group, members, course, etc.)
├── refs.bib                         # Bibliography
├── lib/                             # Template core
│   ├── lib.typ                      # Main show rule and exports
│   ├── state.typ                    # Config state and i18n helper
│   ├── styles.typ                   # Page setup, fonts, colors, numbering
│   ├── utils.typ                    # Helper functions (eq, eqref, flex-caption, appendix)
│   ├── lang.toml                    # Translation strings
│   ├── components/
│   │   ├── cover.typ                # Cover page
│   │   ├── checklist.typ            # Checklist tables
│   │   ├── grading-sheet.typ        # Grading sheet
│   │   ├── minitoc.typ              # Per-chapter mini TOC
│   │   └── index.typ                # Component exports
│   ├── constants/
│   │   ├── sizes.typ                # Size constants
│   │   ├── units.typ                # Unit helpers
│   │   └── index.typ                # Constant exports
│   └── assets/
│       └── logos/                   # School logos
├── content/                         # Report sections
│   ├── 00-notes.typ
│   ├── 01-front-checklists.typ
│   ├── 02-preparation.typ
│   ├── 03-inclass-checklists.typ
│   ├── 04-exercise-1.typ
│   ├── 05-exercise-2.typ
│   ├── 98-appendix.typ
│   └── 99-grading-sheet.typ
└── assets/                          # Report-specific images
```

| Path | Description |
| --- | --- |
| `report.typ` | Entry point. Imports `metadata.typ` and `lib/lib.typ`, applies the template, and renders sections. |
| `metadata.typ` | Configuration for language, draft mode, course, instructor, and group members. |
| `lib/lib.typ` | Exports `#show: lab-report.with(...)` and template helpers. |
| `lib/styles.typ` | Page margins, fonts, heading styles, page/figure/equation numbering, code blocks, draft watermark. |
| `lib/state.typ` | Config state and `i18n` lookup backed by `lang.toml`. |
| `lib/components/*` | Reusable components (cover, checklist, grading sheet, minitoc). |
| `content/*.typ` | Report content files. |
| `refs.bib` | BibTeX file for `#bibliography("refs.bib")`. |
| `assets/` | Report-specific images; `lib/assets/` holds template logos. |

## Acknowledgements

School assets from https://hcmut.edu.vn/gioi-thieu/nhan-dien-thuong-hieu

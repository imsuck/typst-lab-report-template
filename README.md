# Lab Report Template

See [report.pdf](./report.pdf) or [report-monochrome.pdf](./report-monochrome.pdf)

## Goals

This project aims to be a flexible typst template for writing lab reports.

## TODOs

Cool packages I plan to add to the template: [pillar](https://typst.app/universe/package/pillar),
[hydra](https://typst.app/universe/package/hydra,), [algorythmst](https://typst.app/universe/package/algorythmst),
[theorion](https://typst.app/universe/package/theorion).

## Project Structure

```
lab-report/                          # one report instance
├── main.typ                         # entry point – only file you compile
├── metadata.typ                     # all configurable data (lang, group, members, course…)
├── refs.bib                         # citations
│
├── template/                        # the reusable part (copy this folder between reports)
│   ├── lib.typ                      # public API: the main show-rule + helpers
│   ├── styles.typ                   # page setup, fonts, colors, numbering, headers/footers
│   ├── i18n.typ                     # localization dictionary (or i18n/en.typ + i18n/vi.typ)
│   ├── components/
│   │   ├── cover.typ                # cover page (logo, faculty, group table…)
│   │   ├── checklist.typ            # reusable checklist tables
│   │   ├── grading-sheet.typ        # phiếu chấm
│   │   └── utils.typ                # small helpers (draft banners, etc.)
│   └── assets/
│       └── logos/                   # school logos (HCMUT, etc.)
│
├── content/                         # report-specific writing
│   ├── 00-notes.typ                 # student notes / lưu ý
│   ├── 01-front-checklists.typ      # đầu buổi + cuối buổi
│   ├── 02-preparation.typ           # phần chuẩn bị (Bài 1A, 1B…)
│   ├── 03-inclass-checklists.typ
│   ├── 04-exercise-1.typ            # actual solution content
│   ├── 05-exercise-2.typ
│   └── …                            # add/remove freely
│
└── assets/                          # report-specific images, schematics, photos
    ├── schematics/
    └── photos/
```

| Path | Role |
| --- | --- |
| `main.typ` | Imports template + metadata, applies the show rule, decides order of front-matter / body / back-matter, includes the content files, places TOC / LOF / LOT / bibliography. |
| `metadata.typ` | Single source of truth: language, draft mode, school/faculty names, group ID, member table, course code, semester, instructor, etc. Everything that changes between reports or subjects lives here. |
| `template/lib.typ` | The public face. Exports the main `#show: lab-report.with(...)` function and any helpers you want available in content files. |
| `template/styles.typ` | All visual rules: page margins, fonts, heading styles, page numbering (Roman for front matter, Arabic for body), optional running headers/footers, draft-mode watermark or banner. |
| `template/i18n.typ` | Clean localization. A dictionary (or two files) keyed by language code. Strings for “Table of Contents”, “List of Figures”, checklist labels, cover titles, etc. Selected by the `lang` parameter. |
| `template/components/*` | Self-contained building blocks (cover, checklist table, grading sheet…). They receive data from metadata or from the call site and stay language-aware via i18n. |
| `content/*.typ` | Pure content. Each file starts with `#import "../template/lib.typ": *` (or a shorter alias) so it can use helpers. Keep them focused on one logical section. |
| `refs.bib` | Standard BibTeX. Used with `#bibliography("refs.bib")` at the end (or wherever you want). |
| `assets/` (both levels) | Template-level for logos that never change; report-level for experiment photos, hand-drawn schematics, simulation screenshots, etc. |

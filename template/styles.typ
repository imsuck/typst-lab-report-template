#import "i18n.typ": create-i18n

#let draft-watermark(watermark-text, font: auto, fill: rgb(220, 53, 69, 35)) = {
  place(
    center + horizon,
    rotate(
      -35deg,
      text(
        fill: fill,
        size: 50pt,
        weight: "bold",
        font: font,
        watermark-text,
      ),
    ),
  )
}

#let get-palette(metadata) = {
  let mono = metadata.at("monochrome", default: false)
  (
    mono: mono,
    primary: if mono { black } else { rgb("#030391") },
    secondary: if mono { luma(40%) } else { rgb("#1488D8") },
    accent: if mono { black } else { rgb("#d32f2f") },
    text: if mono { black } else { rgb("#212529") },
    bg-soft: if mono { luma(96%) } else { rgb("#f8f9fa") },
    border: if mono { luma(80%) } else { rgb("#dee2e6") },
    muted: if mono { luma(45%) } else { rgb("#6c757d") },
    rule: if mono { luma(75%) } else { rgb("#ced4da") },
    watermark: if mono { luma(85%) } else { rgb(220, 53, 69, 35) },
  )
}

// Global states — set once by lab-report/apply-styles, readable by any component
#let palette-state = state("palette", get-palette((:)))
// Stores the language identifier (e.g. "vi", "en") — functions can't be stored in state
#let lang-state = state("lang", "vi")

#let apply-styles(metadata: (:), body) = {
  let palette = get-palette(metadata)
  let lang = metadata.at("lang", default: "vi")
  let doc-i18n = create-i18n(default-lang: lang)

  // Update global states so all components can read them
  palette-state.update(palette)
  lang-state.update(lang)

  // Font settings from metadata with fallbacks
  let font-cfg = metadata.at("fonts", default: (:))
  let body-font = font-cfg.at("body", default: (
    "Libertinus Serif",
    "Times New Roman",
    "DejaVu Serif",
  ))
  let code-font = font-cfg.at("code", default: (
    "DejaVu Sans Mono",
    "Consolas",
    "Courier New",
  ))
  let heading-font = font-cfg.at("heading", default: body-font)

  set document(
    title: metadata.at("title", default: "Lab Report"),
    author: metadata.at("members", default: ()).map(m => m.name),
    date: auto,
  )

  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 8.5pt, fill: palette.muted)[
            #metadata.at("course-name", default: "Lab Report") - #metadata.at("title", default: "")
          ],
          text(size: 8.5pt, fill: palette.muted)[
            #if metadata.at("group", default: none) != none [
              Nhóm #metadata.group
            ]
          ],
        )
        line(length: 100%, stroke: 0.5pt + palette.rule)
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        line(length: 100%, stroke: 0.5pt + palette.rule)
        v(2pt)
        grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 8.5pt, fill: palette.muted)[
            #metadata.at("school-name", default: "")
          ],
          text(size: 8.5pt, fill: palette.muted, weight: "medium")[
            #counter(page).display()
          ],
        )
      }
    },
    background: if metadata.at("draft", default: false) {
      draft-watermark(
        doc-i18n("draft"),
        font: heading-font,
        fill: palette.watermark,
      )
    } else {
      none
    },
  )

  set text(
    font: body-font,
    size: 11pt,
    lang: metadata.at("lang", default: "vi"),
    fill: palette.text,
  )

  // Configure raw (code and codeblocks)
  show raw: set text(font: code-font)

  set par(
    justify: true,
    leading: 0.72em,
    first-line-indent: 1.25em,
  )

  show heading: it => [
    #v(1em, weak: true)
    #text(font: heading-font, fill: palette.primary, weight: "bold")[
      #it
    ]
    #v(0.6em, weak: true)
  ]

  show heading.where(level: 1): it => [
    #v(1.4em, weak: true)
    #text(
      font: heading-font,
      fill: palette.primary,
      weight: "bold",
      size: 1.3em,
    )[
      #it
    ]
    #v(0.8em, weak: true)
  ]

  show raw.where(block: true): it => block(
    fill: palette.bg-soft,
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + palette.border,
    width: 100%,
    it,
  )

  show figure.caption: it => [
    #v(4pt)
    #text(size: 9.5pt, style: "italic")[#it]
  ]

  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
  set table(
    fill: (x, y) => if y == 0 { palette.primary },
    stroke: 0.5pt + palette.border,
  )

  body
}

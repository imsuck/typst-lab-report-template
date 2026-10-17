#let primary-color = rgb("#002855")
#let secondary-color = rgb("#0056b3")
#let accent-color = rgb("#d32f2f")
#let text-color = rgb("#212529")
#let bg-soft = rgb("#f8f9fa")
#let border-color = rgb("#dee2e6")

#let draft-watermark(watermark-text, font: auto) = {
  place(
    center + horizon,
    rotate(
      -35deg,
      text(
        fill: rgb(220, 53, 69, 35),
        size: 50pt,
        weight: "bold",
        font: font,
        watermark-text,
      ),
    ),
  )
}

#import "i18n.typ": i18n as default-i18n

#let apply-styles(metadata: (:), i18n: default-i18n, body) = {
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
          text(size: 8.5pt, fill: rgb("#6c757d"))[
            #metadata.at("course-name", default: "Lab Report") - #metadata.at("title", default: "")
          ],
          text(size: 8.5pt, fill: rgb("#6c757d"))[
            #if (
              metadata.at("group", default: none) != none
            ) [ Nhóm #metadata.group ]
          ],
        )
        line(length: 100%, stroke: 0.5pt + rgb("#ced4da"))
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        line(length: 100%, stroke: 0.5pt + rgb("#ced4da"))
        v(2pt)
        grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 8.5pt, fill: rgb("#6c757d"))[
            #metadata.at("school-name", default: "")
          ],
          text(size: 8.5pt, fill: rgb("#6c757d"), weight: "medium")[
            #counter(page).display()
          ],
        )
      }
    },
    background: if metadata.at("draft", default: false) {
      draft-watermark(i18n("draft"), font: heading-font)
    } else {
      none
    },
  )

  set text(
    font: body-font,
    size: 11pt,
    lang: metadata.at("lang", default: "vi"),
    fill: text-color,
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
    #text(font: heading-font, fill: primary-color, weight: "bold")[
      #it
    ]
    #v(0.6em, weak: true)
  ]

  show heading.where(level: 1): it => [
    #v(1.4em, weak: true)
    #text(font: heading-font, fill: primary-color, weight: "bold", size: 1.3em)[
      #it
    ]
    #v(0.8em, weak: true)
  ]

  show raw.where(block: true): it => block(
    fill: bg-soft,
    inset: 8pt,
    radius: 4pt,
    stroke: 0.5pt + border-color,
    width: 100%,
    it,
  )

  show figure.caption: it => [
    #v(4pt)
    #text(size: 9.5pt, style: "italic")[#it]
  ]

  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
  show table.cell.where(y: 0): set table.cell(fill: primary-color)

  body
}

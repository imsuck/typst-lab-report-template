#import "state.typ": conf, i18n, in-outline
#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.8": codly-languages
#import "@preview/headcount:0.1.1": dependent-numbering, reset-counter
#import "@preview/outrageous:0.4.1"
#import "@preview/t4t:0.4.3": test

#let draft-watermark(
  watermark-text,
  font: auto,
  fill: rgb(220, 53, 69, 63),
) = {
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

#let apply-styles(body) = context {
  let fonts = conf("fonts")
  let colors = conf("colors")
  let format = conf("format")

  // Page layout
  set page(
    margin: format.margin,
    number-align: center + bottom,
    background: if format.draft {
      draft-watermark(i18n("draft"), font: fonts.body)
    } else {
      none
    },
  )

  // Typography
  let leading-spacing = if conf("lang") == "vi" { 0.65em * 1.3 } else { 0.65em * 1.1 }
  set text(
    font: fonts.body,
    size: fonts.at("size", default: 13pt),
    lang: conf("lang"),
  )
  set par(
    justify: true,
    first-line-indent: conf("format").indent,
    leading: leading-spacing,
    spacing: 13pt,
  )
  show raw: set text(font: fonts.code)
  show heading: set text(font: fonts.heading)
  show math.equation: set text(font: fonts.math)

  // Headings & chapter-aware numbering
  set heading(numbering: "1.1.1.1")
  show heading: set text(size: fonts.at("size", default: 13pt))
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    align(center, upper(it))
  }
  show heading.where(level: 2): it => upper(it)
  show heading.where(level: 4): emph

  set figure(numbering: dependent-numbering("1.1"))
  show heading: reset-counter(counter(figure.where(kind: image)))
  show heading: reset-counter(counter(figure.where(kind: table)))
  show heading: reset-counter(counter(math.equation))

  // Figures & captions
  show figure.where(kind: table): set figure.caption(position: top)
  // https://forum.typst.app/t/how-to-display-short-figure-caption-in-bold-and-long-in-italic/4246/2
  show figure.caption: set text(size: 12pt)
  show figure.caption: it => {
    let numbering = if it.numbering != none {
      [~] + context it.counter.display(it.numbering)
    }
    [*#it.supplement#numbering#it.separator*#it.body]
  }

  // Outlines
  show outline: it => in-outline.update(true) + it + in-outline.update(false)
  show outline.entry: it => if test.is-elem(heading, it.element) {
    outrageous.show-entry(it, font: fonts.heading)
  } else {
    outrageous.show-entry(
      it,
      ..outrageous.presets.outrageous-figures,
    )
  }
  show outline.entry: it => {
    show link: set text(fill: black)
    it
  }

  // Tables
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    stroke: (_x, y) => (
      top: if y == 0 { 1.5pt } else if y == 1 { 0.5pt } else { 0pt },
      bottom: 1.5pt,
    ),
    fill: (_x, y) => if calc.odd(y) { colors.surface },
  )
  show table.cell: set par(justify: false)

  // Links & references
  show link: set text(fill: colors.link)
  show cite: set text(fill: colors.link)
  show ref: set text(fill: colors.link)

  // Code blocks
  show: codly.lang-set_(languages: codly-languages)
  show raw.where(block: true): codly.new

  // Math stuff
  show math.equation.where(block: true): set block(breakable: true)
  show math.equation: it => {
    show footnote: block
    it
  }

  body
}

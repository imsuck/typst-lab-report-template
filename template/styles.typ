#import "globals.typ": *
#import "i18n.typ": i18n

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

// author: tromboneher
// https://sitandr.github.io/typst-examples-book/book/snippets/numbering.html?highlight=clean%20heading#clean-numbering
#let clean-numbering(..schemes) = {
  (..nums) => {
    let (section, ..subsections) = nums.pos()
    let (section_scheme, ..subschemes) = schemes.pos()

    if subsections.len() == 0 {
      numbering(section_scheme, section)
    } else if subschemes.len() == 0 {
      numbering(section_scheme, ..nums.pos())
    } else {
      clean-numbering(..subschemes)(..subsections)
    }
  }
}

#let apply-styles(body) = context {
  let fonts = conf("fonts")
  let colors = conf("colors")

  // page layout
  set page(
    margin: conf("margin"),
    background: if conf("format").draft {
      draft-watermark(i18n("draft"), font: fonts.body)
    } else {
      none
    },
  )

  // fonts
  set text(font: fonts.body, lang: conf("lang"))
  show raw: set text(font: fonts.code)
  show heading: set text(font: fonts.heading)

  set heading(numbering: clean-numbering("I.", "1.1.1.1."))

  show figure.caption: it => [
    #text(style: "italic")[#it]
  ]

  // https://forum.typst.app/t/how-to-display-short-figure-caption-in-bold-and-long-in-italic/4246/2
  show figure.caption: it => {
    let numbering = if it.numbering != none {
      [~] + context it.counter.display(it.numbering)
    }
    emph[*#it.supplement#numbering#it.separator*#it.body]
  }

  show outline: it => in-outline.update(true) + it + in-outline.update(false)

  // tables
  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    stroke: (_x, y) => (top: if y <= 1 { 1pt } else { 0pt }, bottom: 1pt),
    fill: (_x, y) => if calc.odd(y) { colors.surface },
  )

  // add colors to certain clickable stuff (doesn't apply to outline and some
  // other things)
  show link: set text(fill: colors.link)
  show cite: set text(fill: colors.link)

  body
}

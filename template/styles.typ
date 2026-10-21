#import "globals.typ": *

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

// author: tromboneher
// https://sitandr.github.io/typst-examples-book/book/snippets/numbering.html?highlight=clean%20heading#clean-numbering
#let clean_numbering(..schemes) = {
  (..nums) => {
    let (section, ..subsections) = nums.pos()
    let (section_scheme, ..subschemes) = schemes.pos()

    if subsections.len() == 0 {
      numbering(section_scheme, section)
    } else if subschemes.len() == 0 {
      numbering(section_scheme, ..nums.pos())
    }
    else {
      clean_numbering(..subschemes)(..subsections)
    }
  }
}

#let apply-styles(body) = context {
  let fonts = config.get().fonts

  set text(font: fonts.body)

  set heading(numbering: "1.1.1.1.")

  show figure.caption: it => [
    #v(4pt)
    #text(size: 9.5pt, style: "italic")[#it]
  ]

  // https://forum.typst.app/t/how-to-display-short-figure-caption-in-bold-and-long-in-italic/4246/2
  show figure.caption: it => {
    let numbering = if it.numbering != none {
      [~] + context it.counter.display(it.numbering)
    }
    emph[*#it.supplement#numbering#it.separator*#it.body]
  }

  show outline: it => in-outline.update(true) + it + in-outline.update(false)

  show table.cell.where(y: 0): set text(weight: "bold")
  set table(
    stroke: (_x, y) => (top: if y == 1 { 1pt } else { 0pt }),
    fill: (_x, y) => if calc.odd(y) { luma(95%) },
  )

  body
}

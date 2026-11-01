#import "globals.typ": *

#import "styles.typ": apply-styles
#import "i18n.typ": i18n
#import "utils.typ": show-appendix
#import "components/index.typ": *

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.8": codly-languages
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/linguify:0.5.0": set-database

#let render-sections(sections) = {
  let sections = if type(sections) == dictionary {
    (sections,) // dealing with this case: ((file: "a")), dict in parens
  } else {
    sections
  }

  for sec in sections {
    if sec.at("pagebreak", default: false) { pagebreak() }
    if sec.at("file", default: none) != none {
      include "../" + sec.file
    } else if sec.at("content", default: none) != none {
      sec.content
    }
  }
}

#let lab-report(
  frontmatter: (),
  backmatter: (),
  body,
) = context {
  set-database(toml("lang.toml"))

  show: apply-styles

  show: codly.lang-set_(languages: codly-languages)
  show raw.where(block: true): codly.new

  cover-page(style: conf("format").cover-style)

  counter(page).update(1)
  set page(numbering: "I")

  render-sections(frontmatter)

  if conf("format").show-toc and query(heading).len() > 0 {
    // I wanted to put this in styles.typ but scoping would be an issue
    show outline.entry.where(level: 1): set outline.entry(fill: none)
    show outline.entry.where(level: 1): it => {
      set block(above: 1.5em)
      set text(weight: "bold")
      it
    }
    outline()
  }
  // to show LoF, LoT on the outline
  show outline: set heading(outlined: true)
  if conf("format").show-lof and query(figure.where(kind: image)).len() > 0 {
    outline(
      title: i18n("lof-title"),
      target: figure.where(kind: image),
    )
  }
  if conf("format").show-lot and query(figure.where(kind: table)).len() > 0 {
    outline(
      title: i18n("lot-title"),
      target: figure.where(kind: table),
    )
  }
  show outline: set heading(outlined: false)

  pagebreak()
  counter(page).update(1)
  set page(numbering: "1")

  body

  pagebreak()
  counter(page).update(1)
  set page(numbering: "I")

  render-sections(backmatter)
}

#import "state.typ": *
#import "constants/index.typ": *

#import "styles.typ": apply-styles
#import "utils.typ": *
#import "components/index.typ": *

#import "@preview/gentle-clues:1.3.1": *
#import "@preview/linguify:0.5.0": set-database


#let render-outlines(format) = {
  if format.show-toc and query(heading).len() > 0 {
    outline()
  }

  // Show LoF and LoT in the table of contents
  show outline: set heading(outlined: true)
  for (flag, title-key, kind) in (
    ("show-lof", "lof-title", image),
    ("show-lot", "lot-title", table),
  ) {
    if format.at(flag) and query(figure.where(kind: kind)).len() > 0 {
      outline(title: i18n(title-key), target: figure.where(kind: kind))
    }
  }
}

#let lab-report(
  frontmatter: (),
  backmatter: (),
  body,
) = context {
  let format = conf("format")
  set-database(toml("lang.toml"))

  show: apply-styles

  cover-page(style: format.cover-style)

  // Frontmatter
  counter(page).update(1)
  set page(numbering: "i")
  render-sections(frontmatter)
  render-outlines(format)

  // Main body
  pagebreak()
  counter(page).update(1)
  set page(numbering: "1")
  body

  // Backmatter
  if not test.is-empty(backmatter) {
    pagebreak()
    counter(page).update(1)
    set page(numbering: "i")
    render-sections(backmatter)
  }
}

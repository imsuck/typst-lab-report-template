#import "state.typ": *
#import "constants/index.typ": *

#import "styles.typ": apply-styles
#import "utils.typ": *
#import "components/index.typ": *

#import "@preview/gentle-clues:1.3.1": *
#import "@preview/linguify:0.5.0": set-database


#let lab-report(
  frontmatter: (),
  backmatter: (),
  body,
) = context {
  set-database(toml("lang.toml"))

  show: apply-styles

  cover-page(style: conf("format").cover-style)

  counter(page).update(1)
  set page(numbering: "i")

  render-sections(frontmatter)

  if conf("format").show-toc and query(heading).len() > 0 {
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

  if backmatter.len() > 0 {
    pagebreak()
    counter(page).update(1)
    set page(numbering: "i")

    render-sections(backmatter)
  }
}

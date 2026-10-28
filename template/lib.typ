#import "globals.typ": *

#import "styles.typ": apply-styles
#import "i18n.typ": i18n
#import "components/index.typ": *

#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.8": codly-languages

#let render-sections(sections) = {
  if type(sections) == dictionary {
    let sec = sections
    if sec.at("pagebreak", default: false) { pagebreak() }
    if sec.at("file", default: none) != none {
      include "../" + sec.file
    } else if sec.at("content", default: none) != none {
      sec.content
    }
  } else {
    for sec in sections {
      if sec.at("pagebreak", default: false) { pagebreak() }
      if sec.at("file", default: none) != none {
        include "../" + sec.file
      } else if sec.at("content", default: none) != none {
        sec.content
      }
    }
  }
}

#let lab-report(
  frontmatter: (),
  backmatter: (),
  body,
) = context {
  show: apply-styles

  show: codly.lang-set_(languages: codly-languages)
  show raw.where(block: true): codly.new

  cover-page(fancy: conf("format").fancy-cover)

  counter(page).update(1)
  set page(numbering: "I")

  render-sections(frontmatter)

  if conf("format").show-toc and query(heading).len() > 0 {
    outline()
  }
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

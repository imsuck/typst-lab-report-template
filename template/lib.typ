#import "globals.typ": *

#import "styles.typ": apply-styles
#import "i18n.typ": i18n
#import "components/index.typ": *

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

// source: https://github.com/shonk-software/community-ostfalia-thesis/blob/50b5a0e64d390509125e69209727161fca0c88cd/lib/helpers.typ
//-------------------------------------
// Chapter
//
#let add-chapter(
  file: none,
  heading-offset: 0,
  after: none,
  before: none,
  pb: false,
  minitoc-title: auto,
  ..args,
) = [
  #if (after != none and before != none) {
    minitoc(title: minitoc-title, after: after, before: before, indent: auto)
    if pb {
      pagebreak()
    }
  }
  #set heading(offset: heading-offset)

  #if (file != none) {
    include file
  } else if args.pos().len() > 0 {
    args.pos().first()
  }
  #set heading(offset: 0)
]

#let flex-caption(short, long) = context {
  if in-outline.get() { [#short] } else {
    if (long == []) [#strong(short)] else [#strong(short). #long]
  }
}

// https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977/2
#let eq(eq, id: none) = {
  set math.equation(
    numbering: if id == none { none } else { "(1)" },
  )

  if id == none {
    eq
  } else {
    [#eq #label(id)]
  }
}

#let eqref(label) = link(label)[(#ref(label, supplement: none))]

#let lab-report(
  frontmatter: (),
  backmatter: (),
  body,
) = context {
  show: apply-styles

  let conf = config.get()

  cover-page()

  counter(page).update(1)
  set page(numbering: "I")

  render-sections(frontmatter)

  if conf.show-toc {
    outline(title: i18n("toc-title"))
  }
  if conf.show-lof {
    outline(
      title: i18n("lof-title"),
      target: figure.where(kind: image),
    )
  }
  if conf.show-lot {
    outline(
      title: i18n("lot-title"),
      target: figure.where(kind: table),
    )
  }

  pagebreak()
  counter(page).update(1)
  set page(numbering: "1")

  body

  pagebreak()
  counter(page).update(1)
  set page(numbering: "I")

  render-sections(backmatter)
}

#import "@preview/headcount:0.1.1": dependent-numbering, reset-counter
#import "@preview/t4t:0.4.3": def, test
#import "state.typ": appx, i18n, in-outline

#let flatten-none(items) = items.flatten().filter(x => x != none)

#let flex-caption(short, long) = context {
  if in-outline.get() { [#short] } else {
    if (long == []) [#emph(short)] else [#emph(short). #long]
  }
}

// https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977/2
#let eq(eq, id: none) = context {
  let num-fmt = if appx.get() { "(A.1)" } else { "(1.1)" }
  set math.equation(
    numbering: if id == none { none } else { dependent-numbering(num-fmt) },
  )

  if id == none {
    eq
  } else {
    [#eq #label(id)]
  }
}

#let eqref(label) = link(label)[(#ref(label, supplement: none))]

#let show-appendix(body) = {
  set heading(numbering: "A.1.1.1.1", supplement: i18n("appendix-title"))
  set figure(numbering: dependent-numbering("A.1"))
  show heading: reset-counter(counter(figure.where(kind: image)))
  show heading: reset-counter(counter(figure.where(kind: table)))
  show heading: reset-counter(counter(math.equation))
  counter(heading).update(0)
  appx.update(true)

  heading(numbering: none, i18n("appendix-title"))

  body
}

#let render-sections(sections) = {
  for sec in def.as-arr(sections) {
    if sec.at("pagebreak", default: false) { pagebreak() }
    if sec.at("file", default: none) != none {
      include "../" + sec.file
    } else if sec.at("content", default: none) != none {
      sec.content
    }
  }
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

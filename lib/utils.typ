#import "state.typ": appx, in-outline, i18n

#let flatten-none(items) = items.flatten().filter(x => x != none)

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

#let show-appendix(body) = {
  set heading(numbering: "A.1.1.1.1", supplement: i18n("appendix-title"))
  counter(heading).update(0)
  appx.update(true)

  heading(numbering: none, i18n("appendix-title"))

  body
}

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

#import "../globals.typ": *
#import "../i18n.typ": i18n

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

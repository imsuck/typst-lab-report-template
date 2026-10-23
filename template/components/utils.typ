#import "../globals.typ": *
#import "../i18n.typ": i18n

#let bgify(col, lightness: 97%, chroma: 0.02) = {
  let (_, _, h) = color.oklch(col).components(alpha: false)
  color.oklch(lightness, chroma, h)
}

#let alert-box(
  title: none,
  body,
  kind: "info",
) = context {
  let colors = conf("colors")
  let border-col = colors.at(kind)
  let bg-col = bgify(colors.at(kind))
  let icon-col = colors.at(kind)

  block(
    fill: bg-col,
    stroke: (left: 3pt + border-col, rest: none),
    inset: (x: 12pt, y: 10pt),
    radius: (right: 4pt),
    width: 100%,
    [
      #if title != none [
        #text(weight: "bold", fill: icon-col)[#title]
        #v(4pt)
      ]
      #body
    ],
  )
}

#let question-box(num, prompt, solution: none) = context {
  let colors = conf("colors")
  block(
    stroke: (left: 3pt + colors.secondary, rest: none),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    [

      #text(weight: "bold")[#i18n("question") #num: #prompt]

      #if solution != none [
        #text(size: 9pt, weight: "medium", fill: colors.muted)[
          #i18n("answer")
        ]

        #solution
      ]
    ],
  )
}

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

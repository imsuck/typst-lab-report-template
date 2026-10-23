#import "../styles.typ": palette-state

#let alert-box(
  title: none,
  body,
  kind: "info",
) = context {
  let palette = palette-state.get()
  let (border-col, bg-col, icon-col) = if palette.mono {
    // Monochrome: differentiate kinds by lightness only
    if kind == "warning" {
      (luma(55%), luma(95%), luma(35%))
    } else if kind == "danger" {
      (luma(45%), luma(93%), luma(25%))
    } else if kind == "success" {
      (luma(50%), luma(94%), luma(30%))
    } else {
      (luma(60%), luma(96%), luma(40%))
    }
  } else if kind == "warning" {
    (rgb("#ffc107"), rgb("#fff9db"), rgb("#d97706"))
  } else if kind == "danger" {
    (rgb("#dc3545"), rgb("#ffe3e3"), rgb("#b91c1c"))
  } else if kind == "success" {
    (rgb("#28a745"), rgb("#ebfbee"), rgb("#15803d"))
  } else {
    (rgb("#0d6efd"), rgb("#e7f5ff"), rgb("#1d4ed8"))
  }

  block(
    fill: bg-col,
    stroke: (left: 3pt + border-col, rest: 0pt),
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
  let palette = palette-state.get()
  block(
    fill: palette.bg-soft,
    stroke: 0.5pt + palette.border,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    [
      #text(weight: "bold", fill: palette.primary)[Câu hỏi #num:] #prompt
      #if solution != none [
        #v(6pt)
        #line(length: 100%, stroke: 0.5pt + palette.rule)
        #v(4pt)
        #text(
          weight: "bold",
          fill: if palette.mono { palette.primary } else { rgb("#2b8a3e") },
        )[Trả lời:] #solution
      ]
    ],
  )
}

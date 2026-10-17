#let alert-box(
  title: none,
  body,
  kind: "info",
) = {
  let (border-col, bg-col, icon-col) = if kind == "warning" {
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
    stroke: (left: 3pt + border-col, rest: 0.5pt + rgb("#e9ecef")),
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

#let question-box(num, prompt, solution: none) = {
  block(
    fill: rgb("#f8f9fa"),
    stroke: 0.5pt + rgb("#dee2e6"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    [
      #text(weight: "bold", fill: rgb("#002855"))[Câu hỏi #num:] #prompt
      #if solution != none [
        #v(6pt)
        #line(length: 100%, stroke: 0.5pt + rgb("#ced4da"))
        #v(4pt)
        #text(weight: "bold", fill: rgb("#2b8a3e"))[Trả lời:] #solution
      ]
    ],
  )
}

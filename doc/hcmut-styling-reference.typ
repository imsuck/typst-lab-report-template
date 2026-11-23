#import "@preview/cmarker:0.1.10": render

#show heading: set text(font: "Noto Sans")
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  align(center, upper(it))
}
#show heading.where(level: 2): it => upper(strong(it))
#show heading.where(level: 3): strong
#show heading.where(level: 4): emph
#set par(justify: true)
#show raw: set text(font: "Hack")
#show table: set par(justify: false)

// #show heading.where(level: 1): set text(size: 3em)

#render(read("hcmut-styling-reference.md"))

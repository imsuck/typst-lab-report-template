#let in-outline = state("in-outline", false)

#let config = state("config", (
  lang: "vi",
  monochrome: false,
  draft: true,
  show-toc: true,
  show-lof: true,
  show-lot: true,
  fonts: (
    body: ("Times New Roman", "STIX Two Text"),
    code: "Fira Code",
    heading: ("Times New Roman", "STIX Two Text"),
  ),
))

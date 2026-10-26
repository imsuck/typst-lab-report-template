#let in-outline = state("in-outline", false)

#let config = state("config", (
  lang: "vi",
  format: (
    monochrome: false,
    fancy-cover: false,
    draft: true,
    show-toc: true,
    show-lof: true,
    show-lot: true,
  ),
  fonts: (
    body: ("Times New Roman", "STIX Two Text"),
    code: "Fira Code",
    heading: ("Times New Roman", "STIX Two Text"),
  ),
  colors: (
    primary: color.oklch(55%, 0.2, 260deg),
    secondary: color.oklch(55%, 0.03, 260deg),
    accent: color.oklch(60%, 0.15, 150deg),

    text: color.oklch(25%, 0.015, 260deg),
    muted: color.oklch(50%, 0.02, 260deg),
    background: color.oklch(100%, 0, 0deg),
    surface: color.oklch(97%, 0.005, 260deg),
    border: color.oklch(85%, 0.015, 260deg),

    link: color.oklch(48%, 0.14, 260deg),
    heading: color.oklch(22%, 0.02, 260deg),

    success: color.oklch(50%, 0.14, 145deg),
    warning: color.oklch(65%, 0.15, 85deg),
    error: color.oklch(52%, 0.19, 25deg),
    info: color.oklch(55%, 0.15, 245deg),
  ),
  margin: 2.5cm,
))

#let conf(key) = config.get().at(key)

// CONSTANTS
// Fontsizes
// from: https://github.com/shonk-software/community-ostfalia-thesis/blob/50b5a0e64d390509125e69209727161fca0c88cd/lib/constants.typ
#let tinyer = 6pt
#let tiny = 8pt
#let smaller = 9pt
#let small = 10pt
#let normal = 11pt
#let large = 14pt
#let larger = 16pt
#let huge = 24pt
#let huger = 36pt

// fontsize+
#let tinyer-p = tinyer + 5pt
#let tiny-p = tiny + 5pt
#let smaller-p = smaller + 5pt
#let small-p = small + 5pt
#let normal-p = normal + 5pt
#let large-p = large + 5pt
#let larger-p = larger + 5pt
#let huge-p = huge + 5pt
#let huger-p = huger + 5pt

// fontsizes++
#let tinyer-pp = tinyer + 10pt
#let tiny-pp = tiny + 10pt
#let smaller-pp = smaller + 10pt
#let small-pp = small + 10pt
#let normal-pp = normal + 10pt
#let large-pp = large + 10pt
#let larger-pp = larger + 10pt
#let huge-pp = huge + 10pt
#let huger-pp = huger + 10pt

// Units
// from: https://github.com/illusionaries/typst-template/blob/50e23feec410aa84d97ed42d15ff3f3a5dcfbc29/units.typ
#let mA = $thin "mA"$
#let uA = $thin mu"A"$
#let nA = $thin "nA"$

#let mV = $thin "mV"$
#let uV = $thin mu"V"$
#let nV = $thin "nV"$

#let mF = $thin "mF"$
#let uF = $thin mu"F"$
#let nF = $thin "nF"$
#let pF = $thin "pF"$
#let fF = $thin "fF"$

#let mm = $thin "mm"$
#let um = $thin mu"m"$
#let nm = $thin "nm"$

#let ms = $thin "ms"$
#let us = $thin mu"s"$
#let ns = $thin "ns"$
#let ps = $thin "ps"$

#let Hz = $thin "Hz"$
#let kHz = $thin "kHz"$
#let MHz = $thin "MHz"$
#let GHz = $thin "GHz"$

#let mps = $thin "m" thin "s"^(-1)$
#let mps2 = $thin "m" thin "s"^(-2)$
#let kph = $thin "km" thin "h"^(-1)$

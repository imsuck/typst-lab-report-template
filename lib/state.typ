#import "@preview/linguify:0.5.0": linguify as i18n

#let in-outline = state("in-outline", false)
#let appx = state("appx", false)

#let config = state("config", (
  lang: "vi",
  format: (
    monochrome: false, // unplanned
    cover-style: "simple", // "none|simple|fancy"
    draft: true,
    show-toc: true,
    show-lof: true,
    show-lot: true,
    margin: (
      left: 40mm,
      right: 25mm,
      top: 40mm,
      bottom: 25mm,
    ),
    indent: 1.25cm,
  ),
  fonts: (
    size: 13pt,
    body: ("STIX Two Text", "Times New Roman"),
    heading: ("STIX Two Text", "Times New Roman"),
    math: "New Computer Modern Math",
    code: ("Fira Mono",),
  ),
  // also kinda unplanned
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
))

#let conf(key) = config.get().at(key)


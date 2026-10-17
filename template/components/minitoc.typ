// source: https://github.com/shonk-software/community-ostfalia-thesis/blob/50b5a0e64d390509125e69209727161fca0c88cd/lib/helpers.typ
#let minitoc(
  after: none,
  before: none,
  addline: true,
  stroke: 0.5pt,
  length: 100%,
  depth: 3,
  title: auto,
  indent: auto,
) = {
  let resolved-title = if title == auto { i18n("toc-title") } else { title }
  v(2em)
  if resolved-title != none {
    text(weight: "bold", resolved-title)
  }
  if addline == true {
    line(length: length, stroke: stroke)
  }
  let h = selector(heading.where(level: 2))
    .or(heading.where(level: 3))
    .or(heading.where(level: 4))
    .or(heading.where(level: 5))
    .or(heading.where(level: 6))
    .or(heading.where(level: 7))
    .or(heading.where(level: 8))
    .or(heading.where(level: 9))
    .or(heading.where(level: 10))
  outline(
    title: none,
    target: selector(h).after(after).before(before, inclusive: false),
    depth: depth,
    indent: indent,
  )
  if addline == true {
    line(length: length, stroke: stroke)
  }
}

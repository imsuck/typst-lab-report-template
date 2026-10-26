#import "../i18n.typ": i18n
#import "../utils.typ": flatten-none

#let checklist-table(
  title: none,
  numbered: true,
  signature: true,
  items: (),
) = {
  if title != none {
    heading(level: 2, numbering: none, outlined: false)[#title]
  }

  let widths = flatten-none((
    if numbered { (auto,) },
    (1fr, 60pt),
    if signature { (80pt,) },
  ))

  let aligns = flatten-none((
    if numbered { (center + horizon,) },
    (left + horizon, center + horizon),
    if signature { (center + horizon,) },
  ))

  let headers = flatten-none((
    if numbered { ("#",) },
    (i18n("task"), i18n("status")),
    if signature { (i18n("signature"),) },
  ))

  let make-row(item, idx) = {
    let is-dict = type(item) == dictionary

    let task = if is-dict {
      item.at("task", default: "")
    } else {
      item
    }

    let status = if is-dict {
      item.at("status", default: "[  ]")
    } else {
      "[  ]"
    }

    let note = if is-dict {
      item.at("note", default: "")
    } else {
      ""
    }

    flatten-none((
      if numbered { (str(idx + 1),) },
      (task, status),
      if signature { (note,) },
    ))
  }

  table(
    columns: widths,
    align: aligns,
    table.header(..headers),
    ..items.enumerate().map(((idx, item)) => make-row(item, idx)).flatten(),
  )
}

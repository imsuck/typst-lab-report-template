#import "../i18n.typ": i18n as default-i18n

#let checklist-table(
  title: none,
  items: (),
  i18n: default-i18n,
) = {
  if title != none [
    #heading(level: 2, numbering: none)[#title]
  ]

  table(
    columns: (auto, 1fr, 60pt, 80pt),
    align: (
      center + horizon,
      left + horizon,
      center + horizon,
      center + horizon,
    ),
    stroke: 0.5pt + rgb("#dee2e6"),
    table.header(
      [\#], [#i18n("task")], [#i18n("status")], [#i18n("signature")]
    ),
    ..items
      .enumerate()
      .map(((idx, item)) => {
        let content = if type(item) == str or type(item) == content {
          item
        } else { item.at("task", default: "") }
        let status = if type(item) == dictionary {
          item.at("status", default: "[  ]")
        } else { "[  ]" }
        let note = if type(item) == dictionary {
          item.at("note", default: "")
        } else { "" }
        (
          str(idx + 1),
          content,
          status,
          note,
        )
      })
      .flatten(),
  )
}


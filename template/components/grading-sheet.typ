#import "../styles.typ": lang-state, palette-state
#import "../i18n.typ": create-i18n

#let grading-sheet(
  metadata: (:),
  criteria-list: (
    (
      criteria: "Chuẩn bị bài trước thí nghiệm (Pre-lab questions & design)",
      max: "2.0",
      score: "",
    ),
    (
      criteria: "Kỹ năng thực hành, thao tác thiết bị và an toàn phòng lab",
      max: "3.0",
      score: "",
    ),
    (
      criteria: "Thu thập số liệu, kết quả đo và phân tích sóng/dữ liệu",
      max: "3.0",
      score: "",
    ),
    (
      criteria: "Báo cáo thí nghiệm, thảo luận kết quả & trả lời câu hỏi phụ",
      max: "2.0",
      score: "",
    ),
  ),
) = context {
  let palette = palette-state.get()
  let i18n = create-i18n(default-lang: lang-state.get())

  v(0.5em)
  heading(level: 2, numbering: none, outlined: false)[#i18n("grading-sheet")]

  table(
    columns: (auto, 1fr, 70pt, 70pt),
    align: (
      center + horizon,
      left + horizon,
      center + horizon,
      center + horizon,
    ),
    stroke: 0.5pt + palette.border,
    table.header(
      [\#], [#i18n("criteria")], [#i18n("max-score")], [#i18n("awarded-score")]
    ),
    ..criteria-list
      .enumerate()
      .map(((idx, row)) => (
        str(idx + 1),
        row.criteria,
        row.max,
        row.score,
      ))
      .flatten(),
    table.cell(colspan: 2, align: right + horizon)[*Tổng điểm:*],
    [*10.0*],
    [],
  )

  v(1em)
  block(
    stroke: 0.5pt + palette.border,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    [
      *#i18n("instructor-feedback"):*
      #v(3.5cm)
      #align(right)[
        *#i18n("instructor-signature")*
        #v(2.5cm)
      ]
    ],
  )
}

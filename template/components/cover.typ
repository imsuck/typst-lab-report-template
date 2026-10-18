#import "../styles.typ": draft-watermark, lang-state, palette-state
#import "../i18n.typ": create-i18n

#let cover-page(
  metadata: (:),
) = context {
  let palette = palette-state.get()
  let i18n = create-i18n(default-lang: lang-state.get())

  let font-cfg = metadata.at("fonts", default: (:))
  let body-font = font-cfg.at("body", default: (
    "Libertinus Serif",
    "Times New Roman",
    "DejaVu Serif",
  ))
  let heading-font = font-cfg.at("heading", default: body-font)

  set text(font: body-font)
  page(
    header: none,
    footer: none,
    margin: (x: 2.5cm, top: 2cm, bottom: 2cm),
    background: if metadata.at("draft", default: false) {
      draft-watermark(
        i18n("draft"),
        font: heading-font,
        fill: palette.watermark,
      )
    } else {
      none
    },
    [
      #align(center)[
        #text(size: 13pt, weight: "bold", fill: palette.primary)[
          #upper(metadata.at(
            "school-name",
            default: "TRƯỜNG ĐẠI HỌC BÁCH KHOA - ĐHQG TP.HCM",
          ))
        ]

        #v(2pt)
        #text(size: 12pt, weight: "bold", fill: palette.secondary)[
          #upper(metadata.at("faculty-name", default: "KHOA ĐIỆN -- ĐIỆN TỬ"))
        ]

        #v(1.2cm)
        #let logo-path = metadata.at(
          "logo",
          default: "/template/assets/logos/hcmut-logo.png",
        )
        #image(logo-path, width: 3.5cm)

        #v(1.2cm)
        #text(size: 15pt, weight: "bold", fill: palette.primary)[
          #upper(i18n("course")): #upper(metadata.at("course-name", default: ""))
        ]

        #v(4pt)
        #if metadata.at("course-code", default: none) != none [
          #text(size: 12pt, weight: "medium", fill: palette.text)[
            Mã môn học: #metadata.course-code
          ]
        ]

        #v(0.8cm)
        #line(length: 60%, stroke: 1.5pt + palette.primary)
        #v(0.6cm)

        #text(size: 18pt, weight: "bold", fill: palette.primary)[
          #metadata.at("title", default: "BÁO CÁO THÍ NGHIỆM")
        ]

        #if metadata.at("subtitle", default: none) != none [
          #v(6pt)
          #text(size: 13pt, style: "italic", fill: palette.muted)[
            #metadata.subtitle
          ]
        ]

        #v(0.6cm)
        #line(length: 60%, stroke: 1.5pt + palette.primary)
      ]

      #v(1fr)

      #align(center)[
        #block(width: 90%)[
          #grid(
            columns: (auto, 1fr),
            row-gutter: 8pt,
            column-gutter: 12pt,
            [*#i18n("instructor"):*],
            [#metadata.at("instructor", default: "ThS. Nguyễn Văn A")],

            [*#i18n("class-group") / #i18n("group"):*],
            [#metadata.at("class", default: "L01") - #i18n("group") #metadata.at("group", default: "01")],

            [*#i18n("semester"):*],
            [#metadata.at("semester", default: "HK 241") (#metadata.at("academic-year", default: "2024 - 2025"))],
          )

          #v(0.6em)
          #table(
            columns: (auto, 1fr, 80pt, 90pt),
            align: (
              center + horizon,
              left + horizon,
              center + horizon,
              center + horizon,
            ),
            stroke: 0.5pt + palette.border,
            table.header(
              [\#],
              [#i18n("student-name")],
              [#i18n("student-id")],
              [#i18n("role")],
            ),
            ..metadata
              .at("members", default: ())
              .enumerate()
              .map(((idx, member)) => (
                str(idx + 1),
                member.name,
                member.id,
                member.at("role", default: "Thành viên"),
              ))
              .flatten(),
          )
        ]
      ]

      #v(1fr)
      #align(center)[
        #text(size: 10pt, fill: palette.muted)[
          #metadata.at("location", default: "TP. Hồ Chí Minh"), #metadata.at("date", default: datetime.today().display("[month repr:long] [year]"))
        ]
      ]
    ],
  )
}

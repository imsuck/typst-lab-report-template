#import "../i18n.typ": i18n
#import "../globals.typ": *

// fancy: adds an extra cover page for when you need an inner and outer cover
#let cover-page(fancy: false) = context {
  if fancy {
    block(
      inset: 0.6cm,
      width: 100%,
      height: 100%,
      stroke: 2pt,
      align(center)[
        #text(weight: "bold", size: 16pt)[
          #upper(conf("school").name) \
          #upper(conf("school").faculty)
        ]
        #image("../assets/logos/hcmut-logo.png", width: 100pt)

        #v(1fr) // malleable

        #text(weight: "bold", size: 18pt)[
          #upper(conf("doc").subtitle)
        ]

        #v(2em) // malleable

        #text(weight: "bold", size: 22pt)[
          #upper(conf("doc").title)
        ]

        #v(1fr)

        #text(weight: "bold", size: 16pt)[
          #upper[
            #i18n("class-group") #conf("school").class, #i18n("group") #conf("school").group \
            #i18n("instructor"): #conf("school").instructor
          ]
        ]

        #v(1fr)

        #text(weight: "bold", size: 16pt)[
          #conf("school").location, #conf("doc").date
        ]
      ],
    )

    pagebreak()
  }

  align(center)[
    #text(weight: "bold", size: 16pt)[
      #upper(conf("school").name) \
      #upper(conf("school").faculty)
    ]
    #image("../assets/logos/hcmut-logo.png", width: 100pt)

    #v(1fr) // malleable

    #text(weight: "bold", size: 18pt)[
      #upper(conf("doc").subtitle)
    ]

    #v(2em) // malleable

    #text(weight: "bold", size: 22pt)[
      #upper(conf("doc").title)
    ]

    #v(1fr)

    #text(weight: "bold", size: 16pt)[
      #upper[
        #i18n("class-group") #conf("school").class, #i18n("group") #conf("school").group \
      ]
    ]

    #text(weight: "bold", size: 11pt, i18n("members"))
    #table(
      columns: 4,
      inset: (x: 1em, y: 0.75em),
      table.header(
        [\#], i18n("student-name"), i18n("student-id"), i18n("role")
      ),
      ..conf("school")
        .group-members
        .enumerate()
        .map(((idx, member)) => (
          str(idx + 1),
          member.name,
          member.id,
          member.role,
        ))
        .flatten(),
    )

    #v(1fr)

    #text(weight: "bold", size: 16pt)[
      #conf("school").location, #conf("doc").date
    ]
  ]

  pagebreak()
}

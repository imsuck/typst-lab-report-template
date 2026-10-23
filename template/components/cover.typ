#import "../i18n.typ": i18n
#import "../globals.typ": *

#let cover-page() = context {
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

      #v(5em) // malleable

      #text(weight: "bold", size: 18pt)[
        #upper(conf("doc").subtitle)
      ]

      #v(5em) // malleable

      #text(weight: "bold", size: 22pt)[
        #upper(conf("doc").title)
      ]

      #v(5em)

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

#import "metadata.typ": *

#configure()

#show: lab-report.with(
  frontmatter: (
    (
      content: [
        #align(center)[#text(size: 18pt, weight: "bold")[LỜI CẢM ƠN]]
        #lorem(50)

        #lorem(100)

        #lorem(50)

        #pagebreak()
      ],
    )
  ),
  backmatter: (
    (
      content: {
        set page(numbering: (..) => "")
        include "content/99-grading-sheet.typ"
      },
    ),
  ),
)

#include "content/00-notes.typ"
#include "content/01-front-checklists.typ"
#include "content/02-preparation.typ"
#include "content/03-inclass-checklists.typ"
#include "content/04-exercise-1.typ"
#include "content/05-exercise-2.typ"

#bibliography("refs.bib", title: i18n("references-title"), style: "ieee")

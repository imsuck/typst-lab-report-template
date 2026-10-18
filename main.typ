#import "metadata.typ": *

#show: lab-report.with(metadata: metadata)

// Content sections
#include "content/00-notes.typ"
#include "content/01-front-checklists.typ"
#include "content/02-preparation.typ"
#include "content/03-inclass-checklists.typ"
#include "content/04-exercise-1.typ"
#include "content/05-exercise-2.typ"

// Bibliography
#v(1.5em)
#bibliography("refs.bib", title: i18n("references-title"), style: "ieee")

#if metadata.at("show-grading-sheet", default: true) [
  #pagebreak()
  #set page(numbering: (..) => "")
  #include "content/06-grading-sheet.typ"
]

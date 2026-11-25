#import "metadata.typ": *

#configure()

#show: lab-report.with(
  frontmatter: (
    (
      content: [
        #align(center, block(text(size: 18pt, weight: "bold")[LỜI CẢM ƠN]))

        #lorem(50)

        #lorem(100)

        #lorem(50)

        #let pvec(it) = $upright(bold(it))$

        #eq(
          id: "eq:boltzmann-transport",
          $
            (partial f)/(partial t) + pvec(v) dot nabla_pvec(x) f + pvec(F)/m dot nabla_pvec(v) f = integral.triple_(RR^3 times RR^3 times SS^2) B(norm(pvec(v) - pvec(v)_*), pvec(omega)) (f' f_*^' - f f_*) dif pvec(omega) dif pvec(v)_* dif pvec(x)
          $,
        )

        $
          norm(f)_(B_(p,q)^S (RR^d)) = (sum_(j=-1)^oo 2^(j s q) norm(cal(F)^(-1) (phi_j (xi) hat(f) (xi)))_(L^p (RR^d))^q)^(1\/q)
        $

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
#include "content/98-appendix.typ"

#{
  // I want the inner content to be in English
  set text(lang: "en")
  bibliography(
    "refs.bib",
    style: "ieee",
    title: context {
      i18n(
        "references-title",
        lang: conf("lang"),
      )
    },
  )
  context { set text(lang: conf("lang")) }
}

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

        $
          cal(Z)[J] = integral cal(D)_phi.alt exp [i integral_(RR^(1,3)) (-1/2 partial_mu phi.alt partial^mu phi.alt - m^2/2 phi.alt^2 - lambda/4! phi.alt^4 + J phi.alt) dif^4 x]
        $

        $
          cal(L) = & -1/4 G_(mu nu)^a G^(a mu nu) - 1/4 W_(mu nu)^i W^(i mu nu) - 1/4 B_(mu nu) B^(mu nu) \
                   & + sum_"generations" overline(psi)_f i gamma^mu D_mu psi_f \
                   & + (D_mu H)^dagger (D^mu H) - mu^2 H^dagger H - lambda (H^dagger H)^2 \
                   & - (y_u overline(Q)_L tilde(H) u_R + y_d overline(Q)_L H d_R + y_e overline(L)_L H e_R + "h.c.")
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

#import "globals.typ": appx
#import "i18n.typ": i18n

#let flatten-none(items) = items.flatten().filter(x => x != none)

#let show-appendix(body) = {
  set heading(numbering: "A.1.1.1.1", supplement: i18n("appendix-title"))
  counter(heading).update(0)
  appx.update(true)

  heading(numbering: none, i18n("appendix-title"))

  body
}

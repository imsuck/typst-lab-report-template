#import "styles.typ": apply-styles, primary-color, secondary-color
#import "i18n.typ": create-i18n, i18n
#import "components/cover.typ": cover-page
#import "components/checklist.typ": checklist-table
#import "components/grading-sheet.typ": grading-sheet
#import "components/utils.typ": alert-box, question-box

#let lab-report(
  metadata: (:),
  body,
) = {
  // 1. Cover page
  cover-page(metadata: metadata, i18n: i18n)

  // 2. Main styling wrapper
  show: it => apply-styles(metadata: metadata, i18n: i18n, it)

  // 3. Front matter: Roman numerals for page numbering
  set page(numbering: "I")
  counter(page).update(1)

  // Table of Contents
  outline(
    title: i18n("toc-title"),
    indent: auto,
    depth: 3,
  )
  v(1.5em)

  // List of Figures if requested
  if metadata.at("show-lof", default: false) {
    outline(
      title: i18n("lof-title"),
      target: figure.where(kind: image),
    )
    v(1.5em)
  }

  // List of Tables if requested
  if metadata.at("show-lot", default: false) {
    outline(
      title: i18n("lot-title"),
      target: figure.where(kind: table),
    )
    v(1.5em)
  }

  pagebreak()

  // 4. Body matter: Arabic numbering
  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: "1.1")

  body
}

// source: https://github.com/shonk-software/community-ostfalia-thesis/blob/50b5a0e64d390509125e69209727161fca0c88cd/lib/helpers.typ
#let minitoc(
  after: none,
  before: none,
  addline: true,
  stroke: 0.5pt,
  length: 100%,
  depth: 3,
  title: auto,
  indent: auto,
) = {
  let resolved-title = if title == auto { i18n("toc-title") } else { title }
  v(2em)
  if resolved-title != none {
    text(weight: "bold", resolved-title)
  }
  if addline == true {
    line(length: length, stroke: stroke)
  }
  let h = selector(heading.where(level: 2))
    .or(heading.where(level: 3))
    .or(heading.where(level: 4))
    .or(heading.where(level: 5))
    .or(heading.where(level: 6))
    .or(heading.where(level: 7))
    .or(heading.where(level: 8))
    .or(heading.where(level: 9))
    .or(heading.where(level: 10))
  outline(
    title: none,
    target: selector(h).after(after).before(before, inclusive: false),
    depth: depth,
    indent: indent,
  )
  if addline == true {
    line(length: length, stroke: stroke)
  }
}

//-------------------------------------
// Chapter
//
#let add-chapter(
  file: none,
  heading-offset: 0,
  after: none,
  before: none,
  pb: false,
  minitoc-title: auto,
  ..args,
) = [
  #if (after != none and before != none) {
    minitoc(title: minitoc-title, after: after, before: before, indent: auto)
    if pb {
      pagebreak()
    }
  }
  #set heading(offset: heading-offset)

  #if (file != none) {
    include file
  } else if args.pos().len() > 0 {
    args.pos().first()
  }
  #set heading(offset: 0)
]



#import "styles.typ": apply-styles, get-palette, lang-state, palette-state
#import "i18n.typ": create-i18n, i18n
#import "components/cover.typ": cover-page
#import "components/checklist.typ": checklist-table
#import "components/grading-sheet.typ": grading-sheet
#import "components/minitoc.typ": minitoc
#import "components/utils.typ": alert-box, question-box

#let lab-report(
  metadata: (:),
  body,
) = {
  let lang = metadata.at("lang", default: "vi")
  let doc-i18n = create-i18n(default-lang: lang)

  // Initialize global states before any content renders (including cover-page)
  palette-state.update(get-palette(metadata))
  lang-state.update(lang)

  // 1. Cover page
  cover-page(metadata: metadata)

  // 2. Main styling wrapper (also re-sets states for safety)
  show: it => apply-styles(metadata: metadata, it)

  // 3. Front matter: Roman numerals for page numbering
  set page(numbering: "I")
  counter(page).update(1)

  // Table of Contents
  if metadata.at("show-toc", default: false) {
    outline(
      title: doc-i18n("toc-title"),
      indent: auto,
      depth: 3,
    )
    v(1.5em)
  }

  // List of Figures if requested
  if metadata.at("show-lof", default: false) {
    outline(
      title: doc-i18n("lof-title"),
      target: figure.where(kind: image),
    )
    v(1.5em)
  }

  // List of Tables if requested
  if metadata.at("show-lot", default: false) {
    outline(
      title: doc-i18n("lot-title"),
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

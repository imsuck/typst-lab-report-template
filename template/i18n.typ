#import "i18n/en.typ": en
#import "i18n/vi.typ": vi

// Internal dictionary map
#let _langs = (
  "vi": vi,
  "en": en,
)

// Internal lookup function
#let _lookup(locale-id, lang) = {
  let dict = _langs.at(lang, default: vi)
  assert(
    locale-id in dict,
    message: "I18n key "
      + str(locale-id)
      + " doesn't exist for language "
      + str(lang),
  )
  dict.at(locale-id)
}

// Constructor: Returns a callable translator instance bound to a default language
#let create-i18n(default-lang: "vi") = {
  (locale-id, lang: default-lang) => {
    _lookup(locale-id, lang)
  }
}

// Default base translator instance bound to "vi"
#let i18n = create-i18n(default-lang: "vi")

#import "i18n/en.typ": en
#import "i18n/vi.typ": vi

#import "globals.typ": config

// Internal dictionary map
#let _langs = (
  "vi": vi,
  "en": en,
)

// Internal lookup function
#let i18n(locale-id) = context {
  let lang = config.get().lang
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

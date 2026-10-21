#import "template/lib.typ": *

#let configure() = {
  config.update(val => {
    val.monochrome = false

    val
  })
}

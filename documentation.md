# Documentation for Lab Report Template

## Typst

First thing first, before you can use this template, you ought to have some
knowledge of Typst. The easiest way to get started with Typst is through the
dedicated [tutorial](https://typst.app/docs/tutorial/writing-in-typst/) on its
website.

If you have a hard time remembering all the symbols in equations, check out
[Typerino](https://typerino.com/). It basically has everything you will ever
need to deal with undergrad study. And if push comes to shove, you can ask an
LLM to write out the equation for you (not that I recommend it).

If you really need to get deep into Typst as a language, the
[reference](https://typst.app/docs/reference/) is always there to help you out
with your ambitious document styling.

## The template

### File organization

All of the document configuration reside in `/metadata.typ`. It should be
fairly trivial to figure out what each field mean, save for `fancy-cover`, which
demands a little bit of messing around to see its purpose.

`/main.typ` brings everything together. Include all of your document files here.
You can also use frontmatter and backmatter to add special... academia stuff.

`/content/` contains your chapters. Ideally, to stay organized, add some numbers
to sort them in order.

`/assets/` stores all the images that you insert into your document, or maybe
some `.csv` files...

### All things equations

You might want to number specific equations to later mention them, but numbering
every display math block would be a bad idea! That's why there are helper
functions `eq($ stuff $, id: "id1")` and `eqref(<id1>)`. `eq()` only works with
display blocks. `eqref()` can be used in any mathematical expression, you can
even use it in text mode if you prefer `(1)` over `Equation 1`.

### Stylized boxes

There are two kinds of stylized boxes that this template supports:

- `alert-box(title: content | none, body, kind: "info" | "warning" | "error")`
  These are quite eye-catchy. Don't over-use them.
- `question-box(num, prompt, solution: content | none)`
  Used specifically for questions with short answers (or maybe none). If you
  need more space, switching over to standard prose might be better.

### References

Of course, what is an academic paper without citations? `refs.bib` holds all
of the sources that will be referenced in the article. You can use a reference
manager like [Zotero](https://www.zotero.org/) to generate the BibTeX entries,
or ask an LLM to generate them (you should tell it to verify the entries).

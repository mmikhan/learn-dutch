#import "@preview/ilm:2.0.0": *

#set text(lang: "en")

#show: ilm.with(
  title: [Basic Dutch Grammar],
  authors: "Mazedul",
  date: datetime(year: 2026, month: 04, day: 19),
  abstract: [
    A practical beginner's guide to the core grammar patterns you need to start reading, building, and understanding simple Dutch sentences.
  ],
  preface: [#include "frontmatter/preface.typ"],
  raw-text: "use-typst-default",
)

#include "chapters/00-grammar-terms.typ"
#include "chapters/01-sounds-and-spelling.typ"
#include "chapters/02-nouns-and-articles.typ"
#include "chapters/02a-plural-reference.typ"
#include "chapters/03-pronouns-and-word-order.typ"
#include "chapters/04-present-tense-and-negation.typ"
#include "chapters/05-questions-and-useful-patterns.typ"
#include "chapters/06-past-tense-and-perfect-tense.typ"
#include "chapters/07-separable-verbs.typ"
#include "chapters/08-prepositions.typ"

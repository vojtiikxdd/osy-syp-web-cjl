#let header(title: "", author: "", body) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    header: align(right)[#text(size: 9pt, gray)[#title | #author]],
    numbering: "1",
  )

  set text(font: "New Computer Modern", size: 11pt, lang: "cs")
  set par(justify: true)

  show heading.where(level: 1): set text(size: 22pt, weight: "bold", fill: navy)
  show heading.where(level: 2): set text(size: 16pt, weight: "bold", fill: red.darken(20%))

  align(center)[
    #block(text(size: 28pt, weight: "bold")[#title])
    #v(1em)
    #text(size: 14pt)[Příprava k maturitě - SPŠT IT] \
    #line(length: 100%, stroke: 1pt + navy)
  ]

  v(2em)

  outline(
    title: "Obsah",
  )


  body
}

#let theme(
  intro: [],
  body: [],
  summary: [],
  resources: [],
) = {
  import "@preview/zebraw:0.6.1": *

  show: zebraw
  show footnote.entry: set text(navy)

  [= Úvod ]
  intro

  body

  [== Shrnutí ]
  summary

  pagebreak()

  [== Zdroje ]
  resources

  v(2em)
  line(length: 40%, stroke: 0.5pt + gray)
}

#let simple(
  body: [],
  resources: [],
) = {
  import "@preview/zebraw:0.6.1": *

  show footnote.entry: set text(navy)
  show: zebraw

  body

  pagebreak()

  [== Zdroje ]
  resources

  v(2em)
  line(length: 40%, stroke: 0.5pt + gray)
}

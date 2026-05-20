#let header(title: "", author: "", body) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    header: context {
      // Not showing the header on the first page
      if counter(page).get().first() > 1 {
        align(right)[#text(size: 9pt, gray)[#title | #author]]
      }
    },
    numbering: "1",
  )

  set text(font: "JetBrains Mono", size: 11pt, lang: "cs")
  set par(justify: true)

  show heading.where(level: 1): set text(size: 22pt, weight: "bold", fill: eastern.darken(20%))
  show heading.where(level: 2): set text(size: 16pt, weight: "bold", fill: navy.lighten(20%))

  align(center)[
    #block(text(size: 28pt, weight: "bold", fill: blue.darken(15%))[#title])
    #v(1em)
    #text(size: 14pt, fill: blue.darken(45%))[Příprava k maturitě - SPŠT IT] \
    #line(length: 100%, stroke: 1pt + navy)
  ]

  v(2em)

  outline(
    title: "Obsah",
  )

  body
}

#let theme(
  body: [],
  subquestions: [],
  resources: [],
) = {
  import "@preview/zebraw:0.6.1": *

  show: zebraw
  show footnote.entry: set text(navy)

  pagebreak()
  
  body

  [= Odpovědi na zadané podotázeky]
  block(
    fill: luma(240), 
    inset: 10pt, 
    radius: 4pt
  )[
   Každá otázka na začátku odpovědi obsahuje odkaz na konkrétní kapitolu v zápise s proklikem 
  ]
  
  subquestions

  [= Další materiály a zdroje ]
  resources

  v(2em)
  line(length: 40%, stroke: 0.5pt + gray)
}
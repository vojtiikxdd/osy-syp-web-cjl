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
  
  body
}

#let theme(
  uvod: [],
  body: [],
  zaver: [],
) = {

  [= Úvod]
  uvod
  
  body
  
  [== Závěr]
  zaver
  
  v(2em)
  line(length: 40%, stroke: 0.5pt + gray)
}
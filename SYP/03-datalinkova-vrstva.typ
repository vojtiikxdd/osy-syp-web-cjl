#import "../template.typ": header, theme

#show: body => header(
  title: "Data-linková vrstva, Ethernet a základní funkce a konfigurace switche",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Krátký úvod k tématu.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Nadpis kapitoly
    Text...
  ],
  summary: [
    Shrnutí.
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
  ],
)
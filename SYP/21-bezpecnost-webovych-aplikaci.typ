#import "../template.typ": header, theme

#show: body => header(
  title: "Bezpečnost webových aplikací",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Bezpečnost webových aplikací je klíčovým aspektem vývoje a provozu moderních webových služeb. S rostoucí závislostí na internetu a webových aplikacích se zvyšuje i riziko útoků a zneužití těchto aplikací. Bezpečnost webových aplikací zahrnuje širokou škálu opatření a technik, které mají za cíl chránit data, uživatele a infrastrukturu před různými hrozbami, jako jsou SQL injection, cross-site scripting (XSS), cross-site request forgery (CSRF) a další. Implementace bezpečnostních opatření je nezbytná pro zajištění důvěry uživatelů a ochranu citlivých informací.
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
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
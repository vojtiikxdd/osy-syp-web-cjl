#import "../template.typ": header, theme

#show: body => header(
  title: "Sociální inženýrství a sociální aspekty kybernetické bezpečnosti",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Sociální inženýrství je technika manipulace lidí s cílem získat důvěrné informace, přístup k systémům nebo provést neautorizované akce. V kontextu kybernetické bezpečnosti se sociální inženýrství zaměřuje na zneužití lidské psychologie a důvěry, aby útočník dosáhl svých cílů. Tento typ útoku může být velmi účinný, protože často obchází technické bezpečnostní opatření a spoléhá na lidskou chybu nebo nedostatek informací.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Nadpis kapitoly
    Text...
  ],
  summary: [
    
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
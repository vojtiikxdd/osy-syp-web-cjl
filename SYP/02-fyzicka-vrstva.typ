#import "../template.typ": header, theme

#show: body => header(
  title: "Fyzická vrstva, přenosová média a jejich vlastnosti",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Fyzická vrstva (Physical Layer) je nejnižší vrstva referenčního modelu OSI. Zajišťuje přenos jednotlivých bitů mezi zařízeními prostřednictvím fyzického média. Definuje elektrické, mechanické a funkční vlastnosti přenosu dat, například napětí, konektory, rychlosti přenosu a typy kabelů.
  ],
  body: [
    = Nadpis kapitoly
    Text...
  ],
  summary: [
    Fyzická vrstva a přenosová média tvoří základ každé počítačové sítě. Správná volba média závisí na požadavcích na rychlost, vzdálenost, cenu a odolnost proti rušení. Moderní sítě stále více využívají optická vlákna a bezdrátové technologie, zatímco metalické kabely zůstávají důležité především v lokálních sítích.
  ],
  resources: [
    - [Youtube - Fyzická vrstva](https://www.youtube.com/watch?v=ZScMXyQSFfo)
  ],
)
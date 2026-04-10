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
    #set heading(numbering: "1.1")

    = Typy běžně používaných přenosových - síťových médií:

    == Metalická (drátová) média

    Také známá jako metalické kabely, jsou nejběžnějším typem přenosového média v počítačových sítích. Patří sem:

    / Kroucená dvoulinka (Twisted Pair):

      - Typy: UTP, STP, FTP
      - Maximální délka: 100 m (pro Ethernet)
      - Konektor: RJ-45
    
    / Koaxiální kabel:
      
      - Maximální délka: cca 185 m (10BASE2), až 500 m (10BASE5)
      - Konektor: BNC

    == Optická média

    / Optické vlákno (Fiber Optic):
      / Typy:
        - Multimode (MM)
        - Singlemode (SM)
      / Maximální délka:
        - MM: stovky metrů až jednotky km
        - SM: desítky až stovky km
      / Konektory: SC, LC, ST
  ],
  summary: [
    Fyzická vrstva a přenosová média tvoří základ každé počítačové sítě. Správná volba média závisí na požadavcích na rychlost, vzdálenost, cenu a odolnost proti rušení. Moderní sítě stále více využívají optická vlákna a bezdrátové technologie, zatímco metalické kabely zůstávají důležité především v lokálních sítích.
  ],
  resources: [
    - [Youtube - Fyzická vrstva](https://www.youtube.com/watch?v=ZScMXyQSFfo)
  ],
)
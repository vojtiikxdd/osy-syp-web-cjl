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

    == Bezdrátová média

    / Wi-Fi (rádiové vlny):

      - Dosah: desítky metrů (v interiéru)
      - Frekvence: 2,4 GHz / 5 GHz / 6 GHz

    / Bluetooth:

      - Dosah: cca 10 m (běžně)

    / Mikrovlnné spoje:

      - Dosah: až desítky km (přímá viditelnost)

    / Satelitní komunikace:

      - Dosah: globální

    = Výhody, nevýhody a použití jednotlivých médií

    Každá kategorie přenosových médií má své specifické výhody, nevýhody a oblasti použití:

    #table(
      columns: (1.5fr, 2fr, 2fr, 2fr),
      inset: 8pt,
      align: left,
      fill: (col, row) => if row == 0 { navy } else if calc.odd(row) { luma(240) } else { white },

      table.header(
        text(fill: white, weight: "bold")[Médium],
        text(fill: white, weight: "bold")[Výhody],
        text(fill: white, weight: "bold")[Nevýhody],
        text(fill: white, weight: "bold")[Použití],
      ),

      [*Kroucená dvoulinka (UTP/STP)*],
      [- Nízká cena \ - Snadná instalace \ - Dostupnost],
      [- Náchylnost k rušení (UTP) \ - Omezená délka],
      [LAN sítě, kanceláře, domácnosti],

      [*Koaxiální kabel*],
      [- Lepší odolnost než UTP \ - Větší dosah než UTP],
      [- Horší flexibilita \ - Dnes zastaralý],
      [Starší Ethernet, kabelová TV],

      [*Optické vlákno*],
      [- Vysoká rychlost \ - Velká vzdálenost \ - Odolnost vůči rušení],
      [- Vyšší cena \ - Náročnější instalace],
      [Páteřní sítě, datová centra],

      [*Wi-Fi*],
      [- Mobilita \ - Jednoduché nasazení],
      [- Rušení \ - Nižší bezpečnost \ - Kolísání signálu],
      [Domácnosti, kanceláře, veřejné sítě],

      [*Bluetooth*],
      [- Nízká spotřeba \ - Jednoduché spojení],
      [- Krátký dosah \ - Nízká rychlost],
      [Sluchátka, periferie],
    )

  ],
  summary: [
    Fyzická vrstva a přenosová média tvoří základ každé počítačové sítě. Správná volba média závisí na požadavcích na rychlost, vzdálenost, cenu a odolnost proti rušení. Moderní sítě stále více využívají optická vlákna a bezdrátové technologie, zatímco metalické kabely zůstávají důležité především v lokálních sítích.
  ],
  resources: [
    - [Youtube - Fyzická vrstva](https://www.youtube.com/watch?v=ZScMXyQSFfo)
  ],
)

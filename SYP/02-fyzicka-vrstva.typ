#import "../template.typ": header, theme

#show: body => header(
  title: "Fyzická vrstva, přenosová média a jejich vlastnosti",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Fyzická vrstva (Physical Layer) je nejnižší vrstva referenčního modelu OSI. Zajišťuje přenos jednotlivých bitů mezi zařízeními prostřednictvím fyzického média. Definuje elektrické, mechanické a funkční vlastnosti přenosu dat, například napětí, konektory, rychlosti přenosu a typy kabelů.

    Fyzická vrstva neřeší kontrolu nad daty, ale pouze zajišťuje, že data jsou fyzicky přenášena mezi zařízeními. Jakákoliv data budou odeslány na fyzickou vrstvu, budou přenesena. Kontrolu nad daty a jejich správností zajišťují vyšší vrstvy, zejména datalinková vrstva, bez ní by mohly vznikat kolize a chyby v přenášených datech.

    #figure(
      image("../assets/kolize-mezi-daty.png"),
      caption: "Ukázka kolize mezi daty při přenosu bez kontroly",
    )
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

      #figure(
        image("../assets/kroucena-dvoulinka.jpg"),
        caption: "Kroucená dvoulinka (Twisted Pair)",
      )

    / Koaxiální kabel:

      - Maximální délka: cca 185 m (10BASE2), až 500 m (10BASE5)
      - Konektor: BNC

      #figure(
        image("../assets/koaxialni-kabel.jpg"),
        caption: "Koaxiální kabel (Coaxial Cable)",
      )

    == Optická média

    / Optické vlákno (Fiber Optic):
      / Typy:
        - Multimode (MM)
        - Singlemode (SM)

        #figure(
          image("../assets/opticke-vlakno.webp"),
          caption: "Optické vlákno (Fiber Optic)",
        )

      / Maximální délka:
        - MM: stovky metrů až jednotky km
        - SM: desítky až stovky km
      / Konektory:
        - SC, LC, ST

      #figure(
        image("../assets/opticke-vlakno-konektory.jpeg"),
        caption: "Optické vlákno s konektory (Fiber Optic Cable)",
      )

    == Bezdrátová média

    / Wi-Fi (rádiové vlny):

      - Dosah: desítky metrů (v interiéru)
      - Frekvence: 2,4 GHz / 5 GHz / 6 GHz

    / Bluetooth:

      - Dosah: cca 10 m (běžně)

    / Mikrovlnné spoje (Radioreléový spoj):

      - Dosah: až desítky km (přímá viditelnost)
      - Operuje s malým výkonem a vysokou frekvencí (1-80 GHz)

      #figure(
        image("../assets/mikrovlnne-spoje.jpg"),
        caption: "Mikrovlnný spoj (Microwave Link)",
      )

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

    = Zapojení UTP kabelu

    Existují dva základní standardy zapojení:

    / Přímý kabel (Straight-through):
      - Oba konce zapojeny stejně (T568A nebo T568B)
      - Použití:
        - PC ↔ switch
        - switch ↔ router

    / Křížený kabel (Crossover):
      - Jeden konec T568A, druhý T568B
      - Použití:
        - PC ↔ PC
        - switch ↔ switch (starší zařízení bez Auto-MDIX)

    = Vlivy okolního prostředí na přenos

    == Negativní vlivy

    / Elektromagnetické rušení (EMI):
      - Zdroje: elektrické motory, silová vedení, transformátory

    / Přeslech (Crosstalk):
      - Vzájemné ovlivňování vodičů uvnitř kabelu

    / Fyzické poškození:
      - Nadměrný ohyb nebo zlomení kabelu

    / Atmosférické vlivy:
      - Déšť, mlha — především u bezdrátových technologií

    / Teplota a vlhkost:
      - Ovlivňuje elektrické vlastnosti materiálů

    == Eliminace vlivů

    - Použití stíněných kabelů (STP, FTP)
    - Správné vedení kabeláže (dál od silových vodičů)
    - Použití optických vláken (odolné vůči EMI)
    - Kvalitní instalace a mechanická ochrana kabelů
    - Použití opakovačů (repeaters) nebo zesilovačů
    - Využití korekčních mechanismů (např. CRC)
  ],
  summary: [
    Fyzická vrstva a přenosová média tvoří základ každé počítačové sítě. Správná volba média závisí na požadavcích na rychlost, vzdálenost, cenu a odolnost proti rušení. Moderní sítě stále více využívají optická vlákna a bezdrátové technologie, zatímco metalické kabely zůstávají důležité především v lokálních sítích.
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=ZScMXyQSFfo")[Youtube - Fyzická vrstva]
  ],
)

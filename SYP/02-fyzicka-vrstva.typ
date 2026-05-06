#import "../template.typ": header, simple

#show: body => header(
  title: "Fyzická vrstva, přenosová média a jejich vlastnosti",
  author: "Vojtěch Razima",
  body,
)

#simple(
  body: [
    #set heading(numbering: "1.1")

    = Úvod do tématu

    Fyzická vrstva (Physical Layer) je nejnižší vrstva referenčního modelu OSI. Zajišťuje přenos jednotlivých bitů mezi zařízeními prostřednictvím fyzického média. Definuje elektrické, mechanické a funkční vlastnosti přenosu dat, například napětí, konektory, rychlosti přenosu a typy kabelů.

    Fyzická vrstva neřeší kontrolu nad daty, ale pouze zajišťuje, že data jsou fyzicky přenášena mezi zařízeními. Jakákoliv data budou odeslány na fyzickou vrstvu, budou přenesena. Kontrolu nad daty a jejich správností zajišťují vyšší vrstvy, zejména datalinková vrstva, bez ní by mohly vznikat kolize a chyby v přenášených datech.

    #figure(
      image("../assets/kolize-mezi-daty.png", width: 80%),
      caption: "Ukázka kolize mezi daty při přenosu bez kontroly",
    )

    = Typy běžně používaných přenosových - síťových médií:

    == Metalická (drátová) média

    Také známá jako metalické kabely, jsou nejběžnějším typem přenosového média v počítačových sítích. Patří sem:

    / Kroucená dvoulinka (Twisted Pair):

      - Typy: UTP, STP, FTP
      - Maximální délka: 100 m (pro Ethernet)
      - Konektor: RJ-45

      #figure(
        image("../assets/kroucena-dvoulinka.jpg", width: 70%),
        caption: "Kroucená dvoulinka (Twisted Pair)",
      )

    / Koaxiální kabel:

      - Maximální délka: cca 185 m (10BASE2), až 500 m (10BASE5)
      - Konektor: BNC

      #figure(
        image("../assets/koaxialni-kabel.jpg", width: 70%),
        caption: "Koaxiální kabel (Coaxial Cable)",
      )

    == Optická média

    / Optické vlákno (Fiber Optic):
      / Typy:
        - Multimode (MM)
        - Singlemode (SM)

        #figure(
          image("../assets/opticke-vlakno.webp", width: 80%),
          caption: "Optické vlákno (Fiber Optic)",
        )

      / Maximální délka:
        - MM: stovky metrů až jednotky km
        - SM: desítky až stovky km
      / Konektory:
        - SC, LC, ST

      #figure(
        image("../assets/opticke-vlakno-konektory.jpeg", width: 110%),
        caption: "Optické vlákno s konektory (Fiber Optic Cable)",
      )

    #pagebreak()

    == Bezdrátová přenosová média

    Jako fyzické médium využívají bezdrátové technologie elektromagnetické vlnění v nelicencovaných pásmech ISM (Industrial, Scientific, and Medical). Zatímco fyzická vrstva může být u různých zařízení identická (shodná frekvence), způsob řízení přístupu k médiu a formátování dat se zásadně liší podle použitého standardu.

    / Wi-Fi (Standard IEEE 802.11):
      
      Tento protokol je navržen pro vysokorychlostní datové přenosy v rámci lokálních sítí (WLAN). Operuje v pásmech 2,4 GHz, 5 GHz a moderně i 6 GHz. Z hlediska modelu TCP/IP zajišťuje komplexní správu síťového rozhraní, podporu více připojených uzlů současně a vysoký vysílací výkon pro dosah v řádu desítek metrů. Daňí za tyto schopnosti je vyšší režie protokolu (overhead) a značná energetická náročnost.

    / Proprietární RF rozhraní #footnote[RF - Radio Frequency] (Periferie):
      
      Bezdrátové periferie, jako jsou klávesnice a myši, využívají v pásmu 2,4 GHz specifické proprietární protokoly (WPAN), které se od Wi-Fi liší architekturou vrstvy síťového rozhraní.
      
      - *Energetická optimalizace:* Protokoly jsou navrženy pro extrémně nízkou spotřebu a minimální latenci při přenosu malých objemů dat (např. kódy stisknutých kláves).
      
      - *Mechanismus AFH (Adaptive Frequency Hopping):* Zařízení dynamicky mění komunikační kanály v rámci pásma, aby eliminovala kolize s širokopásmovými signály Wi-Fi.
      
      - *Interference:* Při vysokém vytížení pásma 2,4 GHz (např. intenzivní stahování dat přes Wi-Fi) může dojít k zahlcení fyzického média, což vede k zahození rámců periferie a projevuje se jako zpoždění (lag) nebo výpadky vstupu.

    / Bluetooth:

      - Zvládne i přenos souborů a médií, ale primárně pro připojení periferií (sluchátka, klávesnice)
      - Dosah: cca 10 m (běžně)

    / Mikrovlnné spoje (Radioreléový spoj):

      - Dosah: až desítky km (přímá viditelnost)
      - Operuje s malým výkonem a vysokou frekvencí (1-80 GHz)

      #figure(
        image("../assets/mikrovlnne-spoje.jpg", width: 80%),
        caption: "Mikrovlnný spoj (Microwave Link)",
      )

    / Satelitní komunikace:

      - Dosah: globální

    #pagebreak()

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
      [Sluchátka, hodinky, reproduktory, ostatní periferie],
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

    #pagebreak()

    = Vlivy okolního prostředí na přenos

    Každé médium má svoje slabiny

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
  resources: [
    - #link("https://www.youtube.com/watch?v=ZScMXyQSFfo")[Youtube - Fyzická vrstva]
  ],
)

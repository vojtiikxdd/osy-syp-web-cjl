#import "../template.typ": header, theme

#show: body => header(
  title: "Fyzická vrstva, přenosová média a jejich vlastnosti",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    Fyzická vrstva (Physical Layer) je nejnižší vrstva referenčního modelu OSI. Zajišťuje *přenos jednotlivých bitů mezi zařízeními prostřednictvím fyzického média*. Definuje elektrické, mechanické a funkční vlastnosti přenosu dat, například napětí, konektory, rychlosti přenosu a typy kabelů.

    Fyzická vrstva neřeší kontrolu nad daty, ale pouze zajišťuje, že data jsou fyzicky přenášena mezi zařízeními. *Jakákoliv data budou odeslány na fyzickou vrstvu, budou přenesena*. *Kontrolu nad daty* a jejich správností zajišťují vyšší vrstvy, zejména *datalinková vrstva*, bez ní by mohly vznikat kolize a chyby v přenášených datech.

    / Dělíme ji na tři části:
      - *Drátová média* (metalická) – kroucená dvoulinka, koaxiální kabel
      - *Optická média* – optické vlákno
      - *Bezdrátová média* – Wi-Fi, Bluetooth, mikrovlnné spoje, satelitní komunikace

    #v(2em)
    #figure(
      image("../assets/kolize-mezi-daty.png", width: 70%),
      caption: "Ukázka kolize mezi daty při přenosu bez kontroly",
    )

    #set heading(numbering: "1.1")

    = Typy běžně používaných přenosových - síťových médií: <typy-medii>

    == Metalická (drátová) média

    Také známá jako metalické kabely, jsou nejběžnějším typem přenosového média v počítačových sítích. 

    / Patří sem:

      === Kroucená dvoulinka (Twisted Pair): <utp-zapojeni>

      - Vodiče jsou stáčeny do párů pro eliminaci přeslechu (crosstalk) a elektromagnetického rušení.
      - Typy: *UTP* (Unshielded – nestíněný), *STP* (Shielded – stíněný), *FTP* (Foiled – stíněný fólií)
      - Zároveň jsou také dva druhy zapojení: *Přímý* (Straight-through) a *Křížený* (Crossover), které se používají pro různé typy spojení mezi zařízeními.
        - _Křížený kabel se dnes už nevyužívá díky technologii Auto-MDIX, která umožňuje automatickou detekci typu kabelu a přizpůsobení portů._
      - Zpratka *\_TP* znamená _"Twisted Pair"_
      - Maximální délka: 100 m (pro Ethernet)
      - Konektor: RJ-45

      #figure(
        image("../assets/draty-kroucene-dvoulinky.png"),
        caption: "Kroucená dvoulinka (Twisted Pair)",
      )

      / *Kategorie kabelů*:
        - *Cat5e* – rychlost 1 Gbps na 100 m; frekvence 100 MHz (dnešní základní standard)
        - *Cat6* – rychlost 10 Gbps na cca 55 m; frekvence 250 MHz (hustší kroucení a plastový kříž proti přeslechu)
        - *Cat6a* – rychlost 10 Gbps na 100 m; frekvence 500 MHz (tlustší, tvrdší izolace, většinou stíněná verze STP/FTP)
        - *Cat7* – rychlost 10 Gbps; frekvence 600 MHz (vždy přísně stíněný; prémiový kabel)

      #figure(
        image("../assets/UTP-FTP-STP.jpg", width: 80%),
        caption: "Porovnání UTP, FTP a STP kabelů",
      )

      === Koaxiální kabel:

      - Maximální délka: cca 185 m (10BASE2), až 500 m (10BASE5)
      - Konektor: BNC

      #figure(
        image("../assets/koaxialni-kabel.jpg", width: 40%),
        caption: "Koaxiální kabel (Coaxial Cable)s konektorem BNC",
      )
    
    Jiné běžně používané kabely, jako třeba HDMI, USB, Thunderbolt, jsou určeny pro specifické účely (přenos videa, dat mezi počítačem a periferií) a nejsou primárně navrženy pro síťovou komunikaci, i když mohou být využity pro přenos dat v rámci lokální sítě (např. USB Ethernet adaptér). Do sítě se však běžně nepoužívají a proto se o nich v rámci tématu fyzické vrstvy nebudeme dále zmiňovat. 

    == Optická média

    / Optické vlákno (Fiber Optic):
      / Typy:
        - *Multimode (MM)* – jako zdroj světla využívá LED diody, šíří se více paprsků, dochází k vnitřním odrazům (což může vést k rozmazání signálu na delší vzdálenosti)
        - *Singlemode (SM)* – jako zdroj světla využívá úzký laser, paprsek se šíří rovně téměř bez odrazů
        
      / Maximální délka:
        - MM: stovky metrů až jednotky km
        - SM: desítky až stovky km
        
      #figure(
        image("../assets/opticke-vlakno.webp", width: 80%),
        caption: "Optické vlákno (Fiber Optic)",
      )

      / Konektory:
        - SC, LC, ST

      #figure(
        image("../assets/opticke-vlakno-konektory.jpeg", width: 110%),
        caption: "Optické vlákno s konektory (Fiber Optic Cable)",
      )

    == Bezdrátová přenosová média

    Jako fyzické médium využívají bezdrátové technologie *elektromagnetické vlnění v nelicencovaných pásmech ISM* (Industrial, Scientific, and Medical). Zatímco fyzická vrstva může být u různých zařízení identická (shodná frekvence), způsob řízení přístupu k médiu a formátování dat se zásadně liší podle použitého standardu.

    #pagebreak()

    === Wi-Fi (Standard IEEE 802.11):
      
    - Tento protokol je navržen pro vysokorychlostní datové přenosy v rámci lokálních sítí (WLAN). Operuje v pásmech 2,4 GHz, 5 GHz a moderně i 6 GHz. Z hlediska modelu TCP/IP zajišťuje komplexní správu síťového rozhraní, podporu více připojených uzlů současně a vysoký vysílací výkon pro dosah v řádu desítek metrů. Daňí za tyto schopnosti je vyšší režie protokolu (overhead) a značná energetická náročnost.

    === Proprietární RF rozhraní #footnote[RF - Radio Frequency] (Periferie):
      
    - Bezdrátové periferie, jako jsou klávesnice a myši, využívají v pásmu 2,4 GHz specifické proprietární protokoly (WPAN), které se od Wi-Fi liší architekturou vrstvy síťového rozhraní.
    - *Energetická optimalizace:* Protokoly jsou navrženy pro extrémně nízkou spotřebu a minimální latenci při přenosu malých objemů dat (např. kódy stisknutých kláves).
    - *Mechanismus AFH (Adaptive Frequency Hopping):* Zařízení dynamicky mění komunikační kanály v rámci pásma, aby eliminovala kolize s širokopásmovými signály Wi-Fi.
    - *Interference:* Při vysokém vytížení pásma 2,4 GHz (např. intenzivní stahování dat přes Wi-Fi) může dojít k zahlcení fyzického média, což vede k zahození rámců periferie a projevuje se jako zpoždění (lag) nebo výpadky vstupu.

    === Bluetooth:

    - Zvládne i přenos souborů a médií, ale primárně pro připojení periferií (sluchátka, klávesnice)
    - Dosah: cca 10 m (běžně), někdy až 50 m

    / Bluetooth Low Energy (BLE):
      - Optimalizace pro nízkou spotřebu energie, vhodné pro IoT zařízení
      - Dosah: až 300 m (v závislosti na prostředí)

    === Mikrovlnné spoje (Radioreléový spoj):

    - Dosah: až desítky km (přímá viditelnost)
    - Operuje s malým výkonem a vysokou frekvencí (1-80 GHz)

    #figure(
      image("../assets/mikrovlnne-spoje.jpg", width: 80%),
      caption: "Mikrovlnný spoj (Microwave Link)",
    )

    === Satelitní komunikace:

    - Dosah: globální
    
    / Klíčové oblasti využití:

      / Globální navigace (GNSS):
      
        - *Princip:* Satelity neustále vysílají přesný čas a svou polohu. Přijímač na Zemi (mobil, auto) zachytí signál z minimálně 4 satelitů a matematicky dopočítá svou přesnou polohu.
        
      / *Globální systémy*:
        - *GPS* (USA) – nejrozšířenější systém.
        - *Galileo* (Evropská unie) – civilní, vysoce přesný systém.
        - *GLONASS* (Rusko), *BeiDou* (Čína).

      / Satelitní internet (Širokopásmové připojení):
        - *Staré GEO systémy:* Satelity na geostacionární dráze (36 000 km) — vysoká latence (odezva), pomalé, ale velké pokrytí jedním satelitem.
        - *Moderní LEO konstelace (Starlink, OneWeb):* Tisíce malých družic na nízké oběžné dráze (cca 500–1200 km). Nabízejí *nízkou latenci* a vysoké rychlosti srovnatelné s pozemním připojením.
        - *Využití:* Odlehlé oblasti, doprava (letadla, zaoceánské lodě), armáda a záchranné složky.

      / Satelitní telefonování a nouzová komunikace:
        - Nezávislé na pozemních vysílačích (BTS). Funguje i při totálním výpadku infrastruktury na Zemi (blackout, zemětřesení).
        - *Sítě:* Iridium, Inmarsat, Thuraya.
        - *Komerční smartphony:* Moderní telefony již obsahují čipy pro nouzové SOS zprávy přímo přes satelity v místech bez běžného signálu.

      / Televizní a rozhlasové vysílání (Sat-TV):
        - Využívá geostacionární dráhu (GEO) – satelit "stojí" stále nad stejným místem na Zemi.
        - Šíření signálu stylem *Point-to-Multipoint* (jeden vysílač pokryje celý kontinent). Uživatel na Zemi potřebuje pouze parabolu nasměrovanou na konkrétní pozici (např. Skylink).

      / Pozorování Země a meteorologie:
        - Snímkování atmosféry, sledování pohybu mraků, formování hurikánů a předpověď počasí.
        - Monitorování klimatických změn (tání ledovců, lesní požáry, nelegální kácení, úniky ropy).

    #pagebreak()

    *Srovnání oběžných drah družic*

    #table(
      columns: (1.5fr, 1.5fr, 2.5fr, 2.5fr),
      align: (left, center, left, left),
      [*Typ dráhy*], [*Výška (cca)*], [*Výhody*], [*Nevýhody / Využití*],
      [LEO \ (Low Earth Orbit)], [500 – 1 500 km], [- Nízká latence \ - Vyšší rychlosti], [- Nutnost tisíců družic \ - Internet (Starlink)],
      [MEO \ (Medium Earth Orbit)], [5 000 – 20 000 km], [- Dobrý kompromis pokrytí a zpoždění], [- Navigační družice \ - (GPS, Galileo)],
      [GEO \ (Geostationary Orbit)], [35 786 km], [- Satelit je fixní vůči Zemi \ - Stačí málo družic], [- Vysoká latence \ - TV vysílání],
    )

    = Výhody, nevýhody a použití jednotlivých médií <vyhody-nevyhody-pouziti>

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

    Existují dva základní standardy zapojení: T568A a T568B.

    / Přímý kabel (Straight-through):
      - Oba konce zapojeny stejně (T568A nebo T568B)
      - Použití:
        - PC ↔ switch
        - switch ↔ router

    / Křížený kabel (Crossover):
      - Jeden konec T568A, druhý T568B
      - Dnes se využívá technologie *Auto-MDIX*, která dokáže automaticky detekovat typ kabelu a elektronicky porty uvnitř zařízení překřížit podle potřeby.
      - Použití:
        - PC ↔ PC
        - switch ↔ switch (u starších zařízení bez Auto-MDIX)

    = Vlivy okolního prostředí na přenos <vlivy-okolniho-prostredi>

    Každé médium má svoje slabiny.

    == Negativní vlivy

    / Elektromagnetické rušení (EMI):
      - Zdroje: elektrické motory, silová vedení, transformátory

    / Přeslech (Crosstalk):
      - Vzájemné ovlivňování vodičů uvnitř kabelu

    / Útlum (Attenuation):
      - Postupné slábnutí signálu se vzrůstající vzdáleností na médiu

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
    - Použití opakovačů (repeaters) nebo zesilovačů pro řešení útlumu
    - Využití korekčních mechanismů (např. CRC)

  ],
  subquestions: [

    == Vyjmenujte všechny typy běžně používaných síťových medií a zařaďte je do kategorií, uveďte maximální délky pasivního segmentu nebo komunikační vzdálenosti a používané konektory 

    @typy-medii

    === Typy médií:
    
      - Drátová (metalická): Kroucená dvoulinka (UTP, STP), Koaxiální kabel
      - Optická: Optické vlákno (Multimode, Singlemode)
      - Bezdrátová: Wi-Fi, Bluetooth, Mikrovlnné spoje, Satelitní komunikace
    
    === Maximální délky / vzdálenosti:
    
    #v(0.8em)

    / Metalická média:
      - Kroucená dvoulinka: 100 m (Ethernet)
      - Koaxiální kabel: 185 m (10BASE2), 500 m (10BASE5)

    / Optická média:
      - Multimode: stovky metrů až jednotky km
      - Singlemode: desítky až stovky km

    / Bezdrátová média:
      - Wi-Fi: desítky metrů
      - Bluetooth: cca 10 m (běžně), až 50 m
      - Mikrovlnné spoje: až desítky km (přímá viditelnost)
      - Satelitní komunikace: globální
    
    === Používané konektory:

    / Metalická média:
      - Kroucená dvoulinka: RJ-45
      - Koaxiální kabel: BNC

    / Optická média:
      - SC, LC, ST

    / Bezdrátová média:
      - Nemají fyzické konektory, komunikace probíhá vzduchem

    == U jednotlivých medií uveďte jejich výhody a nevýhody, příklady použití

    @vyhody-nevyhody-pouziti

    === Kroucená dvoulinka (UTP/STP):
      - Výhody: Nízká cena, snadná instalace, dostupnost
      - Nevýhody: Náchylnost k rušení (UTP), omezená délka
      - Použití: LAN sítě, kanceláře, domácnosti

    === Koaxiální kabel:
      - Výhody: Lepší odolnost než UTP, větší dosah než UTP
      - Nevýhody: Horší flexibilita, dnes zastaralý a méně používaný
      - Použití: Starší Ethernet, *kabelová TV*

    === Optické vlákno:
      - Výhody: Vysoká rychlost, velká vzdálenost, odolnost vůči rušení
      - Nevýhody: Vyšší cena, náročnější instalace
      - Použití: Páteřní sítě, datová centra

    === Wi-Fi:
      - Výhody: Mobilita, jednoduché nasazení
      - Nevýhody: Rušení, nižší bezpečnost, kolísání signálu
      - Použití: Domácnosti, kanceláře, veřejné sítě

    === Bluetooth:
      - Výhody: Nízká spotřeba, jednoduché spojení
      - Nevýhody: Krátký dosah, nízká rychlost
      - Použití: Sluchátka, hodinky, reproduktory, ostatní periferie

    == U UTP kabelu uveďte nebo nakreslete možné způsoby zapojení a kde se využívají
    
    @utp-zapojeni

    Dnes už je jedno jaký kabel se využívá, protože technologie Auto-MDIX umožňuje automatickou detekci typu kabelu a přizpůsobení portů uvnitř zařízení. Nicméně, pro úplnost:

    / Přímý kabel (Straight-through):
      - Oba konce zapojeny stejně (T568A nebo T568B)
      - Použití:
        - PC ↔ switch
        - switch ↔ router

    / Křížený kabel (Crossover):
      - Jeden konec T568A, druhý T568B
      - Použití:
        - PC ↔ PC
        - switch ↔ switch (u starších zařízení bez Auto-MDIX)

    #figure(
      image("../assets/utp-krizeny-primy.jpg"),
      caption: "Přímé a křížené zapojení UTP kabelu",
    )

    #figure(
      image("../assets/krizena-kroucena-dvoulinka-zapojeni.png"),
      caption: "Ukázka zapojení křížené kroucené dvoulinky (Crossover)",
    )

    == Na některá síťová média negativně působí okolní vlivy, uveďte, které to jsou a jak se dá jejich vliv na přenos dat eliminovat

    @vlivy-okolniho-prostredi

    === Negativní vlivy

    / Elektromagnetické rušení (EMI):
      - Zdroje: elektrické motory, silová vedení, transformátory

    / Přeslech (Crosstalk):
      - Vzájemné ovlivňování vodičů uvnitř kabelu

    / Útlum (Attenuation):
      - Postupné slábnutí signálu se vzrůstající vzdáleností na médiu

    / Fyzické poškození:
      - Nadměrný ohyb nebo zlomení kabelu

    / Atmosférické vlivy:
      - Déšť, mlha — především u bezdrátových technologií

    / Teplota a vlhkost:
      - Ovlivňuje elektrické vlastnosti materiálů

    === Eliminace vlivů

    - Použití stíněných kabelů (STP, FTP)
    - Správné vedení kabeláže (dál od silových vodičů)
    - Použití optických vláken (odolné vůči EMI)
    - Kvalitní instalace a mechanická ochrana kabelů
    - Použití opakovačů (repeaters) nebo zesilovačů pro řešení útlumu
    - Využití korekčních mechanismů (např. CRC)

  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=ZScMXyQSFfo")[Youtube - Fyzická vrstva]
  ],
)
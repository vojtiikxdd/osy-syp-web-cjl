#import "../template.typ": header, theme

#show: body => header(
  title: "ISO/OSI a TCP/IP, protokoly a modely",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    ISO/OSI (International Organization for Standardization / Open Systems Interconnection) je referenční model pro síťovou komunikaci, který byl vyvinut v 80. letech 20. století. Tento model rozděluje síťovou komunikaci do sedmi vrstev, z nichž každá má specifické funkce a odpovědnosti. Plní funkci jako standard pro návrh a implementaci síťových protokolů, což umožňuje interoperabilitu mezi různými systémy a zařízeními.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Důvod použití vrstevnatých modelů

    Vrstevnaté modely v počítačových sítích slouží k rozdělení složité komunikace na menší, přehledné části (vrstvy). Každá vrstva má přesně definovanou funkci a komunikuje pouze se sousedními vrstvami.

    == Hlavní důvody použití:

    - Zjednodušení návrhu a správy sítí

    - Standardizace komunikace

    - Možnost vývoje nezávislých technologií

    - Snazší diagnostika chyb

    - Kompatibilita mezi různými zařízeními a systémy

    = Porovnání modelů ISO-OSI a TCP/IP

    == ISO-OSI model (7 vrstev):

    1. Fyzická

    2. Linková

    3. Síťová

    4. Transportní

    5. Relační

    6. Prezentační

    7. Aplikační

    == TCP/IP model (4 vrstvy):

    1. Síťové rozhraní (Network Access)

    2. Internetová vrstva

    3. Transportní vrstva

    4. Aplikační vrstva

    == Porovnání:

    #figure(
      image("../assets/ISO-OSI-TCP-IP.jpg"),
      caption: "Model ISO/OSI v porovnání s TCP/IP v češtině a v angličtině",
    )

    1. Fyzická vrstva (Physical Layer): Zajišťuje přenos bitů přes fyzické médium, jako jsou kabely nebo bezdrátové signály. Definuje elektrické, mechanické a funkční vlastnosti přenosového média.

    2. Linková vrstva (Data Link Layer): Zajišťuje spolehlivý přenos dat mezi dvěma zařízeními na stejné síti. Řeší problémy jako detekce a oprava chyb, řízení toku a adresování na úrovni linky.

    3. Síťová vrstva (Network Layer): Zajišťuje směrování dat mezi různými sítěmi a zařízeními. Řeší problémy jako adresování, směrování a fragmentace datových paketů.

    4. Transportní vrstva (Transport Layer): Zajišťuje spolehlivý přenos dat mezi koncovými body komunikace. Řeší problémy jako řízení toku, detekce a oprava chyb a segmentace dat.

    5. Relační vrstva (Session Layer): Zajišťuje správu relací mezi aplikacemi, umožňuje synchronizaci a koordinaci komunikace mezi nimi.

    6. Prezentační vrstva (Presentation Layer): Zajišťuje převod dat do formátu, který může být pochopen aplikací. Řeší problémy jako kódování, komprese a šifrování dat.

    7. Aplikační vrstva (Application Layer): Poskytuje rozhraní pro uživatele a aplikace k přístupu ke službám sítě. Zahrnuje protokoly jako HTTP, FTP, SMTP a další.
  ],
  summary: [
    Model ISO/OSI je důležitým konceptem v oblasti počítačových sítí, protože poskytuje strukturovaný rámec pro pochopení a návrh síťových protokolů. I když se v praxi často používají jiné modely (například TCP/IP), ISO/OSI zůstává klíčovým referenčním modelem pro výuku a porozumění síťové komunikaci.
  ],
  resources: [
    - [YouTube: Základy fungování sítí](https://www.youtube.com/watch?v=036dn5OSlvA)
  ]
)

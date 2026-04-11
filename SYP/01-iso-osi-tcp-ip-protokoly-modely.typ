#import "../template.typ": header, theme

#show: body => header(
  title: "ISO/OSI a TCP/IP, protokoly a modely",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    ISO/OSI (International Organization for Standardization / Open Systems Interconnection) je referenční model pro síťovou komunikaci, který byl vyvinut v 80. letech 20. století. Tento model rozděluje síťovou komunikaci do sedmi vrstev, z nichž každá má specifické funkce a odpovědnosti. Plní funkci jako standard pro návrh a implementaci síťových protokolů, což umožňuje interoperabilitu mezi různými systémy a zařízeními.

    ISO/OSI lze přirovnat ke komunikaci mezi lidmi. Data, která chce komunikační zařízení poslat, jsou podle modelu TCP/IP zabalena do paketů, které procházejí různými vrstvami. Každá vrstva přidává své vlastní informace a funkce, aby zajistila správný přenos dat od odesílatele k příjemci.
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

    7. Aplikační vrstva (Application Layer)

      - Poskytuje rozhraní pro uživatele a aplikace k přístupu ke službám sítě
      - Zahrnuje protokoly jako HTTP, FTP, SMTP a další

    6. Linková vrstva (Data Link Layer)

      - Zajišťuje spolehlivý přenos dat mezi dvěma zařízeními na stejné síti
      - Řeší problémy jako detekce a oprava chyb, řízení toku a adresování na úrovni linky

    5. Síťová vrstva (Network Layer)

      - Zajišťuje směrování dat mezi různými sítěmi a zařízeními
      - Řeší problémy jako adresování, směrování a fragmentace datových paketů

    4. Transportní vrstva (Transport Layer)

      - Zajišťuje spolehlivý přenos dat mezi koncovými body komunikace
      - Řeší problémy jako řízení toku, detekce a oprava chyb a segmentace dat

    3. Relační vrstva (Session Layer)

      - Zajišťuje správu relací mezi aplikacemi
      - Umožňuje synchronizaci a koordinaci komunikace mezi nimi

    2. Prezentační vrstva (Presentation Layer)

      - Zajišťuje převod dat do formátu, který může být pochopen aplikací
      - Řeší problémy jako kódování, komprese a šifrování dat

    1. Fyzická vrstva (Physical Layer)

      - Zajišťuje přenos bitů přes fyzické médium, jako jsou kabely nebo bezdrátové signály
      - Definuje elektrické, mechanické a funkční vlastnosti přenosového média.

    == TCP/IP model (4 vrstvy):

    4. Aplikační vrstva (Application Layer)
      - Slučuje původní vrstvy: aplikační, prezentační a relační.
      - Poskytuje protokoly pro konkrétní služby (HTTP, FTP, SMTP, DNS).
      - Zajišťuje kódování, kompresi a správu relací přímo v aplikaci.

    3. Transportní vrstva (Transport Layer)
      - Odpovídá stejnojmenné vrstvě v ISO/OSI.
      - Zajišťuje přenos dat mezi procesy na koncových uzlech.
      - Hlavní protokoly: TCP (spolehlivý, s navázáním spojení) a UDP (rychlý, nespolehlivý).

    2. Síťová vrstva (Internet Layer)
      - Odpovídá síťové vrstvě v ISO/OSI.
      - Zajišťuje adresaci a směrování paketů napříč sítěmi (IP adresy).
      - Hlavní protokol: IP (IPv4, IPv6), ICMP, ARP.

    1. Vrstva síťového rozhraní (Network Access Layer)
      - Slučuje původní linkovou a fyzickou vrstvu.
      - Zajišťuje fyzický přenos dat přes konkrétní médium (Ethernet, Wi-Fi).
      - Řeší hardwarové adresy (MAC) a mechanické vlastnosti kabelů/signálů.

    == Porovnání:

    #figure(
      image("../assets/ISO-OSI-TCP-IP.jpg"),
      caption: "Model ISO/OSI v porovnání s TCP/IP v češtině a v angličtině",
    )

    = Průběh zapouzdření dat:

    / Aplikační vrstva:

      - Data vytvořená aplikací
      - Název: Data
      - Jedná se například o obsah webové stránky, e-mail nebo soubor, který chceme přenést.
    
    / Transportní vrstva:
    
      - Přidání TCP/UDP hlavičky
      - Název: Segment (TCP) / Datagram (UDP)
      - Tato vrstva rozdělí data na menší části (segmenty nebo datagramy) 
        - každý má maximálně 1,5 KB pro TCP a asi 65 KB pro UDP - a přidá informace potřebné pro správný přenos, jako jsou porty a čísla sekvencí (transportní hlavička).
    
    / Internetová vrstva:
    
      - Přidání IP hlavičky
      - Název: Paket (Packet)
    
    / Linková vrstva:
    
      - Přidání MAC adres (hlavička a patička)
      - Název: Rámec (Frame)
    
    / Fyzická vrstva:
    
      - Převod na elektrické/optické signály
      - Název: Bity (Bits)

    Při příjmu dat se tento proces obrací: bity jsou převáděny zpět na rámce, pak na pakety, segmenty/datagramy a nakonec na data pro aplikaci.

    = Protokoly modelu TCP/IP

    / Aplikační vrstva:

      - HTTP – přenos webových stránek
      - HTTPS – zabezpečený HTTP
      - FTP – přenos souborů
      - SMTP – odesílání e-mailů
      - DNS – překlad domén na IP adresy

    / Transportní vrstva:

      - TCP – spolehlivý přenos (kontrola chyb, pořadí)
      - UDP – rychlý, bez záruky doručení

    / Internetová vrstva:

      - IP – adresace zařízení
      - ICMP – diagnostika (např. ping)

    / ARP:
      - překlad IP na MAC adresu

    / Síťové rozhraní:

      - Ethernet – přenos v lokální síti
      - Wi-Fi – bezdrátová komunikace

    = Broadcast, Multicast, Unicast

    / Unicast:
      
      - komunikace 1 → 1 (např. načtení webu)
    
    / Broadcast:
      
      - komunikace 1 → všichni v síti
    
    / Multicast:
      
      - komunikace 1 → skupina zařízení

    = IP adresy

    IP adresy se používají na:

      - Internetové (síťové) vrstvě

    = Zjištění IP adresy počítače
    
    Windows:

    ```bash
    c:\> ipconfig
    ```
    
    Linux:

    ```bash
    $ ip a
    ```
    
    Výstup obsahuje:
    
    - IPv4 adresu
    - IPv6 adresu
    - Masku sítě
    - Výchozí bránu
  ],
  summary: [
    Model ISO/OSI je důležitým konceptem v oblasti počítačových sítí, protože poskytuje strukturovaný rámec pro pochopení a návrh síťových protokolů. I když se v praxi často používají jiné modely (například TCP/IP), ISO/OSI zůstává klíčovým referenčním modelem pro výuku a porozumění síťové komunikaci.
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=036dn5OSlvA")[YouTube: Základy fungování sítí]

    - #link("https://www.youtube.com/watch?v=3b_TAYtzuho")[YouTube: ISO and TCP/IP models - best explanation]
  ]
)

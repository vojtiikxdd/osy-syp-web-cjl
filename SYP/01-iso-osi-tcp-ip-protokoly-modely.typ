#import "../template.typ": header, theme;

#show: body => header(
  title: "ISO/OSI a TCP/IP, protokoly a modely",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    *ISO/OSI* (International Organization for Standardization / Open Systems Interconnection) je *referenční model* #footnote[Referenční model je teoretický rámec pro pochopení a návrh síťových systémů] pro síťovou komunikaci, který byl vyvinut v 80. letech 20. století. Tento model *rozděluje síťovou komunikaci do sedmi vrstev*, z nichž každá má specifické funkce a odpovědnosti. Plní funkci jako standard pro návrh a implementaci síťových protokolů, což umožňuje interoperabilitu mezi různými systémy a zařízeními. *Jednotlivé vrstvy komunikují pouze s vedlejšími vrstvami*.

    *TCP/IP je implementace teoretického modelu ISO/OSI*, která se stala základem pro moderní internet. TCP/IP model má *pouze čtyři vrstvy, které jsou zjednodušenou verzí vrstev ISO/OSI*, ale stále zachovávají klíčové funkce pro komunikaci v síti. *TCP/IP model nebyl jedniný co vznikl*, ale díky vzniku internetu stal se dominantním standardem pro síťovou komunikaci a byl tak přijat ve většině moderních sítí.

    ISO/OSI lze přirovnat ke komunikaci mezi lidmi. Začne to myšlenkou, zprocesování a korekci zprávy, vyslovení a předání zprávy řečí a zpátečně přijetí zprávy sluchem, dekódování zprávy a nakonec pochopení zprávy. Stejně to funguje i u ISO/OSI nebo TCP/IP. Data, která chce komunikační zařízení poslat (např. webový dotaz na novou stránku), Jde to od kliknutí na nějaké webové stránce, přes proces v počítači, zabalení do paketu s nutnými informacemi k přenosu, poslání do routeru až k serveru, který dotaz zpětně zpracuje obrácenou cestou, jakou byla zpráva/dotaz zpracován/a. Každá vrstva přidává své vlastní informace a funkce, aby zajistila správný přenos dat od odesílatele k příjemci.

    TCP/IP *není pouze softwarová záležitost*, ale zahrnuje *i hardwarové* aspekty, jako jsou kabely, konektory a fyzické přenosové médium, ikdyž je software velkou součástí tohoto modelu.

    = Důvod použití vrstevnatých modelů

    Vrstevnaté modely v počítačových sítích slouží k rozdělení složité komunikace na menší, přehledné části (vrstvy). Každá vrstva má přesně definovanou funkci a komunikuje pouze se sousedními vrstvami.

    == Hlavní důvody použití:

    - Zjednodušení návrhu a správy sítí

    - Standardizace komunikace

    - Možnost vývoje nezávislých technologií

    - Snazší diagnostika chyb

    - Kompatibilita mezi různými zařízeními a systémy

    #pagebreak()

    = Porovnání modelů ISO-OSI a TCP/IP

    == ISO-OSI model (7 vrstev):

    7. *Aplikační vrstva* (Application Layer)

      - Poskytuje *rozhraní pro uživatele a aplikace* k přístupu ke službám sítě
      - Zahrnuje protokoly jako *HTTP*, *FTP*, *SMTP* a další

    6. *Prezentační vrstva* (Presentation Layer)

      - Zajišťuje převod dat do formátu, který může být pochopen aplikací
      - Řeší problémy jako kódování, komprese a šifrování dat

    5. *Relační vrstva* (Session Layer)

      - Zajišťuje správu relací mezi aplikacemi
      - Umožňuje synchronizaci a koordinaci komunikace mezi nimi 

    4. *Transportní vrstva* (Transport Layer)

      - Zajišťuje spolehlivý přenos dat mezi koncovými body komunikace
      - Řeší problémy jako řízení toku, detekce a oprava chyb a segmentace dat

    3. *Síťová vrstva* (Network Layer)

      - Zajišťuje směrování dat mezi různými sítěmi a zařízeními
      - Řeší problémy jako adresování, směrování a fragmentace datových paketů

    2. *Linková (_spojová_) vrstva* (Data Link Layer)

      - Zajišťuje spolehlivý *přenos dat mezi dvěma zařízeními na stejné síti*
      - Řeší problémy jako *detekce a oprava chyb*, řízení toku a adresování na úrovni linky

    1. *Fyzická vrstva* (Physical Layer)

      - Zajišťuje přenos bitů přes fyzické médium, jako jsou kabely nebo bezdrátové signály
      - Definuje elektrické, mechanické a funkční vlastnosti přenosového média.

    == TCP/IP model (4 vrstvy):

    4. *Aplikační vrstva* (Application Layer)
      - Slučuje původní vrstvy: *aplikační, prezentační a relační*.
      - Poskytuje protokoly pro konkrétní služby (*HTTP*, *HTTPS*, *FTP*, *SMTP*, *DNS*).
      - Zajišťuje kódování, kompresi a správu relací přímo v aplikaci.

    3. *Transportní vrstva* (Transport Layer)
      - *Odpovídá stejnojmenné vrstvě v ISO/OSI*.
      - Zastupuje *_TCP_* v názvu modelu.
      - Zajišťuje přenos dat mezi procesy na koncových uzlech.
      / Hlavní protokoly: 
        - TCP
          - *spolehlivý*, s navázáním spojení 
        - UDP 
          - *rychlý*, *nespolehlivý*.

    2. *Síťová vrstva* (Internet Layer)
      - *Odpovídá síťové vrstvě v ISO/OSI*.
      - Zastupuje *_IP_* v názvu modelu.
      - Zajišťuje adresaci a směrování paketů napříč sítěmi (IP adresy).
      - Hlavní protokol: IP (*IPv4*, *IPv6*), *ICMP*, *ARP*.

    1. *Vrstva síťového rozhraní* (Network Access Layer)
      - *Slučuje původní linkovou a fyzickou vrstvu*.
      - Zajišťuje spolehlivý fyzický přenos dat přes konkrétní médium (Ethernet, Wi-Fi).
      - Řeší hardwarové adresy (MAC) a mechanické vlastnosti kabelů/signálů.

    == Porovnání:

    #figure(
      image("../assets/ISO-OSI-TCP-IP.jpg"),
      caption: "Model ISO/OSI v porovnání s TCP/IP v češtině a v angličtině",
    )

    = Průběh zapouzdření dat:

    / Aplikační vrstva:

      - Data vytvořená aplikací
      - Název: *Data*
      - Jedná se například o obsah webové stránky, e-mail nebo soubor, který chceme přenést.
    
    / Transportní vrstva:
    
      - Přidání TCP/UDP hlavičky
      - Název: *Segment* (TCP) / *Datagram* (UDP)
      - Tato vrstva rozdělí data na menší části (segmenty nebo datagramy) 
        - každý má maximálně 1,5 KB pro TCP a asi 65 KB pro UDP - a přidá informace potřebné pro správný přenos, jako jsou porty a čísla sekvencí (transportní hlavička).
    
    / Internetová vrstva:
    
      - Přidání IP hlavičky
      - Název: *Paket* (Packet)
    
    / Linková vrstva:
    
      - Přidání MAC adres (hlavička a patička)
      - Název: *Rámec* (Frame)
    
    / Fyzická vrstva:
    
      - Převod na elektrické/optické signály
      - Název: *Bity* (Bits)

    *Při příjmu dat se tento proces obrací*: bity jsou převáděny zpět na rámce, pak na pakety, segmenty/datagramy a nakonec na data pro aplikaci.

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
      
      - komunikace _1_ → _1_ (např. načtení webu)
    
    / Broadcast:
      
      - komunikace _1_ → _všichni v síti_ (např. ARP #footnote[ARP slouží k překladu IP adresy na fyzickou MAC adresu. Dotazy typu: "_Kdo má IP adresu 192.168.1.10? Pošli mi svou MAC adresu._"] požadavek)
    / Multicast:
      
      - komunikace _1_ → _skupina zařízení_ (např. streamování videa do více zařízení)

    = IP adresy

    IP adresy se používají na:

      - Internetové (síťové) vrstvě

    #pagebreak()
    
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
  resources: [
    - #link("https://www.youtube.com/watch?v=036dn5OSlvA")[YouTube: Základy fungování sítí]

    - #link("https://www.youtube.com/watch?v=3b_TAYtzuho")[YouTube: ISO and TCP/IP models - best explanation]
  ]
)

#import "../template.typ": header, theme;

#show: body => header(
  title: "ISO/OSI a TCP/IP, protokoly a modely",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    *ISO/OSI* (International Organization for Standardization / Open Systems Interconnection) je *referenční model* #footnote[Referenční model je teoretický rámec pro pochopení a návrh síťových systémů] pro síťovou komunikaci, který byl vyvinut v 80. letech 20. století. Tento model *rozděluje síťovou komunikaci do sedmi vrstev*, z nichž každá má specifické funkce a odpovědnosti. Plní funkci jako standard pro návrh a implementaci síťových protokolů, což umožňuje interoperabilitu mezi různými systémy a zařízeními. *Jednotlivé vrstvy komunikují pouze s vedlejšími vrstvami*.

    *TCP/IP je implementace teoretického modelu ISO/OSI*, která se stala základem pro moderní internet. TCP/IP model má *pouze čtyři vrstvy, které jsou zjednodušenou verzí vrstev ISO/OSI*, ale stále zachovávají klíčové funkce pro komunikaci v síti. *TCP/IP model nebyl jedniný co vznikl*, ale díky vzniku internetu stal se dominantním standardem pro síťovou komunikaci a byl tak přijat ve většině moderních sítí.

    ISO/OSI lze přirovnat ke komunikaci mezi lidmi. Začne to myšlenkou, zprocesování a korekcí zprávy, vyslovení a předání zprávy řečí a zpátečné přijetí zprávy sluchem, dekódování zprávy a nakonec pochopení zprávy.

    Stejně to funguje i u ISO/OSI nebo TCP/IP. Data, která chce komunikační zařízení poslat (např. webový dotaz na novou stránku), Jde to od kliknutí na nějaké webové stránce, přes proces v počítači, zabalení do paketu s nutnými informacemi k přenosu, poslání do routeru až k serveru, který dotaz zpětně zpracuje obrácenou cestou, jakou byla zpráva/dotaz zpracován/a.

    Každá vrstva přidává své vlastní informace a funkce, aby zajistila správný přenos dat od odesílatele k příjemci.

    TCP/IP *není pouze softwarová záležitost*, ale zahrnuje *i hardwarové* aspekty, jako jsou kabely, konektory a fyzické přenosové médium, ikdyž je software velkou součástí tohoto modelu.

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

    1. *Fyzická vrstva* (Physical Layer)
      - Zajišťuje *přenos bitů přes fyzické médium*, jako jsou kabely nebo bezdrátové signály
      - Definuje elektrické, mechanické a funkční vlastnosti přenosového média
      - *Typické zařízení:* _Hub, Repeater, kabely_

    2. *Linková (_spojová_) vrstva* (Data Link Layer)
      - Zajišťuje spolehlivý *přenos dat mezi dvěma zařízeními na stejné síti*
      - Řeší problémy jako *detekce a oprava chyb*, řízení toku a adresování pomocí MAC adres
      - *Typické zařízení:* Switch

    3. *Síťová vrstva* (Network Layer)
      - Zajišťuje *směrování dat mezi různými sítěmi a zařízeními*
      - Řeší problémy jako adresování, směrování a fragmentace datových paketů
      - *Typické zařízení:* Router

    4. *Transportní vrstva* (Transport Layer)
      - Zajišťuje *spolehlivý přenos dat mezi koncovými body komunikace*
      - Řeší problémy jako řízení toku, detekce a oprava chyb a segmentace dat

    5. *Relační vrstva* (Session Layer)
      - Zajišťuje *správu relací mezi aplikacemi*
      - Umožňuje synchronizaci a koordinaci komunikace mezi nimi

    6. *Prezentační vrstva* (Presentation Layer)
      - Zajišťuje *převod dat do formátu, který může být pochopen aplikací*
      - Řeší problémy jako kódování, komprese a šifrování dat

    7. *Aplikační vrstva* (Application Layer)
      - Poskytuje *rozhraní pro uživatele a aplikace* k přístupu ke službám sítě
      - Zahrnuje protokoly jako *HTTP* (_80_), *FTP* (_20_, _21_), *SMTP* (_25_, _587_) a další

    == TCP/IP model (4 vrstvy):

    4. *Aplikační vrstva* (Application Layer)
      - Slučuje původní vrstvy: *aplikační, prezentační a relační*.
      - Poskytuje protokoly pro konkrétní služby (*HTTP*, *HTTPS*, *FTP*, *SMTP*, *DNS*). Zajišťuje čitelnost dat pro uživatele.
      - Zajišťuje kódování, kompresi a správu relací přímo v aplikaci.

    3. *Transportní vrstva* (Transport Layer)
      - *Odpovídá stejnojmenné vrstvě v ISO/OSI*.
      - Zastupuje *_TCP_* v názvu modelu.
      - Zajišťuje přenos dat mezi procesy na koncových uzlech.
      / Hlavní protokoly: 
        - TCP - *spolehlivý*, s navázáním spojení (kontrola chyb a pořadí)
        - UDP - *rychlý*, *nespolehlivý* (stream)

    2. *Síťová vrstva* (Internet Layer)
      - *Odpovídá síťové vrstvě v ISO/OSI*.
      - Zastupuje *_IP_* v názvu modelu.
      - Zajišťuje adresaci a směrování paketů napříč sítěmi. Zajišťuje odeslání na místo určení i přes více sítí.
      - Hlavní protokoly: IP (*IPv4*, *IPv6*), *ICMP*, *ARP*.

    1. *Vrstva síťového rozhraní* (Network Access Layer)
      - *Slučuje původní linkovou a fyzickou vrstvu*.
      - Zajišťuje spolehlivý fyzický přenos dat přes konkrétní médium (Ethernet, Wi-Fi).
      - Správa spojení mezi zařízeními na úrovni hardwaru (řeší MAC adresy a mechanické vlastnosti).

    == Porovnání:

    #figure(
      image("../assets/ISO-OSI-TCP-IP.jpg"),
      caption: "Model ISO/OSI v porovnání s TCP/IP v češtině a v angličtině",
    )

    = Průběh zapouzdření dat _(Encapsulation)_:
    
    *PDU (Protocol Data Unit)*: Odborný název pro rámec, paket nebo segment. 

    / Aplikační vrstva:
      - Data vytvořená aplikací _např. obsah webové stránky, e-mail nebo soubor_
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

    *Při příjmu dat se tento proces obrací (Dekapsulace)*: bity jsou převáděny zpět na rámce, pak na pakety, segmenty/datagramy a nakonec na data pro aplikaci. Při čtení si každá vrstva přečte svou hlavičku, zahodí ji a předá data další (vyšší) vrstvě.

    = Protokoly modelu TCP/IP

    / Aplikační vrstva:
      - HTTP – přenos webových stránek (port 80)
      - HTTPS – zabezpečený HTTP (port 443)
      - FTP – přenos souborů (port 20, 21)
      - SMTP – odesílání e-mailů (port 25, 587)
      - POP3 – stažení mailů ze serveru do zařízení (port 110)
      - IMAP – synchronizace mailů se serverem a více zařízeními (port 143)
      - DNS – překlad domén na IP adresy (port 53)

    / Transportní vrstva:
      - TCP – spolehlivý přenos (kontrola chyb, pořadí)
      - UDP – rychlý, bez záruky doručení

    #pagebreak()

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

    = Závěr
    Vrstevnaté modely ISO-OSI a TCP/IP jsou základním kamenem počítačových sítí. Umožňují efektivní komunikaci, standardizaci protokolů a snadnější správu. TCP/IP model je prakticky využívaný v dnešním internetu, zatímco ISO-OSI slouží spíše jako teoretický referenční model pro pochopení celé síťové komunikace.

  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=036dn5OSlvA")[YouTube: Základy fungování sítí]

    - #link("https://www.youtube.com/watch?v=3b_TAYtzuho")[YouTube: ISO and TCP/IP models - best explanation]

    - #link("https://www.geeksforgeeks.org/computer-networks/tcp-ip-model/")[GeeksforGeeks: TCP/IP model]
  ]
)
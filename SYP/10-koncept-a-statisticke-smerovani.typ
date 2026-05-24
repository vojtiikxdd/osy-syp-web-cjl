#import "../template.typ": header, theme

#show: body => header(
  title: "Koncept směrování a statické směrování",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Router (směrovač) odděluje sítě a jeho hlavním úkolem je přeposlat paket po nejlepší cestě až k příjemci (klidně přes několik dalších routerů). K rozhodování využívá směrovací tabulku (routing table). Každý router se rozhoduje zcela samostatně — to, že router A zná cestu k routeru B, neznamená, že router B zná zpáteční cestu.

    = Směrovací tabulka a výběr cesty
    
    IP adresa příjemce v paketu neobsahuje délku prefixu (masku). Router proto porovnává IP adresu cíle se záznamy ve své směrovací tabulce. 
    
    Platí pravidlo *Nejdelší shody (Longest Match)*: Pokud existuje více možných cest (např. `172.16.0.0/12`, `172.16.0.0/18` a `172.16.0.0/26`), router vždy preferuje tu s nejdelší shodou (v tomto případě `/26`), protože je nejspecifičtější. Aby byla shoda validní, musí se s adresou příjemce shodovat alespoň bity určené prefixem.

    == Jak se směrovací tabulka plní
    - *Přímo připojené sítě:* Vzniknou automaticky, když je interface nakonfigurován s IP adresou, maskou a je aktivní (ve stavu UP).
    - *Vzdálené sítě:* Jsou zadány buď manuálně (statické směrování), nebo se je router naučí od ostatních routerů pomocí dynamických protokolů (OSPF, EIGRP).
    - *Default Route (Výchozí brána):* Pokud v tabulce není nalezena žádná shoda, paket se pošle na tento next-hop. Zapisuje se jako `0.0.0.0/0` pro IPv4 a `::/0` pro IPv6. Může být zadán staticky nebo naučen dynamicky.

    == Značení záznamů v tabulce
    / L (Local): Identifikuje přímo IP adresu přiřazenou k rozhraní routeru.
    / C (Connected): Přímo připojená síť.
    / S (Static): Statická cesta vytvořená administrátorem.
    / O (OSPF): Síť naučená dynamicky protokolem OSPF.
    / `*` (Asterisk): Kandidát na default route.

    = Proces předávání paketů
    1. Datalinkový rámec dorazí na interface routeru.
    2. Router zkontroluje IP adresu příjemce a hledá nejdelší shodu v tabulce.
    3. Pokud shodu najde, zabalí IP paket do nového datalinkového rámce a odešle jej na výstupní interface (exit interface). Pokud shodu nenajde (a neexistuje default route), *paket zahodí*.

    *Zapouzdření podle typu linky:*
    - *Ethernetová síť:* Router musí znát MAC adresu cíle nebo next-hop routeru. U IPv4 k tomu použije ARP (ARP Request/Reply), u IPv6 použije Neighbor Discovery (ICMPv6 NS/NA).
    - *Sériová linka:* Point-to-Point spojení (např. HDLC, PPP) MAC adresy neřeší. Rámec je zabalen do příslušného formátu a adresa L2 se nastaví jako ekvivalent broadcastu.

    = Mechanismy přeposílání (Forwarding Mechanisms)
    / Process Switching: Nejstarší a nejpomalejší. Každý paket je předán procesoru (CPU), který pro něj složitě vyhledává cestu v tabulce.
    / Fast Switching: Využívá vyrovnávací paměť (cache). CPU najde cestu pouze pro první paket z datového toku, výsledek si uloží a zbytek paketů odbaví rychle z paměti.
    / CEF (Cisco Express Forwarding): Nejrychlejší a nejmodernější. Vytváří *FIB (Forwarding Information Base)* a tabulku sousedství. Matematické výpočty tras jsou vyřešeny předem (v hardwaru), ještě než dorazí první paket.

    = Statické vs. Dynamické směrování
    == Statické směrování
    Explicitní cesta definovaná administrátorem. 
    - *Výhody:* Šetří šířku pásma, nezatěžuje CPU výpočty, je bezpečnější.
    - *Nevýhody:* Nereaguje na změny v topologii sítě (při výpadku linky se cesta nepřepočítá). Využívá se hlavně ve *stub sítích* (sítě s jedinou cestou ven).

    == Dynamické protokoly
    Automaticky vybírají nejlepší cesty a adaptují se na výpadky. Při výběru nejlepší trasy využívají *metriku* (ohodnocení cesty):
    - *RIP:* Metrikou je počet skoků (hop count), max. 15.
    - *OSPF:* Metrikou je cena (cost), která se odvíjí od šířky pásma (bandwidth).
    - *EIGRP:* Metrika se počítá na základě nejpomalejší šířky pásma a zpoždění (delay).

    Pokud existuje více tras se stejnou metrikou, router využije *Load Balancing* (rozdělení zátěže) a pošle data oběma cestami.

    == Administrativní vzdálenost (AD - Administrative Distance)
    Slouží jako měřítko *důvěryhodnosti zdroje trasy*, pokud se router naučí cestu do stejné sítě z více různých zdrojů (např. z OSPF i EIGRP). Nižší číslo znamená vyšší důvěru:
    - *Přímo připojené (Connected):* 0
    - *Statická cesta (Static):* 1
    - *EIGRP:* 90
    - *OSPF:* 110

    = Druhy statických cest
    Při konfiguraci lze zadat jako next-hop IP adresu dalšího routeru, výstupní (exit) interface, nebo obojí. (U IPv6 link-local adresy musí být specifikován i interface).

    1. *Standard Static Route:* Klasická cesta k určité síti.
    2. *Default Static Route:* Cesta posledního záchrany (`0.0.0.0/0`).
    3. *Summary Static Route:* Shrnující cesta, kde se maska upraví tak, aby zahrnovala více menších sítí pod jeden záznam.
    4. *Floating Static Route:* Slouží jako *záložní trasa*. Konfiguruje se s vyšší AD, než má primární dynamický protokol. (Např. EIGRP má AD 90, záložní Floating statické cestě nastavíme AD 95. Dokud EIGRP běží, router preferuje EIGRP. Když EIGRP selže, aktivuje se záložní statická trasa).
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Používaná zařízení v malých sítích a způsoby jejich propojení."
      #v(1em)
      //> @
    ]

    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Výběr těchto zařízení."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Adresace pro malou firmu."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Redundance v malé síti, QoS."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Služby v malé síti."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Audio a video aplikace."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Růst malé sítě."
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Sm%C4%9Brov%C3%A1n%C3%AD")[Wiki — Směrování (Routing)]
    - #link("https://en.wikipedia.org/wiki/Administrative_distance")[Wiki — Administrative Distance]
    - #link("https://en.wikipedia.org/wiki/Cisco_Express_Forwarding")[Wiki — Cisco Express Forwarding (CEF)]
  ],
)
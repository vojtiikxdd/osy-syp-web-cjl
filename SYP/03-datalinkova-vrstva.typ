#import "../template.typ": header, theme

#show: body => header(
  title: "Data-linková vrstva, Ethernet a základní funkce a konfigurace switche",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Data-linková vrstva (Data Link Layer) je druhou vrstvou referenčního modelu OSI. Tvoří most mezi fyzickým přenosem bitů a logickou komunikací vyšších vrstev — přijímá pakety vrstvy 3, zapouzdřuje je do rámců a zajišťuje jejich spolehlivý přenos mezi uzly ve stejné síti pomocí MAC adres. Na rozdíl od síťové vrstvy (IP adresy) pracuje pouze v rámci jednoho síťového segmentu.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Integrace do modelu OSI

    Ethernet jako technologie operuje na vrstvách 1 a 2 modelu OSI — zasahuje do fyzické vrstvy (způsob přenosu bitů) i do linkové vrstvy (přenos rámců mezi sousedními uzly). V modelu TCP/IP odpovídá vrstvě síťového rozhraní.

    Datalinková vrstva plní tyto klíčové funkce:

    - Zapouzdřuje pakety vrstvy 3 (IPv4, IPv6) do rámců vrstvy 2
    - Umožňuje vyšším vrstvám přístup k médiím — protokoly vyšší vrstvy neznají typ použitého média
    - Provádí detekci chyb a zahazuje poškozené rámce
    - Adresuje komunikaci pomocí MAC adres (ne IP adres)
    - Při každém skoku na routeru: přijme rámec → rozbalí → znovu zapouzdří → odešle

    == Podvrstvy IEEE 802

    Datalinková vrstva se dělí na dvě podvrstvy:

    / LLC (Logical Link Control) — IEEE 802.2:
      Komunikuje mezi síťovým softwarem vyšších vrstev a hardwarem. Do rámce vkládá informaci o použitém protokolu vrstvy 3 (IPv4, IPv6), což umožňuje více protokolům sdílet stejné síťové rozhraní a médium.

    / MAC (Media Access Control) — IEEE 802.3 / 802.11 / 802.15:
      Implementována v hardwaru (NIC). Zapouzdřuje data, přidává MAC adresy a kontrolní součet, řídí přístup k médiu. U half-duplexu řídí tok dat, u full-duplexu není řízení přístupu potřeba.

    = Topologie sítí

    Datalinková vrstva „vidí" logickou topologii, která určuje způsob řízení přístupu k médiím a typ rámování.

    == Fyzická vs. logická topologie

    / Fyzická topologie:
      Dáno fyzickým zapojením kabelů a uzlů — sběrnice, kruh, hvězda, strom, mesh.

    / Logická topologie:
      Způsob vzájemné komunikace uzlů, nemusí odpovídat fyzické topologii.

    == WAN topologie

    / Point-to-point: Permanentní přímý spoj mezi dvěma zařízeními. Pomocí protokolu PPP lze komunikovat přes zprostředkující zařízení bez změny logické topologie.
    / Hub and Spoke: Hvězdicová topologie — centrální router, přes který tečou data ostatních uzlů.
    / Mesh: Každé zařízení propojeno s každým. Vysoká odolnost, vysoké náklady.

    == LAN topologie

    / Bus (sběrnice): Zastaralá, dříve koaxiální kabel. Levná, bez potřeby switchů, ale sdílené médium = kolize.
    / Ring (kruh): Uzavřená smyčka, v případě výpadku uzlu nutné přemostění NIC.
    / Star (hvězda): Dnes standard — všechna zařízení připojena k aktivnímu prvku (switch).
    / Mesh: Přímé propojení více uzlů, používáno hybridně.

    = Duplex a řízení přístupu k médiu

    == Half-duplex vs. Full-duplex

    / Half-duplex: Obě zařízení mohou vysílat i přijímat, ale ne současně. Používá WLAN a starší sběrnicové topologie. Vyžaduje metody řízení přístupu.
    / Full-duplex: Obě zařízení komunikují současně. Switche pracují defaultně ve full-duplexu. Po připojení k hubu se mohou přepnout do half-duplexu.

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Důležité:* Obě propojená rozhraní musí fungovat ve stejném duplexním režimu. Neshoda způsobuje latenci a kolize. Funkce *Auto-Negotiation* vyjednává duplex automaticky — pokud je na jedné straně vypnuta, může dojít k neshodě.
    ]

    == Metody řízení přístupu (half-duplex)

    / CSMA/CD (Carrier Sense Multiple Access with Collision Detection):
      Používáno v drátovém Ethernetu s huby (bus topologie).
      - NIC naslouchá médiu — pokud je ticho, vysílá
      - Pokud dvě stanice vysílají současně → kolize
      - Stanice detekuje kolizi (amplituda na médiu > normální nebo porovnání dat), vyšle JAM signál
      - Všechny stanice přestanou vysílat, po náhodné době zkusí znovu
      - Čím více zařízení, tím vyšší pravděpodobnost kolize

    / CSMA/CA (Carrier Sense Multiple Access with Collision Avoidance):
      Používáno na WLAN (bezdrátové sítě).
      - Před vysíláním stanice naslouchá, zda je médium volné
      - Při volném médiu ohlásí ostatním, že bude vysílat (médium si „zamluví")
      - Příjemce posílá potvrzení odesílateli
      - Switche CSMA nepoužívají — pracují ve full-duplexu

    = Ethernet a ethernetový rámec

    Ethernet je dnes dominantní technologie pro LAN sítě. Rychlosti sahají od 10 Mb/s až po 100 Gb/s.

    == Verze Ethernetu

    #table(
      columns: (1.5fr, 1fr, 2fr),
      inset: 8pt,
      align: left,
      fill: (col, row) => if row == 0 { navy } else if calc.odd(row) { luma(240) } else { white },

      table.header(
        text(fill: white, weight: "bold")[Verze],
        text(fill: white, weight: "bold")[Rychlost],
        text(fill: white, weight: "bold")[Poznámka],
      ),

      [Ethernet], [10 Mb/s], [Původně bus + koax, dnes hvězda + UTP],
      [Fast Ethernet], [100 Mb/s], [Dnes považován za základní verzi],
      [Gigabit Ethernet], [1 Gb/s], [Všechny páry UTP, zpětně kompatibilní],
      [10 Gigabit Ethernet], [10 Gb/s], [UTP i optika],
      [40/100 Gigabit Ethernet], [40–100 Gb/s], [Datová centra, drahá technologie],
    )

    == Struktura ethernetového rámce

    Minimální velikost rámce je 64 bytů, maximální 1518 bytů. Rámce mimo tento rozsah jsou automaticky zahozeny.

    / Preambule (7 B): Střídavé 0 a 1 pro synchronizaci hodin příjemce.
    / SFD — Start Frame Delimiter (1 B): Označuje začátek rámce.
    / Cílová MAC adresa (6 B): 48bitová adresa příjemce — unicast, multicast nebo broadcast. Switch ji čte jako první pro co nejrychlejší rozhodnutí o přeposlání.
    / Zdrojová MAC adresa (6 B): 48bitová adresa odesílatele.
    / Typ / délka (2 B): Identifikuje protokol vrstvy 3 (např. IPv4, IPv6).
    / Data (46–1500 B): Zapouzdřený paket. Pokud jsou data příliš malá, doplní se výplní (padding).
    / FCS — Frame Check Sequence (4 B): 32bitový CRC kontrolní součet ze všech polí. Příjemce si vypočítá vlastní CRC a porovná — při neshodě rámec zahodí.

    = MAC adresy

    MAC adresa je unikátní 48bitový identifikátor síťového rozhraní (NIC), označovaná jako BIA (Burned-In Address) — vypálena do ROM. Při spuštění zařízení se zkopíruje do RAM.

    Prvních 24 bitů tvoří *OUI* (Organizationally Unique Identifier) přiřazený výrobci od IEEE, dalších 24 bitů je unikátní číslo přiřazené výrobcem. Duplicita je možná (chyba výroby, softwarová změna).

    == Typy MAC adres

    / Unicast: Konkrétní jedno zařízení.
    / Multicast: Skupina zařízení, adresa odvozena z IP multicast adresy.
    / Broadcast: Všechna zařízení v segmentu — adresa `FF:FF:FF:FF:FF:FF`.

    == Zjišťování MAC adres

    - *IPv4:* Protokol ARP (Address Resolution Protocol)
    - *IPv6:* Protokol ND (Neighbor Discovery) pomocí ICMPv6

    = Aktivní prvky sítě

    / Repeater (opakovač): Zesiluje a opravuje signál fyzické vrstvy. Nepracuje s rámci.
    / Hub: Multiportový repeater. Přijatý signál vysílá na všechny porty — vytváří jednu kolizní doménu.
    / Bridge: Pracuje na datalinkové vrstvě. Má MAC tabulku, odděluje kolizní domény mezi segmenty.
    / Switch: Multiportový bridge. Přeposílá rámce pouze na cílový port dle MAC tabulky. Broadcast a multicast šíří na všechny porty. Defaultně full-duplex.
    / Router: Pracuje na vrstvě 3. Směruje pakety dle IP adres, odděluje broadcastové domény.

    == Funkce switche — MAC tabulka (CAM)

    Switch buduje MAC tabulku dynamicky:

    + Přijde rámec → zdrojová MAC adresa se zapíše k příchozímu portu
    + Pokud cílová MAC *je* v tabulce → rámec se pošle pouze na daný port
    + Pokud cílová MAC *není* v tabulce → rámec se pošle na všechny porty kromě příchozího (flooding)
    + Multicast a broadcast → vždy na všechny porty kromě příchozího
    + Záznamy v tabulce se uchovávají typicky 5 minut

    == Metody přepínání rámců

    / Store-and-Forward: Switch přijme celý rámec, ověří CRC, teprve poté odešle. Nezbytné pro QoS. Vyšší latence, ale žádné poškozené rámce neprojdou.
    / Cut-Through — Fast-Forward: Rámec se odesílá ještě před úplným přijetím, jakmile je přečtena cílová MAC. Nejnižší latence, bez kontroly chyb.
    / Cut-Through — Fragment-Free: Kontrola prvních 64 bytů (nejčastější velikost kolizních fragmentů), poté odeslání. Kompromis mezi rychlostí a spolehlivostí.

    == Buffery switche

    / Port-based memory: Každý port má vlastní frontu. Jeden přetížený port může zpomalit ostatní.
    / Shared memory: Společný buffer pro všechny porty, dynamicky přidělován. Efektivnější využití paměti.

    == Broadcastová a kolizní doména

    / Kolizní doména: Část sítě, kde může docházet ke kolizím. Switch každý port izoluje do vlastní kolizní domény. Hub celou síť spojuje do jedné.
    / Broadcastová doména: Část sítě, kam se šíří broadcast. Switch broadcastovou doménu nerozděluje — to dělá až router (nebo VLAN).

    == Problémy přepínaných sítí — Spanning Tree Protocol (STP)

    Propojení více switchů bez STP může způsobit *síťové smyčky* a *broadcast storm* (broadcast se šíří donekonečna). STP řeší:

    + Výběr root bridge (hlavního mostu)
    + Určení nejkratší cesty ke každému uzlu
    + Zablokování redundantních cest (porty v blocking stavu)

    = Základní konfigurace switche (Cisco IOS)

    == Přístupové metody

    / Console: Přímé připojení konzolového kabelu do console portu.
    / SSH (Secure Shell): Šifrované vzdálené připojení přes virtuální interface (VTY).
    / Telnet: Nezašifrované vzdálené připojení — veškerá data v plaintextu, nedoporučeno.

    == Příkazové módy

    / User EXEC (`>`): Omezená práva, pouze zobrazení. Vstup: zapnutí zařízení.
    / Privileged EXEC (`#`): Plná práva. Vstup: `enable`, výstup: `disable`.
    / Global Configuration: Vstup: `configure terminal`, výstup: `exit` nebo `end` / `Ctrl+Z`.
    / Line Configuration: `line console 0`, `line vty 0 15`.
    / Interface Configuration: `interface vlan 1`, `interface fastethernet 0/1`.

    == Základní příkazy

    ```cisco_ios
    hostname JMENO                        // nastavení názvu zařízení
    enable secret HESLO                   // heslo pro privilegovaný mód
    line console 0
      password HESLO
      login
    line vty 0 15                         // SSH/Telnet přístup (16 linek)
      password HESLO
      login
    service password-encryption           // slabé šifrování hesel v konfiguraci
    banner motd # Varování: pouze autorizovaný přístup! #
    interface vlan 1                      // SVI pro vzdálenou správu
      ip address 192.168.1.10 255.255.255.0
      no shutdown
    ip default-gateway 192.168.1.1        // výchozí brána pro switch
    copy running-config startup-config    // uložení konfigurace do NVRAM
    show running-config                   // zobrazení aktuální konfigurace
    ping 192.168.1.1                      // test konektivity
    traceroute 192.168.1.1                // sledování trasy paketů
    ```

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Poznámka k SVI:* Switch Virtual Interface (VLAN 1) je virtuální rozhraní pro vzdálenou správu switche. Switche nativně nepracují na vrstvě 3 — SVI jim umožňuje mít IP adresu pro SSH/Telnet přístup.
    ]

  ],
  summary: [
    Data-linková vrstva tvoří zásadní propojení mezi fyzickým přenosem bitů (vrstva 1) a logickým směrováním paketů (vrstva 3). Ethernet jako její hlavní realizace prošel vývojem od sdíleného koaxiálního média s CSMA/CD až po plně přepínané full-duplex sítě. Switch jako klíčový prvek odděluje kolizní domény, buduje MAC tabulku dynamicky a volbou metody přepínání (Store-and-Forward vs. Cut-Through) vyvažuje latenci a spolehlivost. Správná konfigurace switche — duplex, hesla, SVI, STP — je základem funkční a bezpečné LAN sítě.
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=c5lV995dSAA")[Youtube - Data Link Layer]
    - #link("https://www.netwrix.com/cisco_commands_cheat_sheet.html")[Cisco Commands Cheat Sheet]
  ],
)
#import "../template.typ": header, theme

#show: body => header(
  title: "Data-linková vrstva, Ethernet a základní funkce a konfigurace switche",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu
    
    *Data-linková vrstva* (Data Link Layer) je *druhou* vrstvou referenčního modelu ISO/OSI. Tvoří most mezi fyzickým přenosem bitů a logickou komunikací vyšších vrstev — *přijímá pakety ze síťové vrstvy, zapouzdřuje je do rámců* a *zajišťuje* jejich *přenos mezi uzly pomocí hardwarových _MAC_ adres*. Na rozdíl od síťové vrstvy, která směruje data napříč internetem pomocí _IP_ adres, tato vrstva operuje výhradně v rozsahu přímého spojení mezi sousedními uzly v lokální síti.

    Primární zařízení datalinkové vrstvy jsou *switche* a *bridgy*, které přeposílají rámce na základě MAC adres. Dále se zde nacházejí *NIC* (Network Interface Cards), které implementují datalinkovou vrstvu pro jednotlivá zařízení.
    
    #set heading(numbering: "1.1")

    = Integrace do modelu ISO/OSI

    *Ethernet* jako technologie *operuje na vrstvách 1 a 2* modelu ISO/OSI — zasahuje do fyzické vrstvy (způsob přenosu bitů) i do linkové vrstvy (přenos rámců mezi sousedními uzly). V modelu TCP/IP odpovídá vrstvě síťového rozhraní.

    / Datalinková vrstva plní tyto klíčové funkce:
      - Zapouzdřuje pakety vrstvy 3 (IPv4, IPv6) do rámců vrstvy 2
      - Umožňuje vyšším vrstvám přístup k médiím — protokoly vyšší vrstvy neznají typ použitého média
      - Provádí detekci chyb a zahazuje poškozené rámce
      - Adresuje komunikaci pomocí MAC adres (ne IP adres)
      - Při každém skoku na routeru: přijme rámec → rozbalí → znovu zapouzdří → odešle

    == Podvrstvy IEEE 802

    IEEE - Institute of Electrical and Electronics Engineers — organizace, která standardizuje technologie pro datové sítě. 

    Datalinková vrstva se dělí na dvě podvrstvy:

    / LLC (Logical Link Control) — IEEE 802.2:
      Komunikuje mezi síťovým *softwarem* vyšších vrstev a hardwarem. Do rámce vkládá informaci o použitém protokolu vrstvy 3 (IPv4, IPv6), což umožňuje více protokolům sdílet stejné síťové rozhraní a médium.

    / MAC (Media Access Control) — IEEE 802.3 / 802.11 / 802.15:
      Implementována *v hardwaru (NIC - Network Interface Card)*. Zapouzdřuje data, přidává MAC adresy a kontrolní součet, řídí přístup k médiu. U half-duplexu řídí tok dat, u full-duplexu není řízení přístupu potřeba.

    = Topologie sítí

    Datalinková vrstva „vidí" logickou topologii, která určuje způsob řízení přístupu k médiím a typ rámování.

    == Fyzická vs. logická topologie

    / Fyzická topologie:
      Dáno fyzickým zapojením kabelů a uzlů — sběrnice, kruh, hvězda, strom, mesh.

    / Logická topologie:
      Způsob vzájemné komunikace uzlů, nemusí odpovídat fyzické topologii.

    == WAN topologie

    / Point-to-point: Permanentní přímý spoj mezi dvěma zařízeními. Pomocí protokolu PPP - _Point-to-Point Protocol_ lze komunikovat přes zprostředkující zařízení bez změny logické topologie.
    / Hub and Spoke: Hvězdicová topologie — centrální router, přes který tečou data ostatních uzlů.
    / Mesh: Každé zařízení propojeno s každým. Vysoká odolnost, vysoké náklady.

    == LAN topologie

    / Bus (sběrnice): Zastaralá, dříve koaxiální kabel. Levná, bez potřeby switchů, ale sdílené médium = kolize.
    / Ring (kruh): Uzavřená smyčka, v případě výpadku uzlu nutné přemostění NIC.
    / Star (hvězda): Dnes standard — všechna zařízení připojena k aktivnímu prvku (switch).
    / Mesh: Přímé propojení více uzlů, používáno hybridně.

    = Duplex a řízení přístupu k médiu

    == Simplex vs. Half-duplex vs. Full-duplex

    / Simplex: Komunikace pouze jedním směrem (např. vysílačka, televize). Žádná interakce.
    / Half-duplex: Obě zařízení mohou vysílat i přijímat, ale ne současně. Používá WLAN a starší sběrnicové topologie. Vyžaduje metody řízení přístupu.
    / Full-duplex: Obě zařízení komunikují současně. Switche pracují defaultně ve full-duplexu. Po připojení k hubu se mohou přepnout do half-duplexu.

    #pagebreak()

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Důležité:* Obě propojená rozhraní musí fungovat ve stejném duplexním režimu. Neshoda způsobuje latenci a kolize. Funkce *Auto-Negotiation* vyjednává duplex automaticky — pokud je na jedné straně vypnuta, může dojít k neshodě.
    ]

    == Metody řízení přístupu (half-duplex) <csma>

    / CSMA/CD (Carrier Sense Multiple Access with Collision Detection):
      Používáno v drátovém Ethernetu s huby (bus topologie).
      - NIC naslouchá médiu — pokud je ticho, vysílá.
      - Pokud dvě stanice vysílají současně → kolize.
      - Stanice detekuje kolizi (amplituda na médiu > normální nebo porovnání dat), vyšle JAM signál.
      - Všechny stanice přestanou vysílat, po náhodné době zkusí znovu.
      - Čím více zařízení, tím vyšší pravděpodobnost kolize.

    / CSMA/CA (Carrier Sense Multiple Access with Collision Avoidance):
      Používáno na WLAN (bezdrátové sítě).
      - Před vysíláním stanice naslouchá, zda je médium volné.
      - Při volném médiu ohlásí ostatním, že bude vysílat (médium si „zamluví", rezervuje časové okno).
      - Příjemce posílá potvrzení odesílateli (ACK).
      - Switche CSMA nepoužívají — pracují ve full-duplexu.

    == Porovnání CSMA/CD a CSMA/CA

    #table(
      columns: (auto, 80pt, 1fr),
      fill: (col, row) => if row == 0 { rgb("#1a3a5f") } else if calc.even(row) { rgb("#f8fafc") } else { none },
      stroke: (col, row) => if row == 0 { none } else { 0.5pt + rgb("#e2e8f0") },
      align: (col, row) => if row == 0 { center + horizon } else if col == 1 { center + horizon } else { left + horizon },

      table.header(
        text(fill: white, weight: "bold")[Vlastnost],
        text(fill: white, weight: "bold")[Ethernet (CSMA/CD)],
        text(fill: white, weight: "bold")[Wi-Fi (CSMA/CA)],
      ),

      [Typ sítě], [Kabelová], [Bezdrátová],
      [Kolize], [Detekuje a řeší je], [Snaží se jim předcházet],
      [Efektivita], [Vyšší], [Nižší (vyšší režie komunikace)],
      [Latence], [Nižší], [Vyšší],
    )

    = Ethernet a ethernetový rámec

    Ethernet je dnes dominantní technologie pro LAN sítě. Rychlosti sahají od 10 Mb/s až po 100 Gb/s.

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Poznámka:* U drátových metalických rozhraní (BASE-T) je maximální délka jednoho segmentu omezena na *100 metrů*.
    ]  

    == Verze Ethernetu <verze-ethernetu>

    #table(
      columns: (auto, 80pt, 1fr),
      fill: (col, row) => if row == 0 { rgb("#1a3a5f") } else if calc.even(row) { rgb("#f8fafc") } else { none },
      stroke: (col, row) => if row == 0 { none } else { 0.5pt + rgb("#e2e8f0") },
      align: (col, row) => if row == 0 { center + horizon } else if col == 1 { center + horizon } else { left + horizon },

      table.header(
        text(fill: white, weight: "bold")[Verze],
        text(fill: white, weight: "bold")[Rychlost],
        text(fill: white, weight: "bold")[Poznámka],
      ),

      [Ethernet], [10 Mb/s], [Původně bus + koax, dnes hvězda + UTP],
      [Fast Ethernet], [100 Mb/s], [Dnes považován za základní verzi],
      [Gigabit Ethernet], [1 Gb/s], [Všechny páry UTP, zpětně kompatibilní],
      [10 Gigabit Ethernet], [10 Gb/s], [UTP (Cat6a/Cat7) i optika],
      [40/100 Gigabit Ethernet], [40–100 Gb/s], [Datová centra, drahá technologie],
    )

    == Struktura ethernetového rámce

    Minimální velikost rámce je 64 bytů, maximální 1518 bytů. Rámce mimo tento rozsah jsou automaticky zahozeny.

    _*Tabulka se nachází na další stránce kvůli své velikosti.*_

    #pagebreak()

    #table(
      columns: (auto, 80pt, 1fr),
      fill: (col, row) => if row == 0 { rgb("#1a3a5f") } else if calc.even(row) { rgb("#f8fafc") } else { none },
      stroke: (col, row) => if row == 0 { none } else { 0.5pt + rgb("#e2e8f0") },
      align: (col, row) => if row == 0 { center + horizon } else if col == 1 { center + horizon } else { left + horizon },
      
      // Header
      table.header(
        text(fill: white, weight: "bold")[Pole rámce],
        text(fill: white, weight: "bold")[Velikost],
        text(fill: white, weight: "bold")[Klíčová funkce a význam]
      ),

      [*Preambule*], [7 B], [Střídavé nuly a jedničky (10101010...) sloužící pro hardwarovou synchronizaci hodin příjemce.],
      [*SFD* \ _(Start Frame Delimiter)_], [1 B], [Končí sekvencí 11 a oznamuje příjemci: „Pozor, následující bajt je již začátek samotného rámce.“],
      [*Cílová MAC adresa*], [6 B], [48bitová fyzická adresa příjemce (Unicast/Multicast/Broadcast). Switch ji čte jako první, aby mohl rámec ihned začít směrovat do správného portu.],
      [*Zdrojová MAC adresa*], [6 B], [48bitová fyzická adresa odesílatele (síťové karty).],
      [*Typ / Délka*], [2 B], [Určuje, jaký protokol z vyšší (síťové) vrstvy je zabalen uvnitř dat (např. 0x0800 pro IPv4, 0x08DD pro IPv6).],
      [*Data* \ _(Payload)_], [46 – 1500 B], [Samotný zapouzdřený paket z vyšší vrstvy. Pokud jsou data menší než 46 B, doplní se prázdnou výplní (_padding_) na minimální délku.],
      [*FCS* \ _(Frame Check Sequence)_], [4 B], [Kontrolní součet (32-bit CRC) vypočítaný ze všech polí. Pokud výpočet příjemci nesouhlasí, rámec bez milosti zahodí jako poškozený.]
    )

    = MAC adresy

    MAC adresa je unikátní 48bitový identifikátor síťového rozhraní (NIC), označovaná jako BIA (Burned-In Address) — vypálena do ROM. Běžně se zapisuje hexadecimálně, např. `00:1A:2B:3C:4D:5E`. Při spuštění zařízení se zkopíruje do RAM.

    Prvních 24 bitů tvoří *OUI* (Organizationally Unique Identifier) přiřazený výrobci od IEEE, dalších 24 bitů je unikátní číslo přiřazené výrobcem. Duplicita je možná (chyba výroby, softwarová změna).

    #pagebreak()

    == Typy MAC adres

    / Unicast: Konkrétní jedno zařízení.
    / Multicast: Skupina zařízení, adresa odvozena z IP multicast adresy.
    / Broadcast: Všechna zařízení v segmentu — adresa `FF:FF:FF:FF:FF:FF`.

    = ARP (Address Resolution Protocol) a komunikace v síti

    == Princip fungování protokolu ARP
    Když chce zařízení odeslat data na určitou IP adresu v lokální síti, potřebuje k tomu znát její fyzickou MAC adresu. Postup překladu IP adresy na MAC adresu probíhá takto:
    + *Kontrola paměti (ARP cache):* Zařízení se nejprve podívá do své paměti, zda už danou MAC adresu nezná.
    + *ARP Request (Broadcast):* Pokud ji nezná, odešle do sítě všem zařízením výzvu: _"Kdo má IP X.X.X.X? Pošlete mi svou MAC adresu."_
    + *ARP Reply (Unicast):* Zařízení, které má dotazovanou IP adresu, odpoví přímo odesílateli a pošle mu svou MAC adresu.
    + *Uložení a odeslání:* Odesílatel si údaj uloží do ARP cache, sestaví ethernetový rámec a úspěšně odešle data.

    == Zjištění ARP tabulky ve Windows
    Pro zobrazení uložených dvojic IP adres a MAC adres (ARP cache) se v příkazovém řádku používá příkaz:
    ```cmd
    C:\> arp -a
    ```

    == Komunikace mimo lokální síť (Default Gateway)
    Pokud počítač komunikuje se zařízením v *jiné síti* (např. načítá webovou stránku z internetu), data odesílá na svou výchozí bránu (router).
    - *Na 2. vrstvě (Rámec):* Zdrojová MAC adresa patří odesílajícímu PC, *cílová MAC adresa patří routeru* (Default Gateway).
    - *Na 3. vrstvě (Paket):* Zdrojová IP adresa patří PC, *cílová IP adresa patří konečnému příjemci* (serveru kdesi v internetu).
    IP adresy zajišťují globální doručení (End-to-End), zatímco MAC adresy se mění při každém přeskoku přes router (Hop-to-Hop).

    #pagebreak()

    = Aktivní prvky sítě <aktivni-prvky-lan>

    / Repeater (opakovač): Zesiluje a opravuje signál fyzické vrstvy. Nepracuje s rámci.
    
    / Hub: Multiportový repeater. Přijatý signál vysílá na všechny porty — vytváří jednu sdílenou kolizní doménu. Dnes se téměř nepoužívá.
    
    / Bridge: Pracuje na datalinkové vrstvě. Má MAC tabulku, odděluje kolizní domény mezi segmenty.
    
    / Switch: Multiportový bridge. Přeposílá rámce pouze na cílový port dle MAC tabulky. Vytváří pro každé zařízení vlastní kolizní doménu. Broadcast a multicast šíří na všechny porty. Defaultně pracuje ve full-duplexu.
    
    / Router: Pracuje na vrstvě 3. Směruje pakety dle IP adres, propojuji různé sítě a odděluje broadcastové domény.

    == Kolizní a broadcastové domény <kolizni-broadcast-domena>

     / Kolizní doména: 
      - Část sítě, kde může docházet ke kolizím rámců. Switch každý port izoluje do vlastní kolizní domény. Hub celou síť spojuje do jedné velké kolizní domény.
     / Broadcastová doména: 
      - Část sítě, kam se šíří broadcast (rámce typu `FF:FF:FF:FF:FF:FF`). Switch broadcastovou doménu nerozděluje — to dělá až router (nebo nasazení VLAN).

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Poznámka:* Switche jsou dnes standardem pro LAN sítě, protože efektivně přeposílají data pouze tam, kde jsou potřeba, a minimalizují kolize. Routery se používají pro propojení různých sítí a směrování dat na internetu.
    ]

    == Funkce switche — MAC tabulka (CAM) <funkce-swiche>

    Switch buduje a udržuje svou MAC (Content Addressable Memory) tabulku dynamicky na základě procházejícího provozu. Tabulka mapuje vazbu mezi `[MAC adresa <-> Fyzický port]`.

    Zpracování každého příchozího rámce probíhá ve třech fázích:

    / Learning (Učení):
      Switch zkontroluje *zdrojovou* (Source) MAC adresu rámce. Pokud ji v tabulce nemá, zapíše si ji společně s číslem portu, ze kterého rámec přišel. Pokud ji zná, pouze obnoví její časovač.

    / Forwarding (Přeposílání):
      Switch se podívá na *cílovou* (Destination) MAC adresu. Pokud tuto adresu v tabulce *najde*, rámec cíleně odešle *pouze na daný konkrétní port*.

    / Flooding (Zaplavení):
      Pokud cílová MAC adresa v tabulce *není* (tzv. _Unknown Unicast_), switch rámec rozešle do *všech aktivních portů* kromě toho, kterým rámec přišel. Jakmile cíl odpoví, switch se jeho polohu naučí (_Learning_).

    / Broadcast a Multicast:
      Rámce s všesměrovou adresou (např. ARP dotaz s cílem `FF:FF:FF:FF:FF:FF`) se nehledají v tabulce a switch je automaticky šíří na všechny porty kromě příchozího.

    / Aging time (Stárnutí):
      Záznamy v CAM tabulce nezůstávají navždy. Pokud zařízení delší dobu nekomunikuje, jeho záznam po vypršení časovače (typicky *5 minut*) z tabulky zmizí, což udržuje tabulku aktuální při změnách topologie.

    == Metody přepínání rámců <metody-prepinani-switche>

    / Store-and-Forward: Switch přijme celý rámec, ověří CRC, teprve poté odešle. Nezbytné pro QoS. Vyšší latence, ale žádné poškozené rámce neprojdou. Běžně nejpoužívanější.
    
    / Cut-Through — Fast-Forward: Rámec se odesílá ihned po přečtení cílové MAC (bez čekání na zbytek). Nejnižší latence, ale přeposílá i chybná data.
    
    / Cut-Through — Fragment-Free: Kontrola prvních 64 bytů (nejčastější velikost kolizních fragmentů), poté odeslání. Kompromis mezi rychlostí a spolehlivostí.

    == Buffery switche
    
    / Port-based memory: Každý port má vlastní frontu. Jeden přetížený port může zpomalit ostatní.
    
    / Shared memory: Společný buffer pro všechny porty, dynamicky přidělován. Efektivnější využití paměti.

    == Broadcastová a kolizní doména

    / Kolizní doména: Část sítě, kde může docházet ke kolizím rámců. Switch každý port izoluje do vlastní kolizní domény. Hub celou síť spojuje do jedné velké kolizní domény.
    
    / Broadcastová doména: Část sítě, kam se šíří broadcast (rámce typu `FF:FF:FF:FF:FF:FF`). Switch broadcastovou doménu nerozděluje — to dělá až router (nebo nasazení VLAN).

    == Problémy přepínaných sítí — Spanning Tree Protocol (STP) <stp>

    Propojení více switchů kruhovou topologií kvůli záloze může způsobit *síťové smyčky* a *broadcast storm* (broadcast se šíří donekonečna a způsobí zahlcení sítě a nestabilitu MAC tabulek). 
    STP tomuto brání. Vypočítá topologii bez smyček tím, že:

    + Zvolí root bridge (hlavní přepínač sítě).
    + Určí nejkratší trasy ke každému uzlu.
    + Nadbytečné (záložní) spoje dočasně zablokuje.

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
  subquestions: [
    == Jakou metodu přístupu k médiu používá ethernet, porovnejte s jinou metodou. Porovnejte jednotlivé metody (výhody / nevýhody)
    
    @csma

    Ethernet používá metodu CSMA/CD (_Carrier Sense Multiple Access with Collision Detection_) pro řízení přístupu k médiu v half-duplexních sítích. V porovnání s CSMA/CA (_Carrier Sense Multiple Access with Collision Avoidance_), která se používá ve Wi-Fi, má CSMA/CD nižší režii a latenci, ale je náchylnější ke kolizím, zejména při větším počtu zařízení. CSMA/CA se snaží kolizím předcházet rezervací média, což zvyšuje spolehlivost, ale také zvyšuje režii a latenci.

    == Vyjmenujte jednotlivé varianty ethernetu na metalickém médiu, u každého definujte šířku pásma a maximální délku pasivního segmentu

    @verze-ethernetu
    
    U metalických rozhraní je maximální délka segmentu omezena na 100 metrů kvůli útlumu signálu a ztrátám způsobeným elektromagnetickým rušením. Pro delší vzdálenosti se používají optické kabely.

    / Ethernet (10BASE-T): 10 Mb/s, max. délka segmentu 100 m
    
    / Fast Ethernet (100BASE-TX): 100 Mb/s, max. délka segmentu 100 m
    
    / Gigabit Ethernet (1000BASE-T): 1 Gb/s, max. délka segmentu 100 m
    
    / 10 Gigabit Ethernet (10GBASE-T): 10 Gb/s, max. délka segmentu 100 m (při použití kvalitního kabelu Cat6a nebo Cat7)
    
    / 40/100 Gigabit Ethernet (40GBASE-T / 100GBASE-T): 40–100 Gb/s, max. délka segmentu 30–50 m (při použití kabelů Cat8)

    #pagebreak()

    == Uveďte, z jakých základních aktivních prvků je složena LAN a podrobně popište jejich funkci 
    
    @aktivni-prvky-lan

    Mezi základní aktivní prvky LAN patří:
    
    / Nic (Network Interface Card): Síťová karta v každém zařízení, která implementuje datalinkovou vrstvu a umožňuje komunikaci přes síť. Obsahuje MAC adresu a zajišťuje zapouzdření dat do rámců.
    
    / Repeater (opakovač): Zesiluje a opravuje signál fyzické vrstvy. Nepracuje s rámci, pouze s bity.
    
    / Hub: Multiportový repeater. Přijatý signál vysílá na všechny porty, čímž vytváří jednu velkou kolizní doménu. Dnes se téměř nepoužívá kvůli neefektivitě.
    
    / Bridge: Pracuje na datalinkové vrstvě. Má MAC tabulku, odděluje kolizní domény mezi segmenty, ale neodděluje broadcastové domény.
    
    / Switch: Multiportový bridge. Přeposílá rámce pouze na cílový port dle MAC tabulky, čímž vytváří pro každé zařízení vlastní kolizní doménu. Broadcast a multicast šíří na všechny porty. Defaultně pracuje ve full-duplexu.
    
    / Router: Pracuje na vrstvě 3. Směruje pakety dle IP adres, propojuji různé sítě a odděluje broadcastové domény. Nezbytný pro komunikaci mezi různými sítěmi (např. LAN a internet).

    == Jaké adresy se využívají na přepínačích a jak probíhá rozhodovací proces na těchto prvcích
    
    @funkce-swiche

    Switche využívají *MAC adresy* pro rozhodování o přeposílání rámců. Při příjmu rámce switch nejprve zkontroluje *zdrojovou* MAC adresu a aktualizuje svou MAC tabulku (CAM) s informací, z kterého portu rámec přišel. Poté se podívá na *cílovou* MAC adresu:
    - Pokud ji v tabulce najde, rámec přepošle pouze na odpovídající port - tzv. _Unicast_.
    - Pokud ji nenajde, rámec zaplaví (flooding) do všech portů kromě toho, kterým přišel - tzv. _Multicast_.
    - Broadcastové a multicastové rámce se automaticky šíří do všech portů kromě příchozího - tzv. _Broadcast_.

    == Podrobně popište fungování switche, MAC table, Store-and-Forward Switching, Cut-Through Switching
    
    @funkce-swiche
    @metody-prepinani-switche

    Switch buduje a udržuje svou MAC (Content Addressable Memory) tabulku dynamicky na základě procházejícího provozu. Tabulka mapuje vazbu mezi `[MAC adresa <-> Fyzický port]`. Při příjmu rámce switch nejprve zkontroluje *zdrojovou* MAC adresu a aktualizuje svou MAC tabulku s informací, z kterého portu rámec přišel. Poté se podívá na *cílovou* MAC adresu:
    
    - Pokud ji v tabulce najde, rámec přepošle pouze na odpovídající port - tzv. _Unicast_.
    
    - Pokud ji nenajde, rámec zaplaví (flooding) do všech portů kromě toho, kterým přišel - tzv. _Multicast_.
    
    - Broadcastové a multicastové rámce se automaticky šíří do všech portů kromě příchozího - tzv. _Broadcast_.

    == Vysvětlete pojem broadcastová a kolizní doména
    
    @kolizni-broadcast-domena

    / Kolizní doména: Část sítě, kde může docházet ke kolizím rámců. Switch každý port izoluje do vlastní kolizní domény. Hub celou síť spojuje do jedné velké kolizní domény.
    / Broadcastová doména: Část sítě, kam se šíří broadcast (rámce typu `FF:FF:FF:FF:FF:FF`). Switch broadcastovou doménu nerozděluje — to dělá až router (nebo nasazení VLAN).

     V praxi to znamená, že v kolizní doméně může docházet ke kolizím datových rámců, což snižuje výkon sítě. Broadcastová doména určuje rozsah, ve kterém se šíří broadcastové zprávy, což může také ovlivnit výkon a bezpečnost sítě.

    == Problémy přepínaných sítí a jejich řešení pomocí spanning-three protokolu

    @stp

    Propojení více switchů kruhovou topologií kvůli záloze může způsobit *síťové smyčky* a *broadcast storm* (broadcast se šíří donekonečna a způsobí zahlcení sítě a nestabilitu MAC tabulek).
    Spanning Tree Protocol (STP) tomuto brání. Vypočítá topologii bez smyček tím, že:
    + Zvolí root bridge (hlavní přepínač sítě).
    + Určí nejkratší trasy ke každému uzlu.
    + Nadbytečné (záložní) spoje dočasně zablokuje.

  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=c5lV995dSAA")[Youtube - Data Link Layer]
    - #link("https://www.netwrix.com/cisco_commands_cheat_sheet.html")[Cisco Commands Cheat Sheet]
  ],
)
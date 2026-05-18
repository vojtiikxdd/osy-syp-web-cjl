#import "../template.typ": header, theme

#show: body => header(
  title: "IPv4 a IPv6 adresace, podsítě",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    Tento dokument shrnuje základy IP adresace (Internet Protocol) ve verzích IPv4 a IPv6. Vysvětluje formáty adres, rozdělení na třídy (u IPv4), principy podsítí (subnetting) a praktické výpočty síťových parametrů (adresa sítě, broadcast, rozsah použitelných hostů) na základě IP adresy a masky podsítě.
    
    #set heading(numbering: "1.1")
    
    = IPv4
    
    - Formát IP adresy, kterým je zařízení viditelné pro internet, je zapsán v tzv. dekadickém tečkovaném formátu.
    - Počet adres: cca 4,3 miliardy ($2^32$)
    
    IPv4 je tvořena 4 bajty = 4 oktety:
    - Binárně:
      - `11000000.10101000.00000001.00000001`
      - Tedy např: `192.168.1.1`
      - `1bajty.1bajty.1bajty.1bajty`
      - `8bitů.8bitů.8bitů.8bitů`
      - Celkem = 32 bitů
    - Decimálně:
      - Např. `192.168.1.1`
    
    Adresa se skládá z Network ID (id sítě) a z Host ID (id hosta v síti).
    _Příklad:_ IP adresa `192.168.1.5` / 24 bitů = část sítě je `192.168.1.0` (ID sítě) a část hosta (ID hosta) je `5`.
    (Znamená masku `255.255.255.0` and síť `192.168.1.0`).
    
    = IPv6
    - Nástupce protokolu IPv4; využívá se 128 bitů, tedy delší adresy (do budoucna by měly vydržet napořád).
    - Počet adres: cca $3.4 times 10^{38}$ (340 sextilionů)

    == Dual Stack (IPv4/IPv6)
    Umožňuje mít na PC aktivní jak IPv4 protokol, tak IPv6. Protokoly existují vedle sebe, fungují a pokud se připojíme na IPv4 server, tak jede IPv4, na IPv6 serveru zase IPv6.

    == Změna formátu IPv6 adresy ve srovnání se stávající IPv4
    - *IPv4*:
      Zápis se člení do 4 oktetů po 8 bitech:
      `192.168.1.1` (maska `255.255.255.0`)
    - *IPv6*:
      Zápis se člení na osm 16bitových částí (každá ze 4 znaků (hexadecimálně)):
      `2001:0DB8:0000:0000:0000:0000:1428:57ab`
      Zápis s nulami se dá zkrátit pomocí `::`. Každou skupinu lze zkrátit o nuly zleva:
      `2001:DB8::1428:57ab`
      Struktura se typicky skládá ze síťové části (prefix) a části rozhraní (interface ID), např. `2001:db8:acad::1/64`.
    
    == Proč vzniklo IPv6?
    Hlavním důvodem vzniku byl malý adresní prostor. IPv4 nabízí celkem 4,3 miliardy adres (navíc byly neefektivně rozděleny (třídy)).
    IPv6 naproti tomu nabízí nepředstavitelný počet adres: 340 sextilionů.
    Dále má nativní podporu bezpečnosti (IPSec) a automatickou konfiguraci (SLAAC).

    == Získání IP adresy?
    Pevné (statické) se přidělují bez ohledu na síť, na rozdíl od dynamických, které jsou přiděleny protokolem DHCP po připojení zařízení do sítě (obnovují se v čase).

    = IP (Internet Protocol)
    - Základní protokol fungující na síťové vrstvě (Network layer). Zajišťuje logické adresování zařízení (PC apod.) v datové síti a doručení dat z bodu A do bodu B.
    - IP adresa nemá fyzický vztah k zařízení. Je logická. S tímto protokolem musí pracovat i ostatní síťová zařízení (např. switch, router...).
    - Jsou dvě verze: IPv4 (32bit) a IPv6 (128bit). IPv4 adres je nedostatek a přechází se na IPv6.
    - Datový blok u IP adresy se nazývá paket, hlavička paketu obsahuje informace nutné k odeslání dat (musí vědět kam data zacílit).

    - IPv4 - 32bitová adresa, která je rozdělena tečkami do 4 dekadických čísel `0-255` (8 bitů na 1 oktet – `xxxxxxxx.xxxxxxxx.xxxxxxxx.xxxxxxxx`)
    - IPv6 - 128bitová adresa (hexadecimální, část na osm 16bitových úseků oddělených dvojtečkou např. `2001:0DB8::1428:57ab`). Zkracování adres - více bloků ze samých nul lze nahradit dvěma dvojtečkami (lze uplatnit pouze jednou!).

    _Proces odeslání dat:_ PC má přidělenou svoji *zdrojovou (source) IP adresu*, která je zapsána v hlavičce a *cílovou (destination) IP adresu*. V hlavičce je taktéž zapsána tzv. verze protokolu. Paket posílá k routeru, který vyhledává podle sítě adresu (směrovací tabulku). Podle masky rozpozná, zda-li jsou ve stejné síti.
    
    *Privátní adresy* = privátní adresy jsou lokální uvnitř jedné sítě (domácí, firemní apd.). Jsou dostupné pouze uvnitř této sítě a nefungují přes internetové routery (NAT překlad). Byly vytvořeny kvůli nedostatku veřejných adres:
    - 10.0.0.0 - 10.255.255.255
    - 172.16.0.0 - 172.31.255.255
    - 192.168.0.0 - 192.168.255.255
    
    *Veřejná adresa* = Adresa přístupná odkudkoli z internetu. Jedinečná na světě (na rozdíl od lokálních adres - IP adresa může být všude u PC uvnitř sítě např. `192.168.1.1`).
    
    *Maska podsítě* = Používá se pro rozdělení IP na síť, podsíť atd.
    - IPv4 adresa se skládá ze dvou částí: Adresy sítě a Adresy zařízení (PC).
    - Funkce masky spočívá v tom, že „vykrývá“ bity, které udávají síť, tedy identifikuje jak velká část náleží síti a co zbylo je samotné PC (host).
    - Zápis masky: ve tvaru desetinných čísel `255.255.255.0` případně zkráceně `/24` = říkáme jí předpona (prefix). Udává počet jedniček (délku síťové části v bitech z celkových 32 bitů IPv4).
    - Čím víc zařízení máme v síti, tím kratší masku potřebujeme (zbude víc pro hosty).
    
    *Způsoby přiřazení IP adres:*
    1. *Staticky* - přiřazeno správcem ručně - do zařízení (např. router, servery).
    2. *Dynamicky* - přiděleno *DHCP serverem* - dynamicky vkládá IP, Maska atd. Uživatele to zbavuje složité konfigurace a dává se jim ta adresa na zapůjčení (Lease time). Běžné u koncových zařízení.
    
    *Rozsah podsítě tvoří:*
    - *Adresa sítě:* Je první možná kombinace bitů (všechny host bity mají hodnotu 0).
    - *Poslední možná kombinace:* Jsou samé jedničky = Výstupy, tedy broadcast adresa - používá se, když posíláme data na všechna zařízení v síti.
    
    Příklad s maskou `255.255.255.0` - prefix `/24`: Rozsah je `0` až `255`, použitelný rozsah adres je od `.1` po `.254`.
    (`0` síťová adresa, `255` broadcast).

    Příklad: `192.168.20.0/24` (host-130) -> adresa je ve třídě C
    Síťová adresa: `192.168.20.0`
    První použitelná: `192.168.20.1`
    Broadcast: `192.168.20.255`
    Maska: `255.255.255.0`
    
    = Síťové třídy a CIDR
    Adresy jsou historicky rozděleny do skupiny A až E podle prvního bytu, tedy podle prvního čísla (od 0 - 255). Třídy určovaly defaultní masku (A = /8, B = /16, C = /24).
    
    - *Třída A:* první bit IP je 0 (rozsah sítí od 1.0.0.0 až 126.255.255.255) a z toho logicky plyne první oktet `1-126`. V každé síti je přibližně 16 milionů IP. Defaultní maska sítě byla `255.0.0.0`. Jsou určeny pro velké nadnárodní firmy.
      - _Poznámka:_ Síť `127.0.0.0` je vyhrazena pro *Loopback* (např. `127.0.0.1` označuje localhost samotného počítače pro testování).
    - *Třída B:* počáteční bity adresy jsou 10. Má rozsah sítí začínající čísly 128-191. Na každou síť připadne zhruba 65 tisíc hostů. Defaultní maska sítě byla `255.255.0.0`. Uplatnění pro středně velké sítě (univerzity).
    - *Třída C:* počáteční bity adresy jsou 110. První oktet je pro rozsah 192-223. Maska podsítě is `255.255.255.0`. Mají mnohem více podsítí, ale každá má kapacitu hostů pouze 254. Určeno pro malé sítě.
    - *Třída D:* rozsah 224.0.0.0 - 239.255.255.255. Vyhrazena pro specifický provoz typu *Multicast*.
    - *Třída E:* rozsah 240.0.0.0 - 255.255.255.255. *Experimentální* použití.

    Zavedení tříd začalo být neefektivní. Rozsah IP z důvodů spotřebovávání adres se rychle vyčerpával. Způsob rozdělení do tříd byl proto nahrazen beztřídním IP adresováním:
    *CIDR (Classless Inter-Domain Routing)* a *VLSM (Variable Length Subnet Mask)*, které jsou pružnější a neomezují masku podle prvního oktetu. Maska se tak může oddělit a libovolně využívat napříč prvními čísly v IP adrese (například použít /24 na adrese začínající na 10.).

    = Proč vytvářet podsítě (Subnetting)?
    Rozdělení jedné velké sítě na menší podsítě se provádí z několika klíčových důvodů:
    - *Efektivnější využití IP adres:* Neplýtváme adresami tam, kde je nepotřebujeme.
    - *Snížení síťového provozu:* Zmenšení broadcastových domén (broadcasty nezahlcují celou obří síť, ale jen danou podsíť).
    - *Zvýšení bezpečnosti:* Jednotlivé podsítě lze mezi sebou oddělit a filtrovat na routeru/firewallu.
    - *Lepší organizace sítě:* Logické rozdělení sítě podle oddělení (např. podsíť pro IT, podsíť pro účtárnu, podsíť pro hosty).

    #pagebreak()

    = Výpočet IP adres
    == 1.1 Síť, broadcast, první a poslední host
    *IP adresa: 180.100.200.101 / 18*
    
    1. Převod masky na binární. /18 znamená 18 jedniček zleva (následováno 14 nulami do 32)
       `11111111.11111111.11000000.00000000` (Binárně)
       `255.255.192.0` (Decimálně)
    
    2. Identifikace důležitého oktetu. Oktet s jedničkami a nulami. Jsou v něm obsaženy jak síťové tak i hostovské bity. (V našem případě 3. oktet: 11000000, odpovídající desetinnému 192)
    
    3. Převod důležitého oktetu (3. oktet) IP na binární. (200 = `11001000`)
    
    4. Logický AND (logický součin) síťového oktetu IP a masky. Tím zjistíme síťový oktet pro adresu sítě.
       Oktet IP: `11001000` (200)
       Oktet Masky: `11000000` (192)
       AND: `11000000` (192)
       (Adresa sítě: první oktety beze změny (tam kde byla maska 255), důležitý oktet zjistěn výše a kde byla maska 0 bude 0). Adresa sítě je tedy: `180.100.192.0`.
       
    5. Pro zjištění Broadcastu provedeme v důležitém oktetu AND masky negované (logický OR mezi IP a negovanou maskou). Převedeme nuly masky na 1 (v oktetu).
       Oktet Masky neg.: `00111111`
       Oktet Sítě: `11000000`
       Výsledek: `11111111` = 255. Broadcast = `180.100.255.255`
    
    6. První a poslední použitelná
       První host: Síť + 1 bit v posledním oktetu = `180.100.192.1`
       Poslední host: Broadcast - 1 bit v posledním oktetu = `180.100.255.254`

    == 1.2 Adresa subnetu
    *IP Adresa: 172.16.153.70 / 22*
    
    1. Převod podsítě na masku (22 -> 22 jedniček) = `255.255.252.0`. Důležitý oktet je 3. (252).
    2. Převod do binární IP adresy. Důležitý je 3. oktet: (153 = `10011001`)
    
    3. AND podsítě s IP adresou.
       IP: `10011001` (153)
       Maska: `11111100` (252)
       AND: `10011000` (152) -> Tento třetí oktet patří adrese sítě.
       Adresa sítě (subnet ID) = `172.16.152.0`

    == 1.3 Počet subnetů a hostů
    Pokud víme, že výchozí (Classful) maska naší sítě (172.16.0.0/16) byla /16 (čemuž odpovídá počátek na 172) a my nyní používáme masku /22. O kolik bitů jsme si "vypůjčili" pro podsiťování? Zvětšili jsme prefix z 16 na 22, tzn. přidali jsme 6 bitů.
    Počet podsítí ze zápůjčených bitů je tedy $2^6$ (protože každý bit má dva stavy: 0 a 1) = 64 možných podsítí.
    
    Počet hostů v podsíti se dá vypočítat ze "zbytkových bitů" po prefixu.
    32 (všechny bity) - 22 (použitý prefix) = 10 bitů zbývá na hosty.
    Pro počet hostů se udává vzorec $2^n - 2$ (kde 2 adresy odečítáme pro samotnou síť a pro broadcast).
    Tedy $2^10 - 2 = 1024 - 2$ = 1022 použitelných hostů.

    == 1.4 Příklad od kamaráda (Rychlý výpočet podsítě /26)
    *IP adresa: 192.168.0.175 / 26*

    1. *Určení masky:* Prefix `/26` znamená 26 jedniček zleva, což odpovídá masce `255.255.255.192`.
    2. *Počet bitů pro hosty:* $32 - 26 = 6$ bitů.
    3. *Velikost podsítě (celkový počet adres):* $2^6 = 64$ adres.
    4. *Počet použitelných adres (hostů):* $2^6 - 2 = 62$ adres (odečítáme adresu sítě a broadcast).
    5. *Určení rozsahu (skoky po 64):*
       - 1. podsíť: `0 - 63`
       - 2. podsíť: `64 - 127`
       - 3. podsíť: `128 - 191` (Zde leží naše IP adresa .175, toto je naše síť)
       - 4. podsíť: `192 - 255`

    #v(1em)
    #table(
      columns: (1.5fr, 2fr),
      inset: 8pt,
      align: left,
      fill: (col, row) => if row == 0 { navy } else if calc.odd(row) { luma(240) } else { white },
      table.header(
        text(fill: white, weight: "bold")[Položka],
        text(fill: white, weight: "bold")[Hodnota],
      ),
      [Zadaná adresa], [192.168.0.175/26],
      [Maska podsítě], [255.255.255.192],
      [Adresa sítě], [192.168.0.128],
      [První použitelná IP], [192.168.0.129],
      [Poslední použitelná IP], [192.168.0.190],
      [Broadcast adresa], [192.168.0.191],
      [Počet hostovských bitů], [6 bitů],
    )
    
  ],
  resources: [
    - #link("[https://cs.wikipedia.org/wiki/IPv4](https://cs.wikipedia.org/wiki/IPv4)")[Wiki - IPv4]
    - #link("[https://cs.wikipedia.org/wiki/IPv6](https://cs.wikipedia.org/wiki/IPv6)")[Wiki - IPv6]
    - #link("[https://cs.wikipedia.org/wiki/T%C5%99%C3%ADdy_IP_adres](https://cs.wikipedia.org/wiki/T%C5%99%C3%ADdy_IP_adres)")[Wiki - Třídy IP adres]
    - #link("[https://cs.wikipedia.org/wiki/Podsi%C5%A5](https://cs.wikipedia.org/wiki/Podsi%C5%A5)")[Wiki - Podsíť (Subnet)]
  ],
)
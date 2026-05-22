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
    
    = IPv4 <ipv4>
    
    - Formát IP adresy, kterým je zařízení viditelné pro internet, je zapsán v tzv. dekadickém tečkovaném formátu.
    - Počet adres: cca 4,3 miliardy ($2^32$)
    
    IPv4 je tvořena 4 bajty = 4 oktety:
    - Binárně:
      - `11000000.10101000.00000001.00000001`
      - Tedy např: `192.168.1.1`
      - `1bajt.1bajt.1bajt.1bajt`
      - `8bitů.8bitů.8bitů.8bitů`
      - Celkem = 32 bitů = (_2^32 možných kombinací_)
    - Decimálně:
      - Např. `192.168.1.1`
    
    Adresa se skládá z Network ID (id sítě) a z Host ID (id hosta v síti).
    _Příklad:_ IP adresa `192.168.1.5` / 24 bitů = část sítě je `192.168.1._` (ID sítě) a část hosta (ID hosta) je `_._._.5`.
    (Znamená masku `255.255.255.0` a síť `192.168.1.0`).

    V případě, že maska označuje jiné číslo než násobek 8 (např. /26), pak se důležitý oktet stává ten, který obsahuje jak bity sítě, tak bity hosta (např. `192.168.0.175 /26` -> důležitý je 4. oktet, protože maska je `255.255.255.192`) IPv4 má 32 bitů - `8+8+8+8` -> když je maska `/26`, znamná to `8+8+8+2` -> bereme tedy první dva bity z bitového zápisu zleva -> `11000000` -> `128 + 64 = 192`.

    / Určení rozsahu (skoky po 64):
      - 1. podsíť: `0 - 63`
      - 2. podsíť: `64 - 127`
      - 3. podsíť: `128 - 191` 
      - 4. podsíť: `192 - 255`

    Máme 4 podsítě (skoky po 64) a v každé podsíti je 62 použitelných hostů (celkem 64 adres, ale první adresa je adresa sítě a poslední adresa je broadcast).

    Pro námi zvolenou masku `/26` to znamná, že se nachází ve 4. podsíti (192-255) a rozsah použitelných hostů je od `192.168.0.193` do `192.168.0.254`.
    
    = IPv6 <ipv6>
    - Nástupce protokolu IPv4; využívá se 128 bitů, tedy delší adresy (do budoucna by měly vydržet napořád, ale to se říkalo i o IPv4).
    - *Počet adres:* cca $3.4 times 10^{38}$ (340 sextilionů). V IPv6 se adresami nešetří.
    - *Absence broadcastu:* IPv6 již *vůbec nevyužívá broadcast* (všesměrové vysílání). Nahrazuje ho efektivnějším *multicastem* (vysíláním pro skupinu) a *anycastem*. Díky tomu se v podsíti neodečítají 2 adresy pro hosty jako u IPv4.

    == Dual Stack (IPv4/IPv6)
    Umožňuje mít na PC aktivní jak IPv4 protokol, tak IPv6. Protokoly existují vedle sebe, fungují a pokud se připojíme na IPv4 server, tak jede IPv4, na IPv6 serveru zase IPv6.

    == Změna formátu IPv6 adresy ve srovnání se stávající IPv4
    - *IPv4*:
      Zápis se člení do 4 oktetů po 8 bitech:
      `192.168.1.1` (maska `255.255.255.0`)

    - *IPv6*:
      Zápis se člení na osm 16bitových částí (hextetů), každá ze 4 hexadecimálních znaků:
      `2001:0DB8:0000:0000:0000:0000:1428:57ab`
      
      *Pravidla zkracování zápisu:*
      1. Každou skupinu lze zkrátit o vedoucí nuly zleva (`0DB8` $arrow.r$ `DB8`).
      2. Souvislá řada skupin obsahující pouze samé nuly se dá nahradit symbolem `::` (lze použít *pouze jednou* v celé adrese).
       Výsledný zkrácený zápis: `2001:DB8::1428:57ab`

    == Architektura adresy a vytváření podsítí <architektura-ipv6>
    U IPv6 se nepoužívá maska v decimálním formátu, ale výhradně prefixový zápis (např. `/64`). Adresa je standardně rigidně rozdělena přesně na polovinu:

    / Síťová část (prvních 64 bitů):
      Obsahuje globální směrovací prefix od poskytovatele a ID podsítě.
    
    / Interface ID (posledních 64 bitů):
      Identifikátor konkrétního rozhraní hosta. Může se generovat:
      - *Náhodně:* Moderní OS (kvůli ochraně soukromí).
      - *Mechanizmem EUI-64:* Odvodí se z unikátní MAC adresy síťové karty (vložením `FF:FE` doprostřed).

    === Subnetting (Tvorba podsítí)
    V IPv6 se bity pro hosty neodpočítávají binárně. Koncová uživatelská podsíť (LAN) má *vždy prefix `/64`*. Poskytovatel internetu (ISP) přidělí zákazníkovi větší blok adres:

    - *Příděl `/48`:* Na podsítě zbývá 16 bitů (celý 4. hextet). Lze vytvořit $2^{16} = 65\ 536$ podsítí o velikosti `/64`.
    - *Příděl `/56`:* Na podsítě zbývá 8 bitů. Lze vytvořit $2^8 = 256$ podsítí o velikosti `/64`.

    Při přídělu `/48` (např. `2001:db8:acad::/48`) tvoříš podsítě pouhým inkrementováním hodnoty ve 4. hextetu:
    - 1. podsíť: `2001:db8:acad:0001::/64`
    - 2. podsíť: `2001:db8:acad:0002::/64`
    - 3. podsíť: `2001:db8:acad:0003::/64`
    
    == Proč vzniklo IPv6?
    Hlavním důvodem vzniku byl malý adresní prostor. IPv4 nabízí celkem 4,3 miliardy adres (navíc byly neefektivně rozděleny (třídy)).
    IPv6 naproti tomu nabízí nepředstavitelný počet adres: 340 sextilionů.
    Dále má nativní podporu bezpečnosti (IPSec) a automatickou konfiguraci (SLAAC).

    == Získání IP adresy? <pridelovani-ip-adres>
    Pevné (statické) se přidělují bez ohledu na síť, na rozdíl od dynamických, které jsou přiděleny protokolem *DHCP* po připojení zařízení do sítě (obnovují se v čase).

    = IP (Internet Protocol)
    - Základní protokol fungující na síťové vrstvě (Network layer). Zajišťuje logické adresování zařízení (PC apod.) v datové síti a doručení dat z bodu A do bodu B.
    - IP adresa nemá fyzický vztah k zařízení. Je logická. S tímto protokolem musí pracovat i ostatní síťová zařízení (např. switch, router...).
    - Jsou dvě verze: IPv4 (32bit) a IPv6 (128bit). IPv4 adres je nedostatek a přechází se na IPv6.
    - Datový blok u IP adresy se nazývá paket, hlavička paketu obsahuje informace nutné k odeslání dat (musí vědět kam data zacílit).

    - IPv4 - 32bitová adresa, která je rozdělena tečkami do 4 dekadických čísel `0-255` (8 bitů na 1 oktet – `xxxxxxxx.xxxxxxxx.xxxxxxxx.xxxxxxxx`)
    
    #pagebreak()
    
    - IPv6 - 128bitová adresa (hexadecimální, část na osm 16bitových úseků oddělených dvojtečkou např. `2001:0DB8::1428:57ab`). Zkracování adres - více bloků ze samých nul lze nahradit dvěma dvojtečkami (lze uplatnit pouze jednou!).

    / Proces odeslání dat: PC má přidělenou svoji *zdrojovou (source) IP adresu*, která je zapsána v hlavičce a *cílovou (destination) IP adresu*. V hlavičce je taktéž zapsána tzv. verze protokolu. Paket posílá k routeru, který vyhledává podle sítě adresu (směrovací tabulku). Podle masky rozpozná, zda-li jsou ve stejné síti.

    == Privátní a veřejné adresy <privatni-verejne-adresy>
    
    / Privátní adresy: Privátní adresy jsou lokální uvnitř jedné sítě (domácí, firemní apd.). Jsou dostupné pouze uvnitř této sítě a nefungují přes internetové routery (NAT překlad). Byly vytvořeny kvůli nedostatku veřejných adres:

    #figure(
      image("../assets/rozsah-privatnich-ipv4.png", width: 70%),
      caption: "Rozsah privátních adres"
    )
    
    *Veřejná adresa* = Adresa přístupná odkudkoli z internetu. Jedinečná na světě (na rozdíl od lokálních adres - IP adresa může být všude u PC uvnitř sítě např. `192.168.1.1`).
    
    *Maska podsítě* = Používá se pro rozdělení IP na síť, podsíť atd.
    - IPv4 adresa se skládá ze dvou částí: Adresy sítě a Adresy zařízení (PC).
    - Funkce masky spočívá v tom, že „vykrývá“ bity, které udávají síť, tedy identifikuje jak velká část náleží síti a co zbylo je samotné PC (host).
    - Zápis masky: ve tvaru desetinných čísel `255.255.255.0` případně zkráceně `/24` = říkáme jí předpona (prefix). Udává počet jedniček (délku síťové části v bitech z celkových 32 bitů IPv4).
    - Čím víc zařízení máme v síti, tím kratší masku potřebujeme (zbude víc pro hosty).
    
    #pagebreak()

    == Způsoby přiřazení IP adres <zpusoby-prirazeni-ip-adres>
    1. *Staticky* - přiřazeno správcem ručně - do zařízení (např. router, servery).
    2. *Dynamicky* - přiděleno *DHCP serverem* - dynamicky vkládá IP, Maska atd. Uživatele to zbavuje složité konfigurace a dává se jim ta adresa na zapůjčení (Lease time). Běžné u koncových zařízení.
    
    *Rozsah podsítě tvoří:*
    - *Adresa sítě:* Je první možná kombinace bitů (všechny host bity mají hodnotu 0).
    - *Poslední možná kombinace:* Jsou samé jedničky = Výstupy, tedy broadcast adresa - používá se, když posíláme data na všechna zařízení v síti.
    
    Příklad s maskou `255.255.255.0` - prefix `/24`: Rozsah je `0` až `255`, použitelný rozsah adres je od `.2` po `.254`.
    (`0` síťová adresa, `255` broadcast, `1` si většinou zabírá router).

    Příklad: `192.168.20.0/24` (host-130) -> adresa je ve třídě C
    Síťová adresa: `192.168.20.0`
    První použitelná: `192.168.20.1`
    Broadcast: `192.168.20.255`
    Maska: `255.255.255.0`
    
    = Síťové třídy a CIDR <tridy-ipv4-adres>
    Adresy jsou historicky rozděleny do skupiny A až E podle prvního bytu, tedy podle prvního čísla (od 0 - 255). Třídy určovaly defaultní masku (A = /8, B = /16, C = /24).
    
    - *Třída A:* první bit IP je 0 (rozsah sítí od 1.0.0.0 až 126.255.255.255) a z toho logicky plyne první oktet `1-126`. V každé síti je přibližně 16 milionů IP. Defaultní maska sítě byla `255.0.0.0`. Jsou určeny pro velké nadnárodní firmy.
      - _Poznámka:_ Síť `127.0.0.0` je vyhrazena pro *Loopback* (např. `127.0.0.1` označuje localhost samotného počítače pro testování).
    - *Třída B:* počáteční bity adresy jsou 10. Má rozsah sítí začínající čísly 128-191. Na každou síť připadne zhruba 65 tisíc hostů. Defaultní maska sítě byla `255.255.0.0`. Uplatnění pro středně velké sítě (univerzity).
    - *Třída C:* počáteční bity adresy jsou 110. První oktet je pro rozsah 192-223. Maska podsítě is `255.255.255.0`. Mají mnohem více podsítí, ale každá má kapacitu hostů pouze 254. Určeno pro malé sítě.
    - *Třída D:* rozsah 224.0.0.0 - 239.255.255.255. Vyhrazena pro specifický provoz typu *Multicast*.
    - *Třída E:* rozsah 240.0.0.0 - 255.255.255.255. *Experimentální* použití.

    #figure(
      image("../assets/tridy-ipv4.png", width: 90%),
      caption: "Rozdělení IP adres do tříd"
    )

    Zavedení tříd začalo být neefektivní. Rozsah IP z důvodů spotřebovávání adres se rychle vyčerpával. Způsob rozdělení do tříd byl proto nahrazen beztřídním IP adresováním:
    *CIDR (_Classless Inter-Domain Routing_)* a *VLSM (_Variable Length Subnet Mask_)*, které jsou pružnější a neomezují masku podle prvního oktetu. Maska se tak může oddělit a libovolně využívat napříč prvními čísly v IP adrese (například použít /24 na adrese začínající na 10.).

    = Proč vytvářet podsítě (Subnetting)? <subnetting>
    Rozdělení jedné velké sítě na menší podsítě se provádí z několika klíčových důvodů:
    - *Efektivnější využití IP adres:* Neplýtváme adresami tam, kde je nepotřebujeme.
    - *Snížení síťového provozu:* Zmenšení broadcastových domén (broadcasty nezahlcují celou obří síť, ale jen danou podsíť).
    - *Zvýšení bezpečnosti:* Jednotlivé podsítě lze mezi sebou oddělit a filtrovat na routeru/firewallu.
    - *Lepší organizace sítě:* Logické rozdělení sítě podle oddělení (např. podsíť pro IT, podsíť pro účtárnu, podsíť pro hosty).

    = Výpočet IP adres
    == Síť, broadcast, první a poslední host
    *IP adresa: 180.100.200.101 / 18*
    
    1. Převod masky na binární. /18 znamená 18 jedniček zleva (následováno 14 nulami do 32)
       `11111111.11111111.11000000.00000000` (Binárně)
       `255.255.192.0` (Decimálně)
    
    2. Identifikace důležitého oktetu. Oktet s jedničkami a nulami. Jsou v něm obsaženy jak síťové tak i hostovské bity. (V našem případě 3. oktet: 11000000, odpovídající desetinnému 192)

    #pagebreak()
    
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

    == Počet subnetů a hostů
    *IP Adresa: 172.16.153.70 / 22*
    
    1. Převod podsítě na masku (22 -> 22 jedniček) = `255.255.252.0`. Důležitý oktet je 3. (252).
    2. Převod do binární IP adresy. Důležitý je 3. oktet: (153 = `10011001`)
    
    3. AND podsítě s IP adresou.
       IP: `10011001` (153)
       Maska: `11111100` (252)
       AND: `10011000` (152) -> Tento třetí oktet patří adrese sítě.
       Adresa sítě (subnet ID) = `172.16.152.0`

    == Počet subnetů a hostů
    Pokud víme, že výchozí (Classful) maska naší sítě (172.16.0.0/16) byla /16 (čemuž odpovídá počátek na 172) a my nyní používáme masku /22. O kolik bitů jsme si "vypůjčili" pro podsiťování? Zvětšili jsme prefix z 16 na 22, tzn. přidali jsme 6 bitů.
    Počet podsítí ze zápůjčených bitů je tedy $2^6$ (protože každý bit má dva stavy: 0 a 1) = 64 možných podsítí.
    
    Počet hostů v podsíti se dá vypočítat ze "zbytkových bitů" po prefixu.
    32 (všechny bity) - 22 (použitý prefix) = 10 bitů zbývá na hosty.
    Pro počet hostů se udává vzorec $2^n - 2$ (kde 2 adresy odečítáme pro samotnou síť a pro broadcast).
    Tedy $2^10 - 2 = 1024 - 2$ = 1022 použitelných hostů.

    == Příklad od kamaráda (Rychlý výpočet podsítě /26)
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
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaké verze IP adres aktuálně máme, jaké jsou jejich délky, množství použitelných adres a jaký je způsob jejich zápisu"
      #v(1em)
      > @ipv4

      > @ipv6
    ]

    Máme dvě verze IP adres: IPv4 (32bit, cca 4,3 miliardy adres, zápis v dekadickém tečkovaném formátu) a IPv6 (128bit, cca 340 sextilionů adres, zápis v hexadecimálním formátu s dvojtečkami).

    / Zápis a množství adres u IPv4: 
      Zápis se člení do 4 oktetů po 8 bitech oddělených tečkou (např. `192.168.1.1` - bitový zápis: `11000000.10101000.00000001.00000001`).
      
      Z každého přiděleného rozsahu (podsítě) lze pro koncové hosty použít pouze část adres. Vždy je nutné *odečíst 2 adresy*:
      
      - Úplně první adresa je *adresa sítě* (např. `192.168.1.0` při masce `/24`).
      - Úplně poslední adresa je *broadcast* (např. `192.168.1.255` při masce `/24`).
      
      _Poznámka z praxe:_ Pro koncové počítače se počet adres sníží o další jednu adresu, kterou si pro sebe zabere rozhraní routeru jako výchozí brána ("Default Gateway") – typicky první použitelná adresa v síti (např. `192.168.1.1`). Pro masku `/24` tedy zbývá `256 - 2 (síť a broadcast) - 1 (router) = 253` adres pro koncové stanice.

    / Zápis a množství adres u IPv6:
      Zápis se člení na osm 16bitových částí (hextetů) oddělených dvojtečkou. Zápis lze zkrátit odstraněním vedoucích nul zleva a nahrazením souvislých bloků nul symbolem `::` (maximálně jednou v celé adrese, např. `2001:DB8::1428:57ab`).
      
      U IPv6 se adresami nešetří a množství použitelných adres funguje na základě standardizovaných bloků (prefixů):
      - *V koncové podsíti (/64):* Každá jedna běžná uživatelská síť (LAN) má rigidní velikost `/64`. To znamená, že v jedné síti je k dispozici $2^(64)$ adres (cca 18,4 trilionu). V IPv6 *neexistuje broadcast*, takže se pro něj neodpočítává žádná adresa.
      - *Příděl od ISP:* Poskytovatel internetu nepřiděluje koncovým zákazníkům jednotlivé adresy, ale rovnou celé velké bloky. Běžná domácnost nebo firma dostane příděl *`/56`* (což představuje $2^8 = 256$ nezávislých podsítí o velikosti `/64`) nebo *`/48`* (což představuje $2^(16) = 65\ 536$ podsítí o velikosti `/64`).
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište strukturu a části IPv4 adresy, použití masky sítě"
      #v(1em)
      > @ipv4
    ]

    / Zápis a množství adres u IPv4: 
      Zápis se člení do 4 oktetů po 8 bitech oddělených tečkou (např. `192.168.1.1` - bitový zápis: `11000000.10101000.00000001.00000001`).
      
      Z každého přiděleného rozsahu (podsítě) lze pro koncové hosty použít pouze část adres. Vždy je nutné *odečíst 2 adresy*:
      
      - Úplně první adresa je *adresa sítě* (např. `192.168.1.0` při masce `/24`).
      - Úplně poslední adresa je *broadcast* (např. `192.168.1.255` při masce `/24`).
      
    #pagebreak()

      #block(
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
      )[
        _Poznámka z praxe:_ Pro koncové počítače se počet adres sníží o další jednu adresu, kterou si pro sebe zabere rozhraní routeru jako výchozí brána ("Default Gateway") – typicky první použitelná adresa v síti (např. `192.168.1.1`). Pro masku `/24` tedy zbývá `256 - 2 (síť a broadcast) - 1 (router) = 253` adres pro koncové stanice.
      ]

      V případě, že maska označuje jiné číslo než násobek 8 (např. /26), pak se důležitý oktet stává ten, který obsahuje jak bity sítě, tak bity hosta (např. `192.168.0.175 /26` -> důležitý je 4. oktet, protože maska je `255.255.255.192`) IPv4 má 32 bitů - `8+8+8+8` -> když je maska `/26`, znamná to `8+8+8+2` -> bereme tedy první dva bity z bitového zápisu zleva -> `11000000` -> `128 + 64 = 192`.

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Vyjmenujte a popište jednotlivé třídy IPv4 adres"
      #v(1em)
      > @tridy-ipv4-adres
    ]

    Adresy jsou historicky rozděleny do skupiny A až E podle prvního bytu, tedy podle prvního čísla (od 0 - 255). Třídy určovaly defaultní masku (A = /8, B = /16, C = /24).
    
    - *Třída A:* první bit IP je 0 (rozsah sítí od 1.0.0.0 až 126.255.255.255) a z toho logicky plyne první oktet `1-126`. V každé síti je přibližně 16 milionů IP. Defaultní maska sítě byla `255.0.0.0`. Jsou určeny pro velké nadnárodní firmy.
      - _Poznámka:_ Síť `127.0.0.0` je vyhrazena pro *Loopback* (např. `127.0.0.1` označuje localhost samotného počítače pro testování).
    - *Třída B:* počáteční bity adresy jsou 10. Má rozsah sítí začínající čísly 128-191. Na každou síť připadne zhruba 65 tisíc hostů. Defaultní maska sítě byla `255.255.0.0`. Uplatnění pro středně velké sítě (univerzity).
    - *Třída C:* počáteční bity adresy jsou 110. První oktet je pro rozsah 192-223. Maska podsítě is `255.255.255.0`. Mají mnohem více podsítí, ale každá má kapacitu hostů pouze 254. Určeno pro malé sítě.
    - *Třída D:* rozsah 224.0.0.0 - 239.255.255.255. Vyhrazena pro specifický provoz typu *Multicast*.
    - *Třída E:* rozsah 240.0.0.0 - 255.255.255.255. *Experimentální* použití.

    #figure(
      image("../assets/tridy-ipv4.png", width: 90%),
      caption: "Rozdělení IP adres do tříd"
    )    
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Vysvětlete pojem veřejné a privátní adresy, privátní vyjmenujte"
      #v(1em)
      > @privatni-verejne-adresy
    ]

    / Privátní adresy: Privátní adresy jsou lokální uvnitř jedné sítě (domácí, firemní apd.). Jsou dostupné pouze uvnitř této sítě a nefungují přes internetové routery (NAT překlad). Byly vytvořeny kvůli nedostatku veřejných adres:

    #figure(
      image("../assets/rozsah-privatnich-ipv4.png", width: 70%),
      caption: "Rozsah privátních adres"
    )
    
    *Veřejná adresa* = Adresa přístupná odkudkoli z internetu. Jedinečná na světě (na rozdíl od lokálních adres - IP adresa může být všude u PC uvnitř sítě např. `192.168.1.1`).
   
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište strukturu a části IPv6 adresy"
      #v(1em)
      > @architektura-ipv6
    ]

    IPv6 využívá 128 bitů, tedy delší adresy (do budoucna by měly vydržet napořád, ale to se říkalo i o IPv4).

    - *Absence broadcastu:* IPv6 již *vůbec nevyužívá broadcast* (všesměrové vysílání). Nahrazuje ho efektivnějším *multicastem* (vysíláním pro skupinu) a *anycastem*. Díky tomu se v podsíti neodečítají 2 adresy pro hosty jako u IPv4.

    ==== Formát IPv6 adresy

      Zápis se člení na osm 16bitových částí (hextetů), každá ze 4 hexadecimálních znaků:
      `2001:0DB8:0000:0000:0000:0000:1428:57ab`
      
      *Pravidla zkracování zápisu:*
      1. Každou skupinu lze zkrátit o vedoucí nuly zleva (`0DB8` $arrow.r$ `DB8`).
      2. Souvislá řada skupin obsahující pouze samé nuly se dá nahradit symbolem `::` (lze použít *pouze jednou* v celé adrese).
       Výsledný zkrácený zápis: `2001:DB8::1428:57ab`

    ==== Architektura adresy a vytváření podsítí
    U IPv6 se nepoužívá maska v decimálním formátu, ale výhradně prefixový zápis (např. `/64`). Adresa je standardně rigidně rozdělena přesně na polovinu:

    / Síťová část (prvních 64 bitů):
      Obsahuje globální směrovací prefix od poskytovatele a ID podsítě.
      Např. `2001:db8:acad::/48` - globální směrovací prefix je `2001:db8:acad` a zbytek (poslední 16 bitů) je pro ID podsítě.
    
    / Interface ID (posledních 64 bitů):
      Identifikátor konkrétního rozhraní hosta. Může se generovat:
      - *Náhodně:* Moderní OS (kvůli ochraně soukromí).
      - *Mechanizmem EUI-64:* Odvodí se z unikátní MAC adresy síťové karty (vložením `FF:FE` doprostřed).

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Statické a dynamické přidělování IP adres"
      #v(1em)
      > @pridelovani-ip-adres

      > @zpusoby-prirazeni-ip-adres
    ]

    *Manuálně* - *statické* přidělování IP adres se používá pro zařízení, která musí mít vždy stejnou adresu (např. routery, servery). Správce sítě ručně nastaví IP adresu, masku a další parametry přímo v konfiguraci zařízení.

    *Automaticky* - *dynamické* přidělování IP adres se provádí pomocí protokolu *DHCP* (Dynamic Host Configuration Protocol). Když se zařízení připojí k síti, DHCP server mu automaticky přiřadí volnou IP adresu z definovaného rozsahu (poolu), spolu s maskou, výchozí bránou a DNS servery. Tato adresa je obvykle "zapůjčena" na určitou dobu (lease time) a může se po uplynutí obnovit nebo změnit.    
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Důvody vytváření podsítí"
      #v(1em)
      > @subnetting
    ]

    Rozdělení jedné velké sítě na menší podsítě se provádí z několika klíčových důvodů:
    - *Efektivnější využití IP adres:* Neplýtváme adresami tam, kde je nepotřebujeme.
    - *Snížení síťového provozu:* Zmenšení broadcastových domén (broadcasty nezahlcují celou obří síť, ale jen danou podsíť).
    - *Zvýšení bezpečnosti:* Jednotlivé podsítě lze mezi sebou oddělit a filtrovat na routeru/firewallu.
    - *Lepší organizace sítě:* Logické rozdělení sítě podle oddělení (např. podsíť pro IT, podsíť pro účtárnu, podsíť pro hosty).
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=5WfiTHiU4x8")[Youtube - what is an IP Address?]
    - #link("https://youtube.com/playlist?list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF&si=DuPzaEKCCgMG0hZU")[Youtube - Subnetting]

  ],
)
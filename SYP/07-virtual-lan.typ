#import "../template.typ": header, theme

#show: body => header(
  title: "VLAN, Inter-VLAN routing a agregace linek",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    VLAN (Virtual Local Area Network) slouží k logickému rozdělení sítě nezávisle na fyzickém uspořádání. Umožňuje segmentovat síť na menší logické celky uvnitř jedné fyzické struktury, obvykle na úrovni přepínačů (L2). Tímto dosahujeme oddělení provozu, zvýšení bezpečnosti a snížení zátěže sítě (broadcastů).

    #set heading(numbering: "1.1")

    = Výhody a principy VLAN

    VLAN vytváří menší broadcastové domény, což vede k efektivnějšímu využití šířky pásma. Mezi hlavní výhody patří:
    - *Snížení broadcastů:* Zlepšení výkonu sítě omezením zbytečného provozu.
    - *Zjednodušená správa:* Přesun uživatele do jiné sítě vyžaduje pouze SW konfiguraci, nikoliv fyzické přepojování kabelů.
    - *Zabezpečení:* Oddělení citlivého provozu do izolovaných sítí.
    - *Snížení nákladů na HW:* Na jednom fyzickém switchi může běžet více virtuálních podsítí.

    = Metody zařazení do VLAN

    / Podle portu: Nejpoužívanější a nejrychlejší řešení. Port je napevno přiřazen konkrétní VLAN (Static VLAN).
    / Podle MAC adresy: Dynamické zařazení. Zařízení je po připojení do libovolného portu zařazeno do správné VLAN na základě své fyzické adresy (náročné na správu tabulek).
    / Podle protokolu: Na základě informací ze 3. vrstvy. V praxi méně rozšířené a pomalejší.
    / Podle autentizace: Využívá protokol IEEE 802.1x k ověření uživatele, který je následně automaticky umístěn do příslušné VLAN.

    = Propojení switchů a Trunking
    VLAN na jednom switchi komunikují interně v rámci operační paměti. Pro přenos mezi více přepínači se používají:
    - *Access porty:* Pro koncová zařízení, patří vždy do jedné VLAN.
    - *Trunk porty:* Přenáší provoz více VLAN přes jeden kabel.

    == IEEE 802.1q Tagging (dot1q)
    Standardizovaná metoda, kde je hlavička originálního rámce rozšířena o *4B (čtyřbajtovou)* informaci. Obsahuje ID protokolu, prioritu a číslo VLAN. Protože dochází k zásahu do hlavičky, musí být na konci rámce přepočítán kontrolní součet.

    == Native VLAN
    Nastavuje se na trunk portech. Provoz v této VLAN se při přenosu *netaguje*. Je nutné ji nastavit shodně na obou stranách trunku (často se využívá pro management).

    = VLAN Trunking Protocol (VTP)
    Proprietární Cisco protokol, který automatizuje správu VLAN (přidávání, mazání, přejmenování) v rámci celé VTP domény. Zařízení se stejným jménem domény a heslem si synchronizují databázi VLAN přes trunk linky.

    = Agregace linek a LACP
    Metoda kombinování více fyzických připojení do jednoho logického kanálu pro zvýšení propustnosti a zajištění redundance (pokud jedna linka selže, ostatní převýší provoz).
    - *LACP (Link Aggregation Control Protocol):* Metoda kontroly svazku, která umožňuje zařízením automaticky sjednat vznik logického kanálu.
    - Agregaci lze aplikovat na 1. vrstvě (bezdrát), 2. vrstvě (porty switche) i 3. vrstvě (rozdělení procesů, hashování).

    = Inter-VLAN Routing
    Různé VLAN spolu standardně nekomunikují. Pro propojení je nutné směrování na 3. vrstvě:
    1. *Traditional:* Každá VLAN má vlastní fyzický kabel vedoucí do samostatného portu routeru. (Neefektivní).
    2. *Router on a Stick (RoaS):* Router a switch jsou propojeny jedním kabelem (trunk). VLAN jsou na routeru řešeny pomocí virtuálních *subinterfaces* (např. `G0/0.10`).
    3. *Multilayer Switch (L3):* Směrování probíhá přímo na switchi pomocí *SVI (Switch Virtual Interface)*. Je to nejrychlejší metoda, nevyžaduje externí zařízení.

    = Základní konfigurace (Cisco IOS)
    ```cisco_ios
    // Vytvoření VLAN
    S1(config)# vlan 10
    S1(config-vlan)# name Management

    // Přiřazení portu do VLAN
    S1(config)# interface fa0/6
    S1(config-if)# switchport mode access
    S1(config-if)# switchport access vlan 10

    // Konfigurace Trunku
    S1(config-if)# switchport mode trunk
    
    // Ověření a správa
    S1# show vlan brief
    S1(config)# no vlan 10
    ```
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Virtual_LAN")[Wiki — Virtual LAN]
    - #link("https://en.wikipedia.org/wiki/IEEE_802.1Q")[IEEE 802.1Q Tagging]
    - #link("https://www.cisco.com")[Cisco — VTP & LACP Documentation]
  ],
)
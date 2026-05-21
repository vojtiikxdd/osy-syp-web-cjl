#import "../template.typ": header, theme

#show: body => header(
  title: "Síťová vrstva, ARP a základní konfigurace routeru",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    *Síťová vrstva* (Network Layer) je třetí vrstvou referenčního modelu OSI. Zajišťuje logické adresování a end-to-end komunikaci mezi koncovými zařízeními skrz celou síť — na rozdíl od datalinkové vrstvy, která řeší pouze přenos mezi sousedními uzly.

    *Síťová vrstva potřebuje ke správnému fungování funkční vrstvu 2 a 1, vrstva 3 sama o sobě nefunguje*

    / Hlavní funkce síťové vrstvy:
      - *Adresování:* Přiřazení logické IP adresy zařízením.
      - *Směrování (Routing):* Výběr nejlepší cesty paketu napříč různými sítěmi.
      - *Fragmentace paketů:* Rozdělení velkých dat na menší části, pokud to vyžaduje přenosové médium.

    #set heading(numbering: "1.1")

    = Integrace do modelu OSI

    Síťová vrstva přijímá od *transportní vrstvy* (vrstva 4) *segment*, přidá vlastní hlavičku (obsahující zdrojovou a cílovou IP) a vznikne *paket*. Ten putuje sítí nezávisle -- pořadí doručení paketů nemusí odpovídat pořadí odeslání, spolehlivost doručení zajišťují vyšší vrstvy (TCP).

    Na síťové vrstvě pracují *routery*, které na základě cílové IP adresy a směrovací tabulky vybírají nejlepší cestu paketu k cíli. Každé koncové zařízení (*host*) má přiřazenu jedinečnou síťovou adresu.

    = Protokoly síťové vrstvy <protokoly-sitove-vrstvy>

    / IP (Internet Protocol):
      Základní protokol vrstvy pro adresování (IPv4, IPv6). Je to protokol *best-effort* — doručení paketu není zaručeno, pakety putují sítí nezávisle na sobě.

    / ICMP (Internet Control Message Protocol):
      Slouží k diagnostice sítě a oznamování chyb (využívají ho nástroje jako `ping` nebo `traceroute`).

    / IPsec:
      Sada protokolů pro zabezpečení a šifrování IP komunikace.

      Patří sem třeba:

      / AH - _Authentication Header_: Poskytuje autentizaci a integritu dat, ale nešifruje obsah.

      / ESP - _Encapsulating Security Payload_: Poskytuje autentizaci, integritu a šifrování dat.

      / ISAKMP - _Internet Security Association and Key Management Protocol_: Protokol pro výměnu klíčů a správu bezpečnostních asociací mezi zařízeními.

        / IKE, IKEv2 - _Internet Key Exchange_: Protokoly pro automatickou výměnu klíčů a nastavení bezpečnostních asociací pro IPsec.

        / KINK - _Kerberized Internet Negotiation of Keys_: Protokol pro výměnu klíčů založený na Kerberosu, který může být použit jako alternativa k IKE.

    / TTL (_Time To Live_ - _Doba života_):
      Položka v IP hlavičce (běžně např. hodnota 64). Každý průchod paketu přes router (hop) sníží hodnotu TTL o 1. Pokud klesne na 0, router paket zahodí. Slouží jako ochrana proti nekonečnému zacyklení paketu v síti.

    = IP adresy a jejich struktura <ip-adresy>

    / IPv4 (32 bitů):
      - Formát: `xxx.xxx.xxx.xxx` (každé číslo 0--255).
      - Dnes trpí nedostatkem adresního prostoru (~4,3 miliardy adres).
      - *Struktura adresy:* IPv4 se dělí na *síťovou část* (Network) a *hostitelskou část* (Host).
      - *Maska sítě:* Určuje, která část adresy patří síti a která hostiteli.
        - Např. Maska `/24` (`255.255.255.0`), maska `/16` (`255.255.0.0`).
      - *Příklad:* U IP `192.168.1.10` s maskou `255.255.255.0` je *síťová část* `192.168.1.0` a *hostitelská část* je `10`.

    / IPv6 (128 bitů):
      - Rozšíření adresního prostoru (zápis v hexadecimální soustavě, např. `2001:db8::1`).
      - Nativní podpora bezpečnosti (IPsec).
      - Defaultní gateway a adresa přijímána automaticky (SLAAC) — není potřeba ruční konfigurace.

    = ARP a RARP — propojení vrstvy 2 a 3 <arp>

    ARP (Address Resolution Protocol) tvoří most mezi datalinkovou a síťovou vrstvou — převádí IP adresu na MAC adresu, která je nutná pro skutečné doručení rámce ve stejné síti.

    == Průběh ARP komunikace

    + Odesílající zařízení chce poslat data na IP adresu a zkontroluje svou *ARP cache* (tabulku).
    + Pokud hledanou MAC adresu nezná, vyšle *ARP Request* jako broadcast (`FF:FF:FF:FF:FF:FF`): _"Kdo má IP 192.168.1.1? Pošlete mi MAC."_
    + Všechna zařízení v podsíti request přijmou, ale odpoví pouze to se shodnou IP.
    + Hledané zařízení odešle *ARP Reply* (unicast): _"Já, moje MAC je XX:XX:XX."_
    + Odesílající zařízení si výsledek uloží do ARP cache a odešle datový rámec.

    == Komunikace mimo lokální síť
    Pokud je cíl mimo lokální síť, data se posílají na výchozí bránu (router).
    - *IP adresa* v paketu = zůstává *cílová IP* (např. 8.8.8.8 v internetu).
    - *MAC adresa* v rámci = *MAC adresa routeru*.

    == RARP (Reverse ARP)

    Opak ARP — zařízení zná svoji MAC adresu, ale chce zjistit svoji IP adresu. Vyšle RARP Request jako broadcast, RARP server vyhledá v tabulce MAC→IP a odpoví přiřazenou IP adresou. Dnes nahrazen protokolem DHCP.

    = Co je router a jak funguje <funkce-routeru>

    *Router (směrovač)* je aktivní síťový prvek pracující na *3. (síťové) vrstvě OSI modelu*. Jeho hlavním úkolem je propojovat různé sítě (např. domácí LAN s internetem) a směrovat data mezi nimi.

    / Fungování routeru:
      Když router přijme paket, podívá se na jeho *cílovou IP adresu*. Tuto adresu porovná se svou *směrovací tabulkou (Routing Table)*, kde hledá nejlepší shodu (nejdelší prefix). 
      
      - Pokud cestu najde, přepošle paket na příslušné rozhraní.
      
      - Pokud cestu v tabulce nemá, pošle ji na tzv. *výchozí cestu (Default Route)*.
      
      - Pokud nemá ani výchozí cestu, paket zahodí a pošle odesílateli ICMP zprávu `Destination Unreachable`.
      
      #block(
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
      )[
        _Důležité:_ Router při přeposílání *mění linkovou (L2) hlavičku* (zdrojovou a cílovou MAC adresu), ale *IP hlavička (L3) zůstává nezměněná* (kromě snížení hodnoty TTL o 1).
      ]    

    == Konfigurační módy (Cisco IOS)
    Na zařízeních Cisco se pohybujeme v hierarchických režimech, které určují naše oprávnění:

    - *User EXEC mode* (`Router>`) -- Základní režim, umožňuje pouze prohlížení základních statistik, nelze nic měnit.
    - *Privileged EXEC mode* (`Router#`) -- Přístup pomocí příkazu `enable`. Umožňuje podrobné testování (`ping`, `traceroute`), prohlížení kompletní konfigurace (`show running-config`) a správu souborů.
    - *Global Configuration mode* (`Router(config)#`) -- Přístup přes `configure terminal`. Zde se provádí změny, které ovlivňují celé zařízení (např. název routeru).
    - *Interface mode* (`Router(config-if)#`) -- Přístup specifikováním rozhraní (např. `interface g0/0`). Slouží ke konfiguraci konkrétního portu (přidělení IP adresy, zapnutí).

    = Směrování paketů (Routing) 

    Router propojuje různé sítě a rozhoduje, kudy data půjdou dál.

    / Jak router pracuje krok za krokem:
      1. Přijme paket na rozhraní.
      2. Zkontroluje cílovou IP adresu v hlavičce.
      3. Podívá se do své *směrovací tabulky* (routing table). Záznamy prohledává od nejdelší masky k nejkratší (největší shoda).
      4. Vybere nejlepší cestu k cíli.
      5. Přepošle paket na další zařízení (next-hop).

    == Typy směrování

    / Statické směrování:
      Administrátor ručně definuje cesty. Vhodné pro malé sítě, žádná automatická adaptace na výpadky a změny topologie.

    / Dynamické směrování:
      Router se učí cesty automaticky od okolních routerů pomocí směrovacích protokolů. Adaptuje se na výpadky. Patří sem:
      - *RIP* (Routing Information Protocol) - jednodušší protokol založený na počtu přeskoků.
      - *OSPF* (Open Shortest Path First) - pokročilejší, bere v potaz rychlost a cenu linky, běžný ve firemních sítích.
      - *BGP* (Border Gateway Protocol) - hlavní protokol, který se stará o směrování v celém internetu.

    = Zabezpečení routeru <zabezpeceni-routeru>

    / Firewall: Filtruje příchozí komunikaci na základě zdrojové IP adresy a čísla portu. Blokuje podezřelý provoz.
    / Hesla: Oddělená hesla pro User EXEC, Privileged EXEC a vzdálený přístup. Doporučuje se používat `secret` (uložené jako hash) místo běžného `password`.
    / Fyzické zabezpečení: Router umístěn v zamčené místnosti nebo racku.
    / SSH místo Telnetu: Telnet přenáší vše v plaintextu (nezašifrovaně), SSH veškerou komunikaci včetně přihlašovacích údajů šifruje.

    = Základní konfigurace routeru (Cisco IOS) <konfigurace-routeru>

    == Přístupové metody a režimy
    - *Console port:* Přímé připojení pomocí rollover kabelu, nutné pro první konfiguraci.
    - *User EXEC (`>`):* Omezená práva, pouze zobrazení.
    - *Privileged EXEC (`#`):* Plný přístup ke konfiguraci (`enable`).
    - *Global Configuration (`(config)#`):* Globální nastavení zařízení (`configure terminal`).
    - *Interface Configuration (`(config-if)#`):* Konfigurace konkrétního rozhraní. Do nižší úrovně se vrací příkazem `exit`.

    == Základní příkazy a nastavení SSH

    ```cisco_ios
    hostname Router1                        // přejmenování zařízení

    enable secret HESLO                     // heslo pro privilegovaný mód (hashované)
    service password-encryption             // šifrování všech nechráněných hesel v konfiguraci

    // --- Nastavení rozhraní (připojení do sítě) ---
    interface gigabitethernet 0/0           // vstup do konfigurace konkrétního rozhraní
      ip address 192.168.1.1 255.255.255.0  // nastavení IP adresy a masky
      no shutdown                           // aktivace rozhraní (defaultně je vypnuté!)
      exit

    ip route 0.0.0.0 0.0.0.0 192.168.1.254  // nastavení výchozí (defaultní) cesty

    // --- Zabezpečení vzdáleného přístupu (SSH) ---
    ip domain-name example.com              // nastavení domény (nutné pro klíče)
    crypto key generate rsa                 // vygenerování RSA šifrovacích klíčů
    username admin privilege 15 secret heslo // vytvoření lokálního účtu pro přihlášení

    line vty 0 4                            // konfigurace virtuálních linek pro vzdálený přístup
      login local                           // vynutí přihlášení přes vytvořené lokální účty
      transport input ssh                   // povolí pouze bezpečné SSH (zakáže Telnet)
      exit

    // --- Zálohování a kontrola ---
    copy running-config startup-config      // uložení aktuální konfigurace do paměti NVRAM
    copy running-config tftp                // záloha konfigurace na vzdálený TFTP server

    show running-config                     // zobrazení aktuálně běžící konfigurace
    show ip interface brief                 // přehled všech rozhraní, jejich IP adres a stavu
    show ip route                           // zobrazení směrovací (routovací) tabulky
    show arp                                // zobrazení tabulky zjištěných MAC/IP adres

    ping 192.168.1.2                        // test konektivity (využívá ICMP)
    traceroute 192.168.1.2                  // sledování celé trasy paketu k cílovému zařízení
    ```

    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Poznámka k DHCP:* V síti musí být aktivní DHCP server pouze na jednom zařízení. Více DHCP serverů způsobí přidělení duplicitních IP adres a kolaps komunikace v celé síti.
    ]

  ],
  subquestions: [

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Protokoly používané na síťové vrstvě. Funkce síťové vrstvy. Charakteristika"
      #v(1em)
      > @protokoly-sitove-vrstvy
    ]

    / IP (Internet Protocol):
      Základní protokol vrstvy pro adresování (IPv4, IPv6). Je to protokol *best-effort* — doručení paketu není zaručeno, pakety putují sítí nezávisle na sobě.

    / ICMP (Internet Control Message Protocol):
      Slouží k diagnostice sítě a oznamování chyb (využívají ho nástroje jako `ping` nebo `traceroute`).

    / IPsec:
      Sada protokolů pro zabezpečení a šifrování IP komunikace.

      Patří sem třeba:

      / AH - _Authentication Header_: Poskytuje autentizaci a integritu dat, ale nešifruje obsah.

      / ESP - _Encapsulating Security Payload_: Poskytuje autentizaci, integritu a šifrování dat.

      / ISAKMP - _Internet Security Association and Key Management Protocol_: Protokol pro výměnu klíčů a správu bezpečnostních asociací mezi zařízeními.

        / IKE, IKEv2 - _Internet Key Exchange_: Protokoly pro automatickou výměnu klíčů a nastavení bezpečnostních asociací pro IPsec.

        / KINK - _Kerberized Internet Negotiation of Keys_: Protokol pro výměnu klíčů založený na Kerberosu, který může být použit jako alternativa k IKE.

    / TTL (_Time To Live_ - _Doba života_):
      Položka v IP hlavičce (běžně např. hodnota 64). Každý průchod paketu přes router (hop) sníží hodnotu TTL o 1. Pokud klesne na 0, router paket zahodí. Slouží jako ochrana proti nekonečnému zacyklení paketu v síti.

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Podrobně popište fungování routeru, postup jeho základní konfigurace a používané módy"
      #v(1em)
      > @funkce-routeru

      > @konfigurace-routeru
    ]

    *Router (směrovač)* je aktivní síťový prvek pracující na *3. (síťové) vrstvě OSI modelu*. Jeho hlavním úkolem je propojovat různé sítě (např. domácí LAN s internetem) a směrovat data mezi nimi.

    / Fungování routeru:
      Když router přijme paket, podívá se na jeho *cílovou IP adresu*. Tuto adresu porovná se svou *směrovací tabulkou (Routing Table)*, kde hledá nejlepší shodu (nejdelší prefix). 
      - Pokud cestu najde, přepošle paket na příslušné rozhraní.
      - Pokud cestu v tabulce nemá, pošle ji na tzv. *výchozí cestu (Default Route)*.
      - Pokud nemá ani výchozí cestu, paket zahodí a pošle odesílateli ICMP zprávu _Destination Unreachable_.

      #block(
        fill: luma(240),
        inset: 10pt,
        radius: 4pt,
      )[
        _Důležité:_ Router při přeposílání *mění linkovou (L2) hlavičku* (zdrojovou a cílovou MAC adresu), ale *IP hlavička (L3) zůstává nezměněná* (kromě snížení hodnoty TTL o 1).
      ]
      
    === Konfigurační módy (Cisco IOS)
    Na zařízeních Cisco se pohybujeme v hierarchických režimech, které určují naše oprávnění:

    - *User EXEC mode* (`Router>`) -- Základní režim, umožňuje pouze prohlížení základních statistik, nelze nic měnit.
    - *Privileged EXEC mode* (`Router#`) -- Přístup pomocí příkazu `enable`. Umožňuje podrobné testování (`ping`, `traceroute`), prohlížení kompletní konfigurace (`show running-config`) a správu souborů.
    - *Global Configuration mode* (`Router(config)#`) -- Přístup přes `configure terminal`. Zde se provádí změny, které ovlivňují celé zařízení (např. název routeru).
    - *Interface mode* (`Router(config-if)#`) -- Přístup specifikováním rozhraní (např. `interface g0/0`). Slouží ke konfiguraci konkrétního portu (přidělení IP adresy, zapnutí).

    === Postup základní konfigurace
    Při oživení nového routeru je nutné provést tyto základní kroky v globální konfiguraci:

    #pagebreak()

    1. *Pojmenování zařízení:*
       ```cisco_ios
       Router(config)# hostname R1
       ```
    2. *Zabezpečení přístupu do privilegovaného režimu:*
       ```cisco_ios
       R1(config)# enable secret mojeHeslo123
       ```
    3. *Zabezpečení konzolové linky (fyzický kabel):*
       ```cisco_ios
       R1(config)# line console 0
       R1(config-line)# password hesloKonzole
       R1(config-line)# login
       R1(config-line)# exit
       ```
    4. *Zabezpečení vzdáleného přístupu (VTY linky pro SSH/Telnet):*
       ```cisco_ios
       R1(config)# line vty 0 4
       R1(config-line)# password hesloVzdaleny
       R1(config-line)# login
       R1(config-line)# exit
       ```
    5. *Šifrování hesel v konfiguraci:* (aby hesla nebyla vidět v plaintextu přes `show run`)
       ```cisco_ios
       R1(config)# service password-encryption
       ```
    6. *Konfigurace a aktivace rozhraní:* (Rozhraní routeru jsou defaultně vypnutá!)
       ```cisco_ios
       R1(config)# interface gigabitethernet 0/0
       R1(config-if)# ip address 192.168.1.1 255.255.255.0
       R1(config-if)# no shutdown
       R1(config-if)# exit
       ```
    7. *Nastavení výchozí cesty (Default Route):* (Kam házet provoz směřující do internetu)
       ```cisco_ios
       R1(config)# ip route 0.0.0.0 0.0.0.0 203.0.113.1
       ```
    8. *Uložení konfigurace:* (Z operační paměti RAM do permanentní NVRAM, provádí se v `#`)
       ```cisco_ios
       R1# copy running-config startup-config
       ```
    #pagebreak()

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište možné způsoby přístupu na router a jeho zabezpečení."
      #v(1em)
      > @zabezpeceni-routeru
    ]

    / Firewall: Filtruje příchozí komunikaci na základě zdrojové IP adresy a čísla portu. Blokuje podezřelý provoz.

    / Hesla: Oddělená hesla pro User EXEC, Privileged EXEC a vzdálený přístup. Doporučuje se používat `secret` (uložené jako hash) místo běžného `password`.

    / Fyzické zabezpečení: Router umístěn v zamčené místnosti nebo racku.

    / SSH místo Telnetu: Telnet přenáší vše v plaintextu (nezašifrovaně), SSH veškerou komunikaci včetně přihlašovacích údajů šifruje.

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jak se aktivuje rozhraní routeru a zálohuje konfigurace"
      #v(1em)
      > @konfigurace-routeru
    ]

    / Rozhraní routeru jsou defaultně vypnutá (administrativně down). Pro aktivaci je nutné použít příkaz `no shutdown` v konfiguraci konkrétního rozhraní:
    ```cisco_ios
      R1(config)# interface gigabitethernet 0/0
      R1(config-if)# ip address 192.168.1.1 255.255.255.0
      R1(config-if)# no shutdown
      R1(config-if)# exit
    ```
    / Zálohování konfigurace se provádí pomocí příkazu `copy`:
      - Pro uložení aktuální konfigurace do NVRAM (aby se načetla po restartu):

      ```cisco_ios
        R1# copy running-config startup-config
      ```
      
      - Pro zálohu konfigurace na vzdálený TFTP server:
      
      ```cisco_ios
        R1# copy running-config tftp
      ```

    #pagebreak()

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaké nástroje máme pro kontrolu nastavení routeru"
      #v(1em)
      > @konfigurace-routeru
    ]

    Použít se dá příkat `show` pro zobrazení různých informací o routeru:
    
    - `show running-config` -- zobrazení aktuální běžící konfigurace v RAM
    
    - `show ip interface brief` -- přehled všech rozhraní, jejich IP adres a stavu (up/down)
    
    - `show ip route` -- zobrazení směrovací (routovací) tabulky
    
    - `show arp` -- zobrazení tabulky zjištěných MAC/IP adres

    - `show run` -- zobrazení kompletní konfiguraci zařízení, včetně všech nastavení a hesel (pokud nejsou šifrována).

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaké adresy používá síťová vrstva"
      #v(1em)
      > @ip-adresy
    ]

    Jedná se o *logické adresy* (na rozdíl od fyzických MAC adres na datalinkové vrstvě). Nejčastěji se jedná o IP adresy, které mohou být ve formátu IPv4 (32 bitů) nebo IPv6 (128 bitů).

    Příklad IPv4 adresy: `192.168.1.1`

    Příklad IPv6 adresy: `2600:1008:B0AF:4E10:34D4:6A71:714C:FF9C`

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište funkci ARP"
      #v(1em)
      > @arp
    ]

    ARP (Address Resolution Protocol) tvoří most mezi datalinkovou a síťovou vrstvou — převádí IP adresu na MAC adresu, která je nutná pro skutečné doručení rámce ve stejné síti.

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište strukturu a části IP adresy, použití masky sítě"
      #v(1em)
      > @ip-adresy
    ]

    #pagebreak()
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=WAZxo2ObFIw&list=PLTk5ZYSbd9Mi_ya5tVFD8NFfU1YZOyml1&index=5")[Youtube - The Network Layer Part 1 - Common L3 network (intro), Packet structure (v4, v6)] 
    - #link("https://www.youtube.com/watch?v=2MpRlYIYxz4&list=PLTk5ZYSbd9Mi_ya5tVFD8NFfU1YZOyml1&index=6")[Youtube - The Network Layer Part 2 - IPv4, Subnet mask, Router and Route Tables]
    - #link("https://www.youtube.com/watch?v=2MpRlYIYxz4&list=PLTk5ZYSbd9Mi_ya5tVFD8NFfU1YZOyml1&index=7")[Youtube - The Network Layer Part 3 - ARP, Routing]

    - #link("https://cs.wikipedia.org/wiki/IPv6")[Wiki — IPv6]
  ],
)

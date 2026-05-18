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

    / Hlavní funkce síťové vrstvy:
      - *Adresování:* Přiřazení logické IP adresy zařízením.
      - *Směrování (Routing):* Výběr nejlepší cesty paketu napříč různými sítěmi.
      - *Fragmentace paketů:* Rozdělení velkých dat na menší části, pokud to vyžaduje přenosové médium.

    #set heading(numbering: "1.1")

    = Integrace do modelu OSI

    Síťová vrstva přijímá od *transportní vrstvy* (vrstva 4) *segment*, přidá vlastní hlavičku (obsahující zdrojovou a cílovou IP) a vznikne *paket*. Ten putuje sítí nezávisle -- pořadí doručení paketů nemusí odpovídat pořadí odeslání, spolehlivost doručení zajišťují vyšší vrstvy (TCP).

    Na síťové vrstvě pracují *routery*, které na základě cílové IP adresy a směrovací tabulky vybírají nejlepší cestu paketu k cíli. Každé koncové zařízení (*host*) má přiřazenu jedinečnou síťovou adresu.

    = Protokoly síťové vrstvy

    / IP (Internet Protocol):
      Základní protokol vrstvy pro adresování (IPv4, IPv6). Je to protokol *best-effort* — doručení paketu není zaručeno, pakety putují sítí nezávisle na sobě.

    / ICMP (Internet Control Message Protocol):
      Slouží k diagnostice sítě a oznamování chyb (využívají ho nástroje jako `ping` nebo `traceroute`).

    / IPsec:
      Sada protokolů pro zabezpečení a šifrování IP komunikace.

    / TTL (Time To Live - Doba života):
      Položka v IP hlavičce (běžně např. hodnota 64). Každý průchod paketu přes router (hop) sníží hodnotu TTL o 1. Pokud klesne na 0, router paket zahodí. Slouží jako ochrana proti nekonečnému zacyklení paketu v síti.

    = IP adresy a jejich struktura

    / IPv4 (32 bitů):
      - Formát: `xxx.xxx.xxx.xxx` (každé číslo 0–255).
      - Dnes trpí nedostatkem adresního prostoru (~4,3 miliardy adres).
      - *Struktura adresy:* IPv4 se dělí na *síťovou část* (Network) a *hostitelskou část* (Host).
      - *Maska sítě:* Určuje, která část adresy patří síti a která hostiteli.
        - Např. Maska `/24` (`255.255.255.0`), maska `/16` (`255.255.0.0`).
      - *Příklad:* U IP `192.168.1.10` s maskou `255.255.255.0` je *síťová část* `192.168.1.0` a *hostitelská část* je `10`.

    / IPv6 (128 bitů):
      - Rozšíření adresního prostoru (zápis v hexadecimální soustavě, např. `2001:db8::1`).
      - Nativní podpora bezpečnosti (IPsec).
      - Defaultní gateway a adresa přijímána automaticky (SLAAC) — není potřeba ruční konfigurace.

    #pagebreak()

    = ARP a RARP — propojení vrstvy 2 a 3

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

    #pagebreak()

    = Zabezpečení routeru

    / Firewall: Filtruje příchozí komunikaci na základě zdrojové IP adresy a čísla portu. Blokuje podezřelý provoz.
    / Hesla: Oddělená hesla pro User EXEC, Privileged EXEC a vzdálený přístup. Doporučuje se používat `secret` (uložené jako hash) místo běžného `password`.
    / Fyzické zabezpečení: Router umístěn v zamčené místnosti nebo racku.
    / SSH místo Telnetu: Telnet přenáší vše v plaintextu (nezašifrovaně), SSH veškerou komunikaci včetně přihlašovacích údajů šifruje.

    = Základní konfigurace routeru (Cisco IOS)

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
  resources: [
    - #link("https://cs.wikipedia.org/wiki/ARP")[Wiki — ARP]
    - #link("https://cs.wikipedia.org/wiki/IPv6")[Wiki — IPv6]
  ],
)
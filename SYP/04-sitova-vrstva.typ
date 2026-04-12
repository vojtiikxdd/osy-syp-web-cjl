#import "../template.typ": header, theme

#show: body => header(
  title: "Síťová vrstva, ARP a základní konfigurace routeru",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Síťová vrstva (Network Layer) je třetí vrstvou referenčního modelu OSI. Zajišťuje end-to-end komunikaci mezi koncovými zařízeními skrz celou síť — na rozdíl od datalinkové vrstvy, která řeší pouze přenos mezi sousedními uzly. K tomu využívá dvě klíčové funkce: *adresování* (přiřazení IP adresy) a *směrování* (výběr nejlepší cesty paketu sítí).
  ],
  body: [
    #set heading(numbering: "1.1")

    = Integrace do modelu OSI

    Síťová vrstva přijímá od transportní vrstvy (vrstva 4) segment, přidá vlastní hlavičku a vznikne *paket*. Ten putuje sítí nezávisle — pořadí doručení paketů nemusí odpovídat pořadí odeslání, spolehlivost doručení zajišťují vyšší vrstvy (TCP).

    Na síťové vrstvě pracují *routery*, které na základě cílové IP adresy a směrovací tabulky vybírají nejlepší cestu paketu k cíli. Každé koncové zařízení (*host*) má přiřazenu jedinečnou síťovou adresu.

    = Protokoly síťové vrstvy

    Nejrozšířenějším protokolem je IP (Internet Protocol):

    / IPv4:
      - 32bitové adresy ve formátu `xxx.xxx.xxx.xxx` (každé číslo 0–255)
      - Dnes nedostačující adresní prostor (~4,3 miliardy adres)

    / IPv6:
      - 128bitové adresy
      - Rozšíření adresního prostoru, nativní podpora bezpečnosti (IPsec)
      - Defaultní gateway přijímána automaticky (SLAAC) — není potřeba ruční konfigurace

    IP je protokol *best-effort* — doručení paketu není zaručeno, pakety putují sítí nezávisle na sobě.

    = ARP a RARP — propojení vrstvy 2 a 3

    ARP (Address Resolution Protocol) tvoří most mezi datalinkovou a síťovou vrstvou — převádí IP adresu na MAC adresu, která je nutná pro skutečné doručení rámce ve stejné síti.

    == Průběh ARP komunikace

    + Odesílající zařízení chce zjistit MAC adresu zařízení s danou IP adresou
    + Vyšle *ARP Request* jako broadcast (`FF:FF:FF:FF:FF:FF`) do celé podsítě
    + Request obsahuje: vlastní MAC, vlastní IP, hledanou IP
    + Všechna zařízení v podsíti request přijmou, odpoví pouze zařízení se shodnou IP
    + Hledané zařízení odešle *ARP Reply* (unicast) se svojí MAC adresou
    + Odesílající zařízení si výsledek uloží do *ARP cache* a odešle rámec

    == RARP (Reverse ARP)

    Opak ARP — zařízení zná svoji MAC adresu, ale chce zjistit svoji IP adresu. Vyšle RARP Request jako broadcast, RARP server vyhledá v tabulce MAC→IP a odpoví přiřazenou IP adresou. Dnes nahrazen protokolem DHCP.

    = Směrování paketů

    Router přeposílá pakety k cíli na základě *směrovací tabulky* (routing table). Záznamy jsou seřazeny od nejdelší masky k nejkratší, poslední záznam je vždy *default gateway* (kam poslat paket, pokud neexistuje specifičtější shoda).

    == Typy směrování

    / Statické směrování:
      Administrátor ručně definuje cesty. Vhodné pro malé sítě, žádná automatická adaptace na změny topologie.

    / Dynamické směrování:
      Router se učí cesty automaticky pomocí směrovacích protokolů, např. *RIP* (Routing Information Protocol). Adaptuje se na výpadky a změny v síti.

    = Zabezpečení routeru

    / Firewall: Filtruje příchozí komunikaci na základě zdrojové IP adresy a čísla portu. Blokuje podezřelý provoz.
    / Hesla: Oddělená hesla pro User EXEC, Privileged EXEC a vzdálený přístup.
    / Fyzické zabezpečení: Router umístěn v zamčené místnosti nebo racku.
    / SSH místo Telnetu: Telnet přenáší vše v plaintextu, SSH komunikaci šifruje.

    = Základní konfigurace routeru (Cisco IOS)

    == Přístupové metody

    / Console port: Přímé připojení pomocí rollover kabelu (RS-232). Nutné pro první konfiguraci.
    / Telnet: Vzdálené připojení, komunikace nešifrovaná — nedoporučeno.
    / SSH: Šifrované vzdálené připojení, náhrada Telnetu.

    == Příkazové módy

    / User EXEC (`R1>`): Omezená práva, pouze zobrazení.
    / Privileged EXEC (`R1#`): Plný přístup ke konfiguraci a diagnostice.
    / Global Configuration (`R1(config)#`): Globální nastavení zařízení.
    / Interface Configuration (`R1(config-if)#`): Konfigurace konkrétního rozhraní.

    == Základní příkazy
  
    ```
    hostname JMENO                          // přejmenování routeru

    line console 0                          // heslo pro konzolový přístup
      password HESLO
      login

    line vty 0 4                            // heslo pro vzdálený přístup (max 5 současných)
      password HESLO
      login

    enable password HESLO                   // heslo pro privilegovaný mód (nešifrované)
    enable secret HESLO                     // heslo pro privilegovaný mód (hashované - preferováno)
    service password-encryption             // slabé šifrování všech hesel v konfiguraci

    interface gigabitethernet 0/0           // konfigurace rozhraní
      ip address 192.168.1.1 255.255.255.0
      no shutdown                           // aktivace rozhraní

    ip route 0.0.0.0 0.0.0.0 192.168.1.254  // statická default route

    copy running-config startup-config      // uložení konfigurace do NVRAM
    show running-config                     // zobrazení aktuální konfigurace
    show startup-config                     // zobrazení uložené konfigurace
    show ip route                           // zobrazení směrovací tabulky
    show ip interface brief                 // přehled rozhraní a jejich IP adres
    ping 192.168.1.1                        // test konektivity
    traceroute 192.168.1.1                  // sledování trasy paketů
    ```
  
    #block(fill: luma(240), inset: 10pt, radius: 4pt)[
      *Poznámka k DHCP:* V síti musí být aktivní DHCP server pouze na jednom zařízení. Více DHCP serverů způsobí přidělení duplicitních IP adres a kolaps komunikace v celé síti.
    ]

  ],
  summary: [
    Síťová vrstva zajišťuje end-to-end doručení paketů skrz celou síť pomocí IP adresování a směrování. ARP tvoří klíčový most mezi logickými IP adresami (vrstva 3) a fyzickými MAC adresami (vrstva 2) — bez něj by nebylo možné doručit rámec ve stejné podsíti. Router jako hlavní prvek vrstvy 3 vybírá nejlepší cestu paketu na základě směrovací tabulky, a to buď staticky nebo dynamicky. Správná konfigurace routeru zahrnuje nastavení hesel, rozhraní, směrování a uložení konfigurace do NVRAM.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/ARP")[Wiki — ARP]
    - #link("https://cs.wikipedia.org/wiki/IPv6")[Wiki — IPv6]
  ],
)
#import "../template.typ": header, theme

#show: body => header(
  title: "SYSTÉMOVÁ PODPORA – OSNOVA MATURITNÍCH OTÁZEK",
  author: "SPŠT",
  body,
)

#theme(
  body: [
   
    #set heading(numbering: "1.1")   

    = Protokoly a modely, ISO-OSI, TCP-IP

    - Vysvětlete důvod použití vrstevnatých modelů
    - Nakreslete vedle sebe a porovnejte oba základní modely
    - Vysvětlete termín „zapouzdření ethernetového rámce - encapsulation“, a co se děje v jednotlivých vrstvách od chvíle, kdy chceme v aplikační vrstvě odeslat nějaká data až po signály na fyzické vrstvě. A napište, jak se datové struktury v jednotlivých vrstvách jmenují
    - Vyjmenujte, jaké protokoly máme v jednotlivých vrstvách TCP-IP modelu a u některých popište jejich funkci
    
    = Fyzická vrstva, přenosová média a jejich vlastnosti

    - Vyjmenujte všechny typy běžně používaných síťových medií a zařaďte je do kategorií, uveďte maximální délky pasivního segmentu nebo komunikační vzdálenosti a používané konektory 
    - U jednotlivých medií uveďte jejich výhody a nevýhody, příklady použití
    - U UTP kabelu uveďte nebo nakreslete možné způsoby zapojení a kde se využívají
    - Na některá síťová média negativně působí okolní vlivy, uveďte, které to jsou a jak se dá jejich vliv na přenos dat eliminovat
    
    = Data-linková vrstva, Ethernet a základní funkce a konfigurace switche

    - Jakou metodu přístupu k médiu používá ethernet, porovnejte s jinou metodou. Porovnejte jednotlivé metody (výhody / nevýhody)
    - Vyjmenujte jednotlivé varianty ethernetu na metalickém médiu, u každého definujte šířku pásma a maximální délku pasivního segmentu
    - Uveďte, z jakých základních aktivních prvků je složena LAN a podrobně popište jejich funkci 
    - Jaké adresy se využívají na přepínačích a jak probíhá rozhodovací proces na těchto prvcích
    - Podrobně popište fungování switche, MAC table, Store-and-Forward Switching, Cut-Through Switching
    - Vysvětlete pojem broadcastová a kolizní doména
    - Problémy přepínaných sítí a jejich řešení pomocí spanning-three protokolu
    
    = Síťová vrstva, ARP, Základní konfigurace routeru

    - Protokoly používané na síťové vrstvě. Funkce síťové vrstvy. Charakteristika
    - Podrobně popište fungování routeru, postup jeho základní konfigurace a používané módy
    - Popište možné způsoby přístupu na router a jeho zabezpečení.
    - Jak se aktivuje rozhraní routeru a zálohuje konfigurace
    - Jaké nástroje máme pro kontrolu nastavení routeru
    - Jaké adresy používá síťová vrstva
    - Popište funkci ARP
    - Popište strukturu a části IP adresy, použití masky sítě
    
    = IPv4 a IPv6 adresace, podsítě

    - Jaké verze IP adres aktuálně máme, jaké jsou jejich délky, množství použitelných adres a jaký je způsob jejich zápisu
    - Popište strukturu a části IPv4 adresy, použití masky sítě
    - Vyjmenujte a popište jednotlivé třídy IPv4 adres
    - Vysvětlete pojem veřejné a privátní adresy, privátní vyjmenujte
    - Popište strukturu a části IPv6 adresy
    - Statické a dynamické přidělování IP adres
    - Důvody vytváření podsítí
    
    = Transportní a aplikační vrstva, ICMP

    - Nejpoužívanější protokoly transportní vrstvy, porovnání
    - Navázání komunikace, ukončení komunikace
    - Ztráta datagramu, seřazení datagramů
    - Porty aplikací a služeb
    - Protokoly aplikační vrstvy vyjmenujte a u některých vysvětlete funkci
    
    = VLAN, Inter-VLAN routing

    - Vysvětlete důvody používání VLAN
    - Způsoby segmentace sítí. Metody vytváření VLAN.
    - Konfigurace VLAN na switchi
    - Popište možné způsoby propojení switchů na kterých jsou vytvořeny 3 stejné VLANy
    - Jak je možné zajistit propojení mezi VLANami, popište možné způsoby řešení
    
    = WLAN koncept, konfigurace

    - Výhody bezdrátových sítí. Typy bezdrátových sítí podle velikosti. Metoda přístupu k médiu.
    - Bezdrátové technologie (Bluetooth, WiFi, WiMAX, mobilní, satelitní).
    - Popište jednotlivé varianty IEEE 802.11 v čem se liší a na jaké frekvenci se provozují
    - Antény
    - Možnosti zabezpečení bezdrátových sítí
    - DoS, Man-in-the-Middle
    
    = Koncept směrování, statické směrování

    - Co je to směrování a jeho základní dělení
    - Funkce směrovače.
    - Možné způsoby připojení k směrovači pro jeho základní konfiguraci. Režimy směrovače.
    - Směrovací tabulka,
    - Přímo připojené sítě, vzdálené sítě, výchozí trasa.
    - Router, routing table, next hop, administrative distance
    - `ip route network-address subnet-mask {ip-address | exit-intf [ip-address]} [distance]`
    
    = Návrh malé sítě, bezpečnost

    - Používaná zařízení v malých sítích a způsoby jejich propojení.
    - Výběr těchto zařízení.
    - Adresace pro malou firmu.
    - Redundance v malé síti, QoS.
    - Služby v malé síti.
    - Audio a video aplikace.
    - Růst malé sítě.
    
    = Přehled operačních systémů

    - jednouživatelské / víceuživatelské
    - lokální / síťové
    - placené / zdarma
    - podle HW platformy
    - licence a edice OS MS (krabicová, OEM, ...)
    - verze a edice OS
    
    = Disky, RAID

    - geometrie disků
    - klasické a dynamické
    - RAID
    - Hot swap
    - NVMe (Non-Volatile Memory Express)
    
    = Virtualizace

    - Co vše je možné virtualizovat
    - Rozdělení typů virtualizace (servery, desktopy, aplikace, uložiště)
    - Popište výhody virtualizace
    - Jaké znáte virtualizační platformy
    - Windows a Sandbox, k čemu slouží.
    - Co je portable aplikace.
    
    = Instalace a konfigurace síťových služeb

    - Jaký je rozdíl v instalaci síťových služeb na platformách Windows / Linux
    - Jaký je rozdíl v konfiguraci serveru a desktopu (Windows)
    - Konfigurace síťových služeb z příkazového řádku
    - V jakém nástroji a jak se instalují jednotlivé služby ve Windows Server
    - Popište jednotlivé síťové služby (DHCP, DNS, FTP, HTTP, file server, print server, SQL server, SMTP server)
    
    = Přehled linuxových distribucí

    - Rozdělení linuxových distribucí s přihlédnutím na finance
    - Rozdělení v závislosti na GUI
    - Architektura Linuxu z hlediska jádra OS
    - Jak to je s náročností Linuxu na hardware a podporou nejnovějšího hardware
    - Co v Linuxu představuje pojem „bash“. Porovnejte s OS Windows.
    
    = Přehled souborových systémů pro Linux

    - Co je a k čemu slouží souborový systém
    - Jaké znáte souborové systémy
    - Čím se liší žurnálovací systémy od ostatních.
    - Jaké znáte souborové systémy vhodné pro Linux
    - Základní příkazy pro práci se soubory a adresáři v Linuxu
    
    = Správa diskových oddílů pomocí diskového manageru

    - Jaký je rozdíl mezi MBR a GPT
    - Vytváření oddílů, rušení oddílů, úprava oddílu, formátování oddílů
    - Jaké příkazy / grafické nástroje znáte pro správu disků a diskových oddílů
  ],
  resources: [
    - #link("https://www.spst.cz")[Youtube - Video k témtu nebo tak]
  ],
)
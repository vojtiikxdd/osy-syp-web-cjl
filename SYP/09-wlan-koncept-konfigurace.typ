#import "../template.typ": header, theme

#show: body => header(
  title: "WLAN: Koncept, správa a konfigurace",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Tento dokument poskytuje hlubší pohled na bezdrátové sítě (WLAN). Rozebírá typy sítí, strukturu topologií podle 802.11 (BSS, ESS), metody modulace a dělení kanálů. Dále se věnuje podrobnému popisu centrální správy přístupových bodů (WLC, CAPWAP), struktuře bezdrátového rámce, autentizaci (RADIUS, EAP) a zabezpečení pomocí moderních standardů WPA2 a WPA3.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Typy bezdrátových sítí a technologie
    / WPAN (Personal): Rozsah do 10 m. Bluetooth (BLE pro mesh, BR/EDR pro point-to-point), ZigBee.
    / WLAN (Local): Středně velké sítě (budovy, kampusy). Wi-Fi na 2,4 GHz a 5 GHz.
    / WMAN (Metropolitan): Velké vzdálenosti. WiMAX (dosah až 50 km, alternativa k DSL/kabelu).
    / WWAN (Wide): Globální sítě využívající licencovaná spektra. Mobilní sítě (4G/5G, GSM, CDMA), satelitní připojení pro odlehlé oblasti.

    Klíčovými organizacemi pro standardizaci jsou *ITU*, *IEEE* a *Wi-Fi Alliance*.

    = Komponenty a role ve WLAN
    - *Wireless Router:* Kombinuje funkce AP (přístup), switche (kabelové porty) a routeru (default gateway, NAT, DHCP, QoS). Vysílá *SSID* (název sítě).
    - *Extender:* Přijímá signál od AP a opakuje jej pro zvětšení dosahu.
    - *Antény:* *Všesměrové* (360° pokrytí), *Směrové* (silný signál jedním směrem) a *MIMO* (Multiple Input Multiple Output – využívá více antén pro razantní zvýšení propustnosti).

    == Typy přístupových bodů (AP)
    / Autonomní AP: Samostatná zařízení, každé se konfiguruje zvlášť. Vhodné pro malé sítě.
    / Lightweight AP (LAP): Přístupové body na bázi kontroléru. Veškerá konfigurace probíhá centrálně přes *WLC (Wireless LAN Controller)*.

    = Topologie 802.11 a komunikace
    == Módy topologie
    1. *Ad hoc mode:* Peer-to-peer (P2P) spojení přímo mezi zařízeními bez AP (např. Wi-Fi Direct).
    2. *Infrastructure mode:* Klienti komunikují výhradně přes AP.
    3. *Tethering:* Mobilní telefon tvoří hotspot pomocí mobilních dat.

    == Stavební bloky Infrastructure módu
    - *BSS (Basic Service Set):* Jedno AP obsluhující své klienty v oblasti pokrytí (BSA). AP se identifikuje pomocí MAC adresy, tzv. *BSSID*.
    - *ESS (Extended Service Set):* Více BSS spojených přes distribuční systém (kabelovou síť). Všechny vysílají stejné *SSID*, klienti mohou plynule přecházet (roaming).

    == Objevování sítě a CSMA/CA
    Zařízení vyhledávají sítě dvěma způsoby:
    - *Pasivní:* AP pravidelně vysílá beacon rámce obsahující SSID a bezpečnostní standardy.
    - *Aktivní:* Klient vysílá "probe request" (s konkrétním SSID nebo bez něj) a AP mu odpoví.

    Pro přístup k médiu se využívá *CSMA/CA* (half-duplex). Klient pošle *RTS (Request to Send)*. Pokud AP souhlasí, odpoví *CTS (Clear to Send)*. Pokud CTS nedorazí, došlo pravděpodobně ke kolizi a klient čeká.

    = Správa AP pomocí WLC a CAPWAP
    *CAPWAP (Control and Provisioning of Wireless Access Points)* je protokol zapouzdřující komunikaci mezi LAP a WLC (nahrazuje starší LWAPP).
    - Využívá *UDP port 5246* pro řídicí zprávy a *UDP port 5247* pro data.
    - Pro zabezpečení přenosu a obranu proti odposlechu (MITM) využívá šifrování *DTLS*.
    - Funkce MAC vrstvy jsou rozděleny mezi AP (např. odesílání beaconů) a WLC (např. autentizace klientů).

    *FlexConnect APs:* Řešení pro vzdálené pobočky. Pokud vypadne spojení s centrálním WLC (*Standalone mode*), AP dokáže lokálně přepínat provoz a ověřovat klienty samo.

    = Kanály a řešení rušení
    Vysílání podléhá rušení (mikrovlnky, cizí AP). Ke zmírnění se používají modulace:
    - *DSSS a FHSS:* Rozprostření signálu napříč širším spektrem nebo rychlé přeskakování frekvencí.
    - *OFDM / OFDMA:* Rozdělení kanálu na menší subkanály bez vzájemného rušení (802.11ax).
    
    *Pásmo 2,4 GHz:* V Evropě 13 kanálů, každý široký 22 MHz s odstupem 5 MHz. Rychle se zaruší a kanály se překrývají.
    *Pásmo 5 GHz:* Nabízí 24 kanálů s odstupem 20 MHz. Nepřekrývají se, poskytují vyšší rychlost, ale mají horší prostupnost překážkami (zdmi).

    = Bezpečnost a kybernetické hrozby
    Hrozby zahrnují *DoS* (zahlcení / úmyslné rušení), *Rogue AP* (nepovolené AP v síti) a *Man-in-the-Middle (MITM)*, kdy útočník vytvoří AP se stejným SSID a odchytává data obětí. Skrytí SSID nebo filtrování MAC adres jsou slabé a snadno překonatelné ochrany.

    == Šifrování a Standardy
    - *WEP / WPA (TKIP):* Zastaralé, kompromitované standardy. WPA měnilo klíče pro každý paket, přidalo MIC (kontrolu integrity).
    - *WPA2:* Aktuální standard využívající robustní šifrování *AES* a protokol *CCMP*.
    - *WPA3:* Nejnovější standard. Přidává *SAE* (obranu proti brute-force odposlechu handshaku), *OWE* pro šifrování otevřených sítí a *PMF* (chráněné management rámce).

    == Autentizace (ověřování)
    / Personal (WPA2-PSK): Pro malé sítě. Všichni uživatelé se ověřují jedním sdíleným heslem (Pre-Shared Key).
    / Enterprise (802.1x / RADIUS): Pro korporace. Uživatel zadává vlastní jméno a heslo. AP komunikuje s *RADIUS serverem* přes protokol *EAP* a ověřuje identitu centrálně (součást AAA - Authentication, Authorization, Accounting).

    = Konfigurace WLC a Troubleshooting
    Konfigurace WLC vyžaduje vytvoření virtuálních interfaců (podobné SVI) namapovaných na konkrétní VLAN a fyzické porty WLC (trunk porty). 
    - Nastaví se IP adresa, brána, DHCP scope.
    - Následně se vytvoří nová *WLAN*, naváže se na daný interface, určí se SSID, šifrování (WPA2/AES) a typ autentizace (PSK nebo RADIUS).
    - WLC může zasílat logy pomocí protokolu *SNMP* na monitorovací server.

    *Troubleshooting:* Kontrola IP konfigurace (`ipconfig`), `ping`, aktualizace ovladačů (NIC), fyzická kontrola zarušení a kontrola konfigurace na WLC/AP.
  ],
  summary: [
    Návrh moderní WLAN vyžaduje hlubokou znalost rádiových pásem (2,4 GHz vs 5 GHz) a topologií (BSS/ESS). Zatímco domácnosti spoléhají na autonomní routery a WPA2-PSK, podnikové sítě využívají Lightweight AP, jež jsou centrálně řízeny kontroléry (WLC) pomocí protokolu CAPWAP s šifrováním DTLS. Bezpečnost v těchto prostředích zajišťuje standard WPA2/WPA3 s algoritmem AES v kombinaci s podnikovou autentizací 802.1x přes RADIUS server.
  ],
  resources: [
    - #link("https://en.wikipedia.org/wiki/IEEE_802.11")[Wiki — IEEE 802.11]
    - #link("https://en.wikipedia.org/wiki/CAPWAP")[Wiki — CAPWAP Protocol]
    - #link("https://en.wikipedia.org/wiki/Wi-Fi_Protected_Access")[Wiki — WPA2 / WPA3]
  ],
)
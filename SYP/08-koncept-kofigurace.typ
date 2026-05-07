#import "../template.typ": header, theme

#show: body => header(
  title: "WLAN: Koncept, standardy a konfigurace",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Tento dokument shrnuje koncepty bezdrátových lokálních sítí (WLAN). Popisuje výhody a nevýhody bezdrátového přenosu, rozdělení sítí podle velikosti, standardy rodiny IEEE 802.11 (Wi-Fi), hardwarové komponenty včetně antén, možnosti zabezpečení proti kybernetickým hrozbám a základy konfigurace bezdrátového směrovače.

    = Úvod do bezdrátových sítí
    WLAN (Wireless Local Area Network) je počítačová síť spojující zařízení pomocí rádiových vln (nejčastěji v nelicencovaných pásmech 2,4 GHz a 5 GHz).

    / Výhody: Eliminace kabeláže, mobilita uživatelů, snadné připojení desítek až stovek mobilních zařízení, jednodušší a levnější upgrade infrastruktury oproti výměně starých kabelů.
    / Nevýhody: Nižší úroveň bezpečnosti (pokusit o připojení se může kdokoli v dosahu), náchylnost k rušení jinými signály nebo fyzickými překážkami, sdílené přenosové médium.

    = Rozdělení sítí a technologie
    == Dělení podle velikosti
    - *WPAN (Wireless Personal Area Network):* Nejmenší sítě pro osobní prostor (např. propojení telefonu a bezdrátových sluchátek).
    - *WLAN (Wireless Local Area Network):* Středně velké sítě pro domácnosti, kanceláře a školy.
    - *WMAN (Wireless Metropolitan Area Network):* Metropolitní sítě pokrývající rozlehlé městské oblasti.

    == Bezdrátové technologie
    - *Bluetooth:* Krátký dosah, pro připojení periferií (myši, klávesnice).
    - *Wi-Fi:* Střední dosah, primární technologie pro přístup k internetu v budovách.
    - *WiMAX:* Větší dosah pro širokopásmové připojení v metropolitních či odlehlých oblastech.
    - *Mobilní sítě (3G, 4G, 5G):* Přenos dat a hlasu na obrovské vzdálenosti přes buňkovou topologii.
    - *Satelitní:* Komunikace s družicemi pro oblasti bez pokrytí běžným signálem.

    = Standardy IEEE 802.11 (Wi-Fi)
    K přístupu na sdílené médium a předcházení kolizím využívají bezdrátové sítě nejčastěji metodu *CSMA/CA* (Carrier Sense Multiple Access with Collision Avoidance). Různé varianty standardu 802.11 definují vysílací frekvence a rychlosti:

    - *802.11b:* 2,4 GHz, rychlost až 11 Mb/s.
    - *802.11a:* 5 GHz, rychlost až 54 Mb/s.
    - *802.11g:* 2,4 GHz, rychlost až 54 Mb/s.
    - *802.11n (Wi-Fi 4):* 2,4 GHz i 5 GHz, rychlost až 600 Mb/s.
    - *802.11ac (Wi-Fi 5):* 5 GHz, rychlost až 7 Gb/s (dnes velmi rozšířené).
    - *802.11ax (Wi-Fi 6):* 2,4 GHz i 5 GHz, rychlost až 9,6 Gb/s.

    == Režimy topologie
    / Ad-hoc: Peer-to-peer (P2P) spojení přímo mezi zařízeními bez centrálního prvku.
    / Infrastructure: Většina Wi-Fi sítí. Klienti se připojují k centrálnímu přístupovému bodu (AP) nebo bezdrátovému směrovači (definuje stavy jako BSS, ESS).

    = Komponenty a parametry antén
    Pro funkční síť jsou potřeba *bezdrátové síťové karty* (integrované či USB) a *bezdrátové routery / přístupové body (AP)*. Moderní AP využívají technologii MIMO (více antén pro vyšší propustnost) a Mesh systémy (např. TP-Link Deco), které automaticky přepínají zařízení na nejlepší kanál a AP.

    *Klíčové vlastnosti antén:*
    - *Zisk (Gain):* Efektivita přenosu energie, vysoký zisk znamená delší dosah.
    - *Směrovost:* Všesměrové (360° pokrytí) vs. směrové (úzký paprsek pro spoje na velkou vzdálenost).
    - *Polarizace:* Orientace vln (vertikální / horizontální).
    - *Frekvenční rozsah a Impedance:* Musí odpovídat vlastnostem sítě a vysílacího zařízení.

    = Zabezpečení a kybernetické hrozby
    == Možnosti ochrany
    - *Šifrování:* Nečitelnost dat pro případ odposlechu (protokoly WEP, WPA, WPA2).
    - *Autentizace:* Ověření identity uživatele (PSK - sdílené heslo, nebo EAP).
    - *Skrytí SSID / Filtrování MAC:* Slabé ochrany; skryjí název sítě nebo povolí jen vybrané fyzické adresy (ty ale lze snadno podvrhnout).
    - *VPN (Virtual Private Network):* Šifrovaný tunel skrze nedůvěryhodnou síť ověřovaný certifikáty. Umožňuje bezpečný přístup do privátní sítě odkudkoliv.

    == Běžné útoky
    - *Man-in-the-Middle (MitM):* Útočník vytvoří falešné AP (Rogue AP) se stejným SSID (názvem sítě), aby uživatele přiměl k připojení a mohl odchytávat jejich komunikaci.
    - *DoS / DDoS (Denial of Service):* Cílené zahlcení sítě obrovským množstvím požadavků, případně úmyslné rušení rádiového signálu, které zamezí legitimním uživatelům v připojení.

    = Základní konfigurace WLAN
    Konfigurace probíhá přes webové grafické rozhraní routeru (po zadání jeho IP adresy do prohlížeče).
    
    Základní kroky konfigurace zahrnují:
    1. Změnu výchozího hesla do administrace routeru.
    2. Nastavení názvu sítě (*SSID*).
    3. Výběr typu zabezpečení (ideálně WPA2/WPA3) a nastavení silného přístupového hesla.
    4. Nastavení vysílacího kanálu (např. 1–12 v pásmu 2,4 GHz) pro minimalizaci rušení.
    5. Změnu IP adresy routeru a nastavení rozsahu lokálních adres přidělovaných DHCP serverem.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Wi-Fi")[Wiki — Wi-Fi (IEEE 802.11)]
    - #link("https://cs.wikipedia.org/wiki/MIMO")[Wiki — MIMO technologie]
    - #link("https://cs.wikipedia.org/wiki/Virtual_private_network")[Wiki — VPN (Virtuální privátní síť)]
  ],
)
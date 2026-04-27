#import "../template.typ": header, theme

#show: body => header(
  title: "Virtualizace",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Virtualizace je technologie, která umožňuje vytvořit softwarovou (virtuální) verzi počítačových prostředků — serverů, operačních systémů, disků nebo celých sítí. Díky virtualizaci lze provozovat více operačních systémů nebo aplikací na jednom fyzickém zařízení současně. Klíčovým prvkem je software zvaný *hypervizor*, který odděluje hardware od operačního systému a spravuje jednotlivé virtuální stroje.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Základní terminologie
    / Hostitel (Host): Fyzický počítač, na kterém virtualizace běží.
    / Host (Guest): Virtuální počítač (nebo OS) běžící na hostiteli.
    / Hypervizor: Software zajišťující správu a provoz virtuálních strojů. Existují dva typy:
    / Virtuální stroj (VM): Izolované virtuální prostředí s vlastním OS a aplikacemi.

    == Typy hypervizorů
    / Typ 1 — Bare-metal: Běží *přímo na hardwaru*, bez hostitelského OS. Nabízí vyšší výkon a bezpečnost. Příklady: VMware ESXi, Microsoft Hyper-V, Xen.
    / Typ 2 — Hosted: Běží *nad hostitelským operačním systémem* jako běžná aplikace. Snazší instalace, ale nižší výkon. Příklady: Oracle VM VirtualBox, VMware Workstation.

    = Co lze virtualizovat
    - *Servery:* Nejrozšířenější typ. Na jednom fyzickém serveru běží více virtuálních serverů, každý s vlastním OS, aplikacemi, přidělenou RAM a diskovým prostorem.
    - *Desktopty:* Pracovní stanice běží jako VM na serveru, uživatel se připojuje vzdáleně (např. přes RDP). Využívá se ve firmách, školách nebo call centrech.
    - *Úložiště (Storage):* Více fyzických disků je spojeno do jednoho logického celku — využívá se v systémech SAN nebo NAS.
    - *Sítě:* Virtuální síťové prvky (switche, routery, firewally) nahrazují fyzická zařízení — technologie VLAN, SDN, VPN.
    - *Aplikace:* Aplikace běží v izolovaném prostředí bez nutnosti instalace do OS (viz sekce níže).

    = Typy virtualizace
    == Emulace
    Software napodobuje chování jiného systému — často s *odlišnou hardwarovou architekturou* (ISA). Instrukce jsou překládány z emulované architektury do hostitelské. Příklad: spuštění hry pro Game Boy na počítači s architekturou x86.

    == Plná virtualizace
    Hostitel poskytuje kompletní virtualizované hardwarové prostředí. Hostovaný OS *neví, že je virtualizován*, a nevyžaduje žádné úpravy. Stejná ISA jako hostitel. Příklady: VirtualBox, VMware Workstation.

    == Paravirtualizace
    Hostitel poskytuje speciální API, přes které s ním host *vědomě komunikuje*. Hostovaný OS musí být upraven, aby tato rozhraní využíval. Výsledkem je efektivnější využití zdrojů a lepší výkon než u plné virtualizace. Příklad: Xen.

    == OS-level virtualizace (Kontejnerizace)
    Více izolovaných uživatelských prostorů (*kontejnerů*) běží na jednom OS a *sdílí jeho jádro*. Kontejnery jsou lehčí než plné VM — nevyžadují vlastní OS. Příklady: Docker, LXC; orchestrace přes Kubernetes (K8s).

    == Aplikační virtualizace
    Aplikace běží v izolovaném prostředí nezávisle na hostitelském OS, často bez nutnosti instalace. Příklady: Java Virtual Machine (JVM), .NET CLR, Wine, portable aplikace.

    === Portable aplikace
    Speciální případ aplikační virtualizace — program nevyžaduje instalaci a lze jej spustit přímo z USB disku nebo libovolné složky. Nezanechává stopy v systému, nevyžaduje administrátorská práva.

    = Virtualizační platformy
    / Oracle VM VirtualBox: Bezplatný, multiplatformní, typ 2. Vhodný pro vývoj a testování.
    / VMware Workstation: Komerční, typ 2, pro Windows a Linux. Pokročilé funkce pro profesionální použití.
    / Microsoft Hyper-V: Typ 1, integrován ve Windows 10/11 Pro a Enterprise a Windows Serveru.
    / Proxmox VE: Open-source platforma typu 1, určená pro servery a datová centra. Podporuje VM i kontejnery (LXC).
    / Windows Sandbox: Dočasné izolované prostředí přímo ve Windows. Po zavření se veškeré změny automaticky odstraní — vhodné pro testování neznámých programů.

    = Výhody a nevýhody virtualizace
    == Výhody
    - *Izolace:* Chyba nebo napadení jednoho VM neovlivní ostatní ani hostitele.
    - *Lepší využití HW:* Jeden fyzický server nahradí mnoho virtuálních.
    - *Nižší náklady:* Méně fyzického HW → nižší výdaje na nákup, elektřinu a chlazení.
    - *Snadná správa:* VM lze jednoduše vytvářet, kopírovat, zálohovat a přesouvat.
    - *Testování a vývoj:* Bezpečné testovací prostředí bez rizika poškození produkčního systému.
    - *Kompatibilita:* Možnost spustit starší aplikace nebo OS na novějším hardware.

    == Nevýhody
    - *Vyšší nároky na HW:* Virtualizace přidává výkonnostní režii (overhead).
    - *Komplexnější správa:* Více vrstev znamená složitější diagnostiku a údržbu.
    - *Single point of failure:* Výpadek hostitele způsobí výpadek všech běžících VM.
  ],
  summary: [
    Virtualizace umožňuje efektivně sdílet fyzický hardware mezi více virtuálními prostředími pomocí hypervizoru. Rozlišujeme hypervizory typu 1 (bare-metal, přímý přístup k HW) a typu 2 (hosted, běží nad OS). Mezi hlavní typy virtualizace patří emulace, plná virtualizace, paravirtualizace, OS-level virtualizace (kontejnery) a aplikační virtualizace. Nejrozšířenějšími nástroji jsou VirtualBox, VMware, Hyper-V a Proxmox. Virtualizace šetří náklady a zvyšuje flexibilitu, ale přináší výkonnostní režii a vyšší nároky na správu.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Virtualizace")[Wiki — Virtualizace]
    - #link("https://cs.wikipedia.org/wiki/Hypervizor")[Wiki — Hypervizor]
    - #link("https://www.proxmox.com/en/proxmox-virtual-environment/overview")[Proxmox VE — Přehled]
    - #link("https://learn.microsoft.com/cs-cz/virtualization/hyper-v-on-windows/about/")[Microsoft Learn — Hyper-V]
    - #link("https://www.docker.com/resources/what-container/")[Docker — Co je kontejner]
  ],
)
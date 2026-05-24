#import "../template.typ": header, theme

#show: body => header(
  title: "Přehled linuxových distribucí",
  author: "Vojtěch Razima, Jakub Málek",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Linux je svobodný operační systém s otevřeným zdrojovým kódem (open-source) založený na unixových principech. Jeho samotný základ tvoří linuxové jádro (Kernel), které v roce 1991 vytvořil Linus Torvalds. Protože jádro samo o sobě netvoří použitelný systém, vznikají tzv. *linuxové distribuce*, které jádro spojují s dalšími nezbytnými nástroji a uživatelským rozhraním.

    = Architektura a složení linuxové distribuce
    Běžná linuxová distribuce se skládá z několika klíčových vrstev:
    - *Kernel (Jádro):* Komunikuje přímo s hardwarem a přiděluje systémové prostředky.
    - *GNU nástroje:* Základní systémové a terminálové nástroje (např. bash, coreutils).
    - *Grafické prostředí (GUI / Desktop Environment):* Zajišťuje vizuální interakci (např. GNOME, KDE Plasma, XFCE, Cinnamon).
    - *Balíčkovací systém (Package Manager):* Stará se o instalaci, aktualizaci a odstraňování softwaru a řeší závislosti mezi programy.

    = Rozdělení linuxových distribucí
    Distribuce se dělí podle mnoha kritérií, aby vyhovovaly různým potřebám uživatelů a firem:

    == Podle filozofie a aktualizací
    / Konzervativní (Fixní vydání): Systém je aktualizován v pravidelných, dlouhých cyklech. Klade se extrémní důraz na stabilitu, software může být starší, ale je důkladně otestovaný (typicky Debian nebo RHEL).
    / Rolling Release (Průběžné aktualizace): Systém nemá verze (jako např. Windows 10/11), aktualizuje se neustále za běhu. Uživatel má vždy nejnovější software, avšak s vyšším rizikem nestability (typicky Arch Linux).

    == Podle licence a financování
    / Bezplatné (Community-driven): Zdarma pro osobní i komerční použití. Vývoj táhne komunita dobrovolníků (Ubuntu, Debian, Arch, Mint).
    / Komerční (Enterprise): Placené distribuce určené pro firmy a kritickou infrastrukturu. Cena zahrnuje certifikace, dlouhodobou podporu (LTS) a profesionální technický support (Red Hat Enterprise Linux, SUSE Linux Enterprise Server).

    == Podle rodokmenu (Základní větve)
    Většina dnešních systémů vychází ze tří hlavních rodin:
    - *Debian-based:* Využívají formát balíčků `.deb` (Debian, Ubuntu, Linux Mint, Kali).
    - *Red Hat-based:* Využívají formát balíčků `.rpm` (RHEL, Fedora, CentOS, Rocky Linux).
    - *Arch-based:* Využívají průběžné aktualizace (Arch Linux, Manjaro).

    = Podrobný přehled hlavních distribucí

    == 1. Ubuntu
    - *Vznik a tvůrce:* 2004, Mark Shuttleworth (společnost Canonical).
    - *Využití:* Desktop i Server. Jedna z nejpopulárnějších distribucí vůbec.
    - *Výhody:* Snadná instalace, obrovská komunita, skvělá podpora hardwaru, jednoduché používání.
    - *Nevýhody:* Obsahuje spoustu nevyžádaných balíčků při čisté instalaci (bloatware), kontroverzní prosazování formátu `snap`.
    - *Balíčkovací systém:* `apt` + `snap` (formát `.deb`).
    - *Výchozí GUI:* GNOME.

    == 2. Debian
    - *Vznik a tvůrce:* 1993, Ian Murdock. (Název vznikl spojením jmen jeho přítelkyně Debry a jeho samotného – Deb+Ian).
    - *Využití:* Primárně Servery a základ pro obrovské množství dalších distribucí.
    - *Výhody:* Extrémní stabilita, obrovský repozitář softwaru, silná komunita, univerzálnost.
    - *Nevýhody:* Zastaralejší verze softwaru (kvůli testování), proprietární (non-free) ovladače jsou ve výchozím stavu vypnuté.
    - *Balíčkovací systém:* `apt` (formát `.deb`).
    - *Výchozí GUI:* Podporuje všechna dostupná prostředí.

    == 3. Arch Linux
    - *Vznik a tvůrce:* 2002, Judd Vinet.
    - *Využití:* Pokročilí uživatelé a vývojáři, kteří chtějí mít systém absolutně pod kontrolou.
    - *Výhody:* Rolling release (vždy nejnovější software), čistý systém bez bloatwaru, úžasná dokumentace (Arch Wiki), přístup do komunitního repozitáře AUR (Arch User Repository).
    - *Nevýhody:* Složitá instalace (přes terminál), při neopatrném updatu se systém může rozbít.
    - *Balíčkovací systém:* `pacman`.
    - *Výchozí GUI:* Žádné (uživatel si musí vše doinstalovat a nastavit sám).

    == 4. Red Hat Enterprise Linux (RHEL)
    - *Vznik a tvůrce:* 2000, společnost Red Hat Inc.
    - *Využití:* Korporátní servery (banky, státní správa, kritická IT infrastruktura).
    - *Výhody:* Dlouhodobá podpora (až 10 let), oficiální certifikace, profesionální support 24/7.
    - *Nevýhody:* Placená komerční licence, velmi konzervativní (starý) software.
    - *Balíčkovací systém:* `dnf` / `yum` (formát `.rpm`).
    - *Výchozí GUI:* GNOME.

    == 5. Fedora
    - *Vznik a tvůrce:* 2003, komunitní projekt silně sponzorovaný společností Red Hat.
    - *Využití:* Pracovní stanice, vývojáři. Slouží jako tzv. "testovací pole" (upstream) pro budoucí verze RHEL.
    - *Výhody:* Přináší nejnovější a inovativní technologie jako první (např. Wayland, Pipewire), poskytuje čistý a neupravovaný GNOME.
    - *Nevýhody:* Krátký životní cyklus verzí (cca 13 měsíců), což nutí uživatele k častým upgradům systému.
    - *Balíčkovací systém:* `dnf` (formát `.rpm`).
    - *Výchozí GUI:* GNOME (Workstation edition).

    == 6. Linux Mint
    - *Vznik a tvůrce:* 2006, Clement Lefebvre. (Vychází z Ubuntu).
    - *Využití:* Běžní uživatelé, ideální pro přechod z Windows.
    - *Výhody:* Velmi intuitivní a uživatelsky přívětivé rozhraní, vlastní praktické nástroje (Mint Tools), nevnucuje formát `snap`.
    - *Nevýhody:* Pomalejší aktualizace softwaru, nenabízí Wayland ve výchozím stavu.
    - *Balíčkovací systém:* `apt` (formát `.deb`).
    - *Výchozí GUI:* Cinnamon (případně MATE nebo Xfce).

    == 7. Kali Linux
    - *Vznik a tvůrce:* 2013, organizace Offensive Security.
    - *Využití:* Profesionálové v kyberbezpečnosti (penetrační testování, bezpečnostní audity, digitální forenzní analýza). Není určen pro běžné každodenní použití!
    - *Výbava:* Obsahuje stovky předinstalovaných hackerských a analytických nástrojů.
    - *Balíčkovací systém:* `apt` (formát `.deb`).
    - *Výchozí GUI:* XFCE.

    = Desktopová vs. Serverová edice
    Mnoho distribucí (jako Ubuntu) nabízí dvě odlišné instalační verze:
    - *Desktopová edice:* Určena pro koncové uživatele. Obsahuje grafické prostředí, předinstalovaný kancelářský software, multimediální nástroje a webový prohlížeč.
    - *Serverová edice:* Určena pro provoz služeb (web servery, databáze). Většinou nemá vůbec žádné grafické rozhraní (ovládá se přes terminál/SSH), má nižší nároky na výkon a je optimalizována pro běh 24/7. (Díky flexibilitě Linuxu však lze na desktopovou verzi doinstalovat serverové služby a naopak).

    = Nástroje pro správu souborů v Linuxu
    Pokud nemáme k dispozici standardní grafické prostředí nebo chceme pracovat efektivněji, využíváme pokročilé správce souborů (File Managery):

    == Midnight Commander (mc)
    Textový správce souborů (CLI) s rozhraním podobným legendárnímu programu Norton Commander.
    - *Instalace:* `sudo apt install mc`
    - *Spuštění:* příkazem `mc`
    - Běží přímo v terminálu. Umožňuje přesouvat, kopírovat, mazat a upravovat soubory (obsahuje integrovaný textový editor `mcedit`) a to vše i na serverech bez grafického rozhraní.

    == Krusader
    Grafický dvoupanelový správce souborů (GUI), primárně navržený pro prostředí KDE. Svým chováním i vzhledem silně připomíná Total Commander z Windows.
    - *Instalace:* `sudo apt install krusader`
    - Umožňuje pokročilou archivaci (ZIP, TAR, RAR), připojení k síťovým diskům a FTP serverům a hromadnou synchronizaci složek.
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Rozdělení linuxových distribucí s přihlédnutím na finance"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Rozdělení v závislosti na GUI"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Architektura Linuxu z hlediska jádra OS"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jak to je s náročností Linuxu na hardware a podporou nejnovějšího hardware"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Co v Linuxu představuje pojem „bash“. Porovnejte s OS Windows."
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Linuxov%C3%A1_distribuce")[Wiki — Linuxová distribuce]
    - #link("https://distrowatch.com/")[DistroWatch — Přehled a žebříčky distribucí]
    - #link("https://wiki.archlinux.org/")[Arch Wiki — Komplexní dokumentace k Linuxu]
  ],
)
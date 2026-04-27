#import "../template.typ": header, theme

#show: body => header(
  title: "Přehled operačních systémů",
  author: "Vojtěch Razima",
  body,
)

#theme(
  intro: [
    Operační systém (OS) je základní software každého počítače nebo elektronického zařízení. Jeho hlavním úkolem je řídit hardware zařízení, spravovat systémové prostředky a umožnit uživateli pracovat s aplikacemi. Funguje jako prostředník mezi uživatelem, aplikacemi a hardwarem.
  ],
  body: [
    #set heading(numbering: "1.1")

    = Hlavní funkce operačního systému
    Mezi základní funkce OS patří:
    - Správa procesoru (CPU) a správa paměti.
    - Správa souborového systému.
    - Řízení vstupních a výstupních zařízení.
    - Zabezpečení systému a uživatelských účtů.
    - Poskytování uživatelského rozhraní (grafického GUI nebo příkazového CLI).

    = Architektura a další klíčové koncepty
    Pro ucelený přehled je důležité znát základní mechanismy, na kterých OS stojí (vybrané body jsou detailněji probírány v dalších otázkách):
    
    - *Architektura OS:* Systém se dělí na *Jádro (Kernel)*, které je v přímém kontaktu s hardwarem, a *Uživatelský prostor (User space)*, kde běží běžné aplikace. Jádra mohou být monolitická (např. Linux), hybridní (Windows NT) nebo postavená na mikrojádře — macOS používá jádro *XNU*, které kombinuje Mach mikrojádro se subsystémem BSD, čímž získává vlastnosti obou přístupů.
    - *Bootovací proces (Start OS):* Skládá se z několika logických kroků: spuštění základního firmwaru (BIOS/UEFI) -> předání řízení Zavaděči (Bootloader, např. GRUB u Linuxu nebo Windows Boot Manager) -> samotné načtení jádra OS do operační paměti.
    - *Správa procesů (Multitasking):* Moderní systémy využívají tzv. preemptivní multitasking. Jádro extrémně rychle přepíná a přiděluje čas procesoru mezi jednotlivé běžící programy, čímž uživateli vytváří plynulou iluzi jejich souběžného běhu.
    - *Souborové systémy:* Způsob logické organizace dat na disku. Zajišťují ukládání, strukturu a čtení souborů (Windows typicky využívá NTFS, Linux ext4/Btrfs a macOS používá APFS).
    - *Virtualizace:* Schopnost operačního systému běžet jako hostitel (Host) a spouštět nad sebou izolovaně další virtuální stroje (např. pomocí Hyper-V u Windows, KVM u Linuxu) nebo moderní kontejnery (Docker).

    = Rozdělení operačních systémů
    == Podle počtu uživatelů
    / Jednouživatelské: Navrženy pro práci pouze jednoho uživatele v jednom okamžiku (např. MS-DOS, starší Windows, Temple OS). Jsou jednodušší, s nižšími nároky na HW, ale mají horší bezpečnost.
    / Víceuživatelské: Umožňují současnou práci více uživatelů (např. Linux, Windows Server, Unix). Každý má vlastní účet a práva, což zajišťuje vyšší bezpečnost a umožňuje vzdálený přístup.

    == Podle práce v síti
    / Lokální OS: Určen pro běh na jednom počítači a spravuje primárně jeho lokální prostředky (běžné desktopové Windows, macOS, běžný Linux).
    / Síťové OS: Umožňují správu počítačové sítě, sdílení zdrojů a centralizovanou správu uživatelů (Windows Server, Linuxové serverové distribuce).

    == Podle licence a hardwaru
    - *Placené:* Vyžadují zakoupení licence (Windows). Nabízí profesionální podporu a snazší ovládání, ale mají omezené možnosti hlubších úprav.
    - *Vázané na hardware:* macOS je distribuován zdarma (jako aktualizace), ale je legálně i technicky vázán výhradně na zařízení Apple (Mac, MacBook). Uživatel si tedy fakticky platí OS v ceně hardware.
    - *Bezplatné (Open-source):* Dostupné zdarma s otevřeným kódem (Linux, FreeBSD). Těží z obrovské komunitní podpory a možnosti úprav kódu.
    - *Podle platformy:* PC a notebooky (Windows, macOS, Linux), Servery (RedHat, Ubuntu Server, Windows Server), Mobilní zařízení (Android, iOS), Vestavěná/Embedded zařízení (RouterOS, OpenWRT, FreeRTOS).

    = Licence Microsoft Windows
    Operační systém Windows existuje v několika typech licencí:
    / Krabicová (Retail): Zakoupená samostatně, lze ji legálně přenést z jednoho počítače na jiný.
    / OEM licence: Dodává se s novým počítačem a je pevně vázaná na konkrétní hardware (nelze přenést).
    / Volume licence (Multilicence): Využívají ji firmy pro instalaci na velké množství počítačů.
    / Edu licence: Speciální edice určená výhradně pro školy, univerzity a studenty.

    = Správa a informace o systému (CLI / GUI)
    == Windows
    Základní informace lze zjistit přes grafické rozhraní nebo příkazový řádek:
    - `winver` – Zobrazí okno s verzí systému, číslem buildu a informací o licenci (spouští se přes Win + R).
    - `systeminfo` – Detailní výpis v CLI (název OS, verze, procesor, RAM, datum instalace).
    - `slmgr /dli` – Nástroj (Software Licensing Management Tool) pro zobrazení základních informací o licenci, edice a stavu aktivace.
    - `slmgr /xpr` – Zobrazí informaci, zda je licence trvalá, nebo datum její expirace.

    == macOS
    - `sw_vers` – Zobrazí základní informace o verzi systému: název produktu (ProductName), verzi macOS (ProductVersion) a číslo buildu (BuildVersion).
    - `system_profiler SPSoftwareDataType` – Podrobnější výpis systémových informací včetně verze jádra XNU, doby běhu systému (uptime) a názvu počítače.

    == Linux
    - `uname -a` – Zobrazí základní informace o systému: typ OS (Linux), název stroje (hostname), verzi jádra (kernel), architekturu procesoru (např. x86_64) a datum kompilace.
    - `lsb_release -a` – Zobrazí detaily o konkrétní linuxové distribuci: výrobce (Distributor ID), název a verzi systému (Description), číslo verze (Release) a kódové označení (Codename, např. *jammy*).
  ],
  summary: [
    Operační systémy jsou nezbytnou součástí všech moderních zařízení. Zajišťují komunikaci mezi hardwarem a aplikacemi pomocí svého jádra (Kernelu) a spravují paměť, běžící procesy i souborový systém. Trh je silně diverzifikovaný — Windows s komerčním licencováním, macOS vázaný na Apple hardware s hybridním XNU jádrem a open-source Linux — každý systém má své specifické licencování a cílovou oblast použití.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Opera%C4%8Dn%C3%AD_syst%C3%A9m")[Wiki — Operační systém]
    - #link("https://cs.wikipedia.org/wiki/J%C3%A1dro_opera%C4%8Dn%C3%ADho_syst%C3%A9mu")[Wiki — Jádro OS (Kernel)]
    - #link("https://cs.wikipedia.org/wiki/XNU")[Wiki — Jádro XNU (macOS)]
    - #link("https://learn.microsoft.com/cs-cz/windows-server/get-started/kms-client-activation-keys")[Microsoft Learn — Nástroj slmgr ve Windows]
  ],
)
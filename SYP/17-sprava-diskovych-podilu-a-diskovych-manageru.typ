#import "../template.typ": header, theme

#show: body => header(
  title: "Správa diskových oddílů pomocí diskového manageru",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Diskový oddíl je logická část fyzického pevného disku nebo SSD, která se chová jako samostatná jednotka s vlastním souborovým systémem. Správné rozdělení disku umožňuje oddělit systémová data od uživatelských, instalovat více operačních systémů (*multi-boot*) nebo zvýšit bezpečnost dat — při pádu systémového oddílu uživatelská data zůstanou nedotčena.

    = Tabulky oddílů: MBR vs. GPT
    Při inicializaci disku je nutné zvolit *schéma tabulky oddílů*, které určuje, jak jsou informace o oddílech na disku uloženy.

    == MBR (Master Boot Record)
    Starší schéma, používané od dob MS-DOS. Informace o oddílech jsou uloženy v *prvním sektoru disku* — pokud se tento sektor poškodí, může dojít ke ztrátě přístupu ke všem oddílům.

    Vlastnosti MBR:
    - Maximální velikost disku: *~2 TB*
    - Maximálně *4 primární oddíly*
    - Alternativně: *3 primární + 1 rozšířený oddíl* (extended partition)
    - Rozšířený oddíl může obsahovat téměř neomezené množství *logických oddílů*

    MBR obsahuje bootovací kód, tabulku oddílů a identifikaci disku.

    #table(
      columns: (1fr, auto, auto, auto),
      inset: 6pt,
      align: left,
      table.header([*Konfigurace*], [*Primární*], [*Rozšířený*], [*Logické*]),
      [Pouze primární],    [max. 4], [0], [0],
      [S rozšířeným],      [max. 3], [1], [téměř ∞],
    )

    == GPT (GUID Partition Table)
    Modernější schéma, součást standardu *UEFI*. Dnes standard pro nové počítače a disky.

    Výhody GPT oproti MBR:
    - Podpora disků *větších než 2 TB*
    - Až *128 oddílů* (ve Windows), v Linuxu prakticky neomezeně
    - *Záložní kopie* tabulky oddílů uložená na konci disku
    - *Kontrolní součty* pro detekci poškození tabulky — vyšší bezpečnost

    = Operace s oddíly
    Před jakoukoli manipulací s oddíly platí *zlaté pravidlo*: vždy nejdříve *zálohujte data*. Operace jako zmenšování nebo slučování oddílů jsou nevratné a při chybě hrozí ztráta dat.

    == Vytvoření oddílu
    Nový oddíl se vytváří z *nepřiřazeného místa* (unallocated space) na disku — při instalaci OS, přidání nového disku nebo reorganizaci úložiště. Postup zahrnuje výběr volného místa, určení velikosti, nastavení typu oddílu a formátování souborovým systémem.

    == Zmenšení oddílu (Shrink)
    Zmenšení oddílu uvolní část jeho místa jako nepřiřazený prostor, aniž by byl oddíl smazán. Uvolněné místo lze použít k vytvoření nového oddílu nebo rozšíření jiného.

    == Rozšíření oddílu (Extend)
    Rozšíření přidá *sousední nepřiřazené místo* k existujícímu oddílu. Ve Windows je podmínkou, aby nepřiřazené místo bylo bezprostředně za rozšiřovaným oddílem.

    == Smazání oddílu
    Smazání oddílu uvolní veškerý jeho prostor jako nepřiřazené místo. Je nutné ověřit, že oddíl neobsahuje systém nebo důležitá data.

    == Formátování oddílu
    Formátování vytvoří na oddílu *souborový systém*, který umožňuje ukládání a správu dat. Existují dvě varianty:
    - *Rychlé formátování (Quick format):* Pouze vytvoří nové záznamy FS, data fyzicky neodstraní — rychlejší.
    - *Úplné formátování (Full format):* Přepisuje celý oddíl, detekuje vadné sektory — pomalejší, bezpečnější.

    Nejpoužívanější souborové systémy:
    / NTFS: Standard Windows — velké soubory, oprávnění (ACL), šifrování (BitLocker), komprese, žurnálování.
    / FAT32: Starší, universální kompatibilita, max. velikost souboru *4 GB*.
    / exFAT: Modernější nástupce FAT32 pro přenosná média — bez omezení 4 GB.
    / ext4: Standard Linuxu — žurnálování, nízká fragmentace, vysoký výkon.

    = Správa disků ve Windows
    == Grafické rozhraní — Správa disků (`diskmgmt.msc`)
    Integrovaný grafický nástroj Windows spustitelný příkazem `diskmgmt.msc` (Win + R). Umožňuje základní operace:
    - Inicializaci nových disků (volba MBR nebo GPT)
    - Vytvoření, smazání a formátování oddílů
    - Rozšíření (*Extend Volume*) a zmenšení (*Shrink Volume*) svazků
    - Změnu písmene jednotky (např. z `D:` na `E:`)
    - Vytvoření a správu *virtuálních disků (VHD/VHDX)*

    == Příkazový řádek — DiskPart
    `DiskPart` je pokročilý nástroj příkazové řádky spouštěný jako *správce* (admin). Je rychlejší než GUI, umožňuje skriptování a práci s disky, které GUI nedokáže zobrazit.

    ```bash
    list disk              # Zobrazí seznam všech fyzických disků
    select disk 1          # Vybere disk č. 1
    list partition         # Zobrazí oddíly vybraného disku
    create partition primary size=10240  # Vytvoří primární oddíl (10 GB)
    format fs=ntfs quick   # Rychlé formátování jako NTFS
    assign letter=D        # Přiřadí písmeno jednotky
    delete partition       # Smaže vybraný oddíl
    ```

    == Virtuální disky (VHD / VHDX)
    Virtuální disk je *soubor na fyzickém disku*, který se v systému chová jako samostatný pevný disk. Lze jej připojit, formátovat a pracovat s ním stejně jako s fyzickým médiem.

    Formáty:
    / VHD: Starší formát, max. velikost *2 TB*.
    / VHDX: Modernější formát, max. velikost *64 TB*, odolnější vůči poškození při výpadku proudu.

    Použití virtuálních disků:
    - *Testování softwaru* bez rizika poškození hlavního systému
    - *Zálohování* (bitové kopie systému)
    - *Virtuální stroje* (Hyper-V, VirtualBox)

    Vytvoření ve Správě disků: _Akce → Vytvořit virtuální pevný disk_.

    = Správa disků v Linuxu
    V Linuxu nejsou disky označeny písmeny jako ve Windows, ale jako *cesty v adresáři* `/dev/`:
    - `/dev/sda` — první fyzický disk (SATA/USB)
    - `/dev/sda1` — první oddíl prvního disku
    - `/dev/nvme0n1` — první NVMe disk

    == Grafické rozhraní — GParted
    *GParted* (GNOME Partition Editor) je nejoblíbenější grafický editor oddílů pro Linux. Umožňuje měnit velikost, přesouvat a kopírovat oddíly *bez ztráty dat*. Dostupný jako live USB pro správu oddílů i mimo běžící systém.

    == Příkazový řádek — fdisk / parted
    ```bash
        sudo fdisk -l               # Zobrazí seznam všech disků a oddílů
        sudo fdisk /dev/sdb         # Spustí interaktivní správu disku sdb
        # Uvnitř fdisk:
        # n = nový oddíl, d = smazat, p = vypsat, w = zapsat změny, q = ukončit

        sudo mkfs.ext4 /dev/sdb1    # Formátuje oddíl jako ext4
        sudo mkfs.ntfs /dev/sdb1    # Formátuje oddíl jako NTFS
        sudo parted /dev/sdb print  # Zobrazí tabulku oddílů přes parted
    ```

    == Swap (odkládací oddíl)
    *Swap* je speciální oddíl nebo soubor, který Linux využívá jako *virtuální RAM* — když dojde fyzická operační paměť, OS odkládá nepoužívaná data z RAM na swap. Doporučená velikost swapu se tradičně rovná velikosti fyzické RAM (pro hibernaci i více).

    ```bash
        sudo swapon --show          # Zobrazí aktivní swap
        sudo mkswap /dev/sdb2       # Vytvoří swap na oddílu
        sudo swapon /dev/sdb2       # Aktivuje swap
    ```

    == LVM (Logical Volume Management)
    Pokročilá správa úložiště, která umožňuje *spojovat více fyzických disků* do jednoho logického celku. Výhodou je snadné rozšiřování svazků za běhu systému bez nutnosti restartu, snapshoty a podpora RAID.

    Základní pojmy LVM:
    / PV (Physical Volume): Fyzický disk nebo oddíl přidaný do LVM.
    / VG (Volume Group): Skupina PV — společný pool úložného prostoru.
    / LV (Logical Volume): Logický svazek z VG — ekvivalent klasického oddílu.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Diskov%C3%BD_odd%C3%ADl")[Wiki — Diskový oddíl]
    - #link("https://cs.wikipedia.org/wiki/Master_boot_record")[Wiki — MBR]
    - #link("https://cs.wikipedia.org/wiki/GUID_Partition_Table")[Wiki — GPT]
    - #link("https://gparted.org/documentation.php")[GParted — Dokumentace]
    - #link("https://learn.microsoft.com/cs-cz/windows-server/storage/disk-management/overview-of-disk-management")[Microsoft Learn — Správa disků]
    - #link("https://cs.wikipedia.org/wiki/Logical_Volume_Manager")[Wiki — LVM]
  ],
)
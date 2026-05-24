#import "../template.typ": header, theme

#show: body => header(
  title: "Přehled souborových systémů pro Linux",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Souborový systém je způsob, jakým operační systém organizuje, ukládá a spravuje data na úložném médiu (pevný disk, SSD, USB flash disk). Určuje strukturu, pojmenování a přístup k souborům a adresářům. Bez souborového systému by data na disku byla pouze neuspořádaná sekvence bitů — OS by nedokázal rozlišit jednotlivé soubory ani adresáře.

    = Co souborový systém určuje
    Každý souborový systém definuje:
    - jak jsou soubory *pojmenovány* a *organizovány* do adresářů (hierarchická struktura),
    - jak jsou *ukládány na disk* (fyzické umístění bloků dat),
    - jak se spravují *přístupová práva* (kdo může soubor číst, zapisovat, spouštět),
    - jak jsou uchovávána *metadata* (vlastník, velikost, čas vytvoření a změny),
    - jak se *chrání data* při neočekávaném výpadku systému (žurnálování).

    = Klíčové koncepty
    == Žurnálování
    Žurnálovací souborový systém zaznamenává chystané změny do speciálního záznamu zvaného *žurnál (journal)* ještě předtím, než jsou skutečně zapsány na disk. Pokud dojde k výpadku proudu nebo pádu systému, OS může po restartu žurnál přečíst a nedokončené operace buď dokončit, nebo vrátit zpět.

    Výhody žurnálování:
    - rychlejší kontrola disku po pádu systému (odpadá zdlouhavé `fsck`)
    - menší riziko ztráty nebo poškození dat
    - vyšší celková stabilita

    Nevýhodou je mírně vyšší režie při každém zápisu na disk. Žurnálování používají: *ext3, ext4* (Linux), *NTFS* (Windows), *APFS* (macOS).

    == Oprávnění souborů
    Oprávnění určují, kdo může soubor číst, zapisovat nebo spouštět. V Linuxu existují tři typy oprávnění a tři skupiny subjektů:

    - *r* (read) — čtení
    - *w* (write) — zápis
    - *x* (execute) — spouštění

    Skupiny: *owner* (vlastník), *group* (skupina), *others* (ostatní).

    Příklad zápisu: `-rwxr-xr--`
    - vlastník: `rwx` (čtení, zápis, spuštění)
    - skupina: `r-x` (čtení, spuštění)
    - ostatní: `r--` (pouze čtení)

    Správa oprávnění:
    ```bash
        chmod 755 soubor.txt   # Nastaví oprávnění číselně
        chmod u+x soubor.txt   # Přidá vlastníkovi právo spuštění
        chown jan:users soubor # Změní vlastníka a skupinu
    ```

    Ve Windows se přístupová práva spravují přes *ACL* (Access Control List), který umožňuje jemnější nastavení práv pro jednotlivé uživatele a skupiny.

    == Diskové oddíly a schémata rozdělení
    Fyzický disk lze rozdělit na samostatné logické části — *oddíly (partitions)*. Každý oddíl může mít vlastní souborový systém. Existují dvě schémata rozdělení:

    / MBR (Master Boot Record): Starší schéma, maximálně *4 primární oddíly*, podporuje disky do *2 TB*. Stále se používá na starším hardwaru.
    / GPT (GUID Partition Table): Moderní schéma, prakticky *neomezený počet oddílů*, podporuje disky nad *2 TB*. Standard pro moderní systémy s UEFI.

    Nástroje pro správu oddílů:
    - `fdisk` — příkazový řádek pro vytváření a mazání oddílů (Linux)
    - `lsblk` — zobrazí přehled disků a oddílů ve stromové struktuře
    - *GParted* — grafický nástroj (resize, formátování, přesun oddílů)
    - *Správa disků* — grafický nástroj Windows
    - `diskpart` — příkazový řádek Windows pro pokročilou správu

    == Mountování
    Mountování je proces *zpřístupnění souborového systému* operačnímu systému — připojení oddílu nebo zařízení do adresářového stromu.

    - *Linux / macOS:* Zařízení se připojuje do adresáře (např. `/mnt/`, `/media/`)
    - *Windows:* Zařízení dostane písmeno disku (`C:`, `D:` apod.)
    - *Síťové systémy:* NFS, SMB — vzdálené úložiště dostupné jako lokální disk
    - *Docker:* Mountování složek hostitele do kontejneru

    ```bash
        sudo mount /dev/sdb1 /home       # Připojí oddíl jako /home
        sudo umount /home                 # Odpojí oddíl
    ```

    Aby bylo připojení *trvalé* (přežilo restart), zapisuje se do souboru `/etc/fstab`:

    ```bash
    /dev/sdb1   /home   ext4   defaults   0   2
    ```

    = Přehled souborových systémů
    == Řada EXT (Extended Filesystem)
    Řada souborových systémů navržených přímo pro linuxové jádro. Prošla čtyřmi generacemi:

    / ext2: Starší, jednoduchý a rychlý FS bez žurnálování. Při výpadku hrozilo poškození dat a zdlouhavá kontrola (`fsck`).
    / ext3: Rozšíření ext2 o *žurnálování*. Zachoval zpětnou kompatibilitu s ext2, výrazně zvýšil bezpečnost dat.
    / ext4: Aktuální standard většiny linuxových distribucí (Ubuntu, Debian, …). Podporuje soubory až do *16 TB* a oddíly až do *1 EB*. Nabízí žurnálování, nízkou fragmentaci a vysoký výkon.

    == XFS
    Moderní souborový systém optimalizovaný pro práci s *velkými soubory* a rozsáhlými datovými úložišti. Výborný výkon při paralelním přístupu. Používá se zejména na serverech (výchozí FS v RHEL/CentOS).

    == Btrfs (B-Tree Filesystem)
    Moderní linuxový souborový systém, který postupně nahrazuje starší řešení. Nabízí pokročilé funkce:
    - *snapshoty* — zálohy stavu souborového systému v daném okamžiku
    - *kontrola integrity dat* — kontrolní součty pro detekci poškozených dat
    - *komprese* dat za běhu
    - *správa více disků* (RAID na úrovni FS)

    == ZFS
    Pokročilý souborový systém používaný hlavně na serverech a v enterprise prostředí. Nabízí:
    - vysokou *ochranu dat* pomocí kontrolních součtů
    - *snapshoty* a klony
    - správu *velkých úložišť* (RAID-Z)
    Původně vyvinut pro Solaris, dostupný pro Linux přes projekt *OpenZFS*.

    == FAT (File Allocation Table)
    Jeden z nejstarších souborových systémů, existuje ve verzích FAT12, FAT16 a *FAT32*. Výhodou je *univerzální kompatibilita* — čte ho prakticky každé zařízení. Nevýhodou je maximální velikost souboru *4 GB* u FAT32, absence žurnálování a žádná přístupová práva. Používá se na USB flash discích, SD kartách a starších zařízeních. *exFAT* je modernější nástupce FAT32 bez omezení velikosti souboru, stále s vysokou kompatibilitou.

    == NTFS (New Technology File System)
    Výchozí souborový systém *Windows* od verze Windows NT. Podporuje soubory větší než 4 GB, žurnálování, šifrování (*BitLocker*), oprávnění souborů (*ACL*) a kompresi dat. Linux dokáže NTFS číst a zapisovat pomocí ovladače `ntfs-3g`, nativní podpora je ale omezená.

    == APFS (Apple File System)
    Výchozí souborový systém *macOS, iOS a iPadOS* od roku 2017. Optimalizován pro SSD disky. Nabízí žurnálování, šifrování a snapshoty. Na Windows ani Linuxu není nativně podporován.

    = Srovnání souborových systémů
    #table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr),
      inset: 6pt,
      align: left,
      table.header([*Vlastnost*], [*ext4*], [*NTFS*], [*FAT32 / exFAT*], [*Btrfs*]),
      [Žurnálování],    [✓], [✓], [✗], [✓],
      [Šifrování],      [–], [✓ (BitLocker)], [✗], [–],
      [Snapshoty],      [✗], [✗], [✗], [✓],
      [Max. soubor],    [16 TB], [16 TB], [4 GB / neomezeno], [16 EB],
      [Přístupová práva],[rwx], [ACL], [✗], [rwx],
      [Primární platforma],[Linux], [Windows], [USB/SD média], [Linux],
    )

    = Adresářová struktura Linuxu (FHS)
    Linux dodržuje standard *Filesystem Hierarchy Standard (FHS)*, který definuje umístění systémových souborů:

    #table(
      columns: (auto, 1fr),
      inset: 6pt,
      align: left,
      table.header([*Adresář*], [*Obsah*]),
      [`/`],      [Kořenový adresář celého systému],
      [`/bin`],   [Základní příkazy dostupné všem uživatelům (`ls`, `cp`, `mv`)],
      [`/sbin`],  [Systémové příkazy, které nelze spustit běžným uživatelem],
      [`/etc`],   [Konfigurační soubory systému a služeb],
      [`/home`],  [Domovské adresáře uživatelů (`/home/jan`, `/home/petr`)],
      [`/root`],  [Domovský adresář uživatele root],
      [`/usr`],   [Programy a jejich knihovny instalované v systému],
      [`/var`],   [Proměnlivá data — logy, databáze, cache],
      [`/tmp`],   [Dočasné soubory (systém je může kdykoli smazat)],
      [`/dev`],   [Soubory reprezentující zařízení (disky, terminály, USB)],
      [`/proc`],  [Virtuální FS s informacemi o běžících procesech a jádře],
      [`/srv`],   [Data poskytovaná službami (webový server, FTP)],
      [`/mnt`],   [Bod pro dočasné mountování externích zařízení],
    )

    = Základní příkazy pro práci se soubory
    ```bash
        ls -la          # Výpis obsahu adresáře včetně skrytých souborů a oprávnění
        cd /etc         # Přechod do adresáře /etc
        cd ..           # Přechod o úroveň výš
        cd ~            # Přechod do domovského adresáře
        mkdir test      # Vytvoření adresáře
        rmdir test      # Smazání prázdného adresáře
        rm soubor.txt   # Smazání souboru
        rm -r adresar   # Rekurzivní smazání adresáře i s obsahem
        cp a.txt b.txt  # Kopírování souboru
        cp -r dir1 dir2 # Kopírování adresáře
        mv a.txt /home  # Přesun souboru
        mv old.txt new.txt # Přejmenování souboru
        touch soubor    # Vytvoření prázdného souboru
    ```
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Co je a k čemu slouží souborový systém"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaké znáte souborové systémy"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Čím se liší žurnálovací systémy od ostatních."
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaké znáte souborové systémy vhodné pro Linux"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Základní příkazy pro práci se soubory a adresáři v Linuxu"
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Souborov%C3%BD_syst%C3%A9m")[Wiki — Souborový systém]
    - #link("https://cs.wikipedia.org/wiki/Ext4")[Wiki — ext4]
    - #link("https://cs.wikipedia.org/wiki/Btrfs")[Wiki — Btrfs]
    - #link("https://cs.wikipedia.org/wiki/%C5%BDurn%C3%A1lov%C3%A1n%C3%AD")[Wiki — Žurnálování]
    - #link("https://refspecs.linuxfoundation.org/fhs.shtml")[Linux Foundation — Filesystem Hierarchy Standard]
    - #link("https://wiki.archlinux.org/title/File_systems")[Arch Wiki — File systems]
  ],
)
    
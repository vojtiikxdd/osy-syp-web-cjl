#import "../template.typ": header, theme

#show: body => header(
  title: "Disky, úložná zařízení a pole RAID",
  author: "Vojtěch Razima, Lukáš Pražák",
  body,
)

#theme(
  intro: [
    Ukládání dat je kritickou a nepostradatelnou součástí každého počítačového systému. Paměťová média se vyznačují tím, že jsou *permanentní* a *nonvolatilní* (stálá) – to znamená, že uložená data zůstávají zachována i po odpojení od zdroje elektrické energie. Během historie prošly disky obrovským technologickým vývojem. Dnes se pro bezpečné a rychlé ukládání velkých objemů dat využívají sofistikovaná komunikační rozhraní (NVMe) a technologie redundance (RAID).
  ],
  body: [
    #set heading(numbering: "1.1")

    = Základní parametry a dělení disků
    Při výběru a hodnocení úložných zařízení se posuzuje několik klíčových parametrů:
    - *Rychlost:* Rychlost čtení a zápisu dat.
    - *Kapacita:* Celková velikost úložiště.
    - *Množství zápisů:* Omezení životnosti paměťových buněk (kolikrát lze data přepsat).
    - *Doba udržení dat:* Degradace média (jak dlouho médium udrží data, pokud je odpojeno).
    - *Poškozitelnost:* Náchylnost na fyzické poškození (otřesy, poškrábání) či elektromagnetické rušení.
    - *Rychlost připojení:* Typ sběrnice (rozhraní), které disk využívá pro komunikaci se zbytkem PC.

    = Geometrie pevných disků
    Fyzická organizace dat je typická především pro klasické mechanické pevné disky (HDD), kde jsou data ukládána na rotující magnetické plotny. Dnes je tato fyzická struktura na úrovni OS často pouze emulovaná, ale tvoří základ pochopení funkce disků.
    
    / Stopy (Tracks): Kruhové dráhy na povrchu plotny, po kterých se pohybuje čtecí a zapisovací hlavička. Každá plotna jich obsahuje tisíce.
    / Sektory (Sectors): Stopa je dále rozdělena na sektory. Jde o úplně nejmenší datovou jednotku, kterou může disk jednorázově přečíst nebo zapsat. Tradiční velikost sektoru činí *512 bajtů*. U moderních disků se však přešlo na tzv. Advanced Format, který používá velikost *4096 bajtů (4K sektory)* pro vyšší efektivitu.
    / Cylindry (Válce): Množina všech stop se stejným poloměrem napříč všemi plotnami disku nad sebou.
    / LBA (Logical Block Addressing): Moderní metoda abstraktního adresování, kdy OS už neřeší fyzickou geometrii (Cylindr-Hlava-Sektor), ale komunikuje s diskem tak, že zkrátka sekvenčně čísluje logické bloky od nuly do maxima.

    = Typy úložných zařízení (Historie a současnost)
    
    == FDD (Floppy Disk Drive – Diskety)
    - Typická kapacita pouhých 1,44 MiB.
    - Vyznačuje se velmi pomalým čtením i zápisem a omezeným počtem přepisů.
    - Technologie je extrémně náchylná na poškození elektromagnetickým polem. Dnes zcela zastaralá a nevyužívaná.
    
    == HDD (Hard Disk Drive – Pevný disk)
    - Tradiční mechanické zařízení využívající magnetický zápis na rotující plotny.
    - Poskytuje velké a levné úložiště se střední rychlostí a téměř neomezeným počtem zápisů.
    - *Nevýhody:* Pomalý start (plotny se musí fyzicky roztočit), vysoká náchylnost na otřesy (nebezpečí poškození ploten čtecí hlavičkou) a rušení silným magnetem. Magnetické plochy mohou časem degradovat.

    == Optická média (CD / DVD)
    - Data se do polykarbonátové vrstvy vypalují a čtou laserem. Mají nulovou magnetickou degradaci a neomezenou životnost čtení.
    - *CD (Compact Disc):* Kapacita 500 – 700 MB. Většinou na jeden zápis.
    - *DVD (Digital Versatile Disc):* Kapacita cca 4,7 GB (při použití více vrstev i přes 8 GB).
    - *Nevýhody:* Extrémně pomalé první načtení, velmi snadno se fyzicky poškodí poškrábáním.

    == SSD (Solid State Drive – Polovodičový disk)
    - Moderní disk bez jakýchkoliv pohyblivých částí, využívající FLASH / EEPROM paměťové čipy.
    - Dosahuje extrémních rychlostí čtení/zápisu a téměř instantního (nulového) zpoždění přístupu k datům.
    - *Nevýhody:* Omezený počet přepisů buněk (v řádu stovek tisíc operací, poté buňka umírá). Při dlouhodobém odpojení od elektřiny dochází k degradaci buněk a riziku ztráty dat.

    = Rozhraní pro připojení disků
    / SATA (Serial ATA): Tradiční standardní rozhraní pro HDD a starší SSD. Maximální rychlosti postupně rostly: SATA I (1.5 Gb/s), SATA II (3 Gb/s) a dnes nejběžnější SATA III (6 Gb/s – reálně propustí max. cca 550 MB/s).
    / NVMe (Non-Volatile Memory Express): Vysoce moderní rozhraní využívající superrychlou sběrnici PCIe. Bylo vytvořeno přímo a exkluzivně pro optimalizaci SSD (flash pamětí). Podporuje masivní paralelní zpracování obrovského množství operací, což umožňuje dosahovat propustnosti v řádu několika GB/s. Používá se v moderních PC, serverech a datacentrech.
    / USB (Universal Serial Bus): Univerzální externí rozhraní pro připojení periferií i přenosných "flash disků".

    = Formátování a software disků
    Než může OS data ukládat, musí se disk zinicializovat vytvořením tabulky oddílů a naformátováním:
    - *MBR (Master Boot Record):* Zastaralý standard. Podporuje max. 4 primární oddíly a dokáže pracovat s disky o velikosti maximálně 2 TB.
    - *GPT (GUID Partition Table):* Nový standard svázaný s rozhraním UEFI. Podporuje prakticky nekonečné velikosti disků a až 128 primárních oddílů.
    - *Rozložení svazků (Windows):* OS umožňuje konfigurovat svazky jako tzv. _Simple volume_ (jednoduchý oddíl na jednom disku) nebo dynamické svazky jako _Spanned volume_ (logické spojení kapacity více fyzických disků dohromady).

    = Technologie RAID (Redundant Array of Independent Disks)
    RAID je technologie kombinující více fyzických disků do jednoho jediného logického celku, který operační systém vidí jako jeden velký disk. Hlavním cílem je zvýšení bezpečnosti (redundance dat proti selhání), zvýšení výkonu (rychlosti zápisu/čtení), nebo kombinace obojího.
    O logiku spojení se stará buď přímo OS (*softwarový RAID*), nebo vyhrazený čip zvaný řadič / controller (*hardwarový RAID*), který výrazně odlehčuje CPU počítače. *Pozor: RAID neslouží jako záloha dat (proti smazání nebo ransomware), ale pouze jako ochrana proti fyzickému selhání hardwaru!*

    == Typy zapojení RAID
    / RAID 0 (Striping / Prokládání): Data se rozsekají na menší bloky a zapisují střídavě na 2 a více disků současně. 
      - *Výhoda:* Extrémní nárůst rychlosti (teoreticky rychlost disků se sčítá). Využívá se plná kapacita všech disků.
      - *Nevýhoda:* Nulová redundance. Pokud odejde byť jen jeden jediný disk, ztratíte nenávratně VŠECHNA data v poli.
      
    / RAID 1 (Mirroring / Zrcadlení): Data se paralelně a identicky zapisují na 2 a více disků najednou, čímž vzniká dokonalý klon.
      - *Výhoda:* Skvělá bezpečnost. Selže-li jeden disk, systém okamžitě a bez přerušení načte data z druhého. Rychlejší čtení.
      - *Nevýhoda:* Výsledná kapacita celého pole odpovídá pouze kapacitě nejmenšího vloženého disku (pokud koupíte dva 2TB disky, máte k dispozici stále jen 2 TB úložného prostoru).

    / RAID 5 (Prokládání s distribuovanou paritou): Komerčně nejběžnější kompromis. Vyžaduje *minimálně 3 disky*. Data a speciální kontrolní samoopravné součty (parita) jsou rovnoměrně prokládány přes všechny disky.
      - *Výhoda:* Výborný balanc mezi obrovskou kapacitou, vysokou rychlostí čtení a bezpečností.
      - *Nevýhoda:* Zápis je lehce pomalejší kvůli výpočtům parity. Pole bez úhony přežije výpadek *právě jednoho* disku. Při selhání dvou disků zaráz data končí. Z celkové kapacity se vždy odečítá velikost rovna kapacitě jednoho disku.

    / RAID 10 (1+0): Spojuje to nejlepší z RAID 1 a RAID 0. Vyžaduje *minimálně 4 disky*. Disky se nejprve spojí do zrcadlených párů (ochrana) a nad těmito páry se následně provádí prokládání (rychlost).
      - *Výhoda:* Maximální výkon i bezpečnost. Pole zvládne výpadek i vícera disků najednou (pokud neodejde celý zrcadlený pár). Špička pro profesionální databáze.
      - *Nevýhoda:* Nejvyšší finanční náklady. Trvale ztratíte celou polovinu zakoupené fyzické kapacity na tvorbu kopií.
  ],
  summary: [
    Úložná zařízení prošla obrovským vývojem od pomalých, fyzicky limitovaných disket, přes mechanické HDD s plotnami a cylindry, až po moderní bleskově rychlá NVMe SSD bez pohyblivých částic. Pro zvládání enormního nárůstu produkce dat a zajištění kritické firemní bezpečnosti se fyzické disky v operačním systému nekonfigurují samostatně, ale sdružují se do sofistikovaných struktur RAID. Zapojení jako RAID 1 a 5 poskytují nezbytnou hardwarovou ochranu (redundanci) proti fatálnímu výpadku a ztrátě důležitých informací.
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/Pevn%C3%BD_disk")[Wiki — Pevný disk (HDD) a geometrie]
    - #link("https://cs.wikipedia.org/wiki/Solid-state_drive")[Wiki — SSD (Solid State Drive)]
    - #link("https://cs.wikipedia.org/wiki/RAID")[Wiki — RAID pole a jejich typy]
    - #link("https://cs.wikipedia.org/wiki/NVM_Express")[Wiki — NVMe rozhraní]
  ],
)
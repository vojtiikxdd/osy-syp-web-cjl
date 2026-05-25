#import "../template.typ": header, theme

#show: body => header(
  title: "Zabezpečení MS Windows, záloha a obnovení nainstalovaného systému",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    _zatim neni intro bruh_

    = Zabezpečení MS Windows
    
    Nejčastěji se uvádí následující formy ochrany: 
    - používání a pravidelná aktualizace antivirového programu.
    - pravidelná aktualizace OS a SW.
    - pravidelné skenování proti malware a spyware.
    - zapnutá firewall.
    - pravidelné zálohování.
    - šifrování citlivých dat.
    - použití hesel a nastavení práv uživatelů.

    == Firewall
    
    Funkce sloužící k zabezpečení síťového provozu, která monitoruje veškerou síťovou komunikaci a rozhoduje o povolení či blokování datových paketů na základě nastavených pravidel.
    
    - Ve výchozím nastavení Windows je brána zapnutá, takže ji uživatel nemusí nijak nastavovat.
    / Chrání před:
      - Neoprávněným přístupem do sítě,
      - neoprávněným čtením provozu sítě,
      - přistupování malwaru do sítě.
    
    Je důležité firewall nikdy nevypínat, lze však v případě potřeby nastavit vlastní pravidla (povolit / zakázat).

    Windows Defender Firewall používá *3 základní síťové profily*. Každý z nich se uplatňuje automaticky podle toho, k jakému typu sítě je počítač zrovna připojen.

    === Doménový profil (Domain Profile)
    Aktivuje se v momentě, kdy je počítač připojen k síti s funkční doménou *Active Directory* (typicky firemní infrastruktura).
    - *Využití:* Firemní kanceláře, korporátní sítě.
    - *Bezpečnost:* Benevolentnější nastavení. Předpokládá se, že síť je pod správou administrátorů a zařízení potřebují komunikovat mezi sebou (vzdálená správa, interní servery).

    === Soukromý profil (Private Profile)
    Tento profil uživatel volí pro sítě, které bezpečně zná a důvěřuje jim.
    - *Využití:* Domácí síť, malá rodinná kancelář.
    - *Bezpečnost:* Střední ochrana. Počítač je v síti *viditelný* (Network Discovery je zapnuté), což usnadňuje sdílení souborů, tisk a streamování.

    === Veřejný profil (Public Profile)
    Výchozí a nejvíce restriktivní profil pro sítě, které nemáte pod kontrolou.
    - *Využití:* Kavárny, hotely, letiště, veřejné Wi-Fi.
    - *Bezpečnost:* Maximální ochrana. Počítač je v síti *skrytý* pro ostatní zařízení. Sdílení souborů a tiskáren je striktně zablokováno, aby se zamezilo útokům zvenčí.
    
    == Antivirus
    
    Počítačový software, který slouží k identifikaci, odstraňování a eliminaci počítačových virů a jiného škodlivého softwaru (malware).
    
    - Výchozí: Windows Defender.
    
    / Funkce antiviru:
      - Prohlížení souborů na lokálním disku, které má za cíl nalézt sekvenci odpovídající definici některého počítačového viru v databázi,
      - detekce podezřelé aktivity počítačového programu, který může značit infekci,
      - analýza zachytávaných dat, sledování aktivit na jednotlivých portech či jiné techniky.
  
    = Zálohování
    
    Zálohování je proces kopírování dat na jiné médium (např. externí disk, cloudové úložiště) pro jejich ochranu v případě ztráty, poškození nebo jiných nepříjemností. 
    
    / Zálohování umožňuje:
      - Obnovit data v případě potřeby, ať už se jedná o nechtěné smazání, selhání hardwaru nebo kybernetický útok.
      - Je to nejúčinnější způsob ochrany dat.
      - Pro zálohování se používají specializované zálohovací programy (u Windows 7 - 11 nazvaný  ”Zálohování a obnovení (Windows 7)”).

    U Windows lze také zapnout automatickou ochranu systému. Ochrana systému znamená, že před každou systémovou změnou se zálohuje aktuální stav a vytvoří se tzv. bod obnovení. Lze ji zapnout pomocí nástroje Ovládací panely -> Vlastnosti systému -> Ochrana systému.

    #figure(
      image("../assets/ochrana-systemu-win.png", width: 80%),
      caption: [Nastavení ochrany systému a bodů obnovení],
    )

    == Typy zálohování

    / Možnosti:
      - plné zálohování – vždy se zálohuje vše
      - přírůstkové zálohování – při dalším zálohování se zálohují pouze soubory a adresáře, které byly změněny nebo vytvořeny od poslední zálohy. Pro obnovení dat jsou zapotřebí všechny zálohy, včetně plné.
      - diferenciální zálohování (rozdílová) - při dalším zálohování se zálohují pouze soubory a adresáře, které byly změněny nebo vytvořeny od poslední plné zálohy. Pro obnovení dat je zapotřebí poslední záloha a plná záloha.
      - synchronizační zálohování – dojde k synchronizaci dvou adresářů nebo disků.

    = Obnovení systému
    Obnovu lze provádět buď pomocí nástroje *Obnovení systému*, nebo pomocí spuštění speciálního režimu Windows (*Nastavení > Aktualizace a zabezpečení > Obnovení > Spuštění s upřesněným nastavením a Restartovat.*).

    #figure(
      image("../assets/moznosti-obnoveni-systemu-win.png", width: 80%),
      caption: [Nastavení ochrany systému a bodů obnovení],
    )

    *Obnovení Systému* je pro návrat k některému z předchozích bodů obnovení (pokud je tato funkce zapnutá). *Obnovení z bitové kopie systému* umožní obnovu systému ze zálohy, která bitovou kopii obsahuje.
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Obecné fungování firewall, typy pravidel a profilu v Microsoft Windows Firewall."
      #v(1em)
      //> @
    ]

    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Princip SSO vč. příkladu, popsat služby Winlogon a Credential Providers."
      #v(1em)
      //> @
    ]
  
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jakým způsobem funguje prokázání identity pomocí certifikátu."
      #v(1em)
      //> @
    ]
  
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Možnosti zálohování v OS Microsoft Windows a obnovení systému."
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
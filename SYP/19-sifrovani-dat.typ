#import "../template.typ": header, theme

#show: body => header(
  title: "Šifrování dat",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Šifrování dat je proces transformace informací do nečitelných formátů, které mohou být dešifrovány pouze oprávněnými osobami s odpovídajícím klíčem. Cílem šifrování je zajistit důvěrnost, integritu a autenticitu dat, což je klíčové pro ochranu citlivých informací před neoprávněným přístupem a zajištění bezpečné komunikace v digitálním světě.

    = Symetrická kryptografie
    Symetrické kryptografické systémy využívají pro šifrování (Encryption) zprávy *M (Message)* a dešifrování (Decryption) šif. textu *C (Ciphertext)* stejný klíč *K (Key)*. Klíč K se v symetrické kryptografii nazývá „tajný klíč“ (secret key).

    == Vlastnosti
    / Konfúze:
        - přerušit vztah mezi *M* a *C*,
        - nelineární transformace,
        - substituce (S-box).
    / Difúze:
        - změna znaku v *M* se projeví změnou několika znaků v *C*
        - transpozice, permutace (P-box)
        - permutace nezvyšuje bezpečnost
    
    Běžně se využívá kombinace obou těchto vlastností (prolínání S-box a P-box operací)
    Symetrická kryptografie se nejčastěji využívá pro šifrování velkého objemu dat

    / Výhody:
        - velmi rychlé
        - jednoduché použití
        - standardizované
    / Nevýhody:
        - problematická distribuce klíčů a jejich utajení
        - problematické zajištění nepopíratelnosti

    Šifrovací klíče jsou často uloženy v chráněném HW, jako čipové karty, SIM, TPM, tokeny
    
    / Proudové šifry:
        - šifrování bit-bit, nebo byte-byte
        - využití v případech, kdy má zařízení omezenou paměť na průchozí data
        - využití také hašovacích funkcí, generátory náhodných čísel
        - velmi malá úroveň difúze
    / Blokové šifry:
        - zpráva/otevřený text se zpracovává po n-bitových blocích
        - blok šifrového textu má stejnou délku jako blok otevřeného textu
        - vhodným zapojením lze převést na proudovou šifru

    == Proudové šifry
    / Výhody:
        - *vysoká rychlost šifrování* – každý symbol šifrován samostatně
        - *malé šíření chyb* – případná chyba ovlivní pouze daný znak

    / Nevýhody:
        - *nízká úroveň difúze* – informace o jednom znaku je transformována opět do jednoho znaku,
        - *náchylnost k úmyslným modifikacím* – při odhalení pozice M v C je možné snadno změnit zprávu,
        - nezajišťují integritu,
        - nebezpečí dvojího použití hesla.
    
    == Blokové šifry
    Šifrují skupinu symbolů otevřeného textu jako jeden blok
    Velikost bloku má zásadní význam pro bezpečnost algoritmu -> pro krátké bloky by bylo možné pro daný klíč vytvořit „slovník“
    Běžně se využívají bloky o 64 a 128 bitech
    
    / Výhody:
        - *vysoká úroveň difúze* – informace otevřeného textu se promítají do n;ěkolika symbolů šifrového textu
        - *imunita vůči narušení* – nelze změnit symbol v bloku, aniž by to b;ylo při dešifrování odhaleno
    / Nevýhody:
        - *zpoždění* – před (de)šifrováním nutno přijmout celý blok
        - *šíření chyb* – chyba ovlivní transformaci všech ostatních znaků téhož bloku
    
    == Feistelova síť
    Vstupní blok o n bitech rozdělíme na 2 části (L a R)
    Iterativní blokový algoritmus, vstup do další (i-té) rundy je výstupem té předchozí k šifrování bitů se používá funkce XOR

    / Iterativní provádění:
        - základem je jednoduchá funkce provádějící šifrování jednoho bloku, která je několikrát po sobě iterativně zopakována (několikrát v rámci jednoho bloku)
        - jedna iterace = runda

    #figure(
      image("../assets/diagram-sifrovani.png", width: 80%),
      caption: ["Diagram šifrování vs dešifrování dat"],
    )

    == DES (Data Encryption Standard)
    Bloky o velikosti 64 bitů, klíč dlouhý pouze 56 bitů, 16 rund
    Zvláštní klíč pro každou rundu (anglicky round)
    V dnešní době rozluštitelný hrubou silou
    Zesílen pro použití i dnes 3DES (nevhodný pro použití)
    Založen na Fiestelově síti
    
    / Blok zprávy 64b je po počáteční permutaci rozdělen do dvou registrů Li a Ri Výstup Ri: 
        - je přiveden do funkce f, jejíž výstup je přes XOR spojen s Li
        - Následně se L a R prohodí
        - Postup se opakuje až do 16. rundy
        - Po 16. rundě => finální permutace (inverzní k počáteční)
        - Dešifrování je provedeno v opačném pořadí

    == AES (Advanced Encryption Standard)
    současný standard pro symetrické systémy (nahradil DES), využívá algoritmus *Rijndael*
    Klíče 128b, 192b nebo 256b, blok vždy 128b
    Doporučení NSA je využívat 192b nebo 256b klíče pro vyšší bezpečnost, ale ani 128b klíče není možné v současné době prolomit pomocí Brute-Force útoků
    Nejsou známy žádné útoky, pouze postranními kanály
    
    / Založen na SP-síti (substitučně permutační), každá runda obsahuje:
        - ByteSub,
        - ShiftRow,
        - MixColumn,
        - AddRoundKey.
    
    = Asymetrická kryptografie
    Asymetrické kryptografické systémy využívají pro šifrování E (Encryption) otevřené zprávy M (Message) a dešifrování D (Decryption) šifrového textu
    C (Ciphertext) pár klíčů Sk a Pk.

    / Klíče se v asymetrické kryptografii dělí na:
        - Sk – soukromý klíč (private key)
        - Pk – veřejný klíč (public key)
  
    Asymetrická kryptografie se nejčastěji využívá pro výměnu klíčů pro symetrické algoritmy, případně pro digitální podpisy.

    / Výhody:
        - mohou zajišťovat nepopiratelnost,
        - standardizované.

    / Nevýhody:
        - Pomalejší než symetrické algoritmy,
        - Nutnost velké délky klíčů.
    
    == RSA
    Pojmenován podle tvůrců – Rivest, Shamir, Adleman
    Nejstarší a nejznámější asymetrický algoritmus pro šifrování, digitální podpis
    Publikován v roce 1977
    Využívá modulární operace modulo ze složeného čísla n = r ⋅ s
    r, s jsou velká prvočísla, jejich rozklad je problém faktorizace
    K šifrování používá veřejný klíč Pk, pro dešifrování pak soukromý klíč Sk
    Pro digitální podpis dokumentu se používá soukromý klíč Sk, podpis se následně ověřuje pomocí veřejného klíče Pk
    Využití RSA:
        - Šifrování velmi krátkých zpráv (např. pro sdílení symetrického klíče)
        - Tvorba digitálního podpisu
        - Součást komunikačních protokolů SSL a TLS
        - Ověření autentičnosti osob a zařízení (pomocí certifikátů)


    == DAS
    Standard pro digitální podpis
    Patentováno, ale zdarma k dispozici
    Algoritmus založen na modulární multiplikativní grupě modulo prvočíslo (stejně DH)

    = Způsob šifrování dat v MS Windows
        - BitLocker
    Technologie pro šifrování disků, objevila se už i verze Windows Vista
    Umožňuje šifrovat celé systémové i nesystémové oddíly
    Používá šifrovací algoritmus AES s délkou klíče 128 bitů nebo 256 bitů

        - EFS (Encryption File Systém)
    K šifrování využívá hybridní kryptografii, což je kombinace využití jak symetrické, tak asymetrické kryptografie
    Dosahuje tak dobrých vlastností jak při šifrování, tak při dešifrování dat

        - DES
    Zkráceně DES (1977)
    Bloky o velikosti 64 bitů, klíč dlouhý pouze 56 bitů, 16 rund
    Zvláštní klíč pro každou rundu (anglicky round)
    V dnešní době rozluštitelný hrubou silou
    Zesílen pro použití i dnes 3DES (ale nevhodný pro použití)

        - 3DES
    Umělé zesílení DES, aby byl odolnější (1999)
    Prodloužení klíče na 112 případně 168 bitů (56b + 56b + 56b)
    Využití tam, kde nevadí zpomalení (je schválený a „bezpečný“ algoritmus)

        - AES – současný standard pro symetrické systémy
    2001 zvolen jako standard v US, nahradil DES
    AES využívá algoritmus *Rijndael*
    Tvůrci z Belgie Joan Deamen a Vincent Rijmen => Rijndael
    Klíče 128b, 192b nebo 256b, blok vždy 128b
    Doporučení NSA je využívat 192b nebo 256b klíče pro vyšší bezpečnost, ale ani 128b klíče není možné v současné době prolomit pomocí Brute-Force útoků
    Nejsou známy žádné útoky, pouze postranními kanály
    
    / Vlastnosti AES:
        - Snadná SW implementace
        - Snadná implementace na 8-bitových procesorech (čipové karty)
        - Méně efektivní na 32 a 64-bitových procesorech
        - nutný sofistikovanější postup implementace
        - sloučení rundovních funkcí do tabulek
        - Rychlost, SW více jak 1,6Gb/s na 64-bit procesorech
        - Odolný proti útokům hrubou silou (délky klíčů 128, 192 a 256b)
        - Nejsou známy analytické útoky rychlejší než hrubou silou
        - Útoky postranními kanály
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === ""
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
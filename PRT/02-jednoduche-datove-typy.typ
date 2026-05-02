#import "../template.typ": header, simple

#show: body => header(
  title: "Jednoduché datové typy",
  author: "Jan Prokůpek",
  body,
)

#simple(
  body: [
    #set heading(numbering: "1.1")

    = Deklarace datových typů a proměnných

    *Proměnná* je pojmenované místo v paměti, kde se uchovává hodnota určitého datového typu.

    *Deklarace* proměnné znamená sdělení překladači, jaký datový typ a název bude proměnná mít.

    *Inicializace* proměnné znamená přiřazení počáteční hodnoty při deklaraci.

    == C++

    ```cpp
    // Deklarace bez inicializace
    int cislo;
    double pi;

    // Deklarace s inicializací
    int vek = 25;
    double pi = 3.14159;

    // Více proměnných najednou
    int a, b, c;
    int x = 10, y = 20, z = 30;

    // Konstanty (nelze měnit)
    const int MAX = 100;
    const double E = 2.71828;
    ```

    == C\#

    ```cs
    // Deklarace bez inicializace
    int cislo;
    double pi;

    // Deklarace s inicializací
    int vek = 25;
    double pi = 3.14159;

    // Více proměnných najednou
    int a, b, c;
    int x = 10, y = 20, z = 30;

    // Konstanty (nelze měnit)
    const int MAX = 100;
    const double E = 2.71828;

    // Implicitně typované proměnné (var)
    var jmeno = "Jan";  // string
    var pocet = 42;     // int
    ```

    = Celočíselné datové typy

    Slouží k ukládání celých čísel (bez desetinné čárky).

    == C++

    #table(
      columns: (auto, auto, auto, auto),
      align: left,
      [*Datový typ*], [*Velikost*], [*Rozsah*], [*Popis*],
      [`short`], [2 B], [-32 768 až 32 767], [Krátké celé číslo],
      [`int`], [4 B], [-2 147 483 648 až 2 147 483 647], [Celé číslo],
      [`long`], [4/8 B], [závislé na systému], [Dlouhé celé číslo],
      [`long long`], [8 B], [-9·10#super[18] až 9·10#super[18]], [Velmi dlouhé celé číslo],
      [`unsigned short`], [2 B], [0 až 65 535], [Neznaménkové krátké],
      [`unsigned int`], [4 B], [0 až 4 294 967 295], [Neznaménkové celé],
      [`unsigned long`], [4/8 B], [závislé na systému], [Neznaménkové dlouhé],
      [`unsigned long long`], [8 B], [0 až 1.8·10#super[19]], [Neznaménkové velmi dlouhé],
    )

    ```cpp
    short maleCislo = 100;
    int cislo = 50000;
    long velkeCislo = 1000000L;
    long long obrovskeCislo = 9223372036854775807LL;

    unsigned int nezaporneCislo = 4000000000U;
    ```

    == C\#

    #table(
      columns: (auto, auto, auto, auto),
      align: left,
      [*Datový typ*], [*Velikost*], [*Rozsah*], [*Popis*],
      [`sbyte`], [1 B], [-128 až 127], [Znaménkový byte],
      [`byte`], [1 B], [0 až 255], [Neznaménkový byte],
      [`short`], [2 B], [-32 768 až 32 767], [Krátké celé číslo],
      [`ushort`], [2 B], [0 až 65 535], [Neznaménkové krátké],
      [`int`], [4 B], [-2 147 483 648 až 2 147 483 647], [Celé číslo],
      [`uint`], [4 B], [0 až 4 294 967 295], [Neznaménkové celé],
      [`long`], [8 B], [-9·10#super[18] až 9·10#super[18]], [Dlouhé celé číslo],
      [`ulong`], [8 B], [0 až 1.8·10#super[19]], [Neznaménkové dlouhé],
    )

    ```cs
    sbyte maleZnamenkove = -50;
    byte maleByte = 200;
    short kratke = 10000;
    ushort kratkeNeznamenkove = 50000;
    int cislo = 1000000;
    uint neznamenkove = 3000000000;
    long velke = 9000000000000000000L;
    ulong velkeNeznamenkove = 18000000000000000000UL;
    ```

    = Reálné datové typy

    Slouží k ukládání čísel s desetinnou čárkou (plovoucí řádová čárka).

    == C++

    #table(
      columns: (auto, auto, auto, auto),
      align: left,
      [*Datový typ*], [*Velikost*], [*Rozsah*], [*Přesnost*],
      [`float`], [4 B], [±3.4·10#super[±38]], [~7 číslic],
      [`double`], [8 B], [±1.7·10#super[±308]], [~15 číslic],
      [`long double`], [8-16 B], [závislé na systému], [~19 číslic],
    )

    ```cpp
    float pi = 3.14f;           // suffix 'f' pro float
    double e = 2.71828;         // implicitně double
    long double presne = 3.141592653589793238L;

    // Vědecká notace
    double velke = 1.5e10;      // 1.5 × 10^10
    float male = 2.3e-5f;       // 2.3 × 10^-5
    ```

    == C\#

    #table(
      columns: (auto, auto, auto, auto),
      align: left,
      [*Datový typ*], [*Velikost*], [*Rozsah*], [*Přesnost*],
      [`float`], [4 B], [±3.4·10#super[±38]], [~7 číslic],
      [`double`], [8 B], [±1.7·10#super[±308]], [~15-16 číslic],
      [`decimal`], [16 B], [±7.9·10#super[±28]], [28-29 číslic],
    )

    ```cs
    float pi = 3.14f;           // suffix 'f' pro float
    double e = 2.71828;         // implicitně double
    decimal cena = 19.99m;      // suffix 'm' pro decimal

    // Vědecká notace
    double velke = 1.5e10;      // 1.5 × 10^10
    float male = 2.3e-5f;       // 2.3 × 10^-5
    ```

    *Poznámka:* Typ `decimal` v C\# je vhodný pro finanční výpočty, kde je potřeba vysoká přesnost a správné zaokrouhlování.

    = Logický datový typ

    Slouží k ukládání pravdivostních hodnot (pravda/nepravda).

    == C++

    ```cpp
    bool pravda = true;
    bool nepravda = false;

    // Výsledky porovnání
    bool vetsi = (5 > 3);       // true
    bool mensi = (10 < 5);      // false
    bool rovno = (7 = 7);      // true

    // Logické operace
    bool a = true && false;     // AND (logický součin) -> false
    bool b = true || false;     // OR (logický součet) -> true
    bool c = !true;             // NOT (negace) -> false

    // V podmínkách
    if (pravda) {
        cout << "Podmínka je splněna" << endl;
    }
    ```

    == C\#

    ```cs
    bool pravda = true;
    bool nepravda = false;

    // Výsledky porovnání
    bool vetsi = (5 > 3);       // true
    bool mensi = (10 < 5);      // false
    bool rovno = (7 = 7);      // true

    // Logické operace
    bool a = true && false;     // AND (logický součin) -> false
    bool b = true || false;     // OR (logický součet) -> true
    bool c = !true;             // NOT (negace) -> false

    // V podmínkách
    if (pravda) {
        Console.WriteLine("Podmínka je splněna");
    }
    ```

    = Datový typ char

    Slouží k ukládání jednotlivých znaků.

    == C++

    ```cpp
    char znak = 'A';
    char cislo = '5';
    char mezera = ' ';
    char novyRadek = '\n';
    char tabulator = '\t';

    // Escape sekvence
    char uvozovky = '\'';
    char zpetneKositko = '\\';

    // ASCII hodnoty
    char a = 65;        // 'A'
    int ascii = 'A';    // 65

    // Práce se znaky
    char velke = 'A';
    char male = velke + 32;     // 'a' (v ASCII tabulce)

    // Funkce pro práce se znaky (v <cctype>)
    #include <cctype>

    bool jePismeno = isalpha('A');      // true
    bool jeCislice = isdigit('5');      // true
    bool jeVelke = isupper('A');        // true
    bool jeMale = islower('a');         // true

    char naMale = tolower('A');         // 'a'
    char naVelke = toupper('a');        // 'A'
    ```

    == C\#

    ```cs
    char znak = 'A';
    char cislo = '5';
    char mezera = ' ';
    char novyRadek = '\n';
    char tabulator = '\t';

    // Escape sekvence
    char uvozovky = '\'';
    char zpetneKositko = '\\';

    // Unicode hodnoty
    char a = (char)65;      // 'A'
    int unicode = 'A';      // 65

    // Lze použít i Unicode escape
    char srdce = '\u2665';  // ♥
    ```

    == Třída Character v C\#

    C\# poskytuje statickou třídu `Char` (nebo `Character` jako alias) s užitečnými metodami:

    ```cs
    // Testovací metody
    bool jePismeno = Char.IsLetter('A');        // true
    bool jeCislice = Char.IsDigit('5');         // true
    bool jeMezera = Char.IsWhiteSpace(' ');     // true
    bool jeVelke = Char.IsUpper('A');           // true
    bool jeMale = Char.IsLower('a');            // true
    bool jePismenoCiCislo = Char.IsLetterOrDigit('A');  // true

    // Konverzní metody
    char naMale = Char.ToLower('A');            // 'a'
    char naVelke = Char.ToUpper('a');           // 'A'

    // Získání numerické hodnoty
    int hodnota = Char.GetNumericValue('5');    // 5.0

    // Porovnání znaků
    int porovnani = Char.Compare('A', 'B');     // -1 (A < B)

    // Příklad použití
    char vstup = 'X';
    if (Char.IsUpper(vstup)) {
        Console.WriteLine($"{vstup} je velké písmeno");
        char male = Char.ToLower(vstup);
        Console.WriteLine($"Malé písmeno: {male}");
    }
    ```
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
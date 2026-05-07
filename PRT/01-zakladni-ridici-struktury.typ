#import "../template.typ": header, theme

#show: body => header(
  title: "Základní řídící struktury",
  author: "Jan Prokůpek",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    = Pojem algoritmus

    *Algoritmus* je přesný návod (postup) jak řešit určitý problém. Jde o konečnou posloupnost jasně definovaných kroků, které vedou k vyřešení úlohy.

    = Vlastnosti algoritmu

    + *Elementárnost* -- algoritmus se skládá z konečného počtu jednoduchých (elementárních) kroků
    + *Konečnost* (finitnost) -- algoritmus musí skončit v konečném počtu kroků
    + *Obecnost* -- algoritmus řeší celou třídu úloh, ne pouze jeden konkrétní případ
    + *Determinovanost* -- každý krok je jednoznačně definován, při opakovaném provedení se stejnými vstupními daty dostaneme stejné výsledky
    + *Rezultativnost* -- algoritmus vždy dospěje k výsledku

    = Způsoby zápisu algoritmu

    + *Slovní popis* -- popis v přirozeném jazyce (čeština, angličtina)
    + *Vývojový diagram* -- grafické znázornění pomocí symbolů a šipek
    + *Strukturogram* (Nassi-Shneidermanův diagram) -- blokové schéma bez použití šipek
    + *Pseudokód* -- zápis podobný programovacímu jazyku, ale zjednodušený a srozumitelný
    + *Programovací jazyk* -- zápis v konkrétním programovacím jazyce (C++, C\#, Python...)

    = Strukturované programování

    Programovací paradigma, které klade důraz na:
    - Přehlednost a čitelnost kódu
    - Používání pouze tří základních řídicích struktur: *sekvence*, *selekce*, *iterace*
    - Vyhýbání se příkazu GOTO
    - Dekompozici problému na menší části (procedury, funkce)
    - Jednodušší ladění a údržbu kódu

    = Sekvence

    *Sekvence* je základní řídicí struktura, kde se příkazy vykonávají postupně jeden za druhým v pořadí, jak jsou napsány.

    ```cpp
    // C++
    int a = 5;
    int b = 10;
    int soucet = a + b;
    cout << soucet << endl;
    ```

    ```cs
    // C#
    int a = 5;
    int b = 10;
    int soucet = a + b;
    Console.WriteLine(soucet);
    ```

    = Selekce (větvení)

    Umožňuje podmíněné vykonání příkazů na základě splnění podmínky.

    == Příkaz if

    *C++:*
    ```cpp
    if (podminka) {
        // kód, který se vykoná, když je podmínka splněna
    }

    if (podminka) {
        // kód pro splněnou podmínku
    } else {
        // kód pro nesplněnou podmínku
    }

    if (podminka1) {
        // kód 1
    } else if (podminka2) {
        // kód 2
    } else {
        // kód 3
    }
    ```

    *C\#:*
    ```cs
    if (podminka) {
        // kód, který se vykoná, když je podmínka splněna
    }

    if (podminka) {
        // kód pro splněnou podmínku
    } else {
        // kód pro nesplněnou podmínku
    }

    if (podminka1) {
        // kód 1
    } else if (podminka2) {
        // kód 2
    } else {
        // kód 3
    }
    ```

    == Příkaz switch

    Používá se pro vícenásobné větvení na základě hodnoty výrazu.

    *C++:*
    ```cpp
    switch (promenna) {
        case hodnota1:
            // kód
            break;
        case hodnota2:
            // kód
            break;
        default:
            // kód pro ostatní případy
            break;
    }
    ```

    *C\#:*
    ```cs
    switch (promenna) {
        case hodnota1:
            // kód
            break;
        case hodnota2:
            // kód
            break;
        default:
            // kód pro ostatní případy
            break;
    }
    ```

    = Iterace (cyklus)

    Umožňuje opakované vykonávání bloku příkazů.

    == Cyklus while

    Cyklus s podmínkou na začátku -- testuje podmínku před každou iterací.

    *C++:*
    ```cpp
    while (podminka) {
        // kód, který se opakuje, dokud je podmínka splněna
    }
    ```

    *C\#:*
    ```cs
    while (podminka) {
        // kód, který se opakuje, dokud je podmínka splněna
    }
    ```

    == Cyklus do-while

    Cyklus s podmínkou na konci -- tělo cyklu se provede vždy alespoň jednou.

    *C++:*
    ```cpp
    do {
        // kód, který se vykoná alespoň jednou
    } while (podminka);
    ```

    *C\#:*
    ```cs
    do {
        // kód, který se vykoná alespoň jednou
    } while (podminka);
    ```

    == Cyklus for

    Cyklus s řídicí proměnnou -- používá se, když známe počet opakování.

    *C++:*
    ```cpp
    for (int i = 0; i < 10; i++) {
        // kód, který se opakuje 10×
    }
    ```

    *C\#:*
    ```cs
    for (int i = 0; i < 10; i++) {
        // kód, který se opakuje 10×
    }
    ```

    = Generování náhodných čísel

    == C++

    ```cpp
    #include <cstdlib>  // pro rand() a srand()
    #include <ctime>    // pro time()

    // Inicializace generátoru (provést jednou na začátku programu)
    srand(time(0));

    // Generování náhodného čísla
    int nahodneCislo = rand();  // 0 až RAND_MAX

    // Náhodné číslo v rozsahu 0-99
    int cislo = rand() % 100;

    // Náhodné číslo v rozsahu 1-100
    int cislo = rand() % 100 + 1;

    // Náhodné číslo v rozsahu min-max
    int cislo = rand() % (max - min + 1) + min;
    ```

    == C\#

    ```cs
    // Vytvoření instance Random (provést jednou)
    Random rnd = new Random();

    // Generování náhodného čísla
    int nahodneCislo = rnd.Next();  // nezáporné celé číslo

    // Náhodné číslo 0-99
    int cislo = rnd.Next(100);

    // Náhodné číslo 1-100
    int cislo = rnd.Next(1, 101);  // horní mez je exkluzivní

    // Náhodné desetinné číslo 0.0-1.0
    double des = rnd.NextDouble();
    ```

    = Kolekce Controls v C\#

    Kolekce `Controls` je vlastnost kontejnerových prvků (Form, Panel, GroupBox...) ve Windows Forms, která obsahuje všechny ovládací prvky (controls) umístěné v daném kontejneru.

    == Základní použití

    ```cs
    // Přístup ke všem ovládacím prvkům formuláře
    foreach (Control ctrl in this.Controls) {
        // Práce s jednotlivými prvky
    }

    // Přidání ovládacího prvku
    Button btn = new Button();
    btn.Text = "Nové tlačítko";
    this.Controls.Add(btn);

    // Odebrání ovládacího prvku
    this.Controls.Remove(btn);

    // Počet prvků v kolekci
    int pocet = this.Controls.Count;
    ```

    == Přístup k prvkům podle typu

    ```cs
    // Najít všechny TextBoxy
    foreach (Control ctrl in this.Controls) {
        if (ctrl is TextBox) {
            TextBox tb = (TextBox)ctrl;
            tb.Clear();  // Vymazání obsahu
        }
    }

    // Pomocí LINQ
    var textBoxy = this.Controls.OfType<TextBox>();
    foreach (TextBox tb in textBoxy) {
        tb.Clear();
    }
    ```

    == Přístup podle jména

    ```cs
    // Najít prvek podle jména
    Control ctrl = this.Controls["textBox1"];
    if (ctrl != null && ctrl is TextBox) {
        TextBox tb = (TextBox)ctrl;
        tb.Text = "Nový text";
    }

    // Nebo pomocí Find
    Control[] controls = this.Controls.Find("textBox1", true);
    if (controls.Length > 0) {
        TextBox tb = (TextBox)controls[0];
    }
    ```

    == Rekurzivní procházení

    Pro práci s vnořenými kontejnery (Panel v Panelu atd.):

    ```cs
    private void ProcházejVšechnyPrvky(Control kontejner) {
        foreach (Control ctrl in kontejner.Controls) {
            // Zpracování prvku
            Console.WriteLine(ctrl.Name);

            // Rekurzivní volání pro vnořené kontejnery
            if (ctrl.HasChildren) {
                ProcházejVšechnyPrvky(ctrl);
            }
        }
    }

    // Použití
    ProcházejVšechnyPrvky(this);
    ```
  ],
  resources: [
    Žádné další zdroje 
  ],
)
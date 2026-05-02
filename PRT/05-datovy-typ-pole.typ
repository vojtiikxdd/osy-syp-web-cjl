#import "../template.typ": header, simple

#show: body => header(
  title: "Datový typ pole",
  author: "Jan Prokůpek",
  body,
)

#simple(
  body: [
    #set heading(numbering: "1.1")

    = Jednorozměrné pole

    *Pole* (array) je datová struktura, která uchovává *pevný počet* prvků *stejného datového typu* uspořádaných v *lineární posloupnosti*.

    == Vlastnosti pole

    - *Pevná velikost* -- po vytvoření nelze změnit
    - *Homogenní* -- všechny prvky mají stejný datový typ
    - *Indexované* -- přístup k prvkům pomocí indexu (číselné pozice)
    - *Nultý index* -- první prvek má index 0
    - *Souvislá paměť* -- prvky jsou uloženy vedle sebe v paměti

    == Výhody polí

    + Rychlý přístup k prvkům (konstantní čas O(1))
    + Efektivní využití paměti
    + Jednoduché procházení prvků
    + Vhodné pro ukládání sekvencí dat

    == Nevýhody polí

    - Pevná velikost -- nelze dynamicky měnit
    - Vkládání a mazání prvků je neefektivní
    - Plýtvání pamětí, pokud není celé pole využito

    = Deklarace a inicializace pole

    == C++ -- pole

    *Deklarace pole:*
    ```cpp
    typPrvku nazevPole[velikost];
    ```

    *Příklady deklarace a inicializace:*
    ```cpp
    // Deklarace bez inicializace (prvky mají náhodné hodnoty)
    int cisla[5];

    // Deklarace s inicializací – explicitní velikost
    int cisla[5] = {10, 20, 30, 40, 50};

    // Deklarace s inicializací – implicitní velikost
    int cisla[] = {10, 20, 30, 40, 50};  // velikost 5

    // Částečná inicializace (zbytek vyplněn nulami)
    int cisla[5] = {10, 20};  // {10, 20, 0, 0, 0}

    // Inicializace všech prvků na nulu
    int cisla[5] = {};  // {0, 0, 0, 0, 0}

    // Pole různých typů
    double teploty[7];
    char znaky[10];
    bool stavy[3] = {true, false, true};
    string jmena[4] = {"Jan", "Petra", "Karel", "Anna"};
    ```

    *Dynamické pole (C++):*
    ```cpp
    // Dynamická alokace pomocí new
    int velikost = 10;
    int* pole = new int[velikost];

    // Použití pole
    pole[0] = 5;
    pole[1] = 10;

    // Uvolnění paměti
    delete[] pole;
    ```

    *Zjištění velikosti pole:*
    ```cpp
    int cisla[] = {1, 2, 3, 4, 5};
    int velikost = sizeof(cisla) / sizeof(cisla[0]);  // 5
    ```

    == C\# -- pole

    *Deklarace pole:*
    ```cs
    typPrvku[] nazevPole;
    ```

    *Příklady deklarace a inicializace:*
    ```cs
    // Deklarace bez inicializace
    int[] cisla;

    // Vytvoření pole s danou velikostí (prvky inicializovány na 0)
    int[] cisla = new int[5];  // {0, 0, 0, 0, 0}

    // Deklarace a inicializace s hodnotami
    int[] cisla = new int[] {10, 20, 30, 40, 50};

    // Zkrácený zápis (typ lze vynechat)
    int[] cisla = {10, 20, 30, 40, 50};

    // Pole různých typů
    double[] teploty = new double[7];
    char[] znaky = {'A', 'B', 'C'};
    bool[] stavy = {true, false, true};
    string[] jmena = {"Jan", "Petra", "Karel", "Anna"};

    // Implicitně typované pole
    var cisla = new[] {1, 2, 3, 4, 5};  // typ int[]
    ```

    *Zjištění velikosti pole:*
    ```cs
    int[] cisla = {1, 2, 3, 4, 5};
    int velikost = cisla.Length;  // 5
    ```

    = Přístup k jednotlivým prvkům pole

    Prvky pole jsou indexované od 0. K prvkům přistupujeme pomocí hranatých závorek `[]`.

    == C++ -- přístup k prvkům

    ```cpp
    int cisla[5] = {10, 20, 30, 40, 50};

    // Čtení hodnot
    int prvni = cisla[0];     // 10
    int druhy = cisla[1];     // 20
    int posledni = cisla[4];  // 50

    // Zápis hodnot
    cisla[0] = 100;
    cisla[2] = 300;

    // Výpis všech prvků pomocí cyklu for
    for (int i = 0; i < 5; i++) {
        cout << cisla[i] << " ";
    }

    // Range-based for loop (C++11)
    for (int cislo : cisla) {
        cout << cislo << " ";
    }

    // Pozor na přístup mimo rozsah (undefined behavior)
    // int x = cisla[10];  // NEBEZPEČNÉ!
    ```

    == C\# -- přístup k prvkům

    ```cs
    int[] cisla = {10, 20, 30, 40, 50};

    // Čtení hodnot
    int prvni = cisla[0];     // 10
    int druhy = cisla[1];     // 20
    int posledni = cisla[4];  // 50

    // Zápis hodnot
    cisla[0] = 100;
    cisla[2] = 300;

    // Výpis všech prvků pomocí cyklu for
    for (int i = 0; i < cisla.Length; i++) {
        Console.Write(cisla[i] + " ");
    }

    // Foreach cyklus
    foreach (int cislo in cisla) {
        Console.Write(cislo + " ");
    }

    // Přístup mimo rozsah vyvolá výjimku
    // int x = cisla[10];  // IndexOutOfRangeException
    ```

    == Indexy od konce (C\# 8.0+)

    ```cs
    int[] cisla = {10, 20, 30, 40, 50};

    // Index od konce pomocí operátoru ^
    int posledni = cisla[^1];     // 50 (poslední prvek)
    int predposledni = cisla[^2]; // 40 (předposlední prvek)

    // Rozsahy (ranges)
    int[] cast = cisla[1..4];     // {20, 30, 40}
    int[] prvniTri = cisla[..3];  // {10, 20, 30}
    int[] posledniDva = cisla[^2..]; // {40, 50}
    ```

    == Praktické příklady

    *Součet prvků pole:*
    ```cpp
    // C++
    int soucet = 0;
    for (int i = 0; i < velikost; i++) {
        soucet += cisla[i];
    }
    ```

    ```cs
    // C#
    int soucet = 0;
    foreach (int cislo in cisla) {
        soucet += cislo;
    }
    ```

    *Nalezení maxima:*
    ```cpp
    // C++
    int max = cisla[0];
    for (int i = 1; i < velikost; i++) {
        if (cisla[i] > max) {
            max = cisla[i];
        }
    }
    ```

    ```cs
    // C#
    int max = cisla[0];
    for (int i = 1; i < cisla.Length; i++) {
        if (cisla[i] > max) {
            max = cisla[i];
        }
    }
    ```

    = Pole jako parametr funkce

    == C++ -- pole jako parametr

    Pole se v C++ předává jako *ukazatel* na první prvek. Velikost pole se obvykle předává jako samostatný parametr.

    ```cpp
    // Pole jako parametr – předává se ukazatel
    void vypisPole(int pole[], int velikost) {
        for (int i = 0; i < velikost; i++) {
            cout << pole[i] << " ";
        }
        cout << endl;
    }

    // Alternativní zápis s ukazatelem
    void vypisPole(int* pole, int velikost) {
        for (int i = 0; i < velikost; i++) {
            cout << pole[i] << " ";
        }
        cout << endl;
    }

    // Změna hodnot v poli
    void nasobDvema(int pole[], int velikost) {
        for (int i = 0; i < velikost; i++) {
            pole[i] *= 2;  // změní původní pole
        }
    }

    // Konstantní pole (nelze měnit)
    void vypisKonstantniPole(const int pole[], int velikost) {
        for (int i = 0; i < velikost; i++) {
            cout << pole[i] << " ";
            // pole[i] = 10;  // CHYBA – nelze měnit
        }
    }

    // Použití
    int main() {
        int cisla[] = {1, 2, 3, 4, 5};
        int velikost = sizeof(cisla) / sizeof(cisla[0]);

        vypisPole(cisla, velikost);
        nasobDvema(cisla, velikost);
        vypisPole(cisla, velikost);  // {2, 4, 6, 8, 10}

        return 0;
    }
    ```

    *Vrácení pole z funkce:*
    ```cpp
    // Dynamicky alokované pole
    int* vytvorPole(int velikost) {
        int* pole = new int[velikost];
        for (int i = 0; i < velikost; i++) {
            pole[i] = i + 1;
        }
        return pole;
    }

    int main() {
        int* pole = vytvorPole(5);
        // použití pole...
        delete[] pole;  // nutné uvolnit paměť!
        return 0;
    }
    ```

    == C\# -- pole jako parametr

    V C\# se pole předává jako *reference*, což znamená, že změny v metodě ovlivní původní pole.

    ```cs
    // Pole jako parametr
    static void VypisPole(int[] pole) {
        foreach (int cislo in pole) {
            Console.Write(cislo + " ");
        }
        Console.WriteLine();
    }

    // Změna hodnot v poli
    static void NasobDvema(int[] pole) {
        for (int i = 0; i < pole.Length; i++) {
            pole[i] *= 2;  // změní původní pole
        }
    }

    // Pole s params – proměnný počet argumentů
    static int Soucet(params int[] cisla) {
        int vysledek = 0;
        foreach (int cislo in cisla) {
            vysledek += cislo;
        }
        return vysledek;
    }

    // Vrácení pole z metody
    static int[] VytvorPole(int velikost) {
        int[] pole = new int[velikost];
        for (int i = 0; i < velikost; i++) {
            pole[i] = i + 1;
        }
        return pole;
    }

    // Použití
    static void Main() {
        int[] cisla = {1, 2, 3, 4, 5};

        VypisPole(cisla);           // 1 2 3 4 5
        NasobDvema(cisla);
        VypisPole(cisla);           // 2 4 6 8 10

        // params – různé způsoby volání
        Console.WriteLine(Soucet(1, 2, 3));         // 6
        Console.WriteLine(Soucet(10, 20, 30, 40));  // 100

        // Vrácení pole
        int[] novePole = VytvorPole(5);
        VypisPole(novePole);        // 1 2 3 4 5
    }
    ```

    = Statické metody třídy Array (C\#)

    Třída `System.Array` poskytuje statické metody pro práci s poli.

    == Řazení pole

    ```cs
    int[] cisla = {5, 2, 8, 1, 9};

    // Seřazení vzestupně
    Array.Sort(cisla);  // {1, 2, 5, 8, 9}

    // Obrácení pořadí
    Array.Reverse(cisla);  // {9, 8, 5, 2, 1}

    // Řazení stringů
    string[] jmena = {"Karel", "Anna", "Petr", "Eva"};
    Array.Sort(jmena);  // {Anna, Eva, Karel, Petr}
    ```

    == Vyhledávání v poli

    ```cs
    int[] cisla = {1, 2, 5, 8, 9};

    // Binární vyhledávání (pole musí být seřazené!)
    int index = Array.BinarySearch(cisla, 5);  // 2

    if (index >= 0) {
        Console.WriteLine($"Nalezeno na indexu {index}");
    } else {
        Console.WriteLine("Nenalezeno");
    }

    // IndexOf – najde první výskyt
    int[] cisla2 = {10, 20, 30, 20, 40};
    int pozice = Array.IndexOf(cisla2, 20);  // 1

    // LastIndexOf – najde poslední výskyt
    int posledni = Array.LastIndexOf(cisla2, 20);  // 3
    ```

    == Kopírování pole

    ```cs
    int[] puvodni = {1, 2, 3, 4, 5};

    // Kopírování celého pole
    int[] kopie = new int[5];
    Array.Copy(puvodni, kopie, 5);

    // Kopírování části pole
    int[] cast = new int[3];
    Array.Copy(puvodni, 1, cast, 0, 3);  // {2, 3, 4}

    // Clone – vytvoří mělkou kopii
    int[] klon = (int[])puvodni.Clone();
    ```

    == Vyplnění pole

    ```cs
    int[] cisla = new int[5];

    // Vyplnění celého pole jednou hodnotou
    Array.Fill(cisla, 10);  // {10, 10, 10, 10, 10}

    // Vyplnění části pole
    Array.Fill(cisla, 5, 1, 3);  // {10, 5, 5, 5, 10}
    //                 hodnota, start, count
    ```

    == Další užitečné metody

    ```cs
    int[] cisla = {1, 2, 3, 4, 5};

    // Vymazání pole (nastavení na výchozí hodnoty)
    Array.Clear(cisla, 0, cisla.Length);  // {0, 0, 0, 0, 0}

    // Změna velikosti (vytvoří nové pole)
    Array.Resize(ref cisla, 10);  // rozšíří na 10 prvků

    // Existence prvku
    bool existuje = Array.Exists(cisla, x => x > 3);  // true/false

    // Najdi prvek dle podmínky
    int[] cisla2 = {1, 2, 3, 4, 5};
    int prvni = Array.Find(cisla2, x => x > 3);  // 4
    int[] vsechny = Array.FindAll(cisla2, x => x > 2);  // {3, 4, 5}

    // ForEach – provede akci pro každý prvek
    Array.ForEach(cisla2, x => Console.Write(x + " "));
    ```

    = Instanční metody pole (C\#)

    Každé pole v C\# má vlastnosti a metody zděděné od `System.Array`.

    == Vlastnosti pole

    ```cs
    int[] cisla = {10, 20, 30, 40, 50};

    // Length – počet prvků
    int pocet = cisla.Length;  // 5

    // Rank – počet dimenzí (1 pro jednorozměrné pole)
    int dimenze = cisla.Rank;  // 1

    // IsReadOnly – zda je pole pouze pro čtení
    bool readOnly = cisla.IsReadOnly;  // false

    // IsFixedSize – zda má pole pevnou velikost
    bool fixed = cisla.IsFixedSize;  // true
    ```

    == Instance metody

    ```cs
    int[] cisla = {1, 2, 3, 4, 5};

    // GetLength – délka v dané dimenzi
    int delka = cisla.GetLength(0);  // 5

    // GetValue – získání hodnoty na indexu (jako object)
    object hodnota = cisla.GetValue(2);  // 3

    // SetValue – nastavení hodnoty na indexu
    cisla.SetValue(100, 2);  // cisla[2] = 100

    // Clone – vytvoří kopii pole
    int[] kopie = (int[])cisla.Clone();

    // CopyTo – zkopíruje do jiného pole
    int[] cil = new int[10];
    cisla.CopyTo(cil, 2);  // zkopíruje od indexu 2
    ```

    == LINQ metody pro pole

    Pole v C\# podporují LINQ dotazy:

    ```cs
    using System.Linq;

    int[] cisla = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    // Where – filtrování
    int[] suda = cisla.Where(x => x % 2 = 0).ToArray();  // {2, 4, 6, 8, 10}

    // Select – transformace
    int[] druhe = cisla.Select(x => x * x).ToArray();  // {1, 4, 9, 16, ...}

    // Sum – součet
    int soucet = cisla.Sum();  // 55

    // Average – průměr
    double prumer = cisla.Average();  // 5.5

    // Min / Max
    int min = cisla.Min();  // 1
    int max = cisla.Max();  // 10

    // Count – počet prvků splňujících podmínku
    int pocetVetsichNezPet = cisla.Count(x => x > 5);  // 5

    // Any – existuje alespoň jeden prvek splňující podmínku
    bool existujeSude = cisla.Any(x => x % 2 = 0);  // true

    // All – všechny prvky splňují podmínku
    bool vsechnaKladna = cisla.All(x => x > 0);  // true

    // First / Last
    int prvni = cisla.First();  // 1
    int posledni = cisla.Last();  // 10

    // FirstOrDefault – vrátí první nebo výchozí hodnotu
    int prvniVetsiNezDeset = cisla.FirstOrDefault(x => x > 10);  // 0

    // OrderBy / OrderByDescending
    int[] serazene = cisla.OrderByDescending(x => x).ToArray();  // {10, 9, 8, ...}

    // Take / Skip
    int[] prvnichPet = cisla.Take(5).ToArray();  // {1, 2, 3, 4, 5}
    int[] bezPrvnichPeti = cisla.Skip(5).ToArray();  // {6, 7, 8, 9, 10}

    // Distinct – unikátní hodnoty
    int[] sOpakovanim = {1, 2, 2, 3, 3, 3, 4};
    int[] unikatni = sOpakovanim.Distinct().ToArray();  // {1, 2, 3, 4}
    ```

    == Příklady praktického použití

    *Statistiky pole:*
    ```cs
    int[] znamky = {1, 2, 1, 3, 2, 1, 4, 3, 2};

    int pocet = znamky.Length;                    // 9
    double prumer = znamky.Average();             // 2.11
    int nejlepsi = znamky.Min();                  // 1
    int nejhorsi = znamky.Max();                  // 4
    int pocetJednicek = znamky.Count(z => z = 1); // 3

    Console.WriteLine($"Počet známek: {pocet}");
    Console.WriteLine($"Průměr: {prumer:F2}");
    Console.WriteLine($"Nejlepší: {nejlepsi}");
    Console.WriteLine($"Nejhorší: {nejhorsi}");
    Console.WriteLine($"Počet jedniček: {pocetJednicek}");
    ```

    *Filtrace a transformace:*
    ```cs
    string[] jmena = {"Anna", "Petr", "Karel", "Eva", "Martin"};

    // Jména začínající na 'A' nebo 'E', převedená na velká písmena
    var vysledek = jmena
        .Where(j => j.StartsWith("A") || j.StartsWith("E"))
        .Select(j => j.ToUpper())
        .ToArray();

    // vysledek: {"ANNA", "EVA"}

    // Seřazená jména delší než 4 znaky
    var dlouha = jmena
        .Where(j => j.Length > 4)
        .OrderBy(j => j)
        .ToArray();

    // dlouha: {"Karel", "Martin", "Petr"}
    ```

  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
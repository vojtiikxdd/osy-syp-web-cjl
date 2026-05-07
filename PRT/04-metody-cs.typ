#import "../template.typ": header, theme

#show: body => header(
  title: "Metody v C#",
  author: "Jan Prokůpek",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    = Pojem metoda

    *Metoda* je pojmenovaný blok kódu, který provádí specifickou úlohu. V C\# jsou metody vždy součástí třídy nebo struktury.

    Metody v C\# poskytují:
    - *Znovupoužitelnost* -- stejný kód lze volat opakovaně
    - *Organizaci* -- logické seskupení funkcionality
    - *Zapouzdření* -- skrytí implementačních detailů
    - *Abstrakci* -- zjednodušení složitých operací
    - *Modularitu* -- rozdělení programu na menší části

    *Rozdíl mezi metodou a funkcí:*
    - V C++ mluvíme o *funkcích*
    - V C\# mluvíme o *metodách* (jsou vždy součástí třídy)
    - Princip je stejný, terminologie se liší

    = Deklarace a implementace metody

    == Syntaxe

    ```cs
    // Základní struktura metody
    modifikatorPristupu navratovyTyp NazevMetody(typParametru1 parametr1, typParametru2 parametr2) {
        // tělo metody
        return hodnota;  // pokud návratový typ není void
    }
    ```

    == Části metody

    + *Modifikátor přístupu* -- `public`, `private`, `protected`, `internal`
    + *Návratový typ* -- typ hodnoty, kterou metoda vrací (`int`, `string`, `void`...)
    + *Název metody* -- identifikátor metody (PascalCase v C\#)
    + *Seznam parametrů* -- vstupy metody (může být prázdný)
    + *Tělo metody* -- kód ohraničený složenými závorkami
    + *Příkaz return* -- vrací hodnotu volajícímu kódu

    == Příklady základních metod

    ```cs
    class Program {
        // Metoda bez parametrů a bez návratové hodnoty
        static void Pozdrav() {
            Console.WriteLine("Ahoj!");
        }

        // Metoda s parametry a návratovou hodnotou
        static int Soucet(int a, int b) {
            return a + b;
        }

        // Metoda s více parametry
        static double Objem(double delka, double sirka, double vyska) {
            return delka * sirka * vyska;
        }

        // Metoda vracející boolean
        static bool JeKladne(int cislo) {
            return cislo > 0;
        }

        // Metoda vracející string
        static string ZiskejPozdrav(string jmeno) {
            return $"Ahoj, {jmeno}!";
        }
    }
    ```

    == Příkaz return

    Příkaz `return` má dva účely:

    + *Ukončí vykonávání metody* -- žádný další kód po return se neprovede
    + *Vrátí hodnotu* -- pokud metoda není typu `void`

    ```cs
    static int AbsolutniHodnota(int cislo) {
        if (cislo < 0) {
            return -cislo;  // ukončí metodu zde
        }
        return cislo;  // jinak vrátí původní hodnotu
    }

    static void VypisHodnotu(int x) {
        if (x < 0) {
            Console.WriteLine("Záporné číslo");
            return;  // předčasné ukončení (void metoda)
        }
        Console.WriteLine($"Kladné číslo: {x}");
    }
    ```

    = Volání metod

    == Statické metody

    Statické metody se volají přes název třídy nebo přímo (pokud jsou ve stejné třídě):

    ```cs
    class Matematika {
        static int Soucet(int a, int b) {
            return a + b;
        }

        static void Main() {
            // Volání metody ve stejné třídě
            int vysledek = Soucet(5, 3);

            // Volání metody z jiné třídy
            int vysledek2 = Matematika.Soucet(10, 20);
        }
    }
    ```

    == Instance metody (nestatické)

    Nestatické metody vyžadují instanci třídy:

    ```cs
    class Kalkulacka {
        public int Soucet(int a, int b) {
            return a + b;
        }
    }

    class Program {
        static void Main() {
            Kalkulacka calc = new Kalkulacka();
            int vysledek = calc.Soucet(5, 3);  // volání přes instanci
        }
    }
    ```

    == Různé způsoby volání

    ```cs
    class Demo {
        static int Mocnina(int zaklad, int exponent) {
            int vysledek = 1;
            for (int i = 0; i < exponent; i++) {
                vysledek *= zaklad;
            }
            return vysledek;
        }

        static void Main() {
            // S proměnnými
            int x = 2, y = 3;
            int a = Mocnina(x, y);

            // S konstantami
            int b = Mocnina(5, 2);

            // S výrazem
            int c = Mocnina(3, 1 + 1);

            // Vnořené volání
            int d = Mocnina(Mocnina(2, 2), 2);  // (2^2)^2 = 16

            // Výsledek jako argument
            Console.WriteLine(Mocnina(2, 5));
        }
    }
    ```

    = Formální a skutečné parametry

    == Formální parametry

    - Parametry v *definici* metody
    - Definují typ a název vstupních hodnot
    - Fungují jako lokální proměnné uvnitř metody
    - Existují pouze během provádění metody

    == Skutečné parametry (argumenty)

    - Hodnoty předané při *volání* metody
    - Mohou být: literály, proměnné, výrazy
    - Musí odpovídat typem a počtem formálním parametrům
    - Pořadí musí souhlasit (nebo použít pojmenované argumenty)

    ```cs
    static double VypocetCeny(double cena, double dph, double sleva) {
        // cena, dph, sleva jsou FORMÁLNÍ parametry
        return cena * (1 + dph) * (1 - sleva);
    }

    static void Main() {
        double zakladniCena = 1000;
        double sazba = 0.21;
        double slevaProcent = 0.1;

        // zakladniCena, sazba, slevaProcent jsou SKUTEČNÉ parametry
        double konecnaCena = VypocetCeny(zakladniCena, sazba, slevaProcent);

        // Také lze použít literály jako skutečné parametry
        double cena2 = VypocetCeny(500, 0.21, 0.05);
    }
    ```

    == Pojmenované argumenty

    C\# umožňuje předávat argumenty podle názvu:

    ```cs
    static void VytvorUzivatele(string jmeno, int vek, string mesto) {
        Console.WriteLine($"{jmeno}, {vek} let, {mesto}");
    }

    static void Main() {
        // Standardní pořadí
        VytvorUzivatele("Jan", 25, "Praha");

        // Pojmenované argumenty (libovolné pořadí)
        VytvorUzivatele(mesto: "Brno", jmeno: "Petra", vek: 30);

        // Kombinace
        VytvorUzivatele("Karel", vek: 28, mesto: "Ostrava");
    }
    ```

    == Volitelné parametry

    Parametry mohou mít výchozí hodnoty:

    ```cs
    static void Pozdrav(string jmeno, string zprava = "Ahoj") {
        Console.WriteLine($"{zprava}, {jmeno}!");
    }

    static void Main() {
        Pozdrav("Jan");                    // použije výchozí "Ahoj"
        Pozdrav("Petra", "Dobrý den");     // použije "Dobrý den"
    }
    ```

    = Modifikátory parametrů

    C\# nabízí různé způsoby předávání parametrů pomocí modifikátorů.

    == Předávání hodnotou (výchozí)

    - Standardní způsob bez modifikátoru
    - Vytvoří se *kopie* hodnoty
    - Změny uvnitř metody *neovlivní* původní proměnnou
    - Vhodné pro hodnotové typy (int, double, bool...)

    ```cs
    static void Zmena(int x) {
        x = 100;  // změní pouze lokální kopii
        Console.WriteLine($"Uvnitř metody: {x}");
    }

    static void Main() {
        int a = 5;
        Zmena(a);
        Console.WriteLine($"Po volání: {a}");  // stále 5
    }
    ```

    == Modifikátor ref

    - Předává *referenci* na původní proměnnou
    - Změny uvnitř metody *ovlivní* původní proměnnou
    - Proměnná *musí být inicializována* před voláním
    - Při volání musí být použito klíčové slovo `ref`

    ```cs
    static void Zmena(ref int x) {
        x = 100;  // změní původní proměnnou
    }

    static void Prohod(ref int a, ref int b) {
        int temp = a;
        a = b;
        b = temp;
    }

    static void Main() {
        int cislo = 5;
        Zmena(ref cislo);
        Console.WriteLine(cislo);  // vypíše 100

        int x = 10, y = 20;
        Prohod(ref x, ref y);
        Console.WriteLine($"{x}, {y}");  // vypíše 20, 10
    }
    ```

    == Modifikátor out

    - Podobný jako `ref`, ale proměnná *nemusí být inicializována*
    - Metoda *musí přiřadit* hodnotu parametru před ukončením
    - Vhodné pro vracení více hodnot z metody
    - Při volání musí být použito klíčové slovo `out`

    ```cs
    static bool TryParse(string text, out int vysledek) {
        try {
            vysledek = int.Parse(text);
            return true;
        } catch {
            vysledek = 0;
            return false;
        }
    }

    static void VratViceHodnot(int x, out int dvojnasobek, out int trojnasobek) {
        dvojnasobek = x * 2;
        trojnasobek = x * 3;
    }

    static void Main() {
        // out - nemusí být inicializováno
        int hodnota;
        if (TryParse("123", out hodnota)) {
            Console.WriteLine($"Převod OK: {hodnota}");
        }

        // C# 7.0+ inline deklarace
        if (TryParse("456", out int cislo)) {
            Console.WriteLine($"Převod OK: {cislo}");
        }

        // Vracení více hodnot
        VratViceHodnot(5, out int dva, out int tri);
        Console.WriteLine($"2x: {dva}, 3x: {tri}");  // 10, 15
    }
    ```

    == Modifikátor in (C\# 7.2+)

    - Předává referenci, ale *pouze pro čtení*
    - Optimalizace pro velké struktury
    - Zabrání změně hodnoty uvnitř metody
    - Volitelné použití klíčového slova při volání

    ```cs
    static double VypocetVzdalenosti(in Vector3 bod1, in Vector3 bod2) {
        // bod1 a bod2 nelze měnit
        double dx = bod2.X - bod1.X;
        double dy = bod2.Y - bod1.Y;
        double dz = bod2.Z - bod1.Z;
        return Math.Sqrt(dx * dx + dy * dy + dz * dz);
    }
    ```

    == Modifikátor params

    - Umožňuje předat *proměnný počet* argumentů
    - Argumenty jsou předány jako pole
    - Musí být poslední parametr v seznamu
    - Lze volat bez argumentů (prázdné pole)

    ```cs
    static int Soucet(params int[] cisla) {
        int vysledek = 0;
        foreach (int cislo in cisla) {
            vysledek += cislo;
        }
        return vysledek;
    }

    static void Main() {
        Console.WriteLine(Soucet());                    // 0
        Console.WriteLine(Soucet(5));                   // 5
        Console.WriteLine(Soucet(1, 2, 3));            // 6
        Console.WriteLine(Soucet(10, 20, 30, 40, 50)); // 150

        // Nebo předat pole přímo
        int[] pole = { 1, 2, 3, 4 };
        Console.WriteLine(Soucet(pole));                // 10
    }
    ```

    == Porovnání modifikátorů

    #table(
      columns: (auto, auto, auto, auto),
      align: left,
      [*Modifikátor*], [*Inicializace před*], [*Přiřazení v metodě*], [*Může měnit*],
      [(žádný)], [Ne], [Ne], [Ne (kopie)],
      [`ref`], [Ano], [Ne], [Ano],
      [`out`], [Ne], [Ano (povinné)], [Ano],
      [`in`], [Ano], [Ne], [Ne (readonly)],
      [`params`], [Ne], [Ne], [Ano (prvky pole)],
    )

    = Přetěžování metod (Method Overloading)

    *Přetěžování metod* umožňuje definovat více metod se *stejným názvem*, ale s *různými parametry*.

    == Pravidla přetěžování

    Metody se mohou lišit:
    + *Počtem parametrů*
    + *Typy parametrů*
    + *Pořadím typů parametrů*
    + *Modifikátory parametrů* (ref, out, in)

    Metody se *neliší* pouze:
    - Návratovým typem
    - Názvy parametrů
    - Modifikátory přístupu

    == Příklady přetěžování

    ```cs
    class Kalkulacka {
        // Různý počet parametrů
        public int Soucet(int a, int b) {
            return a + b;
        }

        public int Soucet(int a, int b, int c) {
            return a + b + c;
        }

        public int Soucet(int a, int b, int c, int d) {
            return a + b + c + d;
        }

        // Různé typy parametrů
        public double Soucet(double a, double b) {
            return a + b;
        }

        public string Soucet(string a, string b) {
            return a + b;  // spojení řetězců
        }

        // Různé pořadí typů
        public void Vypis(int cislo, string text) {
            Console.WriteLine($"Číslo: {cislo}, Text: {text}");
        }

        public void Vypis(string text, int cislo) {
            Console.WriteLine($"Text: {text}, Číslo: {cislo}");
        }
    }
    ```

    == Přetěžování s modifikátory

    ```cs
    class Demo {
        // Standardní předání hodnotou
        public void Metoda(int x) {
            Console.WriteLine("Předání hodnotou");
        }

        // Přetížení s ref
        public void Metoda(ref int x) {
            Console.WriteLine("Předání referencí (ref)");
        }

        // Přetížení s out
        public void Metoda(out int x) {
            x = 10;
            Console.WriteLine("Předání výstupem (out)");
        }
    }
    ```

    == Praktický příklad

    ```cs
    class FormatovaniTextu {
        // Základní metoda
        public string Formatuj(string text) {
            return text.ToUpper();
        }

        // S délkou
        public string Formatuj(string text, int maxDelka) {
            string vysledek = text.ToUpper();
            if (vysledek.Length > maxDelka) {
                vysledek = vysledek.Substring(0, maxDelka) + "...";
            }
            return vysledek;
        }

        // S délkou a prefixem
        public string Formatuj(string text, int maxDelka, string prefix) {
            string vysledek = text.ToUpper();
            if (vysledek.Length > maxDelka) {
                vysledek = vysledek.Substring(0, maxDelka) + "...";
            }
            return prefix + vysledek;
        }

        static void Main() {
            var fmt = new FormatovaniTextu();

            Console.WriteLine(fmt.Formatuj("ahoj"));              // AHOJ
            Console.WriteLine(fmt.Formatuj("ahoj světe", 6));     // AHOJ S...
            Console.WriteLine(fmt.Formatuj("ahoj", 10, ">>> "));  // >>> AHOJ
        }
    }
    ```

    == Výhody přetěžování

    + *Flexibilita* -- jedna metoda pro různé situace
    + *Čitelnost* -- není nutné pamatovat různé názvy
    + *Intuitivnost* -- programátor může volat stejnou metodu různými způsoby
    + *Konzistence* -- jednotné rozhraní pro podobné operace
    + *Polymorfismus* -- základ OOP v C\#
  ],
  resources: [
    Žádné další zdroje
  ],
)

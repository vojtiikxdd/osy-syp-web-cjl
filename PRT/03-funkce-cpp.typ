#import "../template.typ": header, simple

#show: body => header(
  title: "Funkce v C++",
  author: "Jan Prokůpek",
  body,
)

#simple(
  body: [
    #set heading(numbering: "1.1")

    = Pojem funkce

    *Funkce* je pojmenovaný blok kódu, který provádí určitou úlohu. Funkce umožňují:
    - *Znovupoužitelnost kódu* -- jednou napsaný kód lze volat vícekrát
    - *Modularitu* -- rozdělení programu na menší, logické celky
    - *Čitelnost* -- přehlednější a srozumitelnější kód
    - *Údržbu* -- snadnější opravy a změny
    - *Abstrakci* -- skrytí implementačních detailů
    = Definice funkce

    Funkce v C++ má dvě části: *deklaraci* (prototyp) a *implementaci* (tělo funkce).

    == Syntaxe

    ```cpp
    // Deklarace (prototyp) – říká překladači, že funkce existuje
    navratovyTyp nazevFunkce(typParametru1 parametr1, typParametru2 parametr2);

    // Implementace (definice) – obsahuje kód funkce
    navratovyTyp nazevFunkce(typParametru1 parametr1, typParametru2 parametr2) {
        // tělo funkce
        return hodnota;  // pokud návratový typ není void
    }
    ```

    == Části funkce

    + *Návratový typ* -- typ hodnoty, kterou funkce vrací (`int`, `double`, `void`...)
    + *Název funkce* -- identifikátor funkce
    + *Seznam parametrů* -- vstupy funkce (může být prázdný)
    + *Tělo funkce* -- kód ohraničený složenými závorkami `{}`
    + *Příkaz return* -- vrací hodnotu (kromě funkcí typu `void`)
    == Příklady

    ```cpp
    // Funkce bez parametrů a bez návratové hodnoty
    void pozdrav() {
        cout << "Ahoj!" << endl;
    }

    // Funkce s parametry a návratovou hodnotou
    int soucet(int a, int b) {
        return a + b;
    }

    // Funkce s více parametry
    double objem(double delka, double sirka, double vyska) {
        return delka * sirka * vyska;
    }

    // Funkce vracející boolean
    bool jeKladne(int cislo) {
        return cislo > 0;
    }
    ```

    #pagebreak()

    = Umístění definice funkce

    == Před funkcí main()

    ```cpp
    #include <iostream>
    using namespace std;

    // Funkce definována před main() – není potřeba prototyp
    int soucet(int a, int b) {
        return a + b;
    }

    int main() {
        int vysledek = soucet(5, 3);
        cout << vysledek << endl;
        return 0;
    }
    ```

    == Po funkci main() s prototypem

    ```cpp
    #include <iostream>
    using namespace std;

    // Prototyp (deklarace) před main()
    int soucet(int a, int b);

    int main() {
        int vysledek = soucet(5, 3);
        cout << vysledek << endl;
        return 0;
    }

    // Implementace po main()
    int soucet(int a, int b) {
        return a + b;
    }
    ```

    == Hlavičkové soubory

    Pro větší projekty se funkce rozdělují do samostatných souborů:

    *matematika.h* (hlavičkový soubor -- deklarace):
    ```cpp
    #ifndef MATEMATIKA_H
    #define MATEMATIKA_H

    int soucet(int a, int b);
    int rozdil(int a, int b);
    double prumer(int a, int b);

    #endif
    ```

    *matematika.cpp* (zdrojový soubor -- implementace):
    ```cpp
    #include "matematika.h"

    int soucet(int a, int b) {
        return a + b;
    }

    int rozdil(int a, int b) {
        return a - b;
    }

    double prumer(int a, int b) {
        return (a + b) / 2.0;
    }
    ```

    *main.cpp* (hlavní program):
    ```cpp
    #include <iostream>
    #include "matematika.h"
    using namespace std;

    int main() {
        cout << soucet(10, 5) << endl;      // 15
        cout << rozdil(10, 5) << endl;      // 5
        cout << prumer(10, 5) << endl;      // 7.5
        return 0;
    }
    ```

    = Volání funkce

    *Volání funkce* znamená provedení (spuštění) kódu, který je v těle funkce definován.

    ```cpp
    int soucet(int a, int b) {    // a, b jsou FORMÁLNÍ parametry
        return a + b;
    }

    int main() {
        int x = 10, y = 20;
        int vysledek = soucet(x, y);    // x, y jsou SKUTEČNÉ parametry
        // nebo přímo:
        int vysledek2 = soucet(5, 8);   // 5, 8 jsou SKUTEČNÉ parametry
        return 0;
    }
    ```

    == Formální parametry

    - Parametry v *definici* funkce
    - Specifikují typ a název vstupních hodnot
    - Existují pouze během provádění funkce
    - Fungují jako lokální proměnné

    == Skutečné parametry (argumenty)

    - Hodnoty předané při *volání* funkce
    - Mohou být: konstanty, proměnné, výrazy
    - Musí odpovídat typem formálním parametrům
    - Počet a pořadí musí souhlasit

    ```cpp
    double mocnina(double zaklad, int exponent) {
        double vysledek = 1;
        for (int i = 0; i < exponent; i++) {
            vysledek *= zaklad;
        }
        return vysledek;
    }

    int main() {
        // Různé způsoby volání
        double a = mocnina(2.0, 3);         // s proměnnými
        double b = mocnina(5, 2);           // s konstantami
        double c = mocnina(1.5, 2 + 2);     // s výrazem
        return 0;
    }
    ```

    = Lokální a globální proměnné

    == Lokální proměnné

    - Deklarované *uvnitř* funkce nebo bloku
    - Existují pouze během provádění funkce
    - Každé volání funkce vytváří novou instanci
    - Po ukončení funkce jsou zničeny
    - Mají přednost před globálními proměnnými se stejným názvem

    ```cpp
    void funkce() {
        int lokalniPromenna = 10;  // lokální proměnná
        // použitelná jen v této funkci
    }

    int main() {
        int x = 5;  // lokální v main()
        funkce();
        // zde nelze použít lokalniPromenna ani x z funkce()
        return 0;
    }
    ```

    == Globální proměnné

    - Deklarované *mimo* všechny funkce
    - Dostupné ve všech funkcích v programu
    - Existují po celou dobu běhu programu
    - Uchovávají hodnotu mezi voláními funkcí
    - *Nedoporučuje se nadužívat* – horší čitelnost a údržba

    ```cpp
    #include <iostream>
    using namespace std;

    int globalniPromenna = 100;  // globální proměnná

    void funkce1() {
        cout << globalniPromenna << endl;  // přístup k globální
        globalniPromenna = 200;             // změna globální
    }

    void funkce2() {
        int globalniPromenna = 50;  // lokální – zastíní globální
        cout << globalniPromenna << endl;        // vypíše 50
        cout << ::globalniPromenna << endl;      // :: přístup ke globální
    }

    int main() {
        funkce1();  // vypíše 100, změní na 200
        funkce1();  // vypíše 200
        funkce2();  // vypíše 50, pak 200
        return 0;
    }
    ```

    = Typy parametrů funkcí

    == Předávání hodnotou (by value)

    - Standardní způsob předávání parametrů
    - Vytvoří se *kopie* skutečného parametru
    - Změny uvnitř funkce neovlivní původní proměnnou
    - Vhodné pro malé datové typy

    ```cpp
    void zmena(int x) {
        x = 100;  // změní pouze lokální kopii
    }

    int main() {
        int a = 5;
        zmena(a);
        cout << a << endl;  // vypíše 5 (původní hodnota)
        return 0;
    }
    ```

    == Předávání referencí (by reference)

    - Používá se symbol `&`
    - Nepředává se kopie, ale *odkaz* na originální proměnnou
    - Změny uvnitř funkce *ovlivní* původní proměnnou
    - Efektivnější pro velké datové struktury
    - Umožňuje vracet více hodnot

    ```cpp
    void zmena(int &x) {  // & označuje referenci
        x = 100;  // změní původní proměnnou
    }

    void prohod(int &a, int &b) {
        int temp = a;
        a = b;
        b = temp;
    }

    int main() {
        int a = 5;
        zmena(a);
        cout << a << endl;  // vypíše 100 (změněná hodnota)

        int x = 10, y = 20;
        prohod(x, y);
        cout << x << ", " << y << endl;  // vypíše 20, 10
        return 0;
    }
    ```

    == Předávání ukazatelem (by pointer)

    - Používá se symbol `*` pro typ a `&` pro získání adresy
    - Předává se *adresa* proměnné v paměti
    - Funkce pracuje s adresou pomocí operátoru dereference `*`
    - Starší způsob, reference jsou modernější

    ```cpp
    void zmena(int *x) {  // ukazatel na int
        *x = 100;  // změna hodnoty na adrese
    }

    int main() {
        int a = 5;
        zmena(&a);  // předání adresy proměnné a
        cout << a << endl;  // vypíše 100
        return 0;
    }
    ```

    == Konstantní parametry

    - Používá se klíčové slovo `const`
    - Zabrání změně hodnoty parametru
    - Užitečné pro velké objekty předávané referencí

    ```cpp
    void vypis(const int &x) {  // konstantní reference
        cout << x << endl;
        // x = 10;  // CHYBA – nelze měnit const parametr
    }

    double obvod(const double pi, const double r) {
        return 2 * pi * r;
        // pi = 3;  // CHYBA – nelze měnit
    }
    ```

    == Výchozí hodnoty parametrů

    - Parametry mohou mít výchozí hodnoty
    - Výchozí hodnoty se zadávají v deklaraci (prototypu)
    - Parametry s výchozí hodnotou musí být na konci seznamu

    ```cpp
    // V prototypu nebo definici
    void tiskni(string text, int pocet = 1) {
        for (int i = 0; i < pocet; i++) {
            cout << text << endl;
        }
    }

    int main() {
        tiskni("Ahoj");        // použije výchozí pocet = 1
        tiskni("Ahoj", 3);     // použije pocet = 3
        return 0;
    }
    ```

    = Přetěžování funkcí (Function Overloading)

    *Přetěžování funkcí* umožňuje definovat více funkcí se *stejným názvem*, ale s *různými parametry*.

    == Pravidla přetěžování

    Funkce se liší:
    + *Počtem parametrů*
    + *Typy parametrů*
    + *Pořadím typů parametrů*

    Funkce se *neliší* pouze návratovým typem!

    == Příklady přetěžování

    ```cpp
    // Různý počet parametrů
    int soucet(int a, int b) {
        return a + b;
    }

    int soucet(int a, int b, int c) {
        return a + b + c;
    }

    // Různé typy parametrů
    double soucet(double a, double b) {
        return a + b;
    }

    string soucet(string a, string b) {
        return a + b;  // spojení řetězců
    }

    // Použití
    int main() {
        cout << soucet(5, 3) << endl;           // volá int, int
        cout << soucet(5, 3, 2) << endl;        // volá int, int, int
        cout << soucet(2.5, 3.7) << endl;       // volá double, double
        cout << soucet("Ahoj ", "svete") << endl; // volá string, string
        return 0;
    }
    ```

    == Praktický příklad – tisk různých typů

    ```cpp
    #include <iostream>
    using namespace std;

    void vypis(int x) {
        cout << "Celé číslo: " << x << endl;
    }

    void vypis(double x) {
        cout << "Reálné číslo: " << x << endl;
    }

    void vypis(string x) {
        cout << "Text: " << x << endl;
    }

    void vypis(int x, int y) {
        cout << "Dva integery: " << x << ", " << y << endl;
    }

    int main() {
        vypis(42);              // volá vypis(int)
        vypis(3.14);            // volá vypis(double)
        vypis("Hello");         // volá vypis(string)
        vypis(10, 20);          // volá vypis(int, int)
        return 0;
    }
    ```

    == Výhody přetěžování

    + Jednoduché rozhraní -- stejný název pro podobné operace
    + Čitelnější kód -- není nutné vymýšlet různé názvy
    + Intuitivní použití -- programátor nemusí pamatovat různé názvy
    + Polymorfismus -- základ objektově orientovaného programování
  ],
  resources: [
    - #link("https://www.youtube.com")[Youtube - Téma]
    - #link("https://en.wikipedia.org/")[Wiki - Téma]
  ],
)
# Maturitní zápisky — OSY / SYP / WEB

Sdílené typst zápisky ke státní maturitě. PDF se generují automaticky po každém merge do `main`.

---

# 📄 PDF náhled

Všechna PDF jsou automaticky generována po merge do `main` a dostupná na branchi [generated](https://github.com/vojtiikxdd/osy-syp-web/tree/generated).

---

# ⚠️ Než začneš cokoliv dělat

1. **Vytvoř si vlastní branch** podle názvu otázky, např. `osy-*cislo*-navrh-male-site`
2. Soubor vlož do správné složky: `OSY/`, `SYP/` nebo `WEB/`
3. Pojmenuj soubor podle otázky, např. `*cislo-otazky*-navrh-male-site.typ`
4. Až budeš hotov, udělej PR přes [webové rozhraní](https://github.com/vojtiikxdd/osy-syp-web/compare) — **nikdy ho nesluč sám**

---

# Struktura repozitáře

```
OSY/       ← zápisky pro OSY
SYP/       ← zápisky pro SYP
WEB/       ← zápisky pro WEB
assets/    ← obrázky sdílené napříč zápisky
template.typ  ← šablona, kterou importuješ
```

---

# Jak napsat nový zápis

Zkopíruj tuto kostru do svého `.typ` souboru:

```typ
#import "../template.typ": header, theme

#show: body => header(
  title: "Název otázky",
  author: "Jméno Příjmení",
  body,
)

#theme(
  intro: [
    Krátký úvod k tématu.
  ],
  body: [
    = Nadpis kapitoly
    Text...
  ],
  summary: [
    Shrnutí.
  ],
  resources: [
    - [Youtube vide](https://www.youtube.com)
    - [wiki](https://en.wikipedia.org/wiki/Wiki)
  ],
)
```

dokumentace různých funkcí Typstu [zde](https://typst.app/docs/)

---

# Lokální náhled před pushnutím

Nainstaluj [Typst](https://github.com/typst/typst/releases/latest) a spusť:

```bash
typst compile OSY/tvuj-soubor.typ
```

nebo živý náhled při úpravách:

```bash
typst watch OSY/tvuj-soubor.typ
```

případně si přidej do VS Code extension [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) a používej preview v editoru vpravo nahoře (ikona knihy s lupou)
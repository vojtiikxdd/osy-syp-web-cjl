#import "../template.typ": header, theme

#show: body => header(
  title: "Instalace a konfigurace síťových služeb",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    #set heading(numbering: "1.1")

    Síťové služby představují základní funkce serverů v počítačové síti. Umožňují komunikaci mezi zařízeními, sdílení dat, správu uživatelů nebo poskytování webových aplikací. Každá síťová služba naslouchá na konkrétním *portu* a komunikuje přes protokol *TCP* nebo *UDP*. Správce systému musí služby nejen nainstalovat, ale také správně nastavit jejich konfiguraci, zabezpečení a správu uživatelů.

    = Rozdíl mezi Windows a Linuxem
    Instalace a konfigurace síťových služeb se mezi systémy Windows a Linux výrazně liší — především v přístupu ke správě, konfiguračním souborům a nástrojům.

    == Windows
    Ve Windows se síťové služby nazývají *Services* a spravují se přes grafické rozhraní nebo PowerShell. Konfigurace probíhá většinou skrze GUI (grafická průvodce, snap-iny MMC). Na serverové platformě se role instalují nástrojem *Server Manager*:

    + Otevřít *Server Manager*
    + Zvolit *Add Roles and Features*
    + Vybrat požadovanou roli (např. DHCP Server, DNS Server)
    + Dokončit instalaci pomocí průvodce

    Alternativně lze použít PowerShell:
    ```powershell
        Install-WindowsFeature DHCP
        Install-WindowsFeature DNS
    ```

    Výhodou Windows je snadné grafické rozhraní a těsná integrace všech služeb do jednoho správního prostředí (Active Directory, Group Policy apod.).

    == Linux
    V Linuxu se síťové služby nazývají *Daemony* (démoni) a jejich konfigurace probíhá editací *konfiguračních souborů* (typicky v adresáři `/etc/`). Služby se instalují pomocí správců balíčků. Například v distribuci Ubuntu/Debian:

    ```bash
        sudo apt update          # Aktualizuje seznam dostupných balíčků
        sudo apt upgrade         # Nainstaluje nové verze již nainstalovaných balíčků
        sudo apt install apache2 # Nainstaluje webový server Apache
    ```

    Spuštění a správa služeb se provádí přes `systemctl`:

    ```bash
        sudo systemctl start apache2    # Spustí službu
        sudo systemctl enable apache2   # Nastaví automatický start po restartu
        sudo systemctl status apache2   # Zobrazí stav služby
        sudo systemctl stop apache2     # Zastaví službu
    ```

    Výhodou Linuxu je vysoká flexibilita, možnost automatizace pomocí skriptů a velké množství dostupných open-source služeb.

    = Rozdíl mezi serverem a desktopu (Windows)
    Operační systém Windows existuje ve dvou hlavních variantách:

    / Desktopová verze (Windows 10, 11): Určena pro běžné uživatele. Síťové služby nejsou standardně instalovány nebo jsou silně omezeny (např. sdílení souborů, vzdálená plocha). Nepodporuje plnohodnotné serverové role.
    / Serverová verze (Windows Server 2019, 2022): Optimalizována pro provoz síťových služeb a správu celé organizace. Obsahuje Active Directory, DHCP, DNS, webový server IIS, správu uživatelů v doméně a další role.

    = Přehled síťových služeb
    == DHCP server
    *DHCP* (Dynamic Host Configuration Protocol) automaticky přiděluje síťovou konfiguraci zařízením v síti. Bez DHCP by správce musel nastavovat adresy ručně na každém zařízení.

    DHCP přiděluje klientům:
    - *IP adresu* z nastaveného rozsahu (tzv. scope/pool)
    - Adresu *výchozí brány* (default gateway)
    - Adresu *DNS serveru*
    - *Lease time* — dobu, po kterou je IP adresa přidělena danému zařízení

    Po vypršení lease time si zařízení musí o adresu požádat znovu.

    == DNS server
    *DNS* (Domain Name System) převádí doménová jména na IP adresy a zpět. Je to základní infrastrukturní služba internetu i firemních sítí.

    ```
    www.google.com  →  142.250.x.x   (A záznam — IPv4)
    mail.firma.cz   →  10.0.0.5      (MX záznam — mailový server)
    ```

    Hlavní typy DNS záznamů:
    - *A* — doménové jméno → IPv4 adresa
    - *AAAA* — doménové jméno → IPv6 adresa
    - *MX* — adresa poštovního serveru pro doménu
    - *CNAME* — alias (přezdívka) pro jiné doménové jméno
    - *PTR* — reverzní překlad (IP → jméno)

    == FTP server
    *FTP* (File Transfer Protocol) zajišťuje přenos souborů mezi klientem a serverem. Používá port *21* (řídící spojení) a port *20* (datové spojení).

    Funkce a vlastnosti:
    - Přihlašování pomocí *uživatelského jména a hesla*
    - Možnost *anonymního přístupu* (bez hesla, omezená práva)
    - Nastavení *přístupových práv* (čtení, zápis, mazání)
    - Přenos souborů oběma směry (upload i download)

    Nevýhodou klasického FTP je přenos dat *bez šifrování* — proto se v praxi preferuje *SFTP* (FTP přes SSH) nebo *FTPS* (FTP přes TLS).

    === Rozdíl mezi FTP a TFTP
    / FTP (File Transfer Protocol): Plnohodnotný protokol s autentizací, podporou přístupových práv a přenosem oběma směry. Používá *TCP* (spolehlivý přenos).
    / TFTP (Trivial File Transfer Protocol): Velmi jednoduchý protokol *bez autentizace*. Používá *UDP* (nespolehlivý, ale rychlý přenos). Používá se typicky pro bootování zařízení přes síť (PXE boot) nebo nahrávání firmware do síťových zařízení.

    == HTTP/HTTPS server
    *HTTP* (Hypertext Transfer Protocol) server poskytuje webové stránky a aplikace. *HTTPS* je zabezpečená varianta využívající *SSL/TLS certifikát* pro šifrování komunikace.

    Funkce webového serveru:
    - Obsluha HTTP/HTTPS požadavků na portu *80* (HTTP) a *443* (HTTPS)
    - Nastavení *přístupových práv* (omezení přístupu k adresářům)
    - Provoz *více webových stránek na jednom serveru* (virtual hosting)
    - Podpora SSL certifikátů pro HTTPS

    Příklady webových serverů:
    - *Apache HTTP Server* — nejrozšířenější open-source webový server
    - *Nginx* — výkonný server, oblíbený jako reverse proxy
    - *Microsoft IIS* — integrovaný webový server ve Windows Serveru

    == SSH server
    *SSH* (Secure Shell) umožňuje *vzdálený šifrovaný přístup* k serveru přes příkazový řádek. Je standardem pro vzdálenou správu linuxových serverů, používá port *22*.

    Funkce:
    - Přihlášení pomocí *hesla* nebo *kryptografických klíčů* (bezpečnější varianta)
    - Správa *uživatelů* a jejich oprávnění k přístupu
    - Možnost tunelování jiných protokolů přes šifrované SSH spojení
    - Bezpečný přenos souborů přes *SFTP* (nadstavba SSH)

    == File server
    File server zajišťuje *sdílení souborů a adresářů* v síti. Uživatelé mohou ukládat, číst a sdílet dokumenty, přičemž správce nastavuje přístupová práva pro jednotlivé uživatele nebo skupiny.

    Ve Windows se nejčastěji používá protokol *SMB* (Server Message Block). V Linuxu se pro sdílení se systémy Windows nasazuje *Samba* (implementace SMB pro Linux), pro sdílení mezi Linuxovými systémy *NFS*.

    == Print server
    Print server spravuje síťové tiskárny a tiskové fronty. Zajišťuje sdílení tiskárny mezi více uživateli, správu tiskových úloh a řízení přístupových práv.

    == SQL server
    SQL server slouží k ukládání a správě relačních databází. Komunikuje přes jazyk *SQL* (Structured Query Language).

    Příklady:
    - *MySQL / MariaDB* — open-source, velmi rozšířený (webové aplikace)
    - *PostgreSQL* — open-source, pokročilé funkce
    - *Microsoft SQL Server* — komerční řešení pro Windows prostředí

    == SMTP server
    *SMTP* (Simple Mail Transfer Protocol) zajišťuje *odesílání e-mailů* mezi poštovními servery. Pracuje na portu *25* (mezi servery) nebo portu *587* (odesílání od klientů). Pro příjem e-mailů se používají protokoly *IMAP* (port 143/993) nebo *POP3* (port 110/995).

    == Firewall
    Firewall je síťová bezpečnostní služba, která kontroluje a filtruje síťový provoz na základě definovaných *pravidel*. Spravuje, které porty jsou otevřeny nebo blokovány, a řídí pravidla komunikace mezi sítěmi (např. LAN ↔ internet).

    Ve Windows je integrován *Windows Defender Firewall*, v Linuxu se nejčastěji používá `iptables` nebo novější `nftables` (a jejich nadstavby jako `ufw` nebo `firewalld`).

    = Konfigurace z příkazového řádku
    == Windows (PowerShell / netsh)
    ```powershell
        # Nastavení statické IP adresy
        netsh interface ip set address "Ethernet" static 192.168.1.10 255.255.255.0 192.168.1.1

        # Instalace role přes PowerShell
        Install-WindowsFeature -Name DHCP -IncludeManagementTools
    ```

    == Linux (systemctl / ip)
    ```bash
        # Správa služeb
        sudo systemctl start|stop|restart|enable|status <služba>

        # Nastavení IP adresy (dočasně)
        sudo ip addr add 192.168.1.10/24 dev eth0

        # Zobrazení síťových rozhraní
        ip a
    ```
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaký je rozdíl v instalaci síťových služeb na platformách Windows / Linux"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Jaký je rozdíl v konfiguraci serveru a desktopu (Windows)"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Konfigurace síťových služeb z příkazového řádku"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "V jakém nástroji a jak se instalují jednotlivé služby ve Windows Server"
      #v(1em)
      //> @
    ]
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Popište jednotlivé síťové služby (DHCP, DNS, FTP, HTTP, file server, print server, SQL server, SMTP server)"
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://cs.wikipedia.org/wiki/S%C3%AD%C5%A5ov%C3%A1_slu%C5%BEba")[Wiki — Síťová služba]
    - #link("https://cs.wikipedia.org/wiki/DHCP")[Wiki — DHCP]
    - #link("https://cs.wikipedia.org/wiki/Domain_Name_System")[Wiki — DNS]
    - #link("https://cs.wikipedia.org/wiki/Secure_Shell")[Wiki — SSH]
    - #link(
        "https://learn.microsoft.com/cs-cz/windows-server/networking/technologies/dhcp/dhcp-top",
      )[Microsoft Learn — DHCP ve Windows Serveru]
    - #link("https://httpd.apache.org/docs/")[Apache HTTP Server — Dokumentace]
  ],
)

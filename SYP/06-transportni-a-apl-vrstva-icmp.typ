#import "../template.typ": header, theme

#show: body => header(
  title: "Transportní a aplikační vrstva, ICMP",
  author: "Vojtěch Razima",
  body,
)

#theme(
  body: [
    = Úvod do tématu

    Tento dokument shrnuje základní vlastnosti protokolů na transportní vrstvě (TCP, UDP), aplikační vrstvě (DHCP, FTP) a protokol ICMP, který je klíčový pro diagnostiku sítě. 

    #set heading(numbering: "1.1")
    
    = Transportní vrstva

    Transportní vrstva (4. vrstva OSI) je zodpovědná za end-to-end komunikaci mezi aplikacemi na různých hostitelích. Rozděluje data od aplikační vrstvy na *segmenty* a předává je síťové vrstvě. Zajišťuje multiplexování (rozlišení aplikací pomocí portů). Hlavními protokoly jsou *TCP* a *UDP*, nejsou ale jediné. Dále například SCTP (Stream Control Transmission Protocol) nebo DCCP (Datagram Congestion Control Protocol).

    == TCP (Transmission Control Protocol) <tcp>

    TCP je *spojově orientovaný* (connection-oriented) protokol. Před samotným přenosem dat musí být navázáno spojení mezi klientem a serverem pomocí procesu zvaného *Three-way handshake* (SYN, SYN-ACK, ACK). Ukončení spojení probíhá pomocí paketů s příznakem FIN.
    
    Vlastnosti TCP:
    - *Spolehlivost:* Zajišťuje, že všechna data dorazí k cíli. Odesílatel očekává potvrzení o přijetí dat (ACK).
    - *Zaroučení pořadí:* Segmenty jsou očíslovány a příjemce je poskládá do správného pořadí.
    - *Řízení toku (Flow control):* Zabraňuje zahlcení příjemce tím, že reguluje rychlost odesílání dat (okénková metoda).
    - *Použití:* Webové prohlížeče (HTTP/HTTPS), e-maily (SMTP/IMAP), přenos souborů (FTP), databáze — všude, kde je nutná garance doručení a integrity dat.

    == UDP (User Datagram Protocol) <udp>

    UDP je *nespojovaný* (connectionless) protokol. Poskytuje pouze základní funkce (rozdělení na datagramy a porty) bez jakékoliv garance doručení. Funguje na principu "best-effort".

    Vlastnosti UDP:
    - *Nespolehlivost:* Negarantuje doručení dat. Pakety se mohou ztratit nebo dorazit ve špatném pořadí a odesílatel se to nedozví (chybí potvrzování).
    - *Rychlost:* Má mnohem menší hlavičku (8 bajtů) než TCP (20 bajtů) a neprovádí žádné dodatečné kontroly ani navazování spojení.
    - *Použití:* DNS, DHCP, streamování videa, online hry, VoIP komunikace — všude, kde je rychlost důležitější než absolutní spolehlivost a občasná ztráta paketu nevadí.

    == Ostatní protokoly transportní vrstvy
    - *SCTP:* Kombinuje vlastnosti TCP a UDP, podporuje více proudů dat v rámci jednoho spojení a je navržen pro telekomunikační aplikace.
    - *DCCP:* Navržen pro aplikace citlivé na zpoždění, které potřebují řízení přetížení, ale nevyžadují spolehlivost (např. streamování médií).
    - *RUDP (Reliable UDP):* Rozšíření UDP, které přidává spolehlivost, ale není standardizované.
    - *QUIC:* Vyvinutý Googlem, kombinuje rychlost UDP s funkcemi spolehlivosti a bezpečnosti podobnými TCP, určen pro webové aplikace.

    = ICMP (Internet Control Message Protocol)

    ICMP operuje na síťové vrstvě (3. vrstva), společně s IP protokolem. Neslouží k přenosu uživatelských dat, ale primárně k *diagnostice sítě a oznamování chyb*.

    Základní nástroje využívající ICMP:
    - *Ping:* Testuje dosažitelnost jiného zařízení v síti odesláním `Echo Request` a čekáním na `Echo Reply`. Slouží k měření odezvy.
    - *Traceroute (tracert):* Sleduje cestu paketu od zdroje k cíli. Využívá pole TTL (Time to Live) v IP hlavičce a ICMP zprávy `Time Exceeded` k mapování jednotlivých routerů na cestě.

    Další funkce: 
    - Zprávy o nedosažitelnosti cíle (`Destination Unreachable`).
    - Informace o tom, že data byla příliš velká a musí se fragmentovat.

    = Aplikační vrstva

    Poskytuje síťové služby samotným aplikacím, které uživatel používá. Jednotlivé protokoly naslouchají na specifických portech (číslech).
    - *DHCP:* Zajišťuje dynamické přidělování IP adres a dalších parametrů. (Porty 67, 68 / UDP).
    - *FTP:* Slouží pro přenos souborů v síti. (Port 21 pro řízení, Port 20 pro data / TCP).
  ],
  subquestions: [
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Nejpoužívanější protokoly transportní vrstvy, porovnání"
      #v(1em)
      > @tcp
      
      > @udp
    ]
    
    
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Navázání komunikace, ukončení komunikace"
      #v(1em)
      //> @
    ]
    


    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Ztráta datagramu, seřazení datagramů"
      #v(1em)
      //> @
    ]



    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Porty aplikací a služeb"
      #v(1em)
      //> @
    ]
    
    
    
    #block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
    )[
      === "Protokoly aplikační vrstvy vyjmenujte a u některých vysvětlete funkci"
      #v(1em)
      //> @
    ]
  ],
  resources: [
    - #link("https://www.youtube.com/watch?v=9lSwHYgG6tU")[Youtube - Transport Layer Protocols]
    - #link("https://cs.wikipedia.org/wiki/User_Datagram_Protocol")[Wiki - UDP]
    - #link("https://cs.wikipedia.org/wiki/Internet_Control_Message_Protocol")[Wiki - ICMP]
  ],
)
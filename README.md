# Flutter weather app
## Ülevaade:
Tegemist on ilma äpiga, mis näitab asukohapõhiselt hetke ilma ning annab järgmise 5 päeva prognoosi iga 3h tagant.
Äpi kasutamiseks peab telefonis olema sisse lülitatud asukoha määraja.
Äpp kasutab ilmateate saamiseks https://openweathermap.org API-t.

## Juhend:
https://dragosholban.com/2018/07/01/how-to-build-a-simple-weather-app-in-flutter/

#### Arvamus juhendist
Projektis kasutatud juhend oli arusaadavalt ja üsna põhjalikult kirjutatud.
Juhend alustas täiesti nullist ning seletas lahti, kuidas flutter toimib. Iga koodijupi juures oli seletus,
mida sellega tehakse ning põhjalikumaks lugemiseks viited flutteri enda õpetustele.

Midagi negatiivset ei oska juhendi juures välja tuua, kuna esimese flutteri äpi tegemiseks,
olemata seda eelnevalt kasutanud oli kogu vajalik info olemas.

##SDK versiooni muutused
Ei pidanud otseselt midagi muutma.

##Juhendi muutused
Lisasin juurde võimaluse kasutajal otsida ilmateadet soovitud linna kohta maailmas.
Otsimiseks navigeeritakse kasutaja teisele lehele. Peale otsingut kuvatakse linna hetke ilm ja 5 päeva prognoos.
Lisaks muutsin äpi välimust.
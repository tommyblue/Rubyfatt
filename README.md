## Rubyfatt

### [http://rubyfatt.kreations.it/](http://rubyfatt.kreations.it/)

Rubyfatt è un'applicazione open-source multiutente per la gestione delle partite iva.

Gestisce preventivi, fatture, notule e progetti di notula, pagamenti, regimi di tassazione completamente configurabili, fatture ricorrenti.
Ha un piccolo sistema di report con statistiche e grafici sugli incassi, le notule da incassare, ecc. Questo aspetto verrà ulteriormente sviluppato nelle prossime versioni.

### Caratteristiche principali:

* Gestione di differenti tipi di tassazione
* Supporta più tasse calcolate sullo stesso imponibile (ad esempio imponibile calcolato con INPS 4% e Iva 21% e ritenuta d'acconto 20% entrambe calcolate sull'imponibile). Ottimo per ogni tipo di partita iva
* Gestione dei lavori ricorrenti
* Gestione dei progetti di notula e loro trasformazione in notule
* Trasformazione dei lavori in preventivi, progetti di notula e notule/fatture
* Stampa/download PDF delle fatture e degli altri documenti
* Gestione dei pagamenti
* Riepilogo delle fatture emesse
* Modifica della numerazione delle fatture e dei preventivi (ad esempio ad inizio anno)
* Gestione delle coordinate bancarie stampate nei progetti di notula
* Multiutente
* Completamente multilingua, di default in italiano (disponibile la lingua inglese)
* Responsive layout con Twitter Bootstrap

Rubyfatt è un'applicazione **Ruby on Rails** e pertanto fruibile via web (sul proprio pc, su una rete locale o via internet).

## Guide

Tutte le guide (installazione, aggiornamento, deploy, ecc.) le puoi trovare nella [wiki su GitHub](https://github.com/tommyblue/Rubyfatt/wiki)

## Come contribuire

I bug e le cose da fare sono tracciate nelle [segnalazioni di GitHub](https://github.com/tommyblue/Rubyfatt/issues). se vuoi contribuire al progetto forkalo, lavora su qualche **segnalazione** e fai una **pull request**.
Tutte le informazioni che ti servono le trovi sull'help ufficiale di GitHub: [http://help.github.com/send-pull-requests/](http://help.github.com/send-pull-requests/)

Se trovi un errore o hai un suggerimento, ma non hai modo/tempo/voglia di correggerlo, [crea una nuova segnalazione](https://github.com/tommyblue/Rubyfatt/issues/new) e cercherò di lavorarci.

## Roadmap

L'elenco dei buoni propositi per il futuro lo puoi trovare nelle [segnalazioni di GitHub](https://github.com/tommyblue/Rubyfatt/issues?labels=enhancement&page=1&state=open) con la label *enhancement*.

## Changelog

Di seguito i TAG git con le principali caratteristiche e cambiamenti

### 1.2.1

- Possibilità di inserire progetti in corso in un progetto di notula ricorrente

### 1.2.0

- Gestione logo nei PDF
- Quando si crea una tassa viene suggerito l'ordine
- Gestione della la lingua dalla pagina del profilo
- Note sulla tassazione
- Evidenziato se il numero di ore svolte ha superato le ore stimate
- Fixes per Rails 4
- Twitter bootstrap 2.1.0.0
- Nuovo logo e pagina di login
- Rails 3.2.8 e aggiornamento gemme
- Riabilitato layout responsive
- Fix vari

### 1.1.1

- Disabilitato Twitter Responsive per problemi con il menù
- Passaggio delle versioni a 3 cifre

### 1.1

- Aggiunta la gestione delle ore svolte per ogni progetto a tempo
- Gestione delle categorie di lavoro per le ore svolte in un progetto
- Fix minori

### 1.0

- Gestione dei permessi con CanCan
- Tolta l'associazione di una tassa con l'utente, adesso passa da ConsolidatedTax (**richiede migrazione del database**)
- Quando una notula o un progetto di notula vengono scaricati, l'informazione viene salvata (**richiede migrazione del database**)
- Fix minori

### 0.14

- Viene mostrato il totale dei progetti in corso nella pagina riassuntiva del cliente
- Il badge del progetti di notula, nel menù "Stato dei lavori" mostra soltanto i progetti di notula non fatturati
- La pagina riassuntiva dei progetti di notula mostra i progetti divisi in due tabelle: fatturati e non
- Modificato l'ordine dei progetti ricorrenti secondo la scadenza
- Collegata la notula al progetto di notula da cui viene generata (**richiede migrazione del database**)
- Eliminate le icone Fugue e aggiunto Font Awesome
- Eliminazione di un cliente se non ha dati associati
- Gestione della tassazione (tasse e regimi di tassazione)
- Viene evidenziato il cliente attivo nella sidebar
- Creazione notule e progetti di notula direttamente dalla pagina dei lavori in corso
- Scelta della data di fatturazione in fase di trasformazione di un progetto di notula in notula
- Settaggio dei dati di una notula quando generata dai progetti di notula
- Bloccato l'aggiornamento massivo degli attributi non specificati in `attr_accessible`
- Verificate e implementate le validazioni dei modelli
- Fix minori

### 0.13

- Aggiunto il metodo *Option.get_option(user, key)* per ottenere un'opzione o crearla al volo se non esiste

### 0.12

- Gestione preventivi

### 0.11

- Rinominata l'app in **Rubyfatt**

### 0.10

- Aggiunte le icone per device iOS
- Fix minori

### 0.9

- Trasformazione dei progetti ricorrenti in progetti di notula
- Fix minori

### 0.8.2

- Mancava la traduzione del label delle coordinate bancarie
- Fix alla grandezza della textarea.

### 0.8.1

- Aggiunte le coordinate bancarie al profilo utente

### 0.8

- Localizzazione Italiana (impostata come default)
- Verifica del responsive layout
- Qualche resoconto in home page.

### 0.7.2

- Aggiunta la pagina dei progetti in corso ("Working slips")

### 0.7.1

- Fix nella creazione dei progetti di notula

### 0.7

- Aggiunti i breadcrumbs
- Gestione dei link attivi nella navbar

### 0.6

- Passaggio del template a Twitter Bootstrap
- Riscrittura di tutti i form con simple_form

### 0.5

- Gestione dei progetti di notula. Prima dell'aggiornamento modifica la migrazione _20120423154612_add_bank_coordinates.rb_ per inserire le tue coordinate bancarie oppure, successivamente alla migrazione, modifica l'opzione BANK_COORDINATES nell'apposita pagina

### 0.4

- Corretto il bug #2

### 0.3

- Corretto un grave errore che causava l'incremento della numerazione della prossima fattura ad ogni salvataggio di una fattura (ad esempio l'inserimento di un pagamento). *Aggiornando a questa versione è necessario correggere la numerazione delle fatture che hanno ricevuto un pagamento dato che è stato modificato al momento dell'inserimento dello stesso*

### 0.2

- Fatture ricorrenti funzionanti (da perfezionare)

### 0.1

- Versione con gestione clienti e fatture funzionanti. Da testare il funzionamento delle ricorrenze.
- Autenticazione con Devise ma manca la gestione dei permessi con CanCan.
- *In generale può essere considerata una versione stabile nelle sue (ancora poche) funzionalità*

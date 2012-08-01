## Rubyfatt

### [http://rubyfatt.kreations.it/](http://rubyfatt.kreations.it/)

Rubyfatt è un'applicazione per la gestione delle fatture delle partite iva.

Caratteristiche:

* Multiutente (usa Devise e, presto, CanCan, ma è stato testato solo monoutente)
* Gestione di differenti tipi di tassazione
* Supporta più tasse calcolate sullo stesso imponibile
* Gestione dei lavori ricorrenti
* Trasformazione dei lavori in preventivi, progetti di notula e notule/fatture
* Stampa PDF delle fatture e degli altri documenti
* Gestione dei pagamenti
* Riepilogo delle fatture emesse
* Modifica della numerazione delle fatture e dei preventivi (ad esempio ad inizio anno)
* Gestione delle coordinate bancarie
* Completamente multilingua, di default in italiano (disponibile la lingua inglese)
* Responsive layout con Twitter Bootstrap

**Lo stato dell'applicazione è da considerarsi beta**. Io comunque lo uso per le mie fatture :)

## Da fare / To-do

Rubyfatt è nato *di corsa* con la necessità di poter produrre notule in pochi giorni e alcuni aspetti, talvolta banali, sono stati tralasciati.
I bug e le cose da fare sono tracciate nelle [issues di GitHub](https://github.com/tommyblue/Rubyfatt/issues). se vuoi contribuire al progetto forkalo,lavora su qualche **issue** e fai una **pull request**.
Tutte le informazioni che ti servono le trovi sull'help ufficiale di GitHub: [http://help.github.com/send-pull-requests/](http://help.github.com/send-pull-requests/)
Se trovi un errore o hai un suggerimento, ma non hai modo/tempo/voglia di correggerlo, [crea una nuova issue](https://github.com/tommyblue/Rubyfatt/issues/new) e cercherò di lavorarci.

## Installazione

Si installa come tutte le applicazioni rails:

Clona il repository in una cartella:

	git clone git@github.com:tommyblue/Rubyfatt.git

Entra nella cartella e fai il checkout all'ultimo tag "stabile":

	git checkout 0.14

Oppure lascia HEAD se ti piace il rischio :)

Modifica il file **conf/databases.yml** secondo le tue esigenze e personalizza **db/seeds.rb** con i tuoi dati
Fai girare le migrazioni e il seed:

	rake db:migrate
	rake db:seed

Lancia il server con:

	rails server

Collegati all'applicazione dall'indirizzo [http://localhost:3000](http://localhost:3000/) e fai login con i dati di **db_seeds.rb** (quelli di default sono **email** **"demo@example.com"** e **password** **"password"**)

## Aggiornamento

L'aggiornamento consiste nell'aggiornare il repository git locale con:

	git pull

e nell'aggiornamento del database con:

	rake db:migrate

Ti consiglio comunque di leggere il changelog (più in basso) per eventuali istruzioni aggiuntive

## Easyfatt?

Fino alla versione 0.10 il software si chiamava **Easyfatt**. Scoperta l'esistenza di un software commerciale di fatturazione con lo stesso nome ho deciso di cambiare il nome dell'applicazione in **Rubyfatt**.

**Rubyfatt** è in perfetta continuità con la vecchia versione, quindi se hai installato **Easyfatt** e vuoi passare a **Rubyfatt** tutto ciò che devi fare è modificare l'URL del repository con:

	git remote set-url origin git@github.com:tommyblue/Rubyfatt.git

Fai soltanto attenzione che il nome del repository sia *origin* (di solito lo è), altrimenti modifica il comando di conseguenza.

### Logo

Il logo usato nella generazione dei pdf è in **lib/assets/images/logo-notule.png** (PNG, 570x250 pixel)

## Ambiente di sviluppo

* Installare le gemme necessarie con `bundle install`
* Configurare il file **config/database.yml**
* Modificare l'utente di default in **db/seeds.rb** e lanciare `rake db:setup`
* Lanciare il server di sviluppo con `rails s` e collegarsi a [http://localhost:3000/](http://localhost:3000)
* In produzione lanciare anche `bundle exec rake assets:precompile RAILS_ENV=production`

Al momento le gemme con cui sto testando il software sono:

	actionmailer (3.2.0)
	actionpack (3.2.0)
	activemodel (3.2.0)
	activerecord (3.2.0)
	activeresource (3.2.0)
	activesupport (3.2.0)
	arel (3.0.0)
	Ascii85 (1.0.1)
	bcrypt-ruby (3.0.1)
	bootstrap-sass (2.0.2)
	builder (3.0.0)
	bundler (1.0.21)
	cancan (1.6.7)
	chronic_duration (0.9.6)
	coderay (1.0.6)
	coffee-rails (3.2.2, 3.2.1)
	coffee-script (2.2.0)
	coffee-script-source (1.2.0)
	commonjs (0.2.5)
	country-select (1.1.0)
	country_select (0.0.2)
	devise (2.0.0, 1.5.3)
	erubis (2.7.0)
	execjs (1.3.0)
	formtastic (2.0.2)
	hike (1.2.1)
	i18n (0.6.0)
	ice_cube (0.7.6)
	journey (1.0.1, 1.0.0)
	jquery-rails (2.0.0)
	json (1.6.5)
	kgio (2.7.2)
	less (2.1.0)
	less-rails (2.2.1)
	libv8 (3.3.10.4 x86_64-darwin-11)
	mail (2.4.1)
	method_source (0.7.1)
	mime-types (1.17.2)
	money (4.0.1)
	multi_json (1.0.4)
	mysql2 (0.3.11)
	numerizer (0.1.1)
	orm_adapter (0.0.6)
	pdf-reader (1.0.0)
	polyglot (0.3.3)
	prawn (1.0.0.rc1)
	pry (0.9.9.3)
	rack (1.4.1)
	rack-cache (1.1)
	rack-ssl (1.3.2)
	rack-test (0.6.1)
	rails (3.2.0)
	railties (3.2.0)
	raindrops (0.8.0)
	rake (0.9.2.2, 0.8.7)
	rdoc (3.12)
	ruby-rc4 (0.1.4)
	sass (3.1.12)
	sass-rails (3.2.4, 3.2.3)
	simple_form (2.0.1)
	slop (2.4.4)
	sprockets (2.1.2)
	sqlite3 (1.3.5)
	therubyracer (0.10.1)
	thor (0.14.6)
	tilt (1.3.3)
	treetop (1.4.10)
	ttfunk (1.0.3)
	tzinfo (0.3.31)
	uglifier (1.2.3, 1.2.2)
	unicorn (4.2.0)
	vpim (0.695)
	warden (1.1.0)

## Roadmap

Elenco i buoni propositi per il futuro :)

### 1.0

Pubblicherò la versione 1.0 quando avrò completato le validazioni e inserito il supporto a Cancan. Puoi vedere i bug da chiudere per la 1.0 nella pagina [issues su GitHub](https://github.com/tommyblue/Rubyfatt/issues/).

## Changelog

Di seguito i TAG git con le principali caratteristiche e cambiamenti

### HEAD - 0.14

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

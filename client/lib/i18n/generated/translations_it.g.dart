///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsIt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppIt app = _TranslationsAppIt._(_root);
	@override late final _TranslationsUserIt user = _TranslationsUserIt._(_root);
	@override late final _TranslationsWelcomeIt welcome = _TranslationsWelcomeIt._(_root);
	@override late final _TranslationsLoginIt login = _TranslationsLoginIt._(_root);
	@override late final _TranslationsRegisterIt register = _TranslationsRegisterIt._(_root);
	@override late final _TranslationsFormIt form = _TranslationsFormIt._(_root);
	@override late final _TranslationsSwipeCardsIt swipe_cards = _TranslationsSwipeCardsIt._(_root);
	@override late final _TranslationsEventIt event = _TranslationsEventIt._(_root);
	@override late final _TranslationsErrorIt error = _TranslationsErrorIt._(_root);
	@override late final _TranslationsAuthIt auth = _TranslationsAuthIt._(_root);
	@override late final _TranslationsVerifyIt verify = _TranslationsVerifyIt._(_root);
	@override late final _TranslationsProfileIt profile = _TranslationsProfileIt._(_root);
	@override late final _TranslationsResourcesIt resources = _TranslationsResourcesIt._(_root);
	@override late final _TranslationsMessagesIt messages = _TranslationsMessagesIt._(_root);
	@override late final _TranslationsCommonIt common = _TranslationsCommonIt._(_root);
	@override late final _TranslationsPageIt page = _TranslationsPageIt._(_root);
}

// Path: app
class _TranslationsAppIt implements TranslationsAppFr {
	_TranslationsAppIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get login => 'Accedi';
	@override String get signup => 'Registrati';
	@override String get logout => 'Disconnetti';
	@override String get search => 'Cerca';
	@override String get searchLanguage => 'Cerca una lingua';
	@override String get add => 'Aggiungi';
	@override String get edit => 'Modifica';
	@override String get delete => 'Elimina';
	@override String get cancel => 'Annulla';
	@override String get save => 'Salva';
	@override String get yes => 'Sì';
	@override String get no => 'No';
	@override String get confirm => 'Conferma';
	@override String get error => 'Errore';
	@override String get loading => 'Caricamento...';
	@override String get noResults => 'Nessun risultato';
	@override String get noResultsFound => 'Nessun risultato trovato';
	@override String get skip => 'Salta';
	@override String get next => 'Successivo';
	@override String get previous => 'Precedente';
	@override String get finish => 'Termina';
	@override String get back => 'Indietro';
	@override String get submit => 'Invia';
	@override String get searchUser => 'Cerca un utente';
	@override String get searchSubject => 'Cerca una materia';
	@override String get searchTopic => 'Cerca un tema';
	@override String get searchSheet => 'Cerca un foglio';
	@override String get alreadyHaveAccount => 'Hai già un account?';
	@override String get loadingIndicator => 'Caricamento...';
	@override String get errorOccurred => 'Si è verificato un errore';
	@override String get backTo => 'Torna a ';
}

// Path: user
class _TranslationsUserIt implements TranslationsUserFr {
	_TranslationsUserIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Nome utente';
	@override String get name => 'Nome';
	@override String get firstname => 'Nome';
	@override String get birthdate => 'Data di nascita';
	@override String get location => 'Luogo';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Numero di segnalazioni';
	@override String get address => 'Indirizzo';
	@override String get password => 'Password';
	@override String get newPassword => 'Nuova password';
	@override String get anonymous => 'Anonimo';
	@override String get noDescription => 'Nessuna descrizione';
	@override String get noAddress => 'Indirizzo non disponibile';
	@override String get noReportsAvailable => 'Numero di segnalazioni non disponibile';
}

// Path: welcome
class _TranslationsWelcomeIt implements TranslationsWelcomeFr {
	_TranslationsWelcomeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Benvenuto su Edumeet, la piattaforma di revisione collaborativa';
	@override String get setup => 'Iniziamo scegliendo una lingua';
	@override String get whatLanguage => 'Quale lingua parli?';
	@override String get chooseLanguage => 'Scegli una lingua affinché possiamo comunicare insieme';
	@override String get title1 => 'Trova i tuoi appunti di revisione';
	@override String get description1 => 'Accedi gratuitamente a migliaia di \nappunti di revisione creati da studenti';
	@override String get title2 => 'Organizza le tue revisioni';
	@override String get description2 => 'Classifica e organizza i tuoi appunti per una \nmemoria efficace';
	@override String get title3 => 'Rimani motivato';
	@override String get description3 => 'Raggiungi i tuoi obiettivi grazie a consigli \npratici';
	@override String get title4 => 'Unisciti alla nostra comunità';
	@override String get description4 => 'Condividi i tuoi appunti di revisione e \nricevi consigli personalizzati';
}

// Path: login
class _TranslationsLoginIt implements TranslationsLoginFr {
	_TranslationsLoginIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accesso';
	@override String get description => 'Inserisci le tue informazioni qui sotto per accedere';
	@override String get forgotPassword => 'Password dimenticata?';
	@override String get noAccount => 'Non hai un account?';
	@override String get createAccount => 'Crea un account';
}

// Path: register
class _TranslationsRegisterIt implements TranslationsRegisterFr {
	_TranslationsRegisterIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crea un account';
	@override String get description => 'Unisciti a noi per sfruttare i nostri servizi';
	@override String get conditions => 'Creando un account, accetti i nostri Termini di utilizzo e la Politica sulla privacy';
	@override String get registerConfirm => 'Registrazione confermata';
}

// Path: form
class _TranslationsFormIt implements TranslationsFormFr {
	_TranslationsFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Inserisci un nome utente';
	@override String get emptyFirstname => 'Inserisci il tuo nome';
	@override String get emptyEmail => 'Inserisci il tuo indirizzo email';
	@override String get emptyLastname => 'Inserisci il tuo cognome';
	@override String get emptyPassword => 'Inserisci la tua password';
	@override String get emptyConfirmPassword => 'Conferma la tua password';
	@override String get passwordMismatch => 'Le password non corrispondono';
	@override String get invalidEmail => 'Inserisci un indirizzo email valido';
	@override String get invalidAddress => 'Inserisci un indirizzo valido';
	@override String get shortPassword => 'La password deve contenere almeno 8 caratteri';
	@override String get passwordUpperCase => 'La password deve contenere almeno una lettera maiuscola';
	@override String get passwordDigit => 'La password deve contenere almeno un numero';
	@override String get passwordSpecialChar => 'La password deve contenere almeno un carattere speciale';
	@override String get haveToAcceptConditions => 'Devi accettare i termini di utilizzo e la politica sulla privacy';
	@override String get confirmPassword => 'Conferma password';
	@override String get pleaseConfirmPassword => 'Si prega di confermare la tua password';
	@override String get passwordNotMatch => 'Le password non corrispondono';
}

// Path: swipe_cards
class _TranslationsSwipeCardsIt implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Errore nel caricamento degli eventi';
	@override String get end_of_list => 'Hai raggiunto la fine della lista!';
	@override String nope({required Object title}) => 'No a ${title}';
	@override String joined_event({required Object title}) => 'Hai partecipato all\'evento ${title}';
	@override String item_changed({required Object title}) => 'Elemento modificato: ${title}';
}

// Path: event
class _TranslationsEventIt implements TranslationsEventFr {
	_TranslationsEventIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fisico';
	@override String get participants => 'Partecipanti';
	@override String hasJoinEvent({required Object event_title}) => 'Hai partecipato all\'evento ${event_title}';
	@override String get address_copied => 'Indirizzo copiato negli appunti';
	@override String get createEvent => 'Crea un evento';
	@override String get name => 'Nome';
	@override String get description => 'Descrizione';
	@override String get date => 'Data';
	@override String get time => 'Ora';
	@override String get location => 'Luogo';
	@override String get maxParticipants => 'Numero di partecipanti';
	@override String get price => 'Prezzo';
	@override String get image => 'Immagine';
	@override String get create => 'Crea';
	@override String get enterName => 'Per favore, inserisci un nome';
	@override String get enterDescription => 'Per favore, inserisci una descrizione';
	@override String get enterDate => 'Per favore, inserisci una data';
	@override String get enterTime => 'Per favore, inserisci un\'ora';
	@override String get enterLocation => 'Per favore, inserisci un luogo';
	@override String get enterMaxParticipants => 'Per favore, inserisci un numero di partecipanti';
	@override String get invalidMaxParticipants => 'Per favore, inserisci un numero valido';
	@override String get enterPrice => 'Per favore, inserisci un prezzo';
	@override String get invalidPrice => 'Per favore, inserisci un prezzo valido';
	@override String get enterImage => 'Per favore, inserisci un URL dell\'immagine';
	@override String get joinEvent => 'Unisciti all\'evento';
	@override String get eventNotStarted => 'Il link di accesso sarà disponibile qui quando l\'evento inizierà.';
}

// Path: error
class _TranslationsErrorIt implements TranslationsErrorFr {
	_TranslationsErrorIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Errore: ${error}';
	@override String get no_internet => 'Nessuna connessione Internet';
	@override String get no_internet_description => 'Controlla la tua connessione Internet e riprova';
	@override String get no_events => 'Nessun evento trovato';
	@override String get no_events_description => 'Nessun evento è stato trovato al momento. Riprovare più tardi';
	@override String get no_events_found => 'Nessun evento trovato';
	@override String get no_events_found_description => 'Nessun evento è stato trovato al momento. Riprovare più tardi';
	@override String get no_events_found_title => 'Nessun evento trovato';
	@override String get no_events_found_description_title => 'Nessun evento è stato trovato al momento. Riprovare più tardi';
	@override String get no_events_found_description_title_search => 'Nessun evento è stato trovato per la ricerca effettuata. Riprovare con un altro termine';
	@override String get loadingEvents => 'Si è verificato un errore durante il caricamento degli eventi';
	@override String get failedToResetPassword => 'Ripristino della password non riuscito';
}

// Path: auth
class _TranslationsAuthIt implements TranslationsAuthFr {
	_TranslationsAuthIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Hai dimenticato la password?';
	@override String get enterEmail => 'Inserisci il tuo indirizzo e-mail per ricevere le istruzioni per il ripristino';
	@override String get resetPassword => 'Reimposta la password';
	@override String get enterNewPassword => 'Inserisci la tua nuova password';
	@override String get resetInstructionsSent => 'Istruzioni per il ripristino inviate al tuo e-mail';
	@override String get passwordResertSuccess => 'La tua password è stata reimpostata con successo';
}

// Path: verify
class _TranslationsVerifyIt implements TranslationsVerifyFr {
	_TranslationsVerifyIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verifica del codice';
	@override String get description => 'Inserisci il codice di verifica inviato alla tua email';
	@override String get inputLabel => 'Codice di verifica';
	@override String get button => 'Verifica';
	@override String get error => 'Per favore, inserisci il codice di verifica';
}

// Path: profile
class _TranslationsProfileIt implements TranslationsProfileFr {
	_TranslationsProfileIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Modifica il mio profilo';
	@override String get firstname => 'Nome';
	@override String get lastname => 'Cognome';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Data di nascita';
	@override String get address => 'Indirizzo';
	@override String get save => 'Salva';
	@override String get cancel => 'Annulla';
	@override String get enterFirstname => 'Per favore, inserisci il tuo nome';
	@override String get enterLastname => 'Per favore, inserisci il tuo cognome';
	@override String get enterEmail => 'Per favore, inserisci il tuo indirizzo email';
	@override String get invalidEmail => 'Per favore, inserisci un indirizzo email valido';
	@override String get logout => 'Disconnetti';
}

// Path: resources
class _TranslationsResourcesIt implements TranslationsResourcesFr {
	_TranslationsResourcesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Risorse disponibili';
	@override String get name => 'Nome';
	@override String get type => 'Tipo';
}

// Path: messages
class _TranslationsMessagesIt implements TranslationsMessagesFr {
	_TranslationsMessagesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Ultimi messaggi';
	@override String get seeAllMessages => 'Vedi tutti i messaggi';
	@override String get noMessages => 'Nessun messaggio';
	@override String get writeMessageHint => 'Scrivi un messaggio...';
	@override String get sendMessage => 'Invia';
}

// Path: common
class _TranslationsCommonIt implements TranslationsCommonFr {
	_TranslationsCommonIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Mittente';
	@override String get message => 'Messaggio';
}

// Path: page
class _TranslationsPageIt implements TranslationsPageFr {
	_TranslationsPageIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get homePage => 'Pagina principale';
	@override String get profile => 'Profilo';
	@override String get profilePage => 'Pagina del profilo';
	@override String get settings => 'Impostazioni';
	@override String get settingsPage => 'Pagina delle impostazioni';
	@override String get search => 'Ricerca';
	@override String get searchPage => 'Pagina di ricerca';
	@override String get sheet => 'Scheda';
	@override String get sheetPage => 'Pagina della scheda';
	@override String get subject => 'Materia';
	@override String get subjectPage => 'Pagina della materia';
	@override String get topic => 'Tema';
	@override String get topicPage => 'Pagina del tema';
	@override String get event => 'Evento';
	@override String get eventPage => 'Pagina dell\'evento';
	@override String get user => 'Utente';
	@override String get userPage => 'Pagina dell\'utente';
	@override String get about => 'Informazioni';
	@override String get aboutPage => 'Pagina Informazioni';
	@override String get contact => 'Contatto';
	@override String get contactPage => 'Pagina di contatto';
	@override String get terms => 'Condizioni d\'uso';
	@override String get termsPage => 'Pagina delle condizioni d\'uso';
	@override String get privacy => 'Politica sulla privacy';
	@override String get privacyPage => 'Pagina della politica sulla privacy';
	@override String get notifications => 'Notifiche';
	@override String get events => 'Eventi';
	@override String get sheets => 'Schede';
	@override String get subjects => 'Materie';
	@override String get topics => 'Temi';
	@override String get users => 'Utenti';
	@override String get help => 'Aiuto';
	@override String get helpPage => 'Pagina di aiuto';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Accedi';
			case 'app.signup': return 'Registrati';
			case 'app.logout': return 'Disconnetti';
			case 'app.search': return 'Cerca';
			case 'app.searchLanguage': return 'Cerca una lingua';
			case 'app.add': return 'Aggiungi';
			case 'app.edit': return 'Modifica';
			case 'app.delete': return 'Elimina';
			case 'app.cancel': return 'Annulla';
			case 'app.save': return 'Salva';
			case 'app.yes': return 'Sì';
			case 'app.no': return 'No';
			case 'app.confirm': return 'Conferma';
			case 'app.error': return 'Errore';
			case 'app.loading': return 'Caricamento...';
			case 'app.noResults': return 'Nessun risultato';
			case 'app.noResultsFound': return 'Nessun risultato trovato';
			case 'app.skip': return 'Salta';
			case 'app.next': return 'Successivo';
			case 'app.previous': return 'Precedente';
			case 'app.finish': return 'Termina';
			case 'app.back': return 'Indietro';
			case 'app.submit': return 'Invia';
			case 'app.searchUser': return 'Cerca un utente';
			case 'app.searchSubject': return 'Cerca una materia';
			case 'app.searchTopic': return 'Cerca un tema';
			case 'app.searchSheet': return 'Cerca un foglio';
			case 'app.alreadyHaveAccount': return 'Hai già un account?';
			case 'app.loadingIndicator': return 'Caricamento...';
			case 'app.errorOccurred': return 'Si è verificato un errore';
			case 'app.backTo': return 'Torna a ';
			case 'user.email': return 'Email';
			case 'user.username': return 'Nome utente';
			case 'user.name': return 'Nome';
			case 'user.firstname': return 'Nome';
			case 'user.birthdate': return 'Data di nascita';
			case 'user.location': return 'Luogo';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Numero di segnalazioni';
			case 'user.address': return 'Indirizzo';
			case 'user.password': return 'Password';
			case 'user.newPassword': return 'Nuova password';
			case 'user.anonymous': return 'Anonimo';
			case 'user.noDescription': return 'Nessuna descrizione';
			case 'user.noAddress': return 'Indirizzo non disponibile';
			case 'user.noReportsAvailable': return 'Numero di segnalazioni non disponibile';
			case 'welcome.welcome': return 'Benvenuto su Edumeet, la piattaforma di revisione collaborativa';
			case 'welcome.setup': return 'Iniziamo scegliendo una lingua';
			case 'welcome.whatLanguage': return 'Quale lingua parli?';
			case 'welcome.chooseLanguage': return 'Scegli una lingua affinché possiamo comunicare insieme';
			case 'welcome.title1': return 'Trova i tuoi appunti di revisione';
			case 'welcome.description1': return 'Accedi gratuitamente a migliaia di \nappunti di revisione creati da studenti';
			case 'welcome.title2': return 'Organizza le tue revisioni';
			case 'welcome.description2': return 'Classifica e organizza i tuoi appunti per una \nmemoria efficace';
			case 'welcome.title3': return 'Rimani motivato';
			case 'welcome.description3': return 'Raggiungi i tuoi obiettivi grazie a consigli \npratici';
			case 'welcome.title4': return 'Unisciti alla nostra comunità';
			case 'welcome.description4': return 'Condividi i tuoi appunti di revisione e \nricevi consigli personalizzati';
			case 'login.title': return 'Accesso';
			case 'login.description': return 'Inserisci le tue informazioni qui sotto per accedere';
			case 'login.forgotPassword': return 'Password dimenticata?';
			case 'login.noAccount': return 'Non hai un account?';
			case 'login.createAccount': return 'Crea un account';
			case 'register.title': return 'Crea un account';
			case 'register.description': return 'Unisciti a noi per sfruttare i nostri servizi';
			case 'register.conditions': return 'Creando un account, accetti i nostri Termini di utilizzo e la Politica sulla privacy';
			case 'register.registerConfirm': return 'Registrazione confermata';
			case 'form.emptyUsername': return 'Inserisci un nome utente';
			case 'form.emptyFirstname': return 'Inserisci il tuo nome';
			case 'form.emptyEmail': return 'Inserisci il tuo indirizzo email';
			case 'form.emptyLastname': return 'Inserisci il tuo cognome';
			case 'form.emptyPassword': return 'Inserisci la tua password';
			case 'form.emptyConfirmPassword': return 'Conferma la tua password';
			case 'form.passwordMismatch': return 'Le password non corrispondono';
			case 'form.invalidEmail': return 'Inserisci un indirizzo email valido';
			case 'form.invalidAddress': return 'Inserisci un indirizzo valido';
			case 'form.shortPassword': return 'La password deve contenere almeno 8 caratteri';
			case 'form.passwordUpperCase': return 'La password deve contenere almeno una lettera maiuscola';
			case 'form.passwordDigit': return 'La password deve contenere almeno un numero';
			case 'form.passwordSpecialChar': return 'La password deve contenere almeno un carattere speciale';
			case 'form.haveToAcceptConditions': return 'Devi accettare i termini di utilizzo e la politica sulla privacy';
			case 'form.confirmPassword': return 'Conferma password';
			case 'form.pleaseConfirmPassword': return 'Si prega di confermare la tua password';
			case 'form.passwordNotMatch': return 'Le password non corrispondono';
			case 'swipe_cards.loading_error': return 'Errore nel caricamento degli eventi';
			case 'swipe_cards.end_of_list': return 'Hai raggiunto la fine della lista!';
			case 'swipe_cards.nope': return ({required Object title}) => 'No a ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Hai partecipato all\'evento ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Elemento modificato: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fisico';
			case 'event.participants': return 'Partecipanti';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Hai partecipato all\'evento ${event_title}';
			case 'event.address_copied': return 'Indirizzo copiato negli appunti';
			case 'event.createEvent': return 'Crea un evento';
			case 'event.name': return 'Nome';
			case 'event.description': return 'Descrizione';
			case 'event.date': return 'Data';
			case 'event.time': return 'Ora';
			case 'event.location': return 'Luogo';
			case 'event.maxParticipants': return 'Numero di partecipanti';
			case 'event.price': return 'Prezzo';
			case 'event.image': return 'Immagine';
			case 'event.create': return 'Crea';
			case 'event.enterName': return 'Per favore, inserisci un nome';
			case 'event.enterDescription': return 'Per favore, inserisci una descrizione';
			case 'event.enterDate': return 'Per favore, inserisci una data';
			case 'event.enterTime': return 'Per favore, inserisci un\'ora';
			case 'event.enterLocation': return 'Per favore, inserisci un luogo';
			case 'event.enterMaxParticipants': return 'Per favore, inserisci un numero di partecipanti';
			case 'event.invalidMaxParticipants': return 'Per favore, inserisci un numero valido';
			case 'event.enterPrice': return 'Per favore, inserisci un prezzo';
			case 'event.invalidPrice': return 'Per favore, inserisci un prezzo valido';
			case 'event.enterImage': return 'Per favore, inserisci un URL dell\'immagine';
			case 'event.joinEvent': return 'Unisciti all\'evento';
			case 'event.eventNotStarted': return 'Il link di accesso sarà disponibile qui quando l\'evento inizierà.';
			case 'error.details': return ({required Object error}) => 'Errore: ${error}';
			case 'error.no_internet': return 'Nessuna connessione Internet';
			case 'error.no_internet_description': return 'Controlla la tua connessione Internet e riprova';
			case 'error.no_events': return 'Nessun evento trovato';
			case 'error.no_events_description': return 'Nessun evento è stato trovato al momento. Riprovare più tardi';
			case 'error.no_events_found': return 'Nessun evento trovato';
			case 'error.no_events_found_description': return 'Nessun evento è stato trovato al momento. Riprovare più tardi';
			case 'error.no_events_found_title': return 'Nessun evento trovato';
			case 'error.no_events_found_description_title': return 'Nessun evento è stato trovato al momento. Riprovare più tardi';
			case 'error.no_events_found_description_title_search': return 'Nessun evento è stato trovato per la ricerca effettuata. Riprovare con un altro termine';
			case 'error.loadingEvents': return 'Si è verificato un errore durante il caricamento degli eventi';
			case 'error.failedToResetPassword': return 'Ripristino della password non riuscito';
			case 'auth.forgotPassword': return 'Hai dimenticato la password?';
			case 'auth.enterEmail': return 'Inserisci il tuo indirizzo e-mail per ricevere le istruzioni per il ripristino';
			case 'auth.resetPassword': return 'Reimposta la password';
			case 'auth.enterNewPassword': return 'Inserisci la tua nuova password';
			case 'auth.resetInstructionsSent': return 'Istruzioni per il ripristino inviate al tuo e-mail';
			case 'auth.passwordResertSuccess': return 'La tua password è stata reimpostata con successo';
			case 'verify.title': return 'Verifica del codice';
			case 'verify.description': return 'Inserisci il codice di verifica inviato alla tua email';
			case 'verify.inputLabel': return 'Codice di verifica';
			case 'verify.button': return 'Verifica';
			case 'verify.error': return 'Per favore, inserisci il codice di verifica';
			case 'profile.editProfile': return 'Modifica il mio profilo';
			case 'profile.firstname': return 'Nome';
			case 'profile.lastname': return 'Cognome';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Data di nascita';
			case 'profile.address': return 'Indirizzo';
			case 'profile.save': return 'Salva';
			case 'profile.cancel': return 'Annulla';
			case 'profile.enterFirstname': return 'Per favore, inserisci il tuo nome';
			case 'profile.enterLastname': return 'Per favore, inserisci il tuo cognome';
			case 'profile.enterEmail': return 'Per favore, inserisci il tuo indirizzo email';
			case 'profile.invalidEmail': return 'Per favore, inserisci un indirizzo email valido';
			case 'profile.logout': return 'Disconnetti';
			case 'resources.availableResources': return 'Risorse disponibili';
			case 'resources.name': return 'Nome';
			case 'resources.type': return 'Tipo';
			case 'messages.latestMessages': return 'Ultimi messaggi';
			case 'messages.seeAllMessages': return 'Vedi tutti i messaggi';
			case 'messages.noMessages': return 'Nessun messaggio';
			case 'messages.writeMessageHint': return 'Scrivi un messaggio...';
			case 'messages.sendMessage': return 'Invia';
			case 'common.sender': return 'Mittente';
			case 'common.message': return 'Messaggio';
			case 'page.home': return 'Home';
			case 'page.homePage': return 'Pagina principale';
			case 'page.profile': return 'Profilo';
			case 'page.profilePage': return 'Pagina del profilo';
			case 'page.settings': return 'Impostazioni';
			case 'page.settingsPage': return 'Pagina delle impostazioni';
			case 'page.search': return 'Ricerca';
			case 'page.searchPage': return 'Pagina di ricerca';
			case 'page.sheet': return 'Scheda';
			case 'page.sheetPage': return 'Pagina della scheda';
			case 'page.subject': return 'Materia';
			case 'page.subjectPage': return 'Pagina della materia';
			case 'page.topic': return 'Tema';
			case 'page.topicPage': return 'Pagina del tema';
			case 'page.event': return 'Evento';
			case 'page.eventPage': return 'Pagina dell\'evento';
			case 'page.user': return 'Utente';
			case 'page.userPage': return 'Pagina dell\'utente';
			case 'page.about': return 'Informazioni';
			case 'page.aboutPage': return 'Pagina Informazioni';
			case 'page.contact': return 'Contatto';
			case 'page.contactPage': return 'Pagina di contatto';
			case 'page.terms': return 'Condizioni d\'uso';
			case 'page.termsPage': return 'Pagina delle condizioni d\'uso';
			case 'page.privacy': return 'Politica sulla privacy';
			case 'page.privacyPage': return 'Pagina della politica sulla privacy';
			case 'page.notifications': return 'Notifiche';
			case 'page.events': return 'Eventi';
			case 'page.sheets': return 'Schede';
			case 'page.subjects': return 'Materie';
			case 'page.topics': return 'Temi';
			case 'page.users': return 'Utenti';
			case 'page.help': return 'Aiuto';
			case 'page.helpPage': return 'Pagina di aiuto';
			default: return null;
		}
	}
}


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
class TranslationsRo implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRo({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ro,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ro>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRo _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppRo app = _TranslationsAppRo._(_root);
	@override late final _TranslationsUserRo user = _TranslationsUserRo._(_root);
	@override late final _TranslationsWelcomeRo welcome = _TranslationsWelcomeRo._(_root);
	@override late final _TranslationsLoginRo login = _TranslationsLoginRo._(_root);
	@override late final _TranslationsRegisterRo register = _TranslationsRegisterRo._(_root);
	@override late final _TranslationsFormRo form = _TranslationsFormRo._(_root);
	@override late final _TranslationsSwipeCardsRo swipe_cards = _TranslationsSwipeCardsRo._(_root);
	@override late final _TranslationsEventRo event = _TranslationsEventRo._(_root);
	@override late final _TranslationsErrorRo error = _TranslationsErrorRo._(_root);
	@override late final _TranslationsAuthRo auth = _TranslationsAuthRo._(_root);
	@override late final _TranslationsVerifyRo verify = _TranslationsVerifyRo._(_root);
	@override late final _TranslationsProfileRo profile = _TranslationsProfileRo._(_root);
	@override late final _TranslationsResourcesRo resources = _TranslationsResourcesRo._(_root);
	@override late final _TranslationsMessagesRo messages = _TranslationsMessagesRo._(_root);
	@override late final _TranslationsCommonRo common = _TranslationsCommonRo._(_root);
	@override late final _TranslationsPageRo page = _TranslationsPageRo._(_root);
}

// Path: app
class _TranslationsAppRo implements TranslationsAppFr {
	_TranslationsAppRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get login => 'Conectare';
	@override String get signup => 'Înscriere';
	@override String get logout => 'Deconectare';
	@override String get search => 'Căutare';
	@override String get searchLanguage => 'Căutare limbă';
	@override String get add => 'Adăuga';
	@override String get edit => 'Edita';
	@override String get delete => 'Șterge';
	@override String get cancel => 'Anulare';
	@override String get save => 'Salvează';
	@override String get yes => 'Da';
	@override String get no => 'Nu';
	@override String get confirm => 'Confirmă';
	@override String get error => 'Eroare';
	@override String get loading => 'Încărcare...';
	@override String get noResults => 'Niciun rezultat';
	@override String get noResultsFound => 'Niciun rezultat găsit';
	@override String get skip => 'Sari';
	@override String get next => 'Următorul';
	@override String get previous => 'Anterior';
	@override String get finish => 'Finalizare';
	@override String get back => 'Înapoi';
	@override String get submit => 'Trimite';
	@override String get searchUser => 'Caută un utilizator';
	@override String get searchSubject => 'Caută o materie';
	@override String get searchTopic => 'Caută un subiect';
	@override String get searchSheet => 'Caută o fișă';
	@override String get alreadyHaveAccount => 'Ai deja un cont?';
	@override String get loadingIndicator => 'Încărcare...';
	@override String get errorOccurred => 'A apărut o eroare';
	@override String get backTo => 'Înapoi la ';
}

// Path: user
class _TranslationsUserRo implements TranslationsUserFr {
	_TranslationsUserRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Nume de utilizator';
	@override String get name => 'Nume';
	@override String get firstname => 'Prenume';
	@override String get birthdate => 'Data nașterii';
	@override String get location => 'Locație';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Număr de raportări';
	@override String get address => 'Adresă';
	@override String get password => 'Parolă';
	@override String get newPassword => 'Parolă nouă';
	@override String get anonymous => 'Anonim';
	@override String get noDescription => 'Nici o descriere';
	@override String get noAddress => 'Adresă indisponibilă';
	@override String get noReportsAvailable => 'Numărul de raportări nu este disponibil';
}

// Path: welcome
class _TranslationsWelcomeRo implements TranslationsWelcomeFr {
	_TranslationsWelcomeRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Bun venit pe Edumeet, platforma de revizuire colaborativă';
	@override String get setup => 'Haide să începem prin a alege o limbă';
	@override String get whatLanguage => 'Ce limbă vorbești?';
	@override String get chooseLanguage => 'Alege o limbă pentru a putea comunica împreună';
	@override String get title1 => 'Găsește-ți fișele de revizuire';
	@override String get description1 => 'Accesează gratuit mii de fișe de revizuire create de studenți';
	@override String get title2 => 'Organizează-ți revizuirile';
	@override String get description2 => 'Clasează și organizează-ți fișele pentru o memorie eficientă';
	@override String get title3 => 'Rămâi motivat';
	@override String get description3 => 'Atinge-ți obiectivele cu ajutorul unor sfaturi practice';
	@override String get title4 => 'Alătură-te comunității noastre';
	@override String get description4 => 'Împărtășește-ți fișele de revizuire și primește sfaturi personalizate';
}

// Path: login
class _TranslationsLoginRo implements TranslationsLoginFr {
	_TranslationsLoginRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conectare';
	@override String get description => 'Introdu informațiile tale mai jos pentru a te conecta';
	@override String get forgotPassword => 'Parola uitată?';
	@override String get noAccount => 'Nu ai un cont?';
	@override String get createAccount => 'Creează un cont';
}

// Path: register
class _TranslationsRegisterRo implements TranslationsRegisterFr {
	_TranslationsRegisterRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get title => 'Creează un cont';
	@override String get description => 'Alătură-te nouă pentru a beneficia de serviciile noastre';
	@override String get conditions => 'Prin crearea unui cont, accepți Condițiile noastre de utilizare și Politica de confidențialitate';
	@override String get registerConfirm => 'Înscriere confirmată';
}

// Path: form
class _TranslationsFormRo implements TranslationsFormFr {
	_TranslationsFormRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Te rugăm să introduci un nume de utilizator';
	@override String get emptyFirstname => 'Te rugăm să introduci prenumele tău';
	@override String get emptyEmail => 'Te rugăm să introduci adresa ta de email';
	@override String get emptyLastname => 'Te rugăm să introduci numele tău';
	@override String get emptyPassword => 'Te rugăm să introduci parola';
	@override String get emptyConfirmPassword => 'Te rugăm să confirmi parola';
	@override String get passwordMismatch => 'Parolele nu se potrivesc';
	@override String get invalidEmail => 'Te rugăm să introduci o adresă de email validă';
	@override String get invalidAddress => 'Te rugăm să introduci o adresă validă';
	@override String get shortPassword => 'Parola trebuie să aibă cel puțin 8 caractere';
	@override String get passwordUpperCase => 'Parola trebuie să conțină cel puțin o literă mare';
	@override String get passwordDigit => 'Parola trebuie să conțină cel puțin o cifră';
	@override String get passwordSpecialChar => 'Parola trebuie să conțină cel puțin un caracter special';
	@override String get haveToAcceptConditions => 'Trebuie să accepți condițiile de utilizare și politica de confidențialitate';
	@override String get confirmPassword => 'Confirmă parola';
	@override String get pleaseConfirmPassword => 'Te rugăm să confirmi parola';
	@override String get passwordNotMatch => 'Parolele nu se potrivesc';
}

// Path: swipe_cards
class _TranslationsSwipeCardsRo implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Eroare la încărcarea evenimentelor';
	@override String get end_of_list => 'Ai ajuns la sfârșitul listei!';
	@override String nope({required Object title}) => 'Nu pentru ${title}';
	@override String joined_event({required Object title}) => 'Te-ai alăturat evenimentului ${title}';
	@override String item_changed({required Object title}) => 'Element modificat: ${title}';
}

// Path: event
class _TranslationsEventRo implements TranslationsEventFr {
	_TranslationsEventRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fizic';
	@override String get participants => 'Participanți';
	@override String hasJoinEvent({required Object event_title}) => 'Te-ai alăturat evenimentului ${event_title}';
	@override String get address_copied => 'Adresă copiată în clipboard';
	@override String get createEvent => 'Creează un eveniment';
	@override String get name => 'Nume';
	@override String get description => 'Descriere';
	@override String get date => 'Dată';
	@override String get time => 'Oră';
	@override String get location => 'Locație';
	@override String get maxParticipants => 'Numărul maxim de participanți';
	@override String get price => 'Preț';
	@override String get image => 'Imagine';
	@override String get create => 'Creează';
	@override String get enterName => 'Te rugăm să introduci un nume';
	@override String get enterDescription => 'Te rugăm să introduci o descriere';
	@override String get enterDate => 'Te rugăm să introduci o dată';
	@override String get enterTime => 'Te rugăm să introduci o oră';
	@override String get enterLocation => 'Te rugăm să introduci o locație';
	@override String get enterMaxParticipants => 'Te rugăm să introduci un număr de participanți';
	@override String get invalidMaxParticipants => 'Te rugăm să introduci un număr valid';
	@override String get enterPrice => 'Te rugăm să introduci un preț';
	@override String get invalidPrice => 'Te rugăm să introduci un preț valid';
	@override String get enterImage => 'Te rugăm să introduci un URL de imagine';
	@override String get joinEvent => 'Alătură-te evenimentului';
	@override String get eventNotStarted => 'Linkul de conectare va fi disponibil aici când evenimentul va începe.';
}

// Path: error
class _TranslationsErrorRo implements TranslationsErrorFr {
	_TranslationsErrorRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Eroare: ${error}';
	@override String get general => 'A apărut o eroare';
	@override String get no_internet => 'Fără conexiune la Internet';
	@override String get no_internet_description => 'Te rugăm să verifici conexiunea ta la Internet și să încerci din nou';
	@override String get no_events => 'Niciun eveniment găsit';
	@override String get no_events_description => 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
	@override String get no_events_found => 'Niciun eveniment găsit';
	@override String get no_events_found_description => 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
	@override String get no_events_found_title => 'Niciun eveniment găsit';
	@override String get no_events_found_description_title => 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
	@override String get no_events_found_description_title_search => 'Niciun eveniment nu a fost găsit pentru căutarea efectuată. Te rugăm să încerci din nou cu un alt termen';
	@override String get loadingEvents => 'A apărut o eroare la încărcarea evenimentelor';
	@override String get failedToResetPassword => 'Eșec la reinitializarea parolei';
}

// Path: auth
class _TranslationsAuthRo implements TranslationsAuthFr {
	_TranslationsAuthRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Parola uitată?';
	@override String get enterEmail => 'Introdu adresa ta de email pentru a primi instrucțiunile de resetare';
	@override String get resetPassword => 'Resetare parolă';
	@override String get enterNewPassword => 'Introdu noua ta parolă';
	@override String get resetInstructionsSent => 'Instrucțiunile de resetare au fost trimise pe emailul tău';
	@override String get passwordResertSuccess => 'Parola ta a fost resetată cu succes';
}

// Path: verify
class _TranslationsVerifyRo implements TranslationsVerifyFr {
	_TranslationsVerifyRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verificarea codului';
	@override String get description => 'Introdu codul de verificare trimis pe emailul tău';
	@override String get inputLabel => 'Cod de verificare';
	@override String get button => 'Verifică';
	@override String get error => 'Te rog să introduci codul de verificare';
}

// Path: profile
class _TranslationsProfileRo implements TranslationsProfileFr {
	_TranslationsProfileRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Editează profilul meu';
	@override String get firstname => 'Prenume';
	@override String get lastname => 'Nume';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Data nașterii';
	@override String get address => 'Adresă';
	@override String get save => 'Salvează';
	@override String get cancel => 'Anulare';
	@override String get enterFirstname => 'Te rog să introduci prenumele tău';
	@override String get enterLastname => 'Te rog să introduci numele tău';
	@override String get enterEmail => 'Te rog să introduci adresa ta de email';
	@override String get invalidEmail => 'Te rog să introduci o adresă de email validă';
	@override String get logout => 'Deconectare';
}

// Path: resources
class _TranslationsResourcesRo implements TranslationsResourcesFr {
	_TranslationsResourcesRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Resurse disponibile';
	@override String get name => 'Nume';
	@override String get type => 'Tip';
}

// Path: messages
class _TranslationsMessagesRo implements TranslationsMessagesFr {
	_TranslationsMessagesRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Cele mai recente mesaje';
	@override String get seeAllMessages => 'Vezi toate mesajele';
	@override String get noMessages => 'Niciun mesaj';
	@override String get writeMessageHint => 'Scrie un mesaj...';
	@override String get sendMessage => 'Trimite';
}

// Path: common
class _TranslationsCommonRo implements TranslationsCommonFr {
	_TranslationsCommonRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Expeditor';
	@override String get message => 'Mesaj';
}

// Path: page
class _TranslationsPageRo implements TranslationsPageFr {
	_TranslationsPageRo._(this._root);

	final TranslationsRo _root; // ignore: unused_field

	// Translations
	@override String get home => 'Acasă';
	@override String get homePage => 'Pagina principală';
	@override String get profile => 'Profil';
	@override String get profilePage => 'Pagina profilului';
	@override String get settings => 'Setări';
	@override String get settingsPage => 'Pagina setărilor';
	@override String get search => 'Căutare';
	@override String get searchPage => 'Pagina căutării';
	@override String get sheet => 'Fișă';
	@override String get sheetPage => 'Pagina fișei';
	@override String get subject => 'Materie';
	@override String get subjectPage => 'Pagina materiei';
	@override String get topic => 'Subiect';
	@override String get topicPage => 'Pagina subiectului';
	@override String get event => 'Eveniment';
	@override String get eventPage => 'Pagina evenimentului';
	@override String get user => 'Utilizator';
	@override String get userPage => 'Pagina utilizatorului';
	@override String get about => 'Despre';
	@override String get aboutPage => 'Pagina Despre';
	@override String get contact => 'Contact';
	@override String get contactPage => 'Pagina de contact';
	@override String get terms => 'Condiții de utilizare';
	@override String get termsPage => 'Pagina condițiilor de utilizare';
	@override String get privacy => 'Politica de confidențialitate';
	@override String get privacyPage => 'Pagina politicii de confidențialitate';
	@override String get notifications => 'Notificări';
	@override String get events => 'Evenimente';
	@override String get sheets => 'Fișe';
	@override String get subjects => 'Materii';
	@override String get topics => 'Subiecte';
	@override String get users => 'Utilizatori';
	@override String get help => 'Ajutor';
	@override String get helpPage => 'Pagina de ajutor';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRo {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Conectare';
			case 'app.signup': return 'Înscriere';
			case 'app.logout': return 'Deconectare';
			case 'app.search': return 'Căutare';
			case 'app.searchLanguage': return 'Căutare limbă';
			case 'app.add': return 'Adăuga';
			case 'app.edit': return 'Edita';
			case 'app.delete': return 'Șterge';
			case 'app.cancel': return 'Anulare';
			case 'app.save': return 'Salvează';
			case 'app.yes': return 'Da';
			case 'app.no': return 'Nu';
			case 'app.confirm': return 'Confirmă';
			case 'app.error': return 'Eroare';
			case 'app.loading': return 'Încărcare...';
			case 'app.noResults': return 'Niciun rezultat';
			case 'app.noResultsFound': return 'Niciun rezultat găsit';
			case 'app.skip': return 'Sari';
			case 'app.next': return 'Următorul';
			case 'app.previous': return 'Anterior';
			case 'app.finish': return 'Finalizare';
			case 'app.back': return 'Înapoi';
			case 'app.submit': return 'Trimite';
			case 'app.searchUser': return 'Caută un utilizator';
			case 'app.searchSubject': return 'Caută o materie';
			case 'app.searchTopic': return 'Caută un subiect';
			case 'app.searchSheet': return 'Caută o fișă';
			case 'app.alreadyHaveAccount': return 'Ai deja un cont?';
			case 'app.loadingIndicator': return 'Încărcare...';
			case 'app.errorOccurred': return 'A apărut o eroare';
			case 'app.backTo': return 'Înapoi la ';
			case 'user.email': return 'Email';
			case 'user.username': return 'Nume de utilizator';
			case 'user.name': return 'Nume';
			case 'user.firstname': return 'Prenume';
			case 'user.birthdate': return 'Data nașterii';
			case 'user.location': return 'Locație';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Număr de raportări';
			case 'user.address': return 'Adresă';
			case 'user.password': return 'Parolă';
			case 'user.newPassword': return 'Parolă nouă';
			case 'user.anonymous': return 'Anonim';
			case 'user.noDescription': return 'Nici o descriere';
			case 'user.noAddress': return 'Adresă indisponibilă';
			case 'user.noReportsAvailable': return 'Numărul de raportări nu este disponibil';
			case 'welcome.welcome': return 'Bun venit pe Edumeet, platforma de revizuire colaborativă';
			case 'welcome.setup': return 'Haide să începem prin a alege o limbă';
			case 'welcome.whatLanguage': return 'Ce limbă vorbești?';
			case 'welcome.chooseLanguage': return 'Alege o limbă pentru a putea comunica împreună';
			case 'welcome.title1': return 'Găsește-ți fișele de revizuire';
			case 'welcome.description1': return 'Accesează gratuit mii de fișe de revizuire create de studenți';
			case 'welcome.title2': return 'Organizează-ți revizuirile';
			case 'welcome.description2': return 'Clasează și organizează-ți fișele pentru o memorie eficientă';
			case 'welcome.title3': return 'Rămâi motivat';
			case 'welcome.description3': return 'Atinge-ți obiectivele cu ajutorul unor sfaturi practice';
			case 'welcome.title4': return 'Alătură-te comunității noastre';
			case 'welcome.description4': return 'Împărtășește-ți fișele de revizuire și primește sfaturi personalizate';
			case 'login.title': return 'Conectare';
			case 'login.description': return 'Introdu informațiile tale mai jos pentru a te conecta';
			case 'login.forgotPassword': return 'Parola uitată?';
			case 'login.noAccount': return 'Nu ai un cont?';
			case 'login.createAccount': return 'Creează un cont';
			case 'register.title': return 'Creează un cont';
			case 'register.description': return 'Alătură-te nouă pentru a beneficia de serviciile noastre';
			case 'register.conditions': return 'Prin crearea unui cont, accepți Condițiile noastre de utilizare și Politica de confidențialitate';
			case 'register.registerConfirm': return 'Înscriere confirmată';
			case 'form.emptyUsername': return 'Te rugăm să introduci un nume de utilizator';
			case 'form.emptyFirstname': return 'Te rugăm să introduci prenumele tău';
			case 'form.emptyEmail': return 'Te rugăm să introduci adresa ta de email';
			case 'form.emptyLastname': return 'Te rugăm să introduci numele tău';
			case 'form.emptyPassword': return 'Te rugăm să introduci parola';
			case 'form.emptyConfirmPassword': return 'Te rugăm să confirmi parola';
			case 'form.passwordMismatch': return 'Parolele nu se potrivesc';
			case 'form.invalidEmail': return 'Te rugăm să introduci o adresă de email validă';
			case 'form.invalidAddress': return 'Te rugăm să introduci o adresă validă';
			case 'form.shortPassword': return 'Parola trebuie să aibă cel puțin 8 caractere';
			case 'form.passwordUpperCase': return 'Parola trebuie să conțină cel puțin o literă mare';
			case 'form.passwordDigit': return 'Parola trebuie să conțină cel puțin o cifră';
			case 'form.passwordSpecialChar': return 'Parola trebuie să conțină cel puțin un caracter special';
			case 'form.haveToAcceptConditions': return 'Trebuie să accepți condițiile de utilizare și politica de confidențialitate';
			case 'form.confirmPassword': return 'Confirmă parola';
			case 'form.pleaseConfirmPassword': return 'Te rugăm să confirmi parola';
			case 'form.passwordNotMatch': return 'Parolele nu se potrivesc';
			case 'swipe_cards.loading_error': return 'Eroare la încărcarea evenimentelor';
			case 'swipe_cards.end_of_list': return 'Ai ajuns la sfârșitul listei!';
			case 'swipe_cards.nope': return ({required Object title}) => 'Nu pentru ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Te-ai alăturat evenimentului ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Element modificat: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fizic';
			case 'event.participants': return 'Participanți';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Te-ai alăturat evenimentului ${event_title}';
			case 'event.address_copied': return 'Adresă copiată în clipboard';
			case 'event.createEvent': return 'Creează un eveniment';
			case 'event.name': return 'Nume';
			case 'event.description': return 'Descriere';
			case 'event.date': return 'Dată';
			case 'event.time': return 'Oră';
			case 'event.location': return 'Locație';
			case 'event.maxParticipants': return 'Numărul maxim de participanți';
			case 'event.price': return 'Preț';
			case 'event.image': return 'Imagine';
			case 'event.create': return 'Creează';
			case 'event.enterName': return 'Te rugăm să introduci un nume';
			case 'event.enterDescription': return 'Te rugăm să introduci o descriere';
			case 'event.enterDate': return 'Te rugăm să introduci o dată';
			case 'event.enterTime': return 'Te rugăm să introduci o oră';
			case 'event.enterLocation': return 'Te rugăm să introduci o locație';
			case 'event.enterMaxParticipants': return 'Te rugăm să introduci un număr de participanți';
			case 'event.invalidMaxParticipants': return 'Te rugăm să introduci un număr valid';
			case 'event.enterPrice': return 'Te rugăm să introduci un preț';
			case 'event.invalidPrice': return 'Te rugăm să introduci un preț valid';
			case 'event.enterImage': return 'Te rugăm să introduci un URL de imagine';
			case 'event.joinEvent': return 'Alătură-te evenimentului';
			case 'event.eventNotStarted': return 'Linkul de conectare va fi disponibil aici când evenimentul va începe.';
			case 'error.details': return ({required Object error}) => 'Eroare: ${error}';
			case 'error.general': return 'A apărut o eroare';
			case 'error.no_internet': return 'Fără conexiune la Internet';
			case 'error.no_internet_description': return 'Te rugăm să verifici conexiunea ta la Internet și să încerci din nou';
			case 'error.no_events': return 'Niciun eveniment găsit';
			case 'error.no_events_description': return 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
			case 'error.no_events_found': return 'Niciun eveniment găsit';
			case 'error.no_events_found_description': return 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
			case 'error.no_events_found_title': return 'Niciun eveniment găsit';
			case 'error.no_events_found_description_title': return 'Niciun eveniment nu a fost găsit în acest moment. Te rugăm să încerci din nou mai târziu';
			case 'error.no_events_found_description_title_search': return 'Niciun eveniment nu a fost găsit pentru căutarea efectuată. Te rugăm să încerci din nou cu un alt termen';
			case 'error.loadingEvents': return 'A apărut o eroare la încărcarea evenimentelor';
			case 'error.failedToResetPassword': return 'Eșec la reinitializarea parolei';
			case 'auth.forgotPassword': return 'Parola uitată?';
			case 'auth.enterEmail': return 'Introdu adresa ta de email pentru a primi instrucțiunile de resetare';
			case 'auth.resetPassword': return 'Resetare parolă';
			case 'auth.enterNewPassword': return 'Introdu noua ta parolă';
			case 'auth.resetInstructionsSent': return 'Instrucțiunile de resetare au fost trimise pe emailul tău';
			case 'auth.passwordResertSuccess': return 'Parola ta a fost resetată cu succes';
			case 'verify.title': return 'Verificarea codului';
			case 'verify.description': return 'Introdu codul de verificare trimis pe emailul tău';
			case 'verify.inputLabel': return 'Cod de verificare';
			case 'verify.button': return 'Verifică';
			case 'verify.error': return 'Te rog să introduci codul de verificare';
			case 'profile.editProfile': return 'Editează profilul meu';
			case 'profile.firstname': return 'Prenume';
			case 'profile.lastname': return 'Nume';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Data nașterii';
			case 'profile.address': return 'Adresă';
			case 'profile.save': return 'Salvează';
			case 'profile.cancel': return 'Anulare';
			case 'profile.enterFirstname': return 'Te rog să introduci prenumele tău';
			case 'profile.enterLastname': return 'Te rog să introduci numele tău';
			case 'profile.enterEmail': return 'Te rog să introduci adresa ta de email';
			case 'profile.invalidEmail': return 'Te rog să introduci o adresă de email validă';
			case 'profile.logout': return 'Deconectare';
			case 'resources.availableResources': return 'Resurse disponibile';
			case 'resources.name': return 'Nume';
			case 'resources.type': return 'Tip';
			case 'messages.latestMessages': return 'Cele mai recente mesaje';
			case 'messages.seeAllMessages': return 'Vezi toate mesajele';
			case 'messages.noMessages': return 'Niciun mesaj';
			case 'messages.writeMessageHint': return 'Scrie un mesaj...';
			case 'messages.sendMessage': return 'Trimite';
			case 'common.sender': return 'Expeditor';
			case 'common.message': return 'Mesaj';
			case 'page.home': return 'Acasă';
			case 'page.homePage': return 'Pagina principală';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Pagina profilului';
			case 'page.settings': return 'Setări';
			case 'page.settingsPage': return 'Pagina setărilor';
			case 'page.search': return 'Căutare';
			case 'page.searchPage': return 'Pagina căutării';
			case 'page.sheet': return 'Fișă';
			case 'page.sheetPage': return 'Pagina fișei';
			case 'page.subject': return 'Materie';
			case 'page.subjectPage': return 'Pagina materiei';
			case 'page.topic': return 'Subiect';
			case 'page.topicPage': return 'Pagina subiectului';
			case 'page.event': return 'Eveniment';
			case 'page.eventPage': return 'Pagina evenimentului';
			case 'page.user': return 'Utilizator';
			case 'page.userPage': return 'Pagina utilizatorului';
			case 'page.about': return 'Despre';
			case 'page.aboutPage': return 'Pagina Despre';
			case 'page.contact': return 'Contact';
			case 'page.contactPage': return 'Pagina de contact';
			case 'page.terms': return 'Condiții de utilizare';
			case 'page.termsPage': return 'Pagina condițiilor de utilizare';
			case 'page.privacy': return 'Politica de confidențialitate';
			case 'page.privacyPage': return 'Pagina politicii de confidențialitate';
			case 'page.notifications': return 'Notificări';
			case 'page.events': return 'Evenimente';
			case 'page.sheets': return 'Fișe';
			case 'page.subjects': return 'Materii';
			case 'page.topics': return 'Subiecte';
			case 'page.users': return 'Utilizatori';
			case 'page.help': return 'Ajutor';
			case 'page.helpPage': return 'Pagina de ajutor';
			default: return null;
		}
	}
}


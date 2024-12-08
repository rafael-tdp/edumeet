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
class TranslationsDe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppDe app = _TranslationsAppDe._(_root);
	@override late final _TranslationsUserDe user = _TranslationsUserDe._(_root);
	@override late final _TranslationsWelcomeDe welcome = _TranslationsWelcomeDe._(_root);
	@override late final _TranslationsLoginDe login = _TranslationsLoginDe._(_root);
	@override late final _TranslationsRegisterDe register = _TranslationsRegisterDe._(_root);
	@override late final _TranslationsFormDe form = _TranslationsFormDe._(_root);
	@override late final _TranslationsSwipeCardsDe swipe_cards = _TranslationsSwipeCardsDe._(_root);
	@override late final _TranslationsEventDe event = _TranslationsEventDe._(_root);
	@override late final _TranslationsErrorDe error = _TranslationsErrorDe._(_root);
	@override late final _TranslationsAuthDe auth = _TranslationsAuthDe._(_root);
	@override late final _TranslationsVerifyDe verify = _TranslationsVerifyDe._(_root);
	@override late final _TranslationsProfileDe profile = _TranslationsProfileDe._(_root);
	@override late final _TranslationsResourcesDe resources = _TranslationsResourcesDe._(_root);
	@override late final _TranslationsMessagesDe messages = _TranslationsMessagesDe._(_root);
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsPageDe page = _TranslationsPageDe._(_root);
}

// Path: app
class _TranslationsAppDe implements TranslationsAppFr {
	_TranslationsAppDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get login => 'Einloggen';
	@override String get signup => 'Registrieren';
	@override String get logout => 'Abmelden';
	@override String get search => 'Suchen';
	@override String get searchLanguage => 'Sprache suchen';
	@override String get add => 'Hinzufügen';
	@override String get edit => 'Bearbeiten';
	@override String get delete => 'Löschen';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get yes => 'Ja';
	@override String get no => 'Nein';
	@override String get confirm => 'Bestätigen';
	@override String get error => 'Fehler';
	@override String get loading => 'Lädt...';
	@override String get noResults => 'Keine Ergebnisse';
	@override String get noResultsFound => 'Keine Ergebnisse gefunden';
	@override String get skip => 'Überspringen';
	@override String get next => 'Weiter';
	@override String get previous => 'Zurück';
	@override String get finish => 'Fertigstellen';
	@override String get back => 'Zurück';
	@override String get submit => 'Absenden';
	@override String get searchUser => 'Benutzer suchen';
	@override String get searchSubject => 'Fach suchen';
	@override String get searchTopic => 'Thema suchen';
	@override String get searchSheet => 'Blatt suchen';
	@override String get alreadyHaveAccount => 'Haben Sie bereits ein Konto?';
	@override String get loadingIndicator => 'Laden...';
	@override String get errorOccurred => 'Es ist ein Fehler aufgetreten';
	@override String get backTo => 'Zurück zu ';
}

// Path: user
class _TranslationsUserDe implements TranslationsUserFr {
	_TranslationsUserDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get email => 'E-Mail';
	@override String get username => 'Benutzername';
	@override String get name => 'Name';
	@override String get firstname => 'Vorname';
	@override String get birthdate => 'Geburtsdatum';
	@override String get location => 'Standort';
	@override String get bio => 'Biografie';
	@override String get nbReports => 'Anzahl der Meldungen';
	@override String get address => 'Adresse';
	@override String get password => 'Passwort';
	@override String get newPassword => 'Neues Passwort';
	@override String get anonymous => 'Anonym';
	@override String get noDescription => 'Keine Beschreibung';
	@override String get noAddress => 'Adresse nicht verfügbar';
	@override String get noReportsAvailable => 'Anzahl der Meldungen nicht verfügbar';
}

// Path: welcome
class _TranslationsWelcomeDe implements TranslationsWelcomeFr {
	_TranslationsWelcomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Willkommen bei Edumeet, der Plattform für kollaboratives Lernen';
	@override String get setup => 'Lass uns anfangen, indem wir eine Sprache wählen';
	@override String get whatLanguage => 'Welche Sprache sprichst du?';
	@override String get chooseLanguage => 'Wähle eine Sprache, damit wir miteinander kommunizieren können';
	@override String get title1 => 'Finde deine Lernunterlagen';
	@override String get description1 => 'Greife kostenlos auf Tausende von \nLernunterlagen zu, die von Studenten erstellt wurden';
	@override String get title2 => 'Organisiere dein Lernen';
	@override String get description2 => 'Klassifiziere und organisiere deine Unterlagen für ein \neffizientes Gedächtnis';
	@override String get title3 => 'Bleibe motiviert';
	@override String get description3 => 'Erreiche deine Ziele mit praktischen \nTipps';
	@override String get title4 => 'Tritt unserer Gemeinschaft bei';
	@override String get description4 => 'Teile deine Lernunterlagen und \nerhalte personalisierte Tipps';
}

// Path: login
class _TranslationsLoginDe implements TranslationsLoginFr {
	_TranslationsLoginDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anmeldung';
	@override String get description => 'Geben Sie Ihre Informationen unten ein, um sich anzumelden';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get noAccount => 'Haben Sie kein Konto?';
	@override String get createAccount => 'Ein Konto erstellen';
}

// Path: register
class _TranslationsRegisterDe implements TranslationsRegisterFr {
	_TranslationsRegisterDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ein Konto erstellen';
	@override String get description => 'Treten Sie uns bei, um von unseren Dienstleistungen zu profitieren';
	@override String get conditions => 'Indem Sie ein Konto erstellen, akzeptieren Sie unsere Nutzungsbedingungen und die Datenschutzrichtlinie';
	@override String get registerConfirm => 'Registrierung bestätigt';
}

// Path: form
class _TranslationsFormDe implements TranslationsFormFr {
	_TranslationsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Bitte geben Sie einen Benutzernamen ein';
	@override String get emptyFirstname => 'Bitte geben Sie Ihren Vornamen ein';
	@override String get emptyEmail => 'Bitte geben Sie Ihre E-Mail-Adresse ein';
	@override String get emptyLastname => 'Bitte geben Sie Ihren Nachnamen ein';
	@override String get emptyPassword => 'Bitte geben Sie Ihr Passwort ein';
	@override String get emptyConfirmPassword => 'Bitte bestätigen Sie Ihr Passwort';
	@override String get passwordMismatch => 'Die Passwörter stimmen nicht überein';
	@override String get invalidEmail => 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
	@override String get invalidAddress => 'Bitte geben Sie eine gültige Adresse ein';
	@override String get shortPassword => 'Das Passwort muss mindestens 8 Zeichen lang sein';
	@override String get passwordUpperCase => 'Das Passwort muss mindestens einen Großbuchstaben enthalten';
	@override String get passwordDigit => 'Das Passwort muss mindestens eine Zahl enthalten';
	@override String get passwordSpecialChar => 'Das Passwort muss mindestens ein Sonderzeichen enthalten';
	@override String get haveToAcceptConditions => 'Sie müssen die Nutzungsbedingungen und die Datenschutzrichtlinie akzeptieren';
	@override String get confirmPassword => 'Passwort bestätigen';
	@override String get pleaseConfirmPassword => 'Bitte bestätigen Sie Ihr Passwort';
	@override String get passwordNotMatch => 'Die Passwörter stimmen nicht überein';
}

// Path: swipe_cards
class _TranslationsSwipeCardsDe implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Fehler beim Laden der Veranstaltungen';
	@override String get end_of_list => 'Sie haben das Ende der Liste erreicht!';
	@override String nope({required Object title}) => 'Nein zu ${title}';
	@override String joined_event({required Object title}) => 'Sie haben an der Veranstaltung ${title} teilgenommen';
	@override String item_changed({required Object title}) => 'Artikel geändert: ${title}';
}

// Path: event
class _TranslationsEventDe implements TranslationsEventFr {
	_TranslationsEventDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Physisch';
	@override String get participants => 'Teilnehmer';
	@override String hasJoinEvent({required Object event_title}) => 'Sie haben an der Veranstaltung ${event_title} teilgenommen';
	@override String get address_copied => 'Adresse in die Zwischenablage kopiert';
	@override String get createEvent => 'Ein Ereignis erstellen';
	@override String get name => 'Name';
	@override String get description => 'Beschreibung';
	@override String get date => 'Datum';
	@override String get time => 'Uhrzeit';
	@override String get location => 'Ort';
	@override String get maxParticipants => 'Maximale Teilnehmeranzahl';
	@override String get price => 'Preis';
	@override String get image => 'Bild';
	@override String get create => 'Erstellen';
	@override String get enterName => 'Bitte einen Namen eingeben';
	@override String get enterDescription => 'Bitte eine Beschreibung eingeben';
	@override String get enterDate => 'Bitte ein Datum eingeben';
	@override String get enterTime => 'Bitte eine Uhrzeit eingeben';
	@override String get enterLocation => 'Bitte einen Ort eingeben';
	@override String get enterMaxParticipants => 'Bitte eine maximale Teilnehmeranzahl eingeben';
	@override String get invalidMaxParticipants => 'Bitte eine gültige Anzahl eingeben';
	@override String get enterPrice => 'Bitte einen Preis eingeben';
	@override String get invalidPrice => 'Bitte einen gültigen Preis eingeben';
	@override String get enterImage => 'Bitte eine Bild-URL eingeben';
	@override String get joinEvent => 'Veranstaltung beitreten';
	@override String get eventNotStarted => 'Der Verbindungslink wird hier verfügbar sein, sobald die Veranstaltung beginnt.';
}

// Path: error
class _TranslationsErrorDe implements TranslationsErrorFr {
	_TranslationsErrorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Fehler: ${error}';
	@override String get no_internet => 'Keine Internetverbindung';
	@override String get no_internet_description => 'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut';
	@override String get no_events => 'Keine Veranstaltungen gefunden';
	@override String get no_events_description => 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
	@override String get no_events_found => 'Keine Veranstaltungen gefunden';
	@override String get no_events_found_description => 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
	@override String get no_events_found_title => 'Keine Veranstaltungen gefunden';
	@override String get no_events_found_description_title => 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
	@override String get no_events_found_description_title_search => 'Für die durchgeführte Suche wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es mit einem anderen Suchbegriff erneut';
	@override String get loadingEvents => 'Beim Laden der Ereignisse ist ein Fehler aufgetreten';
	@override String get failedToResetPassword => 'Zurücksetzen des Passworts fehlgeschlagen';
}

// Path: auth
class _TranslationsAuthDe implements TranslationsAuthFr {
	_TranslationsAuthDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get enterEmail => 'Geben Sie Ihre E-Mail-Adresse ein, um die Anweisungen zur Zurücksetzung zu erhalten';
	@override String get resetPassword => 'Passwort zurücksetzen';
	@override String get enterNewPassword => 'Geben Sie Ihr neues Passwort ein';
	@override String get resetInstructionsSent => 'Anweisungen zur Zurücksetzung wurden an Ihre E-Mail gesendet';
	@override String get passwordResertSuccess => 'Ihr Passwort wurde erfolgreich zurückgesetzt';
}

// Path: verify
class _TranslationsVerifyDe implements TranslationsVerifyFr {
	_TranslationsVerifyDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Überprüfung des Codes';
	@override String get description => 'Geben Sie den Verifizierungscode ein, der an Ihre E-Mail gesendet wurde';
	@override String get inputLabel => 'Verifizierungscode';
	@override String get button => 'Überprüfen';
	@override String get error => 'Bitte den Verifizierungscode eingeben';
}

// Path: profile
class _TranslationsProfileDe implements TranslationsProfileFr {
	_TranslationsProfileDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Profil bearbeiten';
	@override String get firstname => 'Vorname';
	@override String get lastname => 'Nachname';
	@override String get bio => 'Bio';
	@override String get email => 'E-Mail';
	@override String get birthdate => 'Geburtsdatum';
	@override String get address => 'Adresse';
	@override String get save => 'Speichern';
	@override String get cancel => 'Abbrechen';
	@override String get enterFirstname => 'Bitte geben Sie Ihren Vornamen ein';
	@override String get enterLastname => 'Bitte geben Sie Ihren Nachnamen ein';
	@override String get enterEmail => 'Bitte geben Sie Ihre E-Mail-Adresse ein';
	@override String get invalidEmail => 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
	@override String get logout => 'Abmelden';
}

// Path: resources
class _TranslationsResourcesDe implements TranslationsResourcesFr {
	_TranslationsResourcesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Verfügbare Ressourcen';
	@override String get name => 'Name';
	@override String get type => 'Typ';
}

// Path: messages
class _TranslationsMessagesDe implements TranslationsMessagesFr {
	_TranslationsMessagesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Neueste Nachrichten';
	@override String get seeAllMessages => 'Alle Nachrichten anzeigen';
	@override String get noMessages => 'Keine Nachrichten';
	@override String get writeMessageHint => 'Nachricht schreiben...';
	@override String get sendMessage => 'Senden';
}

// Path: common
class _TranslationsCommonDe implements TranslationsCommonFr {
	_TranslationsCommonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Absender';
	@override String get message => 'Nachricht';
}

// Path: page
class _TranslationsPageDe implements TranslationsPageFr {
	_TranslationsPageDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Startseite';
	@override String get homePage => 'Startseite';
	@override String get profile => 'Profil';
	@override String get profilePage => 'Profilseite';
	@override String get settings => 'Einstellungen';
	@override String get settingsPage => 'Einstellungsseite';
	@override String get search => 'Suche';
	@override String get searchPage => 'Suchseite';
	@override String get sheet => 'Stichblatt';
	@override String get sheetPage => 'Seite des Stichblatts';
	@override String get subject => 'Fach';
	@override String get subjectPage => 'Seite des Fachs';
	@override String get topic => 'Thema';
	@override String get topicPage => 'Seite des Themas';
	@override String get event => 'Ereignis';
	@override String get eventPage => 'Seite des Ereignisses';
	@override String get user => 'Benutzer';
	@override String get userPage => 'Benutzerseite';
	@override String get about => 'Über';
	@override String get aboutPage => 'Über-Seite';
	@override String get contact => 'Kontakt';
	@override String get contactPage => 'Kontaktseite';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get termsPage => 'Seite der Nutzungsbedingungen';
	@override String get privacy => 'Datenschutzpolitik';
	@override String get privacyPage => 'Seite der Datenschutzpolitik';
	@override String get notifications => 'Benachrichtigungen';
	@override String get events => 'Ereignisse';
	@override String get sheets => 'Stichblätter';
	@override String get subjects => 'Fächer';
	@override String get topics => 'Themen';
	@override String get users => 'Benutzer';
	@override String get help => 'Hilfe';
	@override String get helpPage => 'Hilfeseite';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Einloggen';
			case 'app.signup': return 'Registrieren';
			case 'app.logout': return 'Abmelden';
			case 'app.search': return 'Suchen';
			case 'app.searchLanguage': return 'Sprache suchen';
			case 'app.add': return 'Hinzufügen';
			case 'app.edit': return 'Bearbeiten';
			case 'app.delete': return 'Löschen';
			case 'app.cancel': return 'Abbrechen';
			case 'app.save': return 'Speichern';
			case 'app.yes': return 'Ja';
			case 'app.no': return 'Nein';
			case 'app.confirm': return 'Bestätigen';
			case 'app.error': return 'Fehler';
			case 'app.loading': return 'Lädt...';
			case 'app.noResults': return 'Keine Ergebnisse';
			case 'app.noResultsFound': return 'Keine Ergebnisse gefunden';
			case 'app.skip': return 'Überspringen';
			case 'app.next': return 'Weiter';
			case 'app.previous': return 'Zurück';
			case 'app.finish': return 'Fertigstellen';
			case 'app.back': return 'Zurück';
			case 'app.submit': return 'Absenden';
			case 'app.searchUser': return 'Benutzer suchen';
			case 'app.searchSubject': return 'Fach suchen';
			case 'app.searchTopic': return 'Thema suchen';
			case 'app.searchSheet': return 'Blatt suchen';
			case 'app.alreadyHaveAccount': return 'Haben Sie bereits ein Konto?';
			case 'app.loadingIndicator': return 'Laden...';
			case 'app.errorOccurred': return 'Es ist ein Fehler aufgetreten';
			case 'app.backTo': return 'Zurück zu ';
			case 'user.email': return 'E-Mail';
			case 'user.username': return 'Benutzername';
			case 'user.name': return 'Name';
			case 'user.firstname': return 'Vorname';
			case 'user.birthdate': return 'Geburtsdatum';
			case 'user.location': return 'Standort';
			case 'user.bio': return 'Biografie';
			case 'user.nbReports': return 'Anzahl der Meldungen';
			case 'user.address': return 'Adresse';
			case 'user.password': return 'Passwort';
			case 'user.newPassword': return 'Neues Passwort';
			case 'user.anonymous': return 'Anonym';
			case 'user.noDescription': return 'Keine Beschreibung';
			case 'user.noAddress': return 'Adresse nicht verfügbar';
			case 'user.noReportsAvailable': return 'Anzahl der Meldungen nicht verfügbar';
			case 'welcome.welcome': return 'Willkommen bei Edumeet, der Plattform für kollaboratives Lernen';
			case 'welcome.setup': return 'Lass uns anfangen, indem wir eine Sprache wählen';
			case 'welcome.whatLanguage': return 'Welche Sprache sprichst du?';
			case 'welcome.chooseLanguage': return 'Wähle eine Sprache, damit wir miteinander kommunizieren können';
			case 'welcome.title1': return 'Finde deine Lernunterlagen';
			case 'welcome.description1': return 'Greife kostenlos auf Tausende von \nLernunterlagen zu, die von Studenten erstellt wurden';
			case 'welcome.title2': return 'Organisiere dein Lernen';
			case 'welcome.description2': return 'Klassifiziere und organisiere deine Unterlagen für ein \neffizientes Gedächtnis';
			case 'welcome.title3': return 'Bleibe motiviert';
			case 'welcome.description3': return 'Erreiche deine Ziele mit praktischen \nTipps';
			case 'welcome.title4': return 'Tritt unserer Gemeinschaft bei';
			case 'welcome.description4': return 'Teile deine Lernunterlagen und \nerhalte personalisierte Tipps';
			case 'login.title': return 'Anmeldung';
			case 'login.description': return 'Geben Sie Ihre Informationen unten ein, um sich anzumelden';
			case 'login.forgotPassword': return 'Passwort vergessen?';
			case 'login.noAccount': return 'Haben Sie kein Konto?';
			case 'login.createAccount': return 'Ein Konto erstellen';
			case 'register.title': return 'Ein Konto erstellen';
			case 'register.description': return 'Treten Sie uns bei, um von unseren Dienstleistungen zu profitieren';
			case 'register.conditions': return 'Indem Sie ein Konto erstellen, akzeptieren Sie unsere Nutzungsbedingungen und die Datenschutzrichtlinie';
			case 'register.registerConfirm': return 'Registrierung bestätigt';
			case 'form.emptyUsername': return 'Bitte geben Sie einen Benutzernamen ein';
			case 'form.emptyFirstname': return 'Bitte geben Sie Ihren Vornamen ein';
			case 'form.emptyEmail': return 'Bitte geben Sie Ihre E-Mail-Adresse ein';
			case 'form.emptyLastname': return 'Bitte geben Sie Ihren Nachnamen ein';
			case 'form.emptyPassword': return 'Bitte geben Sie Ihr Passwort ein';
			case 'form.emptyConfirmPassword': return 'Bitte bestätigen Sie Ihr Passwort';
			case 'form.passwordMismatch': return 'Die Passwörter stimmen nicht überein';
			case 'form.invalidEmail': return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
			case 'form.invalidAddress': return 'Bitte geben Sie eine gültige Adresse ein';
			case 'form.shortPassword': return 'Das Passwort muss mindestens 8 Zeichen lang sein';
			case 'form.passwordUpperCase': return 'Das Passwort muss mindestens einen Großbuchstaben enthalten';
			case 'form.passwordDigit': return 'Das Passwort muss mindestens eine Zahl enthalten';
			case 'form.passwordSpecialChar': return 'Das Passwort muss mindestens ein Sonderzeichen enthalten';
			case 'form.haveToAcceptConditions': return 'Sie müssen die Nutzungsbedingungen und die Datenschutzrichtlinie akzeptieren';
			case 'form.confirmPassword': return 'Passwort bestätigen';
			case 'form.pleaseConfirmPassword': return 'Bitte bestätigen Sie Ihr Passwort';
			case 'form.passwordNotMatch': return 'Die Passwörter stimmen nicht überein';
			case 'swipe_cards.loading_error': return 'Fehler beim Laden der Veranstaltungen';
			case 'swipe_cards.end_of_list': return 'Sie haben das Ende der Liste erreicht!';
			case 'swipe_cards.nope': return ({required Object title}) => 'Nein zu ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Sie haben an der Veranstaltung ${title} teilgenommen';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Artikel geändert: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Physisch';
			case 'event.participants': return 'Teilnehmer';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Sie haben an der Veranstaltung ${event_title} teilgenommen';
			case 'event.address_copied': return 'Adresse in die Zwischenablage kopiert';
			case 'event.createEvent': return 'Ein Ereignis erstellen';
			case 'event.name': return 'Name';
			case 'event.description': return 'Beschreibung';
			case 'event.date': return 'Datum';
			case 'event.time': return 'Uhrzeit';
			case 'event.location': return 'Ort';
			case 'event.maxParticipants': return 'Maximale Teilnehmeranzahl';
			case 'event.price': return 'Preis';
			case 'event.image': return 'Bild';
			case 'event.create': return 'Erstellen';
			case 'event.enterName': return 'Bitte einen Namen eingeben';
			case 'event.enterDescription': return 'Bitte eine Beschreibung eingeben';
			case 'event.enterDate': return 'Bitte ein Datum eingeben';
			case 'event.enterTime': return 'Bitte eine Uhrzeit eingeben';
			case 'event.enterLocation': return 'Bitte einen Ort eingeben';
			case 'event.enterMaxParticipants': return 'Bitte eine maximale Teilnehmeranzahl eingeben';
			case 'event.invalidMaxParticipants': return 'Bitte eine gültige Anzahl eingeben';
			case 'event.enterPrice': return 'Bitte einen Preis eingeben';
			case 'event.invalidPrice': return 'Bitte einen gültigen Preis eingeben';
			case 'event.enterImage': return 'Bitte eine Bild-URL eingeben';
			case 'event.joinEvent': return 'Veranstaltung beitreten';
			case 'event.eventNotStarted': return 'Der Verbindungslink wird hier verfügbar sein, sobald die Veranstaltung beginnt.';
			case 'error.details': return ({required Object error}) => 'Fehler: ${error}';
			case 'error.no_internet': return 'Keine Internetverbindung';
			case 'error.no_internet_description': return 'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut';
			case 'error.no_events': return 'Keine Veranstaltungen gefunden';
			case 'error.no_events_description': return 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
			case 'error.no_events_found': return 'Keine Veranstaltungen gefunden';
			case 'error.no_events_found_description': return 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
			case 'error.no_events_found_title': return 'Keine Veranstaltungen gefunden';
			case 'error.no_events_found_description_title': return 'Momentan wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es später erneut';
			case 'error.no_events_found_description_title_search': return 'Für die durchgeführte Suche wurden keine Veranstaltungen gefunden. Bitte versuchen Sie es mit einem anderen Suchbegriff erneut';
			case 'error.loadingEvents': return 'Beim Laden der Ereignisse ist ein Fehler aufgetreten';
			case 'error.failedToResetPassword': return 'Zurücksetzen des Passworts fehlgeschlagen';
			case 'auth.forgotPassword': return 'Passwort vergessen?';
			case 'auth.enterEmail': return 'Geben Sie Ihre E-Mail-Adresse ein, um die Anweisungen zur Zurücksetzung zu erhalten';
			case 'auth.resetPassword': return 'Passwort zurücksetzen';
			case 'auth.enterNewPassword': return 'Geben Sie Ihr neues Passwort ein';
			case 'auth.resetInstructionsSent': return 'Anweisungen zur Zurücksetzung wurden an Ihre E-Mail gesendet';
			case 'auth.passwordResertSuccess': return 'Ihr Passwort wurde erfolgreich zurückgesetzt';
			case 'verify.title': return 'Überprüfung des Codes';
			case 'verify.description': return 'Geben Sie den Verifizierungscode ein, der an Ihre E-Mail gesendet wurde';
			case 'verify.inputLabel': return 'Verifizierungscode';
			case 'verify.button': return 'Überprüfen';
			case 'verify.error': return 'Bitte den Verifizierungscode eingeben';
			case 'profile.editProfile': return 'Profil bearbeiten';
			case 'profile.firstname': return 'Vorname';
			case 'profile.lastname': return 'Nachname';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'E-Mail';
			case 'profile.birthdate': return 'Geburtsdatum';
			case 'profile.address': return 'Adresse';
			case 'profile.save': return 'Speichern';
			case 'profile.cancel': return 'Abbrechen';
			case 'profile.enterFirstname': return 'Bitte geben Sie Ihren Vornamen ein';
			case 'profile.enterLastname': return 'Bitte geben Sie Ihren Nachnamen ein';
			case 'profile.enterEmail': return 'Bitte geben Sie Ihre E-Mail-Adresse ein';
			case 'profile.invalidEmail': return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
			case 'profile.logout': return 'Abmelden';
			case 'resources.availableResources': return 'Verfügbare Ressourcen';
			case 'resources.name': return 'Name';
			case 'resources.type': return 'Typ';
			case 'messages.latestMessages': return 'Neueste Nachrichten';
			case 'messages.seeAllMessages': return 'Alle Nachrichten anzeigen';
			case 'messages.noMessages': return 'Keine Nachrichten';
			case 'messages.writeMessageHint': return 'Nachricht schreiben...';
			case 'messages.sendMessage': return 'Senden';
			case 'common.sender': return 'Absender';
			case 'common.message': return 'Nachricht';
			case 'page.home': return 'Startseite';
			case 'page.homePage': return 'Startseite';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Profilseite';
			case 'page.settings': return 'Einstellungen';
			case 'page.settingsPage': return 'Einstellungsseite';
			case 'page.search': return 'Suche';
			case 'page.searchPage': return 'Suchseite';
			case 'page.sheet': return 'Stichblatt';
			case 'page.sheetPage': return 'Seite des Stichblatts';
			case 'page.subject': return 'Fach';
			case 'page.subjectPage': return 'Seite des Fachs';
			case 'page.topic': return 'Thema';
			case 'page.topicPage': return 'Seite des Themas';
			case 'page.event': return 'Ereignis';
			case 'page.eventPage': return 'Seite des Ereignisses';
			case 'page.user': return 'Benutzer';
			case 'page.userPage': return 'Benutzerseite';
			case 'page.about': return 'Über';
			case 'page.aboutPage': return 'Über-Seite';
			case 'page.contact': return 'Kontakt';
			case 'page.contactPage': return 'Kontaktseite';
			case 'page.terms': return 'Nutzungsbedingungen';
			case 'page.termsPage': return 'Seite der Nutzungsbedingungen';
			case 'page.privacy': return 'Datenschutzpolitik';
			case 'page.privacyPage': return 'Seite der Datenschutzpolitik';
			case 'page.notifications': return 'Benachrichtigungen';
			case 'page.events': return 'Ereignisse';
			case 'page.sheets': return 'Stichblätter';
			case 'page.subjects': return 'Fächer';
			case 'page.topics': return 'Themen';
			case 'page.users': return 'Benutzer';
			case 'page.help': return 'Hilfe';
			case 'page.helpPage': return 'Hilfeseite';
			default: return null;
		}
	}
}


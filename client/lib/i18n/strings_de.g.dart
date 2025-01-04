///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

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
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsPageDe page = _TranslationsPageDe._(_root);
}

// Path: app
class _TranslationsAppDe implements TranslationsAppEn {
	_TranslationsAppDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get login => 'Einloggen';
	@override String get signup => 'Registrieren';
	@override String get logout => 'Ausloggen';
	@override String get search => 'Suchen';
	@override String get searchLanguage => 'Eine Sprache suchen';
	@override String get add => 'Hinzufügen';
	@override String get edit => 'Bearbeiten';
	@override String get delete => 'Löschen';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get yes => 'Ja';
	@override String get no => 'Nein';
	@override String get confirm => 'Bestätigen';
	@override String get error => 'Fehler';
	@override String get loading => 'Laden...';
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
	@override String get alreadyHaveAccount => 'Sie haben bereits ein Konto?';
	@override String get loadingIndicator => 'Laden...';
	@override String get errorOccurred => 'Ein Fehler ist aufgetreten';
	@override String get backTo => 'Zurück zu ';
	@override String get unknown => 'Unbekannt';
}

// Path: user
class _TranslationsUserDe implements TranslationsUserEn {
	_TranslationsUserDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Benutzername';
	@override String get name => 'Name';
	@override String get firstname => 'Vorname';
	@override String get birthdate => 'Geburtsdatum';
	@override String get location => 'Ort';
	@override String get bio => 'Bio';
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
class _TranslationsWelcomeDe implements TranslationsWelcomeEn {
	_TranslationsWelcomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Willkommen bei Edumeet, der Plattform für gemeinsames Lernen';
	@override String get setup => 'Lass uns zunächst eine Sprache wählen';
	@override String get whatLanguage => 'Welche Sprache sprichst du?';
	@override String get chooseLanguage => 'Wähle eine Sprache, damit wir kommunizieren können';
	@override String get title1 => 'Finde deine Lernunterlagen';
	@override String get description1 => 'Greife kostenlos auf Tausende von \nLernunterlagen zu, die von Studenten erstellt wurden';
	@override String get title2 => 'Organisiere dein Lernen';
	@override String get description2 => 'Sortiere und organisiere deine Unterlagen für ein \neffektives Gedächtnis';
	@override String get title3 => 'Bleib motiviert';
	@override String get description3 => 'Erreiche deine Ziele mit praktischen Tipps';
	@override String get title4 => 'Tritt unserer Community bei';
	@override String get description4 => 'Teile deine Lernunterlagen und \nerhalte persönliche Ratschläge';
}

// Path: login
class _TranslationsLoginDe implements TranslationsLoginEn {
	_TranslationsLoginDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anmeldung';
	@override String get description => 'Gib deine Informationen unten ein, um dich anzumelden';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get noAccount => 'Hast du kein Konto?';
	@override String get createAccount => 'Ein Konto erstellen';
}

// Path: register
class _TranslationsRegisterDe implements TranslationsRegisterEn {
	_TranslationsRegisterDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ein Konto erstellen';
	@override String get description => 'Tritt uns bei, um von unseren Dienstleistungen zu profitieren';
	@override String get conditions => 'Durch die Erstellung eines Kontos akzeptierst du unsere Nutzungsbedingungen und unsere Datenschutzerklärung';
	@override String get registerConfirm => 'Registrierung bestätigt';
}

// Path: form
class _TranslationsFormDe implements TranslationsFormEn {
	_TranslationsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Bitte Benutzername eingeben';
	@override String get emptyFirstname => 'Bitte Vorname eingeben';
	@override String get emptyEmail => 'Bitte E-Mail-Adresse eingeben';
	@override String get emptyLastname => 'Bitte Nachnamen eingeben';
	@override String get emptyPassword => 'Bitte Passwort eingeben';
	@override String get emptyConfirmPassword => 'Bitte Passwort bestätigen';
	@override String get passwordMismatch => 'Die Passwörter stimmen nicht überein';
	@override String get invalidEmail => 'Bitte gültige E-Mail-Adresse eingeben';
	@override String get invalidAddress => 'Bitte gültige Adresse eingeben';
	@override String get shortPassword => 'Das Passwort muss mindestens 8 Zeichen lang sein';
	@override String get passwordUpperCase => 'Das Passwort muss mindestens einen Großbuchstaben enthalten';
	@override String get passwordDigit => 'Das Passwort muss mindestens eine Zahl enthalten';
	@override String get passwordSpecialChar => 'Das Passwort muss mindestens ein Sonderzeichen enthalten';
	@override String get haveToAcceptConditions => 'Du musst die Nutzungsbedingungen und die Datenschutzerklärung akzeptieren';
	@override String get confirmPassword => 'Passwort bestätigen';
	@override String get pleaseConfirmPassword => 'Bitte bestätige dein Passwort';
	@override String get passwordNotMatch => 'Die Passwörter stimmen nicht überein';
	@override String get invalidUsername => 'Der Benutzername muss:\n- zwischen 3 und 20 Zeichen lang sein\n- mit einem Buchstaben beginnen\n- keine Sonderzeichen enthalten';
}

// Path: swipe_cards
class _TranslationsSwipeCardsDe implements TranslationsSwipeCardsEn {
	_TranslationsSwipeCardsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Fehler beim Laden der Ereignisse';
	@override String get end_of_list => 'Du hast das Ende der Liste erreicht!';
	@override String get nope => 'Nein zu {{title}}';
	@override String get joined_event => 'Du hast am Ereignis {{title}} teilgenommen';
	@override String get item_changed => 'Element geändert: {{title}}';
}

// Path: event
class _TranslationsEventDe implements TranslationsEventEn {
	_TranslationsEventDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Physisch';
	@override String get participants => 'Teilnehmer';
	@override String get hasJoinEvent => 'Du hast am Ereignis {{event_title}} teilgenommen';
	@override String get address_copied => 'Adresse in die Zwischenablage kopiert';
	@override String get createEvent => 'Ereignis erstellen';
	@override String get name => 'Name';
	@override String get description => 'Beschreibung';
	@override String get date => 'Datum';
	@override String get time => 'Uhrzeit';
	@override String get location => 'Ort';
	@override String get maxParticipants => 'Maximale Teilnehmerzahl';
	@override String get price => 'Preis';
	@override String get image => 'Bild';
	@override String get create => 'Erstellen';
	@override String get enterName => 'Bitte einen Namen eingeben';
	@override String get enterDescription => 'Bitte eine Beschreibung eingeben';
	@override String get enterDate => 'Bitte ein Datum eingeben';
	@override String get enterTime => 'Bitte eine Uhrzeit eingeben';
	@override String get enterLocation => 'Bitte einen Ort eingeben';
	@override String get enterMaxParticipants => 'Bitte eine Teilnehmerzahl eingeben';
	@override String get invalidMaxParticipants => 'Bitte eine gültige Anzahl eingeben';
	@override String get enterPrice => 'Bitte einen Preis eingeben';
	@override String get invalidPrice => 'Bitte einen gültigen Preis eingeben';
	@override String get enterImage => 'Bitte eine Bild-URL eingeben';
	@override String get joinEvent => 'Ereignis beitreten';
	@override String get eventNotStarted => 'Der Verbindungslink wird hier verfügbar sein, wenn das Ereignis beginnt.';
}

// Path: error
class _TranslationsErrorDe implements TranslationsErrorEn {
	_TranslationsErrorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get details => 'Fehler: {{error}}';
	@override String get general => 'Es ist ein Fehler aufgetreten';
	@override String get no_results => 'Keine Ergebnisse gefunden';
	@override String get no_internet => 'Keine Internetverbindung';
	@override String get no_internet_description => 'Bitte überprüfe deine Internetverbindung und versuche es erneut';
	@override String get no_events => 'Keine Ereignisse gefunden';
	@override String get no_events_description => 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
	@override String get no_events_found => 'Keine Ereignisse gefunden';
	@override String get no_events_found_description => 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
	@override String get no_events_found_title => 'Keine Ereignisse gefunden';
	@override String get no_events_found_description_title => 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
	@override String get no_events_found_description_title_search => 'Es wurden keine Ereignisse für die durchgeführte Suche gefunden. Bitte versuche es mit einem anderen Begriff erneut';
	@override String get loadingEvents => 'Ein Fehler ist beim Laden der Ereignisse aufgetreten';
	@override String get failedToResetPassword => 'Zurücksetzen des Passworts fehlgeschlagen';
}

// Path: auth
class _TranslationsAuthDe implements TranslationsAuthEn {
	_TranslationsAuthDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get enterEmail => 'Gib deine E-Mail-Adresse ein, um die Anweisungen zum Zurücksetzen zu erhalten';
	@override String get resetPassword => 'Passwort zurücksetzen';
	@override String get enterNewPassword => 'Gib dein neues Passwort ein';
	@override String get resetInstructionsSent => 'Anweisungen zum Zurücksetzen wurden an deine E-Mail gesendet';
	@override String get passwordResertSuccess => 'Dein Passwort wurde erfolgreich zurückgesetzt';
}

// Path: verify
class _TranslationsVerifyDe implements TranslationsVerifyEn {
	_TranslationsVerifyDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Codeprüfung';
	@override String get description => 'Gib den zur Verfügung gestellten Bestätigungscode ein';
	@override String get inputLabel => 'Bestätigungscode';
	@override String get button => 'Überprüfen';
	@override String get error => 'Bitte den Bestätigungscode eingeben';
}

// Path: profile
class _TranslationsProfileDe implements TranslationsProfileEn {
	_TranslationsProfileDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Profil bearbeiten';
	@override String get firstname => 'Vorname';
	@override String get lastname => 'Nachname';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Geburtsdatum';
	@override String get address => 'Adresse';
	@override String get save => 'Speichern';
	@override String get cancel => 'Abbrechen';
	@override String get enterFirstname => 'Bitte Vorname eingeben';
	@override String get enterLastname => 'Bitte Nachnamen eingeben';
	@override String get enterEmail => 'Bitte E-Mail-Adresse eingeben';
	@override String get invalidEmail => 'Bitte gültige E-Mail-Adresse eingeben';
	@override String get logout => 'Ausloggen';
}

// Path: resources
class _TranslationsResourcesDe implements TranslationsResourcesEn {
	_TranslationsResourcesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Verfügbare Ressourcen';
	@override String get name => 'Name';
	@override String get type => 'Typ';
}

// Path: messages
class _TranslationsMessagesDe implements TranslationsMessagesEn {
	_TranslationsMessagesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Letzte Nachrichten';
	@override String get seeAllMessages => 'Alle Nachrichten anzeigen';
	@override String get noMessages => 'Keine Nachrichten';
	@override String get writeMessageHint => 'Nachricht schreiben...';
	@override String get sendMessage => 'Nachricht senden';
}

// Path: common
class _TranslationsCommonDe implements TranslationsCommonEn {
	_TranslationsCommonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Absender';
	@override String get message => 'Nachricht';
}

// Path: settings
class _TranslationsSettingsDe implements TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get account => 'Konto';
	@override String get settings => 'Einstellungen';
	@override String get language => 'Sprache';
	@override String get manageSubjects => 'Fächer verwalten';
	@override String get notifications => 'Benachrichtigungen';
	@override String get about => 'Über';
	@override String get contact => 'Kontakt';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get privacy => 'Datenschutzrichtlinie';
}

// Path: page
class _TranslationsPageDe implements TranslationsPageEn {
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
	@override String get sheet => 'Blatt';
	@override String get sheetPage => 'Blattseite';
	@override String get subject => 'Fach';
	@override String get subjectPage => 'Fachseite';
	@override String get topic => 'Thema';
	@override String get topicPage => 'Themenseite';
	@override String get event => 'Ereignis';
	@override String get eventPage => 'Ereignisseite';
	@override String get user => 'Benutzer';
	@override String get userPage => 'Benutzseite';
	@override String get about => 'Über';
	@override String get aboutPage => 'Über-Seite';
	@override String get contact => 'Kontakt';
	@override String get contactPage => 'Kontaktseite';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get termsPage => 'Seite der Nutzungsbedingungen';
	@override String get privacy => 'Datenschutzrichtlinie';
	@override String get privacyPage => 'Seite der Datenschutzrichtlinie';
	@override String get notifications => 'Benachrichtigungen';
	@override String get events => 'Ereignisse';
	@override String get sheets => 'Blätter';
	@override String get subjects => 'Fächer';
	@override String get topics => 'Themen';
	@override String get users => 'Benutzer';
	@override String get help => 'Hilfe';
	@override String get helpPage => 'Hilfe-Seite';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Einloggen';
			case 'app.signup': return 'Registrieren';
			case 'app.logout': return 'Ausloggen';
			case 'app.search': return 'Suchen';
			case 'app.searchLanguage': return 'Eine Sprache suchen';
			case 'app.add': return 'Hinzufügen';
			case 'app.edit': return 'Bearbeiten';
			case 'app.delete': return 'Löschen';
			case 'app.cancel': return 'Abbrechen';
			case 'app.save': return 'Speichern';
			case 'app.yes': return 'Ja';
			case 'app.no': return 'Nein';
			case 'app.confirm': return 'Bestätigen';
			case 'app.error': return 'Fehler';
			case 'app.loading': return 'Laden...';
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
			case 'app.alreadyHaveAccount': return 'Sie haben bereits ein Konto?';
			case 'app.loadingIndicator': return 'Laden...';
			case 'app.errorOccurred': return 'Ein Fehler ist aufgetreten';
			case 'app.backTo': return 'Zurück zu ';
			case 'app.unknown': return 'Unbekannt';
			case 'user.email': return 'Email';
			case 'user.username': return 'Benutzername';
			case 'user.name': return 'Name';
			case 'user.firstname': return 'Vorname';
			case 'user.birthdate': return 'Geburtsdatum';
			case 'user.location': return 'Ort';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Anzahl der Meldungen';
			case 'user.address': return 'Adresse';
			case 'user.password': return 'Passwort';
			case 'user.newPassword': return 'Neues Passwort';
			case 'user.anonymous': return 'Anonym';
			case 'user.noDescription': return 'Keine Beschreibung';
			case 'user.noAddress': return 'Adresse nicht verfügbar';
			case 'user.noReportsAvailable': return 'Anzahl der Meldungen nicht verfügbar';
			case 'welcome.welcome': return 'Willkommen bei Edumeet, der Plattform für gemeinsames Lernen';
			case 'welcome.setup': return 'Lass uns zunächst eine Sprache wählen';
			case 'welcome.whatLanguage': return 'Welche Sprache sprichst du?';
			case 'welcome.chooseLanguage': return 'Wähle eine Sprache, damit wir kommunizieren können';
			case 'welcome.title1': return 'Finde deine Lernunterlagen';
			case 'welcome.description1': return 'Greife kostenlos auf Tausende von \nLernunterlagen zu, die von Studenten erstellt wurden';
			case 'welcome.title2': return 'Organisiere dein Lernen';
			case 'welcome.description2': return 'Sortiere und organisiere deine Unterlagen für ein \neffektives Gedächtnis';
			case 'welcome.title3': return 'Bleib motiviert';
			case 'welcome.description3': return 'Erreiche deine Ziele mit praktischen Tipps';
			case 'welcome.title4': return 'Tritt unserer Community bei';
			case 'welcome.description4': return 'Teile deine Lernunterlagen und \nerhalte persönliche Ratschläge';
			case 'login.title': return 'Anmeldung';
			case 'login.description': return 'Gib deine Informationen unten ein, um dich anzumelden';
			case 'login.forgotPassword': return 'Passwort vergessen?';
			case 'login.noAccount': return 'Hast du kein Konto?';
			case 'login.createAccount': return 'Ein Konto erstellen';
			case 'register.title': return 'Ein Konto erstellen';
			case 'register.description': return 'Tritt uns bei, um von unseren Dienstleistungen zu profitieren';
			case 'register.conditions': return 'Durch die Erstellung eines Kontos akzeptierst du unsere Nutzungsbedingungen und unsere Datenschutzerklärung';
			case 'register.registerConfirm': return 'Registrierung bestätigt';
			case 'form.emptyUsername': return 'Bitte Benutzername eingeben';
			case 'form.emptyFirstname': return 'Bitte Vorname eingeben';
			case 'form.emptyEmail': return 'Bitte E-Mail-Adresse eingeben';
			case 'form.emptyLastname': return 'Bitte Nachnamen eingeben';
			case 'form.emptyPassword': return 'Bitte Passwort eingeben';
			case 'form.emptyConfirmPassword': return 'Bitte Passwort bestätigen';
			case 'form.passwordMismatch': return 'Die Passwörter stimmen nicht überein';
			case 'form.invalidEmail': return 'Bitte gültige E-Mail-Adresse eingeben';
			case 'form.invalidAddress': return 'Bitte gültige Adresse eingeben';
			case 'form.shortPassword': return 'Das Passwort muss mindestens 8 Zeichen lang sein';
			case 'form.passwordUpperCase': return 'Das Passwort muss mindestens einen Großbuchstaben enthalten';
			case 'form.passwordDigit': return 'Das Passwort muss mindestens eine Zahl enthalten';
			case 'form.passwordSpecialChar': return 'Das Passwort muss mindestens ein Sonderzeichen enthalten';
			case 'form.haveToAcceptConditions': return 'Du musst die Nutzungsbedingungen und die Datenschutzerklärung akzeptieren';
			case 'form.confirmPassword': return 'Passwort bestätigen';
			case 'form.pleaseConfirmPassword': return 'Bitte bestätige dein Passwort';
			case 'form.passwordNotMatch': return 'Die Passwörter stimmen nicht überein';
			case 'form.invalidUsername': return 'Der Benutzername muss:\n- zwischen 3 und 20 Zeichen lang sein\n- mit einem Buchstaben beginnen\n- keine Sonderzeichen enthalten';
			case 'swipe_cards.loading_error': return 'Fehler beim Laden der Ereignisse';
			case 'swipe_cards.end_of_list': return 'Du hast das Ende der Liste erreicht!';
			case 'swipe_cards.nope': return 'Nein zu {{title}}';
			case 'swipe_cards.joined_event': return 'Du hast am Ereignis {{title}} teilgenommen';
			case 'swipe_cards.item_changed': return 'Element geändert: {{title}}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Physisch';
			case 'event.participants': return 'Teilnehmer';
			case 'event.hasJoinEvent': return 'Du hast am Ereignis {{event_title}} teilgenommen';
			case 'event.address_copied': return 'Adresse in die Zwischenablage kopiert';
			case 'event.createEvent': return 'Ereignis erstellen';
			case 'event.name': return 'Name';
			case 'event.description': return 'Beschreibung';
			case 'event.date': return 'Datum';
			case 'event.time': return 'Uhrzeit';
			case 'event.location': return 'Ort';
			case 'event.maxParticipants': return 'Maximale Teilnehmerzahl';
			case 'event.price': return 'Preis';
			case 'event.image': return 'Bild';
			case 'event.create': return 'Erstellen';
			case 'event.enterName': return 'Bitte einen Namen eingeben';
			case 'event.enterDescription': return 'Bitte eine Beschreibung eingeben';
			case 'event.enterDate': return 'Bitte ein Datum eingeben';
			case 'event.enterTime': return 'Bitte eine Uhrzeit eingeben';
			case 'event.enterLocation': return 'Bitte einen Ort eingeben';
			case 'event.enterMaxParticipants': return 'Bitte eine Teilnehmerzahl eingeben';
			case 'event.invalidMaxParticipants': return 'Bitte eine gültige Anzahl eingeben';
			case 'event.enterPrice': return 'Bitte einen Preis eingeben';
			case 'event.invalidPrice': return 'Bitte einen gültigen Preis eingeben';
			case 'event.enterImage': return 'Bitte eine Bild-URL eingeben';
			case 'event.joinEvent': return 'Ereignis beitreten';
			case 'event.eventNotStarted': return 'Der Verbindungslink wird hier verfügbar sein, wenn das Ereignis beginnt.';
			case 'error.details': return 'Fehler: {{error}}';
			case 'error.general': return 'Es ist ein Fehler aufgetreten';
			case 'error.no_results': return 'Keine Ergebnisse gefunden';
			case 'error.no_internet': return 'Keine Internetverbindung';
			case 'error.no_internet_description': return 'Bitte überprüfe deine Internetverbindung und versuche es erneut';
			case 'error.no_events': return 'Keine Ereignisse gefunden';
			case 'error.no_events_description': return 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
			case 'error.no_events_found': return 'Keine Ereignisse gefunden';
			case 'error.no_events_found_description': return 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
			case 'error.no_events_found_title': return 'Keine Ereignisse gefunden';
			case 'error.no_events_found_description_title': return 'Es wurden derzeit keine Ereignisse gefunden. Bitte versuche es später erneut';
			case 'error.no_events_found_description_title_search': return 'Es wurden keine Ereignisse für die durchgeführte Suche gefunden. Bitte versuche es mit einem anderen Begriff erneut';
			case 'error.loadingEvents': return 'Ein Fehler ist beim Laden der Ereignisse aufgetreten';
			case 'error.failedToResetPassword': return 'Zurücksetzen des Passworts fehlgeschlagen';
			case 'auth.forgotPassword': return 'Passwort vergessen?';
			case 'auth.enterEmail': return 'Gib deine E-Mail-Adresse ein, um die Anweisungen zum Zurücksetzen zu erhalten';
			case 'auth.resetPassword': return 'Passwort zurücksetzen';
			case 'auth.enterNewPassword': return 'Gib dein neues Passwort ein';
			case 'auth.resetInstructionsSent': return 'Anweisungen zum Zurücksetzen wurden an deine E-Mail gesendet';
			case 'auth.passwordResertSuccess': return 'Dein Passwort wurde erfolgreich zurückgesetzt';
			case 'verify.title': return 'Codeprüfung';
			case 'verify.description': return 'Gib den zur Verfügung gestellten Bestätigungscode ein';
			case 'verify.inputLabel': return 'Bestätigungscode';
			case 'verify.button': return 'Überprüfen';
			case 'verify.error': return 'Bitte den Bestätigungscode eingeben';
			case 'profile.editProfile': return 'Profil bearbeiten';
			case 'profile.firstname': return 'Vorname';
			case 'profile.lastname': return 'Nachname';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Geburtsdatum';
			case 'profile.address': return 'Adresse';
			case 'profile.save': return 'Speichern';
			case 'profile.cancel': return 'Abbrechen';
			case 'profile.enterFirstname': return 'Bitte Vorname eingeben';
			case 'profile.enterLastname': return 'Bitte Nachnamen eingeben';
			case 'profile.enterEmail': return 'Bitte E-Mail-Adresse eingeben';
			case 'profile.invalidEmail': return 'Bitte gültige E-Mail-Adresse eingeben';
			case 'profile.logout': return 'Ausloggen';
			case 'resources.availableResources': return 'Verfügbare Ressourcen';
			case 'resources.name': return 'Name';
			case 'resources.type': return 'Typ';
			case 'messages.latestMessages': return 'Letzte Nachrichten';
			case 'messages.seeAllMessages': return 'Alle Nachrichten anzeigen';
			case 'messages.noMessages': return 'Keine Nachrichten';
			case 'messages.writeMessageHint': return 'Nachricht schreiben...';
			case 'messages.sendMessage': return 'Nachricht senden';
			case 'common.sender': return 'Absender';
			case 'common.message': return 'Nachricht';
			case 'settings.account': return 'Konto';
			case 'settings.settings': return 'Einstellungen';
			case 'settings.language': return 'Sprache';
			case 'settings.manageSubjects': return 'Fächer verwalten';
			case 'settings.notifications': return 'Benachrichtigungen';
			case 'settings.about': return 'Über';
			case 'settings.contact': return 'Kontakt';
			case 'settings.terms': return 'Nutzungsbedingungen';
			case 'settings.privacy': return 'Datenschutzrichtlinie';
			case 'page.home': return 'Startseite';
			case 'page.homePage': return 'Startseite';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Profilseite';
			case 'page.settings': return 'Einstellungen';
			case 'page.settingsPage': return 'Einstellungsseite';
			case 'page.search': return 'Suche';
			case 'page.searchPage': return 'Suchseite';
			case 'page.sheet': return 'Blatt';
			case 'page.sheetPage': return 'Blattseite';
			case 'page.subject': return 'Fach';
			case 'page.subjectPage': return 'Fachseite';
			case 'page.topic': return 'Thema';
			case 'page.topicPage': return 'Themenseite';
			case 'page.event': return 'Ereignis';
			case 'page.eventPage': return 'Ereignisseite';
			case 'page.user': return 'Benutzer';
			case 'page.userPage': return 'Benutzseite';
			case 'page.about': return 'Über';
			case 'page.aboutPage': return 'Über-Seite';
			case 'page.contact': return 'Kontakt';
			case 'page.contactPage': return 'Kontaktseite';
			case 'page.terms': return 'Nutzungsbedingungen';
			case 'page.termsPage': return 'Seite der Nutzungsbedingungen';
			case 'page.privacy': return 'Datenschutzrichtlinie';
			case 'page.privacyPage': return 'Seite der Datenschutzrichtlinie';
			case 'page.notifications': return 'Benachrichtigungen';
			case 'page.events': return 'Ereignisse';
			case 'page.sheets': return 'Blätter';
			case 'page.subjects': return 'Fächer';
			case 'page.topics': return 'Themen';
			case 'page.users': return 'Benutzer';
			case 'page.help': return 'Hilfe';
			case 'page.helpPage': return 'Hilfe-Seite';
			default: return null;
		}
	}
}


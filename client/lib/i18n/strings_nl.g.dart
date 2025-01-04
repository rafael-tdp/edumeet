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
class TranslationsNl implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsNl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.nl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <nl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsNl _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppNl app = _TranslationsAppNl._(_root);
	@override late final _TranslationsUserNl user = _TranslationsUserNl._(_root);
	@override late final _TranslationsWelcomeNl welcome = _TranslationsWelcomeNl._(_root);
	@override late final _TranslationsLoginNl login = _TranslationsLoginNl._(_root);
	@override late final _TranslationsRegisterNl register = _TranslationsRegisterNl._(_root);
	@override late final _TranslationsFormNl form = _TranslationsFormNl._(_root);
	@override late final _TranslationsSwipeCardsNl swipe_cards = _TranslationsSwipeCardsNl._(_root);
	@override late final _TranslationsEventNl event = _TranslationsEventNl._(_root);
	@override late final _TranslationsErrorNl error = _TranslationsErrorNl._(_root);
	@override late final _TranslationsAuthNl auth = _TranslationsAuthNl._(_root);
	@override late final _TranslationsVerifyNl verify = _TranslationsVerifyNl._(_root);
	@override late final _TranslationsProfileNl profile = _TranslationsProfileNl._(_root);
	@override late final _TranslationsResourcesNl resources = _TranslationsResourcesNl._(_root);
	@override late final _TranslationsMessagesNl messages = _TranslationsMessagesNl._(_root);
	@override late final _TranslationsCommonNl common = _TranslationsCommonNl._(_root);
	@override late final _TranslationsSettingsNl settings = _TranslationsSettingsNl._(_root);
	@override late final _TranslationsPageNl page = _TranslationsPageNl._(_root);
}

// Path: app
class _TranslationsAppNl implements TranslationsAppEn {
	_TranslationsAppNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get login => 'Inloggen';
	@override String get signup => 'Aanmelden';
	@override String get logout => 'Uitloggen';
	@override String get search => 'Zoeken';
	@override String get searchLanguage => 'Zoek een taal';
	@override String get add => 'Toevoegen';
	@override String get edit => 'Bewerken';
	@override String get delete => 'Verwijderen';
	@override String get cancel => 'Annuleren';
	@override String get save => 'Opslaan';
	@override String get yes => 'Ja';
	@override String get no => 'Nee';
	@override String get confirm => 'Bevestigen';
	@override String get error => 'Fout';
	@override String get loading => 'Laden...';
	@override String get noResults => 'Geen resultaten';
	@override String get noResultsFound => 'Geen resultaten gevonden';
	@override String get skip => 'Overslaan';
	@override String get next => 'Volgende';
	@override String get previous => 'Vorige';
	@override String get finish => 'Voltooi';
	@override String get back => 'Terug';
	@override String get submit => 'Indienen';
	@override String get searchUser => 'Zoek een gebruiker';
	@override String get searchSubject => 'Zoek een vak';
	@override String get searchTopic => 'Zoek een onderwerp';
	@override String get searchSheet => 'Zoek een fiche';
	@override String get alreadyHaveAccount => 'Heb je al een account?';
	@override String get loadingIndicator => 'Laden...';
	@override String get errorOccurred => 'Er is een fout opgetreden';
	@override String get backTo => 'Terug naar ';
	@override String get unknown => 'Onbekend';
}

// Path: user
class _TranslationsUserNl implements TranslationsUserEn {
	_TranslationsUserNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get email => 'E-mail';
	@override String get username => 'Gebruikersnaam';
	@override String get name => 'Naam';
	@override String get firstname => 'Voornaam';
	@override String get birthdate => 'Geboortedatum';
	@override String get location => 'Locatie';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Aantal meldingen';
	@override String get address => 'Adres';
	@override String get password => 'Wachtwoord';
	@override String get newPassword => 'Nieuw wachtwoord';
	@override String get anonymous => 'Anoniem';
	@override String get noDescription => 'Geen beschrijving';
	@override String get noAddress => 'Adres niet beschikbaar';
	@override String get noReportsAvailable => 'Aantal meldingen niet beschikbaar';
}

// Path: welcome
class _TranslationsWelcomeNl implements TranslationsWelcomeEn {
	_TranslationsWelcomeNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Welkom bij Edumeet, het platform voor samenwerkingsstudie';
	@override String get setup => 'Laten we beginnen met het kiezen van een taal';
	@override String get whatLanguage => 'Welke taal spreek je?';
	@override String get chooseLanguage => 'Kies een taal zodat we samen kunnen communiceren';
	@override String get title1 => 'Vind je studiefiches';
	@override String get description1 => 'Toegang tot duizenden studiefiches die door studenten zijn gemaakt';
	@override String get title2 => 'Organiseer je studies';
	@override String get description2 => 'Categoriseer en organiseer je fiches voor effectieve onthouding';
	@override String get title3 => 'Blijf gemotiveerd';
	@override String get description3 => 'Bereik je doelen met praktische tips';
	@override String get title4 => 'Word lid van onze gemeenschap';
	@override String get description4 => 'Deel je studiefiches en ontvang persoonlijke adviezen';
}

// Path: login
class _TranslationsLoginNl implements TranslationsLoginEn {
	_TranslationsLoginNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aanmelding';
	@override String get description => 'Voer hieronder je gegevens in om in te loggen';
	@override String get forgotPassword => 'Wachtwoord vergeten?';
	@override String get noAccount => 'Heb je geen account?';
	@override String get createAccount => 'Maak een account aan';
}

// Path: register
class _TranslationsRegisterNl implements TranslationsRegisterEn {
	_TranslationsRegisterNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account aanmaken';
	@override String get description => 'Sluit je bij ons aan om gebruik te maken van onze diensten';
	@override String get conditions => 'Door een account aan te maken, ga je akkoord met onze Gebruiksvoorwaarden en Privacybeleid';
	@override String get registerConfirm => 'Aanmelding bevestigd';
}

// Path: form
class _TranslationsFormNl implements TranslationsFormEn {
	_TranslationsFormNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Voer een gebruikersnaam in';
	@override String get emptyFirstname => 'Voer je voornaam in';
	@override String get emptyEmail => 'Voer je e-mailadres in';
	@override String get emptyLastname => 'Voer je naam in';
	@override String get emptyPassword => 'Voer je wachtwoord in';
	@override String get emptyConfirmPassword => 'Bevestig je wachtwoord';
	@override String get passwordMismatch => 'Wachtwoorden komen niet overeen';
	@override String get invalidEmail => 'Voer een geldig e-mailadres in';
	@override String get invalidAddress => 'Voer een geldig adres in';
	@override String get shortPassword => 'Het wachtwoord moet minstens 8 tekens bevatten';
	@override String get passwordUpperCase => 'Het wachtwoord moet minstens één hoofdletter bevatten';
	@override String get passwordDigit => 'Het wachtwoord moet minstens één cijfer bevatten';
	@override String get passwordSpecialChar => 'Het wachtwoord moet minstens één speciaal teken bevatten';
	@override String get haveToAcceptConditions => 'Je moet de gebruiksvoorwaarden en het privacybeleid accepteren';
	@override String get confirmPassword => 'Bevestig het wachtwoord';
	@override String get pleaseConfirmPassword => 'Bevestig je wachtwoord';
	@override String get passwordNotMatch => 'Wachtwoorden komen niet overeen';
	@override String get invalidUsername => 'De gebruikersnaam moet: \n- tussen de 3 en 20 tekens bevatten \n- beginnen met een letter \n- geen speciale tekens bevatten';
}

// Path: swipe_cards
class _TranslationsSwipeCardsNl implements TranslationsSwipeCardsEn {
	_TranslationsSwipeCardsNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Fout bij het laden van de evenementen';
	@override String get end_of_list => 'Je hebt het einde van de lijst bereikt!';
	@override String get nope => 'Nee tegen {{title}}';
	@override String get joined_event => 'Je hebt je bij het evenement {{title}} gevoegd';
	@override String get item_changed => 'Item gewijzigd: {{title}}';
}

// Path: event
class _TranslationsEventNl implements TranslationsEventEn {
	_TranslationsEventNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fysiek';
	@override String get participants => 'Deelnemers';
	@override String get hasJoinEvent => 'Je hebt je bij het evenement {{event_title}} gevoegd';
	@override String get address_copied => 'Adres gekopieerd naar het klembord';
	@override String get createEvent => 'Maak een evenement';
	@override String get name => 'Naam';
	@override String get description => 'Beschrijving';
	@override String get date => 'Datum';
	@override String get time => 'Tijd';
	@override String get location => 'Locatie';
	@override String get maxParticipants => 'Maximaal aantal deelnemers';
	@override String get price => 'Prijs';
	@override String get image => 'Afbeelding';
	@override String get create => 'Aanmaken';
	@override String get enterName => 'Voer een naam in';
	@override String get enterDescription => 'Voer een beschrijving in';
	@override String get enterDate => 'Voer een datum in';
	@override String get enterTime => 'Voer een tijd in';
	@override String get enterLocation => 'Voer een locatie in';
	@override String get enterMaxParticipants => 'Voer een maximaal aantal deelnemers in';
	@override String get invalidMaxParticipants => 'Voer een geldig aantal in';
	@override String get enterPrice => 'Voer een prijs in';
	@override String get invalidPrice => 'Voer een geldige prijs in';
	@override String get enterImage => 'Voer een afbeelding-URL in';
	@override String get joinEvent => 'Deelnemen aan het evenement';
	@override String get eventNotStarted => 'De inloglink zal hier beschikbaar zijn wanneer het evenement begint.';
}

// Path: error
class _TranslationsErrorNl implements TranslationsErrorEn {
	_TranslationsErrorNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get details => 'Fout: {{error}}';
	@override String get general => 'Er is een fout opgetreden';
	@override String get no_results => 'Geen resultaten gevonden';
	@override String get no_internet => 'Geen internetverbinding';
	@override String get no_internet_description => 'Controleer je internetverbinding en probeer het opnieuw';
	@override String get no_events => 'Geen evenementen gevonden';
	@override String get no_events_description => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found => 'Geen evenementen gevonden';
	@override String get no_events_found_description => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found_title => 'Geen evenementen gevonden';
	@override String get no_events_found_description_title => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found_description_title_search => 'Er zijn geen evenementen gevonden voor de uitgevoerde zoekopdracht. Probeer het opnieuw met een andere zoekterm';
	@override String get loadingEvents => 'Er is een fout opgetreden bij het laden van de evenementen';
	@override String get failedToResetPassword => 'Wachtwoordreset is mislukt';
}

// Path: auth
class _TranslationsAuthNl implements TranslationsAuthEn {
	_TranslationsAuthNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Wachtwoord vergeten?';
	@override String get enterEmail => 'Voer je e-mailadres in om instructies voor reset te ontvangen';
	@override String get resetPassword => 'Wachtwoord resetten';
	@override String get enterNewPassword => 'Voer je nieuwe wachtwoord in';
	@override String get resetInstructionsSent => 'Instructies voor reset zijn naar je e-mail gestuurd';
	@override String get passwordResertSuccess => 'Je wachtwoord is succesvol gereset';
}

// Path: verify
class _TranslationsVerifyNl implements TranslationsVerifyEn {
	_TranslationsVerifyNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verificatiecode';
	@override String get description => 'Voer de verificatiecode in die naar je e-mail is gestuurd';
	@override String get inputLabel => 'Verificatiecode';
	@override String get button => 'Verifiëren';
	@override String get error => 'Voer de verificatiecode in';
}

// Path: profile
class _TranslationsProfileNl implements TranslationsProfileEn {
	_TranslationsProfileNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Mijn profiel bewerken';
	@override String get firstname => 'Voornaam';
	@override String get lastname => 'Achternaam';
	@override String get bio => 'Bio';
	@override String get email => 'E-mail';
	@override String get birthdate => 'Geboortedatum';
	@override String get address => 'Adres';
	@override String get save => 'Opslaan';
	@override String get cancel => 'Annuleren';
	@override String get enterFirstname => 'Voer je voornaam in';
	@override String get enterLastname => 'Voer je achternaam in';
	@override String get enterEmail => 'Voer je e-mailadres in';
	@override String get invalidEmail => 'Voer een geldig e-mailadres in';
	@override String get logout => 'Uitloggen';
}

// Path: resources
class _TranslationsResourcesNl implements TranslationsResourcesEn {
	_TranslationsResourcesNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Beschikbare bronnen';
	@override String get name => 'Naam';
	@override String get type => 'Type';
}

// Path: messages
class _TranslationsMessagesNl implements TranslationsMessagesEn {
	_TranslationsMessagesNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Laatste berichten';
	@override String get seeAllMessages => 'Bekijk alle berichten';
	@override String get noMessages => 'Geen berichten';
	@override String get writeMessageHint => 'Schrijf een bericht...';
	@override String get sendMessage => 'Verstuur';
}

// Path: common
class _TranslationsCommonNl implements TranslationsCommonEn {
	_TranslationsCommonNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Afzender';
	@override String get message => 'Bericht';
}

// Path: settings
class _TranslationsSettingsNl implements TranslationsSettingsEn {
	_TranslationsSettingsNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get account => 'Account';
	@override String get settings => 'Instellingen';
	@override String get language => 'Taal';
	@override String get manageSubjects => 'Beheer vakken';
	@override String get notifications => 'Meldingen';
	@override String get about => 'Over';
	@override String get contact => 'Contact';
	@override String get terms => 'Voorwaarden';
	@override String get privacy => 'Privacybeleid';
}

// Path: page
class _TranslationsPageNl implements TranslationsPageEn {
	_TranslationsPageNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get home => 'Startpagina';
	@override String get homePage => 'Startpagina';
	@override String get profile => 'Profiel';
	@override String get profilePage => 'Profielpagina';
	@override String get settings => 'Instellingen';
	@override String get settingsPage => 'Instellingenpagina';
	@override String get search => 'Zoeken';
	@override String get searchPage => 'Zoekpagina';
	@override String get sheet => 'Fiche';
	@override String get sheetPage => 'Fichepagina';
	@override String get subject => 'Vak';
	@override String get subjectPage => 'Vakpagina';
	@override String get topic => 'Onderwerp';
	@override String get topicPage => 'Onderwerp pagina';
	@override String get event => 'Evenement';
	@override String get eventPage => 'Evenement pagina';
	@override String get user => 'Gebruiker';
	@override String get userPage => 'Gebruikerspagina';
	@override String get about => 'Over';
	@override String get aboutPage => 'Over pagina';
	@override String get contact => 'Contact';
	@override String get contactPage => 'Contactpagina';
	@override String get terms => 'Gebruiksvoorwaarden';
	@override String get termsPage => 'Pagina van de gebruiksvoorwaarden';
	@override String get privacy => 'Privacybeleid';
	@override String get privacyPage => 'Privacybeleid pagina';
	@override String get notifications => 'Meldingen';
	@override String get events => 'Evenementen';
	@override String get sheets => 'Fiches';
	@override String get subjects => 'Vakken';
	@override String get topics => 'Onderwerpen';
	@override String get users => 'Gebruikers';
	@override String get help => 'Hulp';
	@override String get helpPage => 'Hulp pagina';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsNl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Inloggen';
			case 'app.signup': return 'Aanmelden';
			case 'app.logout': return 'Uitloggen';
			case 'app.search': return 'Zoeken';
			case 'app.searchLanguage': return 'Zoek een taal';
			case 'app.add': return 'Toevoegen';
			case 'app.edit': return 'Bewerken';
			case 'app.delete': return 'Verwijderen';
			case 'app.cancel': return 'Annuleren';
			case 'app.save': return 'Opslaan';
			case 'app.yes': return 'Ja';
			case 'app.no': return 'Nee';
			case 'app.confirm': return 'Bevestigen';
			case 'app.error': return 'Fout';
			case 'app.loading': return 'Laden...';
			case 'app.noResults': return 'Geen resultaten';
			case 'app.noResultsFound': return 'Geen resultaten gevonden';
			case 'app.skip': return 'Overslaan';
			case 'app.next': return 'Volgende';
			case 'app.previous': return 'Vorige';
			case 'app.finish': return 'Voltooi';
			case 'app.back': return 'Terug';
			case 'app.submit': return 'Indienen';
			case 'app.searchUser': return 'Zoek een gebruiker';
			case 'app.searchSubject': return 'Zoek een vak';
			case 'app.searchTopic': return 'Zoek een onderwerp';
			case 'app.searchSheet': return 'Zoek een fiche';
			case 'app.alreadyHaveAccount': return 'Heb je al een account?';
			case 'app.loadingIndicator': return 'Laden...';
			case 'app.errorOccurred': return 'Er is een fout opgetreden';
			case 'app.backTo': return 'Terug naar ';
			case 'app.unknown': return 'Onbekend';
			case 'user.email': return 'E-mail';
			case 'user.username': return 'Gebruikersnaam';
			case 'user.name': return 'Naam';
			case 'user.firstname': return 'Voornaam';
			case 'user.birthdate': return 'Geboortedatum';
			case 'user.location': return 'Locatie';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Aantal meldingen';
			case 'user.address': return 'Adres';
			case 'user.password': return 'Wachtwoord';
			case 'user.newPassword': return 'Nieuw wachtwoord';
			case 'user.anonymous': return 'Anoniem';
			case 'user.noDescription': return 'Geen beschrijving';
			case 'user.noAddress': return 'Adres niet beschikbaar';
			case 'user.noReportsAvailable': return 'Aantal meldingen niet beschikbaar';
			case 'welcome.welcome': return 'Welkom bij Edumeet, het platform voor samenwerkingsstudie';
			case 'welcome.setup': return 'Laten we beginnen met het kiezen van een taal';
			case 'welcome.whatLanguage': return 'Welke taal spreek je?';
			case 'welcome.chooseLanguage': return 'Kies een taal zodat we samen kunnen communiceren';
			case 'welcome.title1': return 'Vind je studiefiches';
			case 'welcome.description1': return 'Toegang tot duizenden studiefiches die door studenten zijn gemaakt';
			case 'welcome.title2': return 'Organiseer je studies';
			case 'welcome.description2': return 'Categoriseer en organiseer je fiches voor effectieve onthouding';
			case 'welcome.title3': return 'Blijf gemotiveerd';
			case 'welcome.description3': return 'Bereik je doelen met praktische tips';
			case 'welcome.title4': return 'Word lid van onze gemeenschap';
			case 'welcome.description4': return 'Deel je studiefiches en ontvang persoonlijke adviezen';
			case 'login.title': return 'Aanmelding';
			case 'login.description': return 'Voer hieronder je gegevens in om in te loggen';
			case 'login.forgotPassword': return 'Wachtwoord vergeten?';
			case 'login.noAccount': return 'Heb je geen account?';
			case 'login.createAccount': return 'Maak een account aan';
			case 'register.title': return 'Account aanmaken';
			case 'register.description': return 'Sluit je bij ons aan om gebruik te maken van onze diensten';
			case 'register.conditions': return 'Door een account aan te maken, ga je akkoord met onze Gebruiksvoorwaarden en Privacybeleid';
			case 'register.registerConfirm': return 'Aanmelding bevestigd';
			case 'form.emptyUsername': return 'Voer een gebruikersnaam in';
			case 'form.emptyFirstname': return 'Voer je voornaam in';
			case 'form.emptyEmail': return 'Voer je e-mailadres in';
			case 'form.emptyLastname': return 'Voer je naam in';
			case 'form.emptyPassword': return 'Voer je wachtwoord in';
			case 'form.emptyConfirmPassword': return 'Bevestig je wachtwoord';
			case 'form.passwordMismatch': return 'Wachtwoorden komen niet overeen';
			case 'form.invalidEmail': return 'Voer een geldig e-mailadres in';
			case 'form.invalidAddress': return 'Voer een geldig adres in';
			case 'form.shortPassword': return 'Het wachtwoord moet minstens 8 tekens bevatten';
			case 'form.passwordUpperCase': return 'Het wachtwoord moet minstens één hoofdletter bevatten';
			case 'form.passwordDigit': return 'Het wachtwoord moet minstens één cijfer bevatten';
			case 'form.passwordSpecialChar': return 'Het wachtwoord moet minstens één speciaal teken bevatten';
			case 'form.haveToAcceptConditions': return 'Je moet de gebruiksvoorwaarden en het privacybeleid accepteren';
			case 'form.confirmPassword': return 'Bevestig het wachtwoord';
			case 'form.pleaseConfirmPassword': return 'Bevestig je wachtwoord';
			case 'form.passwordNotMatch': return 'Wachtwoorden komen niet overeen';
			case 'form.invalidUsername': return 'De gebruikersnaam moet: \n- tussen de 3 en 20 tekens bevatten \n- beginnen met een letter \n- geen speciale tekens bevatten';
			case 'swipe_cards.loading_error': return 'Fout bij het laden van de evenementen';
			case 'swipe_cards.end_of_list': return 'Je hebt het einde van de lijst bereikt!';
			case 'swipe_cards.nope': return 'Nee tegen {{title}}';
			case 'swipe_cards.joined_event': return 'Je hebt je bij het evenement {{title}} gevoegd';
			case 'swipe_cards.item_changed': return 'Item gewijzigd: {{title}}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fysiek';
			case 'event.participants': return 'Deelnemers';
			case 'event.hasJoinEvent': return 'Je hebt je bij het evenement {{event_title}} gevoegd';
			case 'event.address_copied': return 'Adres gekopieerd naar het klembord';
			case 'event.createEvent': return 'Maak een evenement';
			case 'event.name': return 'Naam';
			case 'event.description': return 'Beschrijving';
			case 'event.date': return 'Datum';
			case 'event.time': return 'Tijd';
			case 'event.location': return 'Locatie';
			case 'event.maxParticipants': return 'Maximaal aantal deelnemers';
			case 'event.price': return 'Prijs';
			case 'event.image': return 'Afbeelding';
			case 'event.create': return 'Aanmaken';
			case 'event.enterName': return 'Voer een naam in';
			case 'event.enterDescription': return 'Voer een beschrijving in';
			case 'event.enterDate': return 'Voer een datum in';
			case 'event.enterTime': return 'Voer een tijd in';
			case 'event.enterLocation': return 'Voer een locatie in';
			case 'event.enterMaxParticipants': return 'Voer een maximaal aantal deelnemers in';
			case 'event.invalidMaxParticipants': return 'Voer een geldig aantal in';
			case 'event.enterPrice': return 'Voer een prijs in';
			case 'event.invalidPrice': return 'Voer een geldige prijs in';
			case 'event.enterImage': return 'Voer een afbeelding-URL in';
			case 'event.joinEvent': return 'Deelnemen aan het evenement';
			case 'event.eventNotStarted': return 'De inloglink zal hier beschikbaar zijn wanneer het evenement begint.';
			case 'error.details': return 'Fout: {{error}}';
			case 'error.general': return 'Er is een fout opgetreden';
			case 'error.no_results': return 'Geen resultaten gevonden';
			case 'error.no_internet': return 'Geen internetverbinding';
			case 'error.no_internet_description': return 'Controleer je internetverbinding en probeer het opnieuw';
			case 'error.no_events': return 'Geen evenementen gevonden';
			case 'error.no_events_description': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found': return 'Geen evenementen gevonden';
			case 'error.no_events_found_description': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found_title': return 'Geen evenementen gevonden';
			case 'error.no_events_found_description_title': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found_description_title_search': return 'Er zijn geen evenementen gevonden voor de uitgevoerde zoekopdracht. Probeer het opnieuw met een andere zoekterm';
			case 'error.loadingEvents': return 'Er is een fout opgetreden bij het laden van de evenementen';
			case 'error.failedToResetPassword': return 'Wachtwoordreset is mislukt';
			case 'auth.forgotPassword': return 'Wachtwoord vergeten?';
			case 'auth.enterEmail': return 'Voer je e-mailadres in om instructies voor reset te ontvangen';
			case 'auth.resetPassword': return 'Wachtwoord resetten';
			case 'auth.enterNewPassword': return 'Voer je nieuwe wachtwoord in';
			case 'auth.resetInstructionsSent': return 'Instructies voor reset zijn naar je e-mail gestuurd';
			case 'auth.passwordResertSuccess': return 'Je wachtwoord is succesvol gereset';
			case 'verify.title': return 'Verificatiecode';
			case 'verify.description': return 'Voer de verificatiecode in die naar je e-mail is gestuurd';
			case 'verify.inputLabel': return 'Verificatiecode';
			case 'verify.button': return 'Verifiëren';
			case 'verify.error': return 'Voer de verificatiecode in';
			case 'profile.editProfile': return 'Mijn profiel bewerken';
			case 'profile.firstname': return 'Voornaam';
			case 'profile.lastname': return 'Achternaam';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'E-mail';
			case 'profile.birthdate': return 'Geboortedatum';
			case 'profile.address': return 'Adres';
			case 'profile.save': return 'Opslaan';
			case 'profile.cancel': return 'Annuleren';
			case 'profile.enterFirstname': return 'Voer je voornaam in';
			case 'profile.enterLastname': return 'Voer je achternaam in';
			case 'profile.enterEmail': return 'Voer je e-mailadres in';
			case 'profile.invalidEmail': return 'Voer een geldig e-mailadres in';
			case 'profile.logout': return 'Uitloggen';
			case 'resources.availableResources': return 'Beschikbare bronnen';
			case 'resources.name': return 'Naam';
			case 'resources.type': return 'Type';
			case 'messages.latestMessages': return 'Laatste berichten';
			case 'messages.seeAllMessages': return 'Bekijk alle berichten';
			case 'messages.noMessages': return 'Geen berichten';
			case 'messages.writeMessageHint': return 'Schrijf een bericht...';
			case 'messages.sendMessage': return 'Verstuur';
			case 'common.sender': return 'Afzender';
			case 'common.message': return 'Bericht';
			case 'settings.account': return 'Account';
			case 'settings.settings': return 'Instellingen';
			case 'settings.language': return 'Taal';
			case 'settings.manageSubjects': return 'Beheer vakken';
			case 'settings.notifications': return 'Meldingen';
			case 'settings.about': return 'Over';
			case 'settings.contact': return 'Contact';
			case 'settings.terms': return 'Voorwaarden';
			case 'settings.privacy': return 'Privacybeleid';
			case 'page.home': return 'Startpagina';
			case 'page.homePage': return 'Startpagina';
			case 'page.profile': return 'Profiel';
			case 'page.profilePage': return 'Profielpagina';
			case 'page.settings': return 'Instellingen';
			case 'page.settingsPage': return 'Instellingenpagina';
			case 'page.search': return 'Zoeken';
			case 'page.searchPage': return 'Zoekpagina';
			case 'page.sheet': return 'Fiche';
			case 'page.sheetPage': return 'Fichepagina';
			case 'page.subject': return 'Vak';
			case 'page.subjectPage': return 'Vakpagina';
			case 'page.topic': return 'Onderwerp';
			case 'page.topicPage': return 'Onderwerp pagina';
			case 'page.event': return 'Evenement';
			case 'page.eventPage': return 'Evenement pagina';
			case 'page.user': return 'Gebruiker';
			case 'page.userPage': return 'Gebruikerspagina';
			case 'page.about': return 'Over';
			case 'page.aboutPage': return 'Over pagina';
			case 'page.contact': return 'Contact';
			case 'page.contactPage': return 'Contactpagina';
			case 'page.terms': return 'Gebruiksvoorwaarden';
			case 'page.termsPage': return 'Pagina van de gebruiksvoorwaarden';
			case 'page.privacy': return 'Privacybeleid';
			case 'page.privacyPage': return 'Privacybeleid pagina';
			case 'page.notifications': return 'Meldingen';
			case 'page.events': return 'Evenementen';
			case 'page.sheets': return 'Fiches';
			case 'page.subjects': return 'Vakken';
			case 'page.topics': return 'Onderwerpen';
			case 'page.users': return 'Gebruikers';
			case 'page.help': return 'Hulp';
			case 'page.helpPage': return 'Hulp pagina';
			default: return null;
		}
	}
}


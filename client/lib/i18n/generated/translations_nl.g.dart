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
	@override late final _TranslationsPageNl page = _TranslationsPageNl._(_root);
}

// Path: app
class _TranslationsAppNl implements TranslationsAppFr {
	_TranslationsAppNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get login => 'Inloggen';
	@override String get signup => 'Aanmelden';
	@override String get logout => 'Afmelden';
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
	@override String get finish => 'Voltooien';
	@override String get back => 'Terug';
	@override String get submit => 'Verzenden';
	@override String get searchUser => 'Zoek een gebruiker';
	@override String get searchSubject => 'Zoek een vak';
	@override String get searchTopic => 'Zoek een onderwerp';
	@override String get searchSheet => 'Zoek een blad';
	@override String get alreadyHaveAccount => 'Heeft u al een account?';
	@override String get loadingIndicator => 'Laden...';
	@override String get errorOccurred => 'Er is een fout opgetreden';
	@override String get backTo => 'Terug naar ';
}

// Path: user
class _TranslationsUserNl implements TranslationsUserFr {
	_TranslationsUserNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
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
class _TranslationsWelcomeNl implements TranslationsWelcomeFr {
	_TranslationsWelcomeNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Welkom bij Edumeet, het samenwerkende studieplatform';
	@override String get setup => 'Laten we beginnen met het kiezen van een taal';
	@override String get whatLanguage => 'Welke taal spreek je?';
	@override String get chooseLanguage => 'Kies een taal zodat we samen kunnen communiceren';
	@override String get title1 => 'Vind je studiematerialen';
	@override String get description1 => 'Toegang tot duizenden \ngestudeerde materialen gemaakt door studenten, gratis';
	@override String get title2 => 'Organiseer je studie';
	@override String get description2 => 'Sorteer en organiseer je materialen voor een \neffectief geheugen';
	@override String get title3 => 'Blijf gemotiveerd';
	@override String get description3 => 'Bereik je doelen met praktische \ntips';
	@override String get title4 => 'Word lid van onze gemeenschap';
	@override String get description4 => 'Deel je studiematerialen en \nontvang persoonlijke tips';
}

// Path: login
class _TranslationsLoginNl implements TranslationsLoginFr {
	_TranslationsLoginNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inloggen';
	@override String get description => 'Voer onderstaande informatie in om in te loggen';
	@override String get forgotPassword => 'Wachtwoord vergeten?';
	@override String get noAccount => 'Heeft u geen account?';
	@override String get createAccount => 'Maak een account aan';
}

// Path: register
class _TranslationsRegisterNl implements TranslationsRegisterFr {
	_TranslationsRegisterNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account aanmaken';
	@override String get description => 'Sluit je bij ons aan om van onze diensten te profiteren';
	@override String get conditions => 'Door een account aan te maken, accepteert u onze Gebruiksvoorwaarden en Privacybeleid';
	@override String get registerConfirm => 'Registratie bevestigd';
}

// Path: form
class _TranslationsFormNl implements TranslationsFormFr {
	_TranslationsFormNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Voer een gebruikersnaam in';
	@override String get emptyFirstname => 'Voer uw voornaam in';
	@override String get emptyEmail => 'Voer uw e-mailadres in';
	@override String get emptyLastname => 'Voer uw achternaam in';
	@override String get emptyPassword => 'Voer uw wachtwoord in';
	@override String get emptyConfirmPassword => 'Bevestig uw wachtwoord';
	@override String get passwordMismatch => 'De wachtwoorden komen niet overeen';
	@override String get invalidEmail => 'Voer een geldig e-mailadres in';
	@override String get invalidAddress => 'Voer een geldig adres in';
	@override String get shortPassword => 'Het wachtwoord moet minimaal 8 tekens bevatten';
	@override String get passwordUpperCase => 'Het wachtwoord moet minstens één hoofdletter bevatten';
	@override String get passwordDigit => 'Het wachtwoord moet minstens één cijfer bevatten';
	@override String get passwordSpecialChar => 'Het wachtwoord moet minstens één speciaal teken bevatten';
	@override String get haveToAcceptConditions => 'U moet de gebruiksvoorwaarden en het privacybeleid accepteren';
	@override String get confirmPassword => 'Bevestig wachtwoord';
	@override String get pleaseConfirmPassword => 'Bevestig uw wachtwoord';
	@override String get passwordNotMatch => 'De wachtwoorden komen niet overeen';
}

// Path: swipe_cards
class _TranslationsSwipeCardsNl implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Fout bij het laden van evenementen';
	@override String get end_of_list => 'U heeft het einde van de lijst bereikt!';
	@override String nope({required Object title}) => 'Nee tegen ${title}';
	@override String joined_event({required Object title}) => 'Je hebt je bij het evenement ${title} gevoegd';
	@override String item_changed({required Object title}) => 'Item gewijzigd: ${title}';
}

// Path: event
class _TranslationsEventNl implements TranslationsEventFr {
	_TranslationsEventNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fysiek';
	@override String get participants => 'Deelnemers';
	@override String hasJoinEvent({required Object event_title}) => 'U heeft zich aangemeld voor het evenement ${event_title}';
	@override String get address_copied => 'Adres gekopieerd naar het klembord';
	@override String get createEvent => 'Evenement aanmaken';
	@override String get name => 'Naam';
	@override String get description => 'Beschrijving';
	@override String get date => 'Datum';
	@override String get time => 'Tijd';
	@override String get location => 'Locatie';
	@override String get maxParticipants => 'Aantal deelnemers';
	@override String get price => 'Prijs';
	@override String get image => 'Afbeelding';
	@override String get create => 'Aanmaken';
	@override String get enterName => 'Voer een naam in';
	@override String get enterDescription => 'Voer een beschrijving in';
	@override String get enterDate => 'Voer een datum in';
	@override String get enterTime => 'Voer een tijd in';
	@override String get enterLocation => 'Voer een locatie in';
	@override String get enterMaxParticipants => 'Voer een aantal deelnemers in';
	@override String get invalidMaxParticipants => 'Voer een geldig aantal in';
	@override String get enterPrice => 'Voer een prijs in';
	@override String get invalidPrice => 'Voer een geldige prijs in';
	@override String get enterImage => 'Voer een afbeelding URL in';
	@override String get joinEvent => 'Nodig evenement';
	@override String get eventNotStarted => 'De verbindingslink zal hier beschikbaar zijn wanneer het evenement begint.';
}

// Path: error
class _TranslationsErrorNl implements TranslationsErrorFr {
	_TranslationsErrorNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Fout: ${error}';
	@override String get no_internet => 'Geen internetverbinding';
	@override String get no_internet_description => 'Controleer je internetverbinding en probeer het opnieuw';
	@override String get no_events => 'Geen evenementen gevonden';
	@override String get no_events_description => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found => 'Geen evenementen gevonden';
	@override String get no_events_found_description => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found_title => 'Geen evenementen gevonden';
	@override String get no_events_found_description_title => 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
	@override String get no_events_found_description_title_search => 'Er zijn geen evenementen gevonden voor de uitgevoerde zoekopdracht. Probeer het met een andere term opnieuw';
	@override String get loadingEvents => 'Er is een fout opgetreden tijdens het laden van de evenementen';
	@override String get failedToResetPassword => 'Wachtwoord resetten is mislukt';
}

// Path: auth
class _TranslationsAuthNl implements TranslationsAuthFr {
	_TranslationsAuthNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Wachtwoord vergeten?';
	@override String get enterEmail => 'Voer uw e-mailadres in om de instructies voor het opnieuw instellen te ontvangen';
	@override String get resetPassword => 'Wachtwoord opnieuw instellen';
	@override String get enterNewPassword => 'Voer uw nieuwe wachtwoord in';
	@override String get resetInstructionsSent => 'Instructies voor het opnieuw instellen zijn naar uw e-mail verzonden';
	@override String get passwordResertSuccess => 'Uw wachtwoord is succesvol opnieuw ingesteld';
}

// Path: verify
class _TranslationsVerifyNl implements TranslationsVerifyFr {
	_TranslationsVerifyNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Code verificatie';
	@override String get description => 'Voer de verificatiecode in die naar uw e-mail is gestuurd';
	@override String get inputLabel => 'Verificatiecode';
	@override String get button => 'Controleren';
	@override String get error => 'Voer de verificatiecode in';
}

// Path: profile
class _TranslationsProfileNl implements TranslationsProfileFr {
	_TranslationsProfileNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Bewerk mijn profiel';
	@override String get firstname => 'Voornaam';
	@override String get lastname => 'Achternaam';
	@override String get bio => 'Bio';
	@override String get email => 'E-mail';
	@override String get birthdate => 'Geboortedatum';
	@override String get address => 'Adres';
	@override String get save => 'Opslaan';
	@override String get cancel => 'Annuleren';
	@override String get enterFirstname => 'Voer uw voornaam in';
	@override String get enterLastname => 'Voer uw achternaam in';
	@override String get enterEmail => 'Voer uw e-mailadres in';
	@override String get invalidEmail => 'Voer een geldig e-mailadres in';
	@override String get logout => 'Uitloggen';
}

// Path: resources
class _TranslationsResourcesNl implements TranslationsResourcesFr {
	_TranslationsResourcesNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Beschikbare middelen';
	@override String get name => 'Naam';
	@override String get type => 'Type';
}

// Path: messages
class _TranslationsMessagesNl implements TranslationsMessagesFr {
	_TranslationsMessagesNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Laatste berichten';
	@override String get seeAllMessages => 'Bekijk alle berichten';
	@override String get noMessages => 'Geen berichten';
	@override String get writeMessageHint => 'Schrijf een bericht...';
	@override String get sendMessage => 'Verzenden';
}

// Path: common
class _TranslationsCommonNl implements TranslationsCommonFr {
	_TranslationsCommonNl._(this._root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Afzender';
	@override String get message => 'Bericht';
}

// Path: page
class _TranslationsPageNl implements TranslationsPageFr {
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
	@override String get sheet => 'Blad';
	@override String get sheetPage => 'Bladpagina';
	@override String get subject => 'Onderwerp';
	@override String get subjectPage => 'Onderwerp pagina';
	@override String get topic => 'Onderwerp';
	@override String get topicPage => 'Onderwerp pagina';
	@override String get event => 'Evenement';
	@override String get eventPage => 'Evenement pagina';
	@override String get user => 'Gebruiker';
	@override String get userPage => 'Gebruikerspagina';
	@override String get about => 'Over';
	@override String get aboutPage => 'Overpagina';
	@override String get contact => 'Contact';
	@override String get contactPage => 'Contactpagina';
	@override String get terms => 'Gebruiksvoorwaarden';
	@override String get termsPage => 'Gebruiksvoorwaarden pagina';
	@override String get privacy => 'Privacybeleid';
	@override String get privacyPage => 'Privacybeleid pagina';
	@override String get notifications => 'Notificaties';
	@override String get events => 'Evenementen';
	@override String get sheets => 'Bladen';
	@override String get subjects => 'Onderwerpen';
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
			case 'app.logout': return 'Afmelden';
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
			case 'app.finish': return 'Voltooien';
			case 'app.back': return 'Terug';
			case 'app.submit': return 'Verzenden';
			case 'app.searchUser': return 'Zoek een gebruiker';
			case 'app.searchSubject': return 'Zoek een vak';
			case 'app.searchTopic': return 'Zoek een onderwerp';
			case 'app.searchSheet': return 'Zoek een blad';
			case 'app.alreadyHaveAccount': return 'Heeft u al een account?';
			case 'app.loadingIndicator': return 'Laden...';
			case 'app.errorOccurred': return 'Er is een fout opgetreden';
			case 'app.backTo': return 'Terug naar ';
			case 'user.email': return 'Email';
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
			case 'welcome.welcome': return 'Welkom bij Edumeet, het samenwerkende studieplatform';
			case 'welcome.setup': return 'Laten we beginnen met het kiezen van een taal';
			case 'welcome.whatLanguage': return 'Welke taal spreek je?';
			case 'welcome.chooseLanguage': return 'Kies een taal zodat we samen kunnen communiceren';
			case 'welcome.title1': return 'Vind je studiematerialen';
			case 'welcome.description1': return 'Toegang tot duizenden \ngestudeerde materialen gemaakt door studenten, gratis';
			case 'welcome.title2': return 'Organiseer je studie';
			case 'welcome.description2': return 'Sorteer en organiseer je materialen voor een \neffectief geheugen';
			case 'welcome.title3': return 'Blijf gemotiveerd';
			case 'welcome.description3': return 'Bereik je doelen met praktische \ntips';
			case 'welcome.title4': return 'Word lid van onze gemeenschap';
			case 'welcome.description4': return 'Deel je studiematerialen en \nontvang persoonlijke tips';
			case 'login.title': return 'Inloggen';
			case 'login.description': return 'Voer onderstaande informatie in om in te loggen';
			case 'login.forgotPassword': return 'Wachtwoord vergeten?';
			case 'login.noAccount': return 'Heeft u geen account?';
			case 'login.createAccount': return 'Maak een account aan';
			case 'register.title': return 'Account aanmaken';
			case 'register.description': return 'Sluit je bij ons aan om van onze diensten te profiteren';
			case 'register.conditions': return 'Door een account aan te maken, accepteert u onze Gebruiksvoorwaarden en Privacybeleid';
			case 'register.registerConfirm': return 'Registratie bevestigd';
			case 'form.emptyUsername': return 'Voer een gebruikersnaam in';
			case 'form.emptyFirstname': return 'Voer uw voornaam in';
			case 'form.emptyEmail': return 'Voer uw e-mailadres in';
			case 'form.emptyLastname': return 'Voer uw achternaam in';
			case 'form.emptyPassword': return 'Voer uw wachtwoord in';
			case 'form.emptyConfirmPassword': return 'Bevestig uw wachtwoord';
			case 'form.passwordMismatch': return 'De wachtwoorden komen niet overeen';
			case 'form.invalidEmail': return 'Voer een geldig e-mailadres in';
			case 'form.invalidAddress': return 'Voer een geldig adres in';
			case 'form.shortPassword': return 'Het wachtwoord moet minimaal 8 tekens bevatten';
			case 'form.passwordUpperCase': return 'Het wachtwoord moet minstens één hoofdletter bevatten';
			case 'form.passwordDigit': return 'Het wachtwoord moet minstens één cijfer bevatten';
			case 'form.passwordSpecialChar': return 'Het wachtwoord moet minstens één speciaal teken bevatten';
			case 'form.haveToAcceptConditions': return 'U moet de gebruiksvoorwaarden en het privacybeleid accepteren';
			case 'form.confirmPassword': return 'Bevestig wachtwoord';
			case 'form.pleaseConfirmPassword': return 'Bevestig uw wachtwoord';
			case 'form.passwordNotMatch': return 'De wachtwoorden komen niet overeen';
			case 'swipe_cards.loading_error': return 'Fout bij het laden van evenementen';
			case 'swipe_cards.end_of_list': return 'U heeft het einde van de lijst bereikt!';
			case 'swipe_cards.nope': return ({required Object title}) => 'Nee tegen ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Je hebt je bij het evenement ${title} gevoegd';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Item gewijzigd: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fysiek';
			case 'event.participants': return 'Deelnemers';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'U heeft zich aangemeld voor het evenement ${event_title}';
			case 'event.address_copied': return 'Adres gekopieerd naar het klembord';
			case 'event.createEvent': return 'Evenement aanmaken';
			case 'event.name': return 'Naam';
			case 'event.description': return 'Beschrijving';
			case 'event.date': return 'Datum';
			case 'event.time': return 'Tijd';
			case 'event.location': return 'Locatie';
			case 'event.maxParticipants': return 'Aantal deelnemers';
			case 'event.price': return 'Prijs';
			case 'event.image': return 'Afbeelding';
			case 'event.create': return 'Aanmaken';
			case 'event.enterName': return 'Voer een naam in';
			case 'event.enterDescription': return 'Voer een beschrijving in';
			case 'event.enterDate': return 'Voer een datum in';
			case 'event.enterTime': return 'Voer een tijd in';
			case 'event.enterLocation': return 'Voer een locatie in';
			case 'event.enterMaxParticipants': return 'Voer een aantal deelnemers in';
			case 'event.invalidMaxParticipants': return 'Voer een geldig aantal in';
			case 'event.enterPrice': return 'Voer een prijs in';
			case 'event.invalidPrice': return 'Voer een geldige prijs in';
			case 'event.enterImage': return 'Voer een afbeelding URL in';
			case 'event.joinEvent': return 'Nodig evenement';
			case 'event.eventNotStarted': return 'De verbindingslink zal hier beschikbaar zijn wanneer het evenement begint.';
			case 'error.details': return ({required Object error}) => 'Fout: ${error}';
			case 'error.no_internet': return 'Geen internetverbinding';
			case 'error.no_internet_description': return 'Controleer je internetverbinding en probeer het opnieuw';
			case 'error.no_events': return 'Geen evenementen gevonden';
			case 'error.no_events_description': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found': return 'Geen evenementen gevonden';
			case 'error.no_events_found_description': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found_title': return 'Geen evenementen gevonden';
			case 'error.no_events_found_description_title': return 'Er zijn momenteel geen evenementen gevonden. Probeer het later opnieuw';
			case 'error.no_events_found_description_title_search': return 'Er zijn geen evenementen gevonden voor de uitgevoerde zoekopdracht. Probeer het met een andere term opnieuw';
			case 'error.loadingEvents': return 'Er is een fout opgetreden tijdens het laden van de evenementen';
			case 'error.failedToResetPassword': return 'Wachtwoord resetten is mislukt';
			case 'auth.forgotPassword': return 'Wachtwoord vergeten?';
			case 'auth.enterEmail': return 'Voer uw e-mailadres in om de instructies voor het opnieuw instellen te ontvangen';
			case 'auth.resetPassword': return 'Wachtwoord opnieuw instellen';
			case 'auth.enterNewPassword': return 'Voer uw nieuwe wachtwoord in';
			case 'auth.resetInstructionsSent': return 'Instructies voor het opnieuw instellen zijn naar uw e-mail verzonden';
			case 'auth.passwordResertSuccess': return 'Uw wachtwoord is succesvol opnieuw ingesteld';
			case 'verify.title': return 'Code verificatie';
			case 'verify.description': return 'Voer de verificatiecode in die naar uw e-mail is gestuurd';
			case 'verify.inputLabel': return 'Verificatiecode';
			case 'verify.button': return 'Controleren';
			case 'verify.error': return 'Voer de verificatiecode in';
			case 'profile.editProfile': return 'Bewerk mijn profiel';
			case 'profile.firstname': return 'Voornaam';
			case 'profile.lastname': return 'Achternaam';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'E-mail';
			case 'profile.birthdate': return 'Geboortedatum';
			case 'profile.address': return 'Adres';
			case 'profile.save': return 'Opslaan';
			case 'profile.cancel': return 'Annuleren';
			case 'profile.enterFirstname': return 'Voer uw voornaam in';
			case 'profile.enterLastname': return 'Voer uw achternaam in';
			case 'profile.enterEmail': return 'Voer uw e-mailadres in';
			case 'profile.invalidEmail': return 'Voer een geldig e-mailadres in';
			case 'profile.logout': return 'Uitloggen';
			case 'resources.availableResources': return 'Beschikbare middelen';
			case 'resources.name': return 'Naam';
			case 'resources.type': return 'Type';
			case 'messages.latestMessages': return 'Laatste berichten';
			case 'messages.seeAllMessages': return 'Bekijk alle berichten';
			case 'messages.noMessages': return 'Geen berichten';
			case 'messages.writeMessageHint': return 'Schrijf een bericht...';
			case 'messages.sendMessage': return 'Verzenden';
			case 'common.sender': return 'Afzender';
			case 'common.message': return 'Bericht';
			case 'page.home': return 'Startpagina';
			case 'page.homePage': return 'Startpagina';
			case 'page.profile': return 'Profiel';
			case 'page.profilePage': return 'Profielpagina';
			case 'page.settings': return 'Instellingen';
			case 'page.settingsPage': return 'Instellingenpagina';
			case 'page.search': return 'Zoeken';
			case 'page.searchPage': return 'Zoekpagina';
			case 'page.sheet': return 'Blad';
			case 'page.sheetPage': return 'Bladpagina';
			case 'page.subject': return 'Onderwerp';
			case 'page.subjectPage': return 'Onderwerp pagina';
			case 'page.topic': return 'Onderwerp';
			case 'page.topicPage': return 'Onderwerp pagina';
			case 'page.event': return 'Evenement';
			case 'page.eventPage': return 'Evenement pagina';
			case 'page.user': return 'Gebruiker';
			case 'page.userPage': return 'Gebruikerspagina';
			case 'page.about': return 'Over';
			case 'page.aboutPage': return 'Overpagina';
			case 'page.contact': return 'Contact';
			case 'page.contactPage': return 'Contactpagina';
			case 'page.terms': return 'Gebruiksvoorwaarden';
			case 'page.termsPage': return 'Gebruiksvoorwaarden pagina';
			case 'page.privacy': return 'Privacybeleid';
			case 'page.privacyPage': return 'Privacybeleid pagina';
			case 'page.notifications': return 'Notificaties';
			case 'page.events': return 'Evenementen';
			case 'page.sheets': return 'Bladen';
			case 'page.subjects': return 'Onderwerpen';
			case 'page.topics': return 'Onderwerpen';
			case 'page.users': return 'Gebruikers';
			case 'page.help': return 'Hulp';
			case 'page.helpPage': return 'Hulp pagina';
			default: return null;
		}
	}
}


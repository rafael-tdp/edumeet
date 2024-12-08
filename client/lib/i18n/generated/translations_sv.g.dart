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
class TranslationsSv implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsSv({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.sv,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <sv>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsSv _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppSv app = _TranslationsAppSv._(_root);
	@override late final _TranslationsUserSv user = _TranslationsUserSv._(_root);
	@override late final _TranslationsWelcomeSv welcome = _TranslationsWelcomeSv._(_root);
	@override late final _TranslationsLoginSv login = _TranslationsLoginSv._(_root);
	@override late final _TranslationsRegisterSv register = _TranslationsRegisterSv._(_root);
	@override late final _TranslationsFormSv form = _TranslationsFormSv._(_root);
	@override late final _TranslationsSwipeCardsSv swipe_cards = _TranslationsSwipeCardsSv._(_root);
	@override late final _TranslationsEventSv event = _TranslationsEventSv._(_root);
	@override late final _TranslationsErrorSv error = _TranslationsErrorSv._(_root);
	@override late final _TranslationsAuthSv auth = _TranslationsAuthSv._(_root);
	@override late final _TranslationsVerifySv verify = _TranslationsVerifySv._(_root);
	@override late final _TranslationsProfileSv profile = _TranslationsProfileSv._(_root);
	@override late final _TranslationsResourcesSv resources = _TranslationsResourcesSv._(_root);
	@override late final _TranslationsMessagesSv messages = _TranslationsMessagesSv._(_root);
	@override late final _TranslationsCommonSv common = _TranslationsCommonSv._(_root);
	@override late final _TranslationsPageSv page = _TranslationsPageSv._(_root);
}

// Path: app
class _TranslationsAppSv implements TranslationsAppFr {
	_TranslationsAppSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get login => 'Logga in';
	@override String get signup => 'Registrera sig';
	@override String get logout => 'Logga ut';
	@override String get search => 'Sök';
	@override String get searchLanguage => 'Sök ett språk';
	@override String get add => 'Lägg till';
	@override String get edit => 'Redigera';
	@override String get delete => 'Ta bort';
	@override String get cancel => 'Avbryt';
	@override String get save => 'Spara';
	@override String get yes => 'Ja';
	@override String get no => 'Nej';
	@override String get confirm => 'Bekräfta';
	@override String get error => 'Fel';
	@override String get loading => 'Laddar...';
	@override String get noResults => 'Inga resultat';
	@override String get noResultsFound => 'Inga resultat funna';
	@override String get skip => 'Hoppa över';
	@override String get next => 'Nästa';
	@override String get previous => 'Föregående';
	@override String get finish => 'Avsluta';
	@override String get back => 'Tillbaka';
	@override String get submit => 'Skicka';
	@override String get searchUser => 'Sök användare';
	@override String get searchSubject => 'Sök ämne';
	@override String get searchTopic => 'Sök ämne';
	@override String get searchSheet => 'Sök blad';
	@override String get alreadyHaveAccount => 'Har du redan ett konto?';
	@override String get loadingIndicator => 'Laddar...';
	@override String get errorOccurred => 'Ett fel har uppstått';
	@override String get backTo => 'Tillbaka till ';
}

// Path: user
class _TranslationsUserSv implements TranslationsUserFr {
	_TranslationsUserSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get email => 'E-post';
	@override String get username => 'Användarnamn';
	@override String get name => 'Namn';
	@override String get firstname => 'Förnamn';
	@override String get birthdate => 'Födelsedatum';
	@override String get location => 'Plats';
	@override String get bio => 'Biografi';
	@override String get nbReports => 'Antal rapporter';
	@override String get address => 'Adress';
	@override String get password => 'Lösenord';
	@override String get newPassword => 'Nytt lösenord';
	@override String get anonymous => 'Anonym';
	@override String get noDescription => 'Ingen beskrivning';
	@override String get noAddress => 'Adress ej tillgänglig';
	@override String get noReportsAvailable => 'Antal rapporter ej tillgängligt';
}

// Path: welcome
class _TranslationsWelcomeSv implements TranslationsWelcomeFr {
	_TranslationsWelcomeSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Välkommen till Edumeet, plattformen för samarbetsinriktad studiehjälp';
	@override String get setup => 'Låt oss börja med att välja ett språk';
	@override String get whatLanguage => 'Vilket språk talar du?';
	@override String get chooseLanguage => 'Välj ett språk så att vi kan kommunicera tillsammans';
	@override String get title1 => 'Hitta dina studiehandouts';
	@override String get description1 => 'Få gratis tillgång till tusentals \nstudiehandouts skapade av studenter';
	@override String get title2 => 'Organisera dina studier';
	@override String get description2 => 'Klassificera och organisera dina handouts för en \neffektiv inlärning';
	@override String get title3 => 'Håll dig motiverad';
	@override String get description3 => 'Uppnå dina mål med praktiska \nråd';
	@override String get title4 => 'Gå med i vårt community';
	@override String get description4 => 'Dela dina studiehandouts och \n få personliga råd';
}

// Path: login
class _TranslationsLoginSv implements TranslationsLoginFr {
	_TranslationsLoginSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inloggning';
	@override String get description => 'Ange dina uppgifter nedan för att logga in';
	@override String get forgotPassword => 'Glömt lösenordet?';
	@override String get noAccount => 'Har du inget konto?';
	@override String get createAccount => 'Skapa ett konto';
}

// Path: register
class _TranslationsRegisterSv implements TranslationsRegisterFr {
	_TranslationsRegisterSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Skapa ett konto';
	@override String get description => 'Gå med oss för att dra nytta av våra tjänster';
	@override String get conditions => 'Genom att skapa ett konto accepterar du våra Användarvillkor och Integritetspolicy';
	@override String get registerConfirm => 'Registrering bekräftad';
}

// Path: form
class _TranslationsFormSv implements TranslationsFormFr {
	_TranslationsFormSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Vänligen ange ett användarnamn';
	@override String get emptyFirstname => 'Vänligen ange ditt förnamn';
	@override String get emptyEmail => 'Vänligen ange din e-postadress';
	@override String get emptyLastname => 'Vänligen ange ditt efternamn';
	@override String get emptyPassword => 'Vänligen ange ditt lösenord';
	@override String get emptyConfirmPassword => 'Vänligen bekräfta ditt lösenord';
	@override String get passwordMismatch => 'Lösenorden matchar inte';
	@override String get invalidEmail => 'Vänligen ange en giltig e-postadress';
	@override String get invalidAddress => 'Vänligen ange en giltig adress';
	@override String get shortPassword => 'Lösenordet måste vara minst 8 tecken långt';
	@override String get passwordUpperCase => 'Lösenordet måste innehålla minst en stor bokstav';
	@override String get passwordDigit => 'Lösenordet måste innehålla minst en siffra';
	@override String get passwordSpecialChar => 'Lösenordet måste innehålla minst ett specialtecken';
	@override String get haveToAcceptConditions => 'Du måste acceptera användarvillkoren och integritetspolicyn';
	@override String get confirmPassword => 'Bekräfta lösenord';
	@override String get pleaseConfirmPassword => 'Vänligen bekräfta ditt lösenord';
	@override String get passwordNotMatch => 'Lösenorden matchar inte';
}

// Path: swipe_cards
class _TranslationsSwipeCardsSv implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Fel vid inläsning av händelser';
	@override String get end_of_list => 'Du har nått slutet av listan!';
	@override String nope({required Object title}) => 'Nej till ${title}';
	@override String joined_event({required Object title}) => 'Du har gått med i händelsen ${title}';
	@override String item_changed({required Object title}) => 'Objekt ändrat: ${title}';
}

// Path: event
class _TranslationsEventSv implements TranslationsEventFr {
	_TranslationsEventSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fysisk';
	@override String get participants => 'Deltagare';
	@override String hasJoinEvent({required Object event_title}) => 'Du har gått med i evenemanget ${event_title}';
	@override String get address_copied => 'Adressen har kopierats till urklipp';
	@override String get createEvent => 'Skapa ett evenemang';
	@override String get name => 'Namn';
	@override String get description => 'Beskrivning';
	@override String get date => 'Datum';
	@override String get time => 'Tid';
	@override String get location => 'Plats';
	@override String get maxParticipants => 'Max antal deltagare';
	@override String get price => 'Pris';
	@override String get image => 'Bild';
	@override String get create => 'Skapa';
	@override String get enterName => 'Vänligen ange ett namn';
	@override String get enterDescription => 'Vänligen ange en beskrivning';
	@override String get enterDate => 'Vänligen ange ett datum';
	@override String get enterTime => 'Vänligen ange en tid';
	@override String get enterLocation => 'Vänligen ange en plats';
	@override String get enterMaxParticipants => 'Vänligen ange ett max antal deltagare';
	@override String get invalidMaxParticipants => 'Vänligen ange ett giltigt antal';
	@override String get enterPrice => 'Vänligen ange ett pris';
	@override String get invalidPrice => 'Vänligen ange ett giltigt pris';
	@override String get enterImage => 'Vänligen ange en bild-URL';
	@override String get joinEvent => 'Gå med i evenemanget';
	@override String get eventNotStarted => 'Länk för att ansluta kommer att vara tillgänglig här när evenemanget startar.';
}

// Path: error
class _TranslationsErrorSv implements TranslationsErrorFr {
	_TranslationsErrorSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Fel: ${error}';
	@override String get no_internet => 'Ingen internetanslutning';
	@override String get no_internet_description => 'Kontrollera din internetanslutning och försök igen';
	@override String get no_events => 'Inga händelser funna';
	@override String get no_events_description => 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
	@override String get no_events_found => 'Inga händelser funna';
	@override String get no_events_found_description => 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
	@override String get no_events_found_title => 'Inga händelser funna';
	@override String get no_events_found_description_title => 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
	@override String get no_events_found_description_title_search => 'Inga händelser har hittats för den angivna sökningen. Vänligen försök igen med ett annat sökord';
	@override String get loadingEvents => 'Ett fel uppstod vid inläsning av evenemang';
	@override String get failedToResetPassword => 'Misslyckades med att återställa lösenordet';
}

// Path: auth
class _TranslationsAuthSv implements TranslationsAuthFr {
	_TranslationsAuthSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Glömt ditt lösenord?';
	@override String get enterEmail => 'Ange din e-postadress för att få instruktioner för återställning';
	@override String get resetPassword => 'Återställ lösenordet';
	@override String get enterNewPassword => 'Ange ditt nya lösenord';
	@override String get resetInstructionsSent => 'Instruktioner för återställning har skickats till din e-post';
	@override String get passwordResertSuccess => 'Ditt lösenord har återställts framgångsrikt';
}

// Path: verify
class _TranslationsVerifySv implements TranslationsVerifyFr {
	_TranslationsVerifySv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verifiering av koden';
	@override String get description => 'Ange verifieringskoden som skickats till din e-post';
	@override String get inputLabel => 'Verifieringskod';
	@override String get button => 'Verifiera';
	@override String get error => 'Vänligen ange verifieringskoden';
}

// Path: profile
class _TranslationsProfileSv implements TranslationsProfileFr {
	_TranslationsProfileSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Redigera min profil';
	@override String get firstname => 'Förnamn';
	@override String get lastname => 'Efternamn';
	@override String get bio => 'Bio';
	@override String get email => 'E-post';
	@override String get birthdate => 'Födelsedatum';
	@override String get address => 'Adress';
	@override String get save => 'Spara';
	@override String get cancel => 'Avbryt';
	@override String get enterFirstname => 'Vänligen ange ditt förnamn';
	@override String get enterLastname => 'Vänligen ange ditt efternamn';
	@override String get enterEmail => 'Vänligen ange din e-postadress';
	@override String get invalidEmail => 'Vänligen ange en giltig e-postadress';
	@override String get logout => 'Logga ut';
}

// Path: resources
class _TranslationsResourcesSv implements TranslationsResourcesFr {
	_TranslationsResourcesSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Tillgängliga resurser';
	@override String get name => 'Namn';
	@override String get type => 'Typ';
}

// Path: messages
class _TranslationsMessagesSv implements TranslationsMessagesFr {
	_TranslationsMessagesSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Senaste meddelanden';
	@override String get seeAllMessages => 'Se alla meddelanden';
	@override String get noMessages => 'Inga meddelanden';
	@override String get writeMessageHint => 'Skriv ett meddelande...';
	@override String get sendMessage => 'Skicka';
}

// Path: common
class _TranslationsCommonSv implements TranslationsCommonFr {
	_TranslationsCommonSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Avsändare';
	@override String get message => 'Meddelande';
}

// Path: page
class _TranslationsPageSv implements TranslationsPageFr {
	_TranslationsPageSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get home => 'Hem';
	@override String get homePage => 'Startsida';
	@override String get profile => 'Profil';
	@override String get profilePage => 'Profil-sida';
	@override String get settings => 'Inställningar';
	@override String get settingsPage => 'Inställningar-sida';
	@override String get search => 'Sök';
	@override String get searchPage => 'Sök-sida';
	@override String get sheet => 'Blad';
	@override String get sheetPage => 'Blad-sida';
	@override String get subject => 'Ämne';
	@override String get subjectPage => 'Ämnes-sida';
	@override String get topic => 'Tema';
	@override String get topicPage => 'Temasida';
	@override String get event => 'Evenemang';
	@override String get eventPage => 'Evenemang-sida';
	@override String get user => 'Användare';
	@override String get userPage => 'Användare-sida';
	@override String get about => 'Om';
	@override String get aboutPage => 'Om-sida';
	@override String get contact => 'Kontakt';
	@override String get contactPage => 'Kontaktsida';
	@override String get terms => 'Användarvillkor';
	@override String get termsPage => 'Användarvillkor-sida';
	@override String get privacy => 'Integritetspolicy';
	@override String get privacyPage => 'Integritetspolicy-sida';
	@override String get notifications => 'Notifieringar';
	@override String get events => 'Evenemang';
	@override String get sheets => 'Blad';
	@override String get subjects => 'Ämnen';
	@override String get topics => 'Teman';
	@override String get users => 'Användare';
	@override String get help => 'Hjälp';
	@override String get helpPage => 'Hjälp-sida';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsSv {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Logga in';
			case 'app.signup': return 'Registrera sig';
			case 'app.logout': return 'Logga ut';
			case 'app.search': return 'Sök';
			case 'app.searchLanguage': return 'Sök ett språk';
			case 'app.add': return 'Lägg till';
			case 'app.edit': return 'Redigera';
			case 'app.delete': return 'Ta bort';
			case 'app.cancel': return 'Avbryt';
			case 'app.save': return 'Spara';
			case 'app.yes': return 'Ja';
			case 'app.no': return 'Nej';
			case 'app.confirm': return 'Bekräfta';
			case 'app.error': return 'Fel';
			case 'app.loading': return 'Laddar...';
			case 'app.noResults': return 'Inga resultat';
			case 'app.noResultsFound': return 'Inga resultat funna';
			case 'app.skip': return 'Hoppa över';
			case 'app.next': return 'Nästa';
			case 'app.previous': return 'Föregående';
			case 'app.finish': return 'Avsluta';
			case 'app.back': return 'Tillbaka';
			case 'app.submit': return 'Skicka';
			case 'app.searchUser': return 'Sök användare';
			case 'app.searchSubject': return 'Sök ämne';
			case 'app.searchTopic': return 'Sök ämne';
			case 'app.searchSheet': return 'Sök blad';
			case 'app.alreadyHaveAccount': return 'Har du redan ett konto?';
			case 'app.loadingIndicator': return 'Laddar...';
			case 'app.errorOccurred': return 'Ett fel har uppstått';
			case 'app.backTo': return 'Tillbaka till ';
			case 'user.email': return 'E-post';
			case 'user.username': return 'Användarnamn';
			case 'user.name': return 'Namn';
			case 'user.firstname': return 'Förnamn';
			case 'user.birthdate': return 'Födelsedatum';
			case 'user.location': return 'Plats';
			case 'user.bio': return 'Biografi';
			case 'user.nbReports': return 'Antal rapporter';
			case 'user.address': return 'Adress';
			case 'user.password': return 'Lösenord';
			case 'user.newPassword': return 'Nytt lösenord';
			case 'user.anonymous': return 'Anonym';
			case 'user.noDescription': return 'Ingen beskrivning';
			case 'user.noAddress': return 'Adress ej tillgänglig';
			case 'user.noReportsAvailable': return 'Antal rapporter ej tillgängligt';
			case 'welcome.welcome': return 'Välkommen till Edumeet, plattformen för samarbetsinriktad studiehjälp';
			case 'welcome.setup': return 'Låt oss börja med att välja ett språk';
			case 'welcome.whatLanguage': return 'Vilket språk talar du?';
			case 'welcome.chooseLanguage': return 'Välj ett språk så att vi kan kommunicera tillsammans';
			case 'welcome.title1': return 'Hitta dina studiehandouts';
			case 'welcome.description1': return 'Få gratis tillgång till tusentals \nstudiehandouts skapade av studenter';
			case 'welcome.title2': return 'Organisera dina studier';
			case 'welcome.description2': return 'Klassificera och organisera dina handouts för en \neffektiv inlärning';
			case 'welcome.title3': return 'Håll dig motiverad';
			case 'welcome.description3': return 'Uppnå dina mål med praktiska \nråd';
			case 'welcome.title4': return 'Gå med i vårt community';
			case 'welcome.description4': return 'Dela dina studiehandouts och \n få personliga råd';
			case 'login.title': return 'Inloggning';
			case 'login.description': return 'Ange dina uppgifter nedan för att logga in';
			case 'login.forgotPassword': return 'Glömt lösenordet?';
			case 'login.noAccount': return 'Har du inget konto?';
			case 'login.createAccount': return 'Skapa ett konto';
			case 'register.title': return 'Skapa ett konto';
			case 'register.description': return 'Gå med oss för att dra nytta av våra tjänster';
			case 'register.conditions': return 'Genom att skapa ett konto accepterar du våra Användarvillkor och Integritetspolicy';
			case 'register.registerConfirm': return 'Registrering bekräftad';
			case 'form.emptyUsername': return 'Vänligen ange ett användarnamn';
			case 'form.emptyFirstname': return 'Vänligen ange ditt förnamn';
			case 'form.emptyEmail': return 'Vänligen ange din e-postadress';
			case 'form.emptyLastname': return 'Vänligen ange ditt efternamn';
			case 'form.emptyPassword': return 'Vänligen ange ditt lösenord';
			case 'form.emptyConfirmPassword': return 'Vänligen bekräfta ditt lösenord';
			case 'form.passwordMismatch': return 'Lösenorden matchar inte';
			case 'form.invalidEmail': return 'Vänligen ange en giltig e-postadress';
			case 'form.invalidAddress': return 'Vänligen ange en giltig adress';
			case 'form.shortPassword': return 'Lösenordet måste vara minst 8 tecken långt';
			case 'form.passwordUpperCase': return 'Lösenordet måste innehålla minst en stor bokstav';
			case 'form.passwordDigit': return 'Lösenordet måste innehålla minst en siffra';
			case 'form.passwordSpecialChar': return 'Lösenordet måste innehålla minst ett specialtecken';
			case 'form.haveToAcceptConditions': return 'Du måste acceptera användarvillkoren och integritetspolicyn';
			case 'form.confirmPassword': return 'Bekräfta lösenord';
			case 'form.pleaseConfirmPassword': return 'Vänligen bekräfta ditt lösenord';
			case 'form.passwordNotMatch': return 'Lösenorden matchar inte';
			case 'swipe_cards.loading_error': return 'Fel vid inläsning av händelser';
			case 'swipe_cards.end_of_list': return 'Du har nått slutet av listan!';
			case 'swipe_cards.nope': return ({required Object title}) => 'Nej till ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Du har gått med i händelsen ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Objekt ändrat: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fysisk';
			case 'event.participants': return 'Deltagare';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Du har gått med i evenemanget ${event_title}';
			case 'event.address_copied': return 'Adressen har kopierats till urklipp';
			case 'event.createEvent': return 'Skapa ett evenemang';
			case 'event.name': return 'Namn';
			case 'event.description': return 'Beskrivning';
			case 'event.date': return 'Datum';
			case 'event.time': return 'Tid';
			case 'event.location': return 'Plats';
			case 'event.maxParticipants': return 'Max antal deltagare';
			case 'event.price': return 'Pris';
			case 'event.image': return 'Bild';
			case 'event.create': return 'Skapa';
			case 'event.enterName': return 'Vänligen ange ett namn';
			case 'event.enterDescription': return 'Vänligen ange en beskrivning';
			case 'event.enterDate': return 'Vänligen ange ett datum';
			case 'event.enterTime': return 'Vänligen ange en tid';
			case 'event.enterLocation': return 'Vänligen ange en plats';
			case 'event.enterMaxParticipants': return 'Vänligen ange ett max antal deltagare';
			case 'event.invalidMaxParticipants': return 'Vänligen ange ett giltigt antal';
			case 'event.enterPrice': return 'Vänligen ange ett pris';
			case 'event.invalidPrice': return 'Vänligen ange ett giltigt pris';
			case 'event.enterImage': return 'Vänligen ange en bild-URL';
			case 'event.joinEvent': return 'Gå med i evenemanget';
			case 'event.eventNotStarted': return 'Länk för att ansluta kommer att vara tillgänglig här när evenemanget startar.';
			case 'error.details': return ({required Object error}) => 'Fel: ${error}';
			case 'error.no_internet': return 'Ingen internetanslutning';
			case 'error.no_internet_description': return 'Kontrollera din internetanslutning och försök igen';
			case 'error.no_events': return 'Inga händelser funna';
			case 'error.no_events_description': return 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
			case 'error.no_events_found': return 'Inga händelser funna';
			case 'error.no_events_found_description': return 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
			case 'error.no_events_found_title': return 'Inga händelser funna';
			case 'error.no_events_found_description_title': return 'Inga händelser har hittats för tillfället. Vänligen försök igen senare';
			case 'error.no_events_found_description_title_search': return 'Inga händelser har hittats för den angivna sökningen. Vänligen försök igen med ett annat sökord';
			case 'error.loadingEvents': return 'Ett fel uppstod vid inläsning av evenemang';
			case 'error.failedToResetPassword': return 'Misslyckades med att återställa lösenordet';
			case 'auth.forgotPassword': return 'Glömt ditt lösenord?';
			case 'auth.enterEmail': return 'Ange din e-postadress för att få instruktioner för återställning';
			case 'auth.resetPassword': return 'Återställ lösenordet';
			case 'auth.enterNewPassword': return 'Ange ditt nya lösenord';
			case 'auth.resetInstructionsSent': return 'Instruktioner för återställning har skickats till din e-post';
			case 'auth.passwordResertSuccess': return 'Ditt lösenord har återställts framgångsrikt';
			case 'verify.title': return 'Verifiering av koden';
			case 'verify.description': return 'Ange verifieringskoden som skickats till din e-post';
			case 'verify.inputLabel': return 'Verifieringskod';
			case 'verify.button': return 'Verifiera';
			case 'verify.error': return 'Vänligen ange verifieringskoden';
			case 'profile.editProfile': return 'Redigera min profil';
			case 'profile.firstname': return 'Förnamn';
			case 'profile.lastname': return 'Efternamn';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'E-post';
			case 'profile.birthdate': return 'Födelsedatum';
			case 'profile.address': return 'Adress';
			case 'profile.save': return 'Spara';
			case 'profile.cancel': return 'Avbryt';
			case 'profile.enterFirstname': return 'Vänligen ange ditt förnamn';
			case 'profile.enterLastname': return 'Vänligen ange ditt efternamn';
			case 'profile.enterEmail': return 'Vänligen ange din e-postadress';
			case 'profile.invalidEmail': return 'Vänligen ange en giltig e-postadress';
			case 'profile.logout': return 'Logga ut';
			case 'resources.availableResources': return 'Tillgängliga resurser';
			case 'resources.name': return 'Namn';
			case 'resources.type': return 'Typ';
			case 'messages.latestMessages': return 'Senaste meddelanden';
			case 'messages.seeAllMessages': return 'Se alla meddelanden';
			case 'messages.noMessages': return 'Inga meddelanden';
			case 'messages.writeMessageHint': return 'Skriv ett meddelande...';
			case 'messages.sendMessage': return 'Skicka';
			case 'common.sender': return 'Avsändare';
			case 'common.message': return 'Meddelande';
			case 'page.home': return 'Hem';
			case 'page.homePage': return 'Startsida';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Profil-sida';
			case 'page.settings': return 'Inställningar';
			case 'page.settingsPage': return 'Inställningar-sida';
			case 'page.search': return 'Sök';
			case 'page.searchPage': return 'Sök-sida';
			case 'page.sheet': return 'Blad';
			case 'page.sheetPage': return 'Blad-sida';
			case 'page.subject': return 'Ämne';
			case 'page.subjectPage': return 'Ämnes-sida';
			case 'page.topic': return 'Tema';
			case 'page.topicPage': return 'Temasida';
			case 'page.event': return 'Evenemang';
			case 'page.eventPage': return 'Evenemang-sida';
			case 'page.user': return 'Användare';
			case 'page.userPage': return 'Användare-sida';
			case 'page.about': return 'Om';
			case 'page.aboutPage': return 'Om-sida';
			case 'page.contact': return 'Kontakt';
			case 'page.contactPage': return 'Kontaktsida';
			case 'page.terms': return 'Användarvillkor';
			case 'page.termsPage': return 'Användarvillkor-sida';
			case 'page.privacy': return 'Integritetspolicy';
			case 'page.privacyPage': return 'Integritetspolicy-sida';
			case 'page.notifications': return 'Notifieringar';
			case 'page.events': return 'Evenemang';
			case 'page.sheets': return 'Blad';
			case 'page.subjects': return 'Ämnen';
			case 'page.topics': return 'Teman';
			case 'page.users': return 'Användare';
			case 'page.help': return 'Hjälp';
			case 'page.helpPage': return 'Hjälp-sida';
			default: return null;
		}
	}
}


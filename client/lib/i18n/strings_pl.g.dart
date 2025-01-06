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
class TranslationsPl implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsPl _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppPl app = _TranslationsAppPl._(_root);
	@override late final _TranslationsUserPl user = _TranslationsUserPl._(_root);
	@override late final _TranslationsWelcomePl welcome = _TranslationsWelcomePl._(_root);
	@override late final _TranslationsLoginPl login = _TranslationsLoginPl._(_root);
	@override late final _TranslationsRegisterPl register = _TranslationsRegisterPl._(_root);
	@override late final _TranslationsFormPl form = _TranslationsFormPl._(_root);
	@override late final _TranslationsSwipeCardsPl swipe_cards = _TranslationsSwipeCardsPl._(_root);
	@override late final _TranslationsEventPl event = _TranslationsEventPl._(_root);
	@override late final _TranslationsErrorPl error = _TranslationsErrorPl._(_root);
	@override late final _TranslationsAuthPl auth = _TranslationsAuthPl._(_root);
	@override late final _TranslationsVerifyPl verify = _TranslationsVerifyPl._(_root);
	@override late final _TranslationsProfilePl profile = _TranslationsProfilePl._(_root);
	@override late final _TranslationsResourcesPl resources = _TranslationsResourcesPl._(_root);
	@override late final _TranslationsMessagesPl messages = _TranslationsMessagesPl._(_root);
	@override late final _TranslationsCommonPl common = _TranslationsCommonPl._(_root);
	@override late final _TranslationsSettingsPl settings = _TranslationsSettingsPl._(_root);
	@override late final _TranslationsPagePl page = _TranslationsPagePl._(_root);
}

// Path: app
class _TranslationsAppPl implements TranslationsAppEn {
	_TranslationsAppPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get login => 'Zaloguj się';
	@override String get signup => 'Zarejestruj się';
	@override String get logout => 'Wyloguj się';
	@override String get search => 'Szukaj';
	@override String get searchLanguage => 'Szukaj języka';
	@override String get add => 'Dodaj';
	@override String get edit => 'Edytuj';
	@override String get delete => 'Usuń';
	@override String get cancel => 'Anuluj';
	@override String get save => 'Zapisz';
	@override String get yes => 'Tak';
	@override String get no => 'Nie';
	@override String get confirm => 'Potwierdź';
	@override String get error => 'Błąd';
	@override String get loading => 'Ładowanie...';
	@override String get noResults => 'Brak wyników';
	@override String get noResultsFound => 'Nie znaleziono wyników';
	@override String get skip => 'Pomiń';
	@override String get next => 'Następny';
	@override String get previous => 'Poprzedni';
	@override String get finish => 'Zakończ';
	@override String get back => 'Powrót';
	@override String get submit => 'Wyślij';
	@override String get searchUser => 'Szukaj użytkownika';
	@override String get searchSubject => 'Szukaj przedmiotu';
	@override String get searchTopic => 'Szukaj tematu';
	@override String get searchSheet => 'Szukaj notatki';
	@override String get alreadyHaveAccount => 'Masz już konto?';
	@override String get loadingIndicator => 'Ładowanie...';
	@override String get errorOccurred => 'Wystąpił błąd';
	@override String get backTo => 'Powrót do ';
	@override String get unknown => 'Nieznane';
}

// Path: user
class _TranslationsUserPl implements TranslationsUserEn {
	_TranslationsUserPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Nazwa użytkownika';
	@override String get name => 'Nazwisko';
	@override String get firstname => 'Imię';
	@override String get birthdate => 'Data urodzenia';
	@override String get location => 'Miejsce';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Liczba zgłoszeń';
	@override String get address => 'Adres';
	@override String get password => 'Hasło';
	@override String get newPassword => 'Nowe hasło';
	@override String get anonymous => 'Anonimowy';
	@override String get noDescription => 'Brak opisu';
	@override String get noAddress => 'Adres niedostępny';
	@override String get noReportsAvailable => 'Liczba zgłoszeń niedostępna';
	@override String get noBio => 'Brak dostępnych informacji o biografii';
	@override String get noBirthdate => 'Data urodzenia niedostępna';
	@override String get noLocation => 'Miejsce niedostępne';
	@override String get noEmail => 'Email niedostępny';
	@override String get noUsername => 'Nazwa użytkownika niedostępna';
	@override String get noName => 'Imię i nazwisko niedostępne';
	@override String get noFirstname => 'Imię niedostępne';
	@override String get you => 'ty';
	@override String get me => '(ja)';
}

// Path: welcome
class _TranslationsWelcomePl implements TranslationsWelcomeEn {
	_TranslationsWelcomePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Witamy w Edumeet, platformie do wspólnej nauki';
	@override String get setup => 'Zacznijmy od wyboru języka';
	@override String get whatLanguage => 'W jakim języku mówisz?';
	@override String get chooseLanguage => 'Wybierz język, abyśmy mogli się komunikować';
	@override String get title1 => 'Znajdź swoje notatki do nauki';
	@override String get description1 => 'Uzyskaj dostęp do tysięcy notatek do nauki stworzonych przez studentów za darmo';
	@override String get title2 => 'Organizuj swoje nauki';
	@override String get description2 => 'Sortuj i organizuj swoje notatki dla skutecznej pamięci';
	@override String get title3 => 'Pozostań zmotywowany';
	@override String get description3 => 'Osiągaj swoje cele dzięki praktycznym wskazówkom';
	@override String get title4 => 'Dołącz do naszej społeczności';
	@override String get description4 => 'Dziel się swoimi notatkami i otrzymuj spersonalizowane porady';
}

// Path: login
class _TranslationsLoginPl implements TranslationsLoginEn {
	_TranslationsLoginPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Logowanie';
	@override String get description => 'Wprowadź swoje dane poniżej, aby się zalogować';
	@override String get forgotPassword => 'Zapomniałeś hasła?';
	@override String get noAccount => 'Nie masz konta?';
	@override String get createAccount => 'Utwórz konto';
}

// Path: register
class _TranslationsRegisterPl implements TranslationsRegisterEn {
	_TranslationsRegisterPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Załóż konto';
	@override String get description => 'Dołącz do nas, aby korzystać z naszych usług';
	@override String get conditions => 'Tworząc konto, akceptujesz nasze Warunki korzystania i Politykę prywatności';
	@override String get registerConfirm => 'Rejestracja potwierdzona';
}

// Path: form
class _TranslationsFormPl implements TranslationsFormEn {
	_TranslationsFormPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Proszę wprowadzić nazwę użytkownika';
	@override String get emptyFirstname => 'Proszę wprowadzić imię';
	@override String get emptyEmail => 'Proszę wprowadzić adres email';
	@override String get emptyLastname => 'Proszę wprowadzić nazwisko';
	@override String get emptyPassword => 'Proszę wprowadzić hasło';
	@override String get emptyConfirmPassword => 'Proszę potwierdzić hasło';
	@override String get passwordMismatch => 'Hasła się nie zgadzają';
	@override String get invalidEmail => 'Proszę wprowadzić poprawny adres e-mail';
	@override String get invalidAddress => 'Proszę wprowadzić poprawny adres';
	@override String get shortPassword => 'Hasło musi mieć co najmniej 8 znaków';
	@override String get passwordUpperCase => 'Hasło musi zawierać przynajmniej jedną dużą literę';
	@override String get passwordDigit => 'Hasło musi zawierać przynajmniej jedną cyfrę';
	@override String get passwordSpecialChar => 'Hasło musi zawierać przynajmniej jeden znak specjalny';
	@override String get haveToAcceptConditions => 'Musisz zaakceptować warunki korzystania i politykę prywatności';
	@override String get confirmPassword => 'Potwierdź hasło';
	@override String get pleaseConfirmPassword => 'Proszę potwierdzić hasło';
	@override String get passwordNotMatch => 'Hasła się nie zgadzają';
	@override String get invalidUsername => 'Nazwa użytkownika musi:\n- mieć od 3 do 20 znaków\n- zaczynać się od litery\n- nie zawierać znaków specjalnych';
}

// Path: swipe_cards
class _TranslationsSwipeCardsPl implements TranslationsSwipeCardsEn {
	_TranslationsSwipeCardsPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Błąd ładowania wydarzeń';
	@override String get end_of_list => 'Osiągnąłeś koniec listy!';
	@override String get nope => 'Nie dla {{title}}';
	@override String get joined_event => 'Dołączyłeś do wydarzenia {{title}}';
	@override String get item_changed => 'Element zmieniony: {{title}}';
}

// Path: event
class _TranslationsEventPl implements TranslationsEventEn {
	_TranslationsEventPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Fizyczny';
	@override String get participants => 'Uczestnicy';
	@override String get hasJoinEvent => 'Dołączyłeś do wydarzenia {{event_title}}';
	@override String get address_copied => 'Adres skopiowany do schowka';
	@override String get createEvent => 'Utwórz wydarzenie';
	@override String get name => 'Nazwa';
	@override String get description => 'Opis';
	@override String get date => 'Data';
	@override String get time => 'Czas';
	@override String get location => 'Miejsce';
	@override String get maxParticipants => 'Liczba uczestników';
	@override String get price => 'Cena';
	@override String get image => 'Obraz';
	@override String get create => 'Utwórz';
	@override String get enterName => 'Proszę wprowadzić nazwę';
	@override String get enterDescription => 'Proszę wprowadzić opis';
	@override String get enterDate => 'Proszę wprowadzić datę';
	@override String get enterTime => 'Proszę wprowadzić czas';
	@override String get enterLocation => 'Proszę wprowadzić miejsce';
	@override String get enterMaxParticipants => 'Proszę wprowadzić liczbę uczestników';
	@override String get invalidMaxParticipants => 'Proszę wprowadzić poprawną liczbę';
	@override String get enterPrice => 'Proszę wprowadzić cenę';
	@override String get invalidPrice => 'Proszę wprowadzić poprawną cenę';
	@override String get enterImage => 'Proszę wprowadzić URL obrazu';
	@override String get joinEvent => 'Dołącz do wydarzenia';
	@override String get eventNotStarted => 'Link do połączenia będzie dostępny tutaj, gdy wydarzenie się rozpocznie.';
}

// Path: error
class _TranslationsErrorPl implements TranslationsErrorEn {
	_TranslationsErrorPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get details => 'Błąd: {{error}}';
	@override String get general => 'Wystąpił błąd';
	@override String get no_results => 'Nie znaleziono żadnych wyników';
	@override String get no_internet => 'Brak połączenia z internetem';
	@override String get no_internet_description => 'Proszę sprawdzić połączenie z internetem i spróbować ponownie';
	@override String get no_events => 'Brak wydarzeń';
	@override String get no_events_description => 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
	@override String get no_events_found => 'Nie znaleziono wydarzeń';
	@override String get no_events_found_description => 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
	@override String get no_events_found_title => 'Nie znaleziono wydarzeń';
	@override String get no_events_found_description_title => 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
	@override String get no_events_found_description_title_search => 'Nie znaleziono żadnych wydarzeń dla podanego wyszukiwania. Proszę spróbować z innym terminem';
	@override String get loadingEvents => 'Wystąpił błąd podczas ładowania wydarzeń';
	@override String get failedToResetPassword => 'Nie udało się zresetować hasła';
}

// Path: auth
class _TranslationsAuthPl implements TranslationsAuthEn {
	_TranslationsAuthPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Zapomniałeś hasła?';
	@override String get enterEmail => 'Podaj swój adres e-mail, aby otrzymać instrukcje resetowania';
	@override String get resetPassword => 'Zresetuj hasło';
	@override String get enterNewPassword => 'Podaj nowe hasło';
	@override String get resetInstructionsSent => 'Instrukcje resetowania zostały wysłane na twój e-mail';
	@override String get passwordResertSuccess => 'Twoje hasło zostało pomyślnie zresetowane';
}

// Path: verify
class _TranslationsVerifyPl implements TranslationsVerifyEn {
	_TranslationsVerifyPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Weryfikacja kodu';
	@override String get description => 'Wprowadź kod weryfikacyjny wysłany na twój e-mail';
	@override String get inputLabel => 'Kod weryfikacyjny';
	@override String get button => 'Sprawdź';
	@override String get error => 'Proszę wprowadzić kod weryfikacyjny';
}

// Path: profile
class _TranslationsProfilePl implements TranslationsProfileEn {
	_TranslationsProfilePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Edytuj mój profil';
	@override String get firstname => 'Imię';
	@override String get lastname => 'Nazwisko';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Data urodzenia';
	@override String get address => 'Adres';
	@override String get save => 'Zapisz';
	@override String get cancel => 'Anuluj';
	@override String get enterFirstname => 'Proszę wprowadzić imię';
	@override String get enterLastname => 'Proszę wprowadzić nazwisko';
	@override String get enterEmail => 'Proszę wprowadzić adres e-mail';
	@override String get invalidEmail => 'Proszę wprowadzić poprawny adres e-mail';
	@override String get logout => 'Wyloguj się';
}

// Path: resources
class _TranslationsResourcesPl implements TranslationsResourcesEn {
	_TranslationsResourcesPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Dostępne zasoby';
	@override String get name => 'Nazwa';
	@override String get type => 'Typ';
}

// Path: messages
class _TranslationsMessagesPl implements TranslationsMessagesEn {
	_TranslationsMessagesPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Najnowsze wiadomości';
	@override String get seeAllMessages => 'Zobacz wszystkie wiadomości';
	@override String get noMessages => 'Brak wiadomości';
	@override String get writeMessageHint => 'Napisz wiadomość...';
	@override String get sendMessage => 'Wyślij';
}

// Path: common
class _TranslationsCommonPl implements TranslationsCommonEn {
	_TranslationsCommonPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Nadawca';
	@override String get message => 'Wiadomość';
}

// Path: settings
class _TranslationsSettingsPl implements TranslationsSettingsEn {
	_TranslationsSettingsPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get account => 'Konto';
	@override String get settings => 'Ustawienia';
	@override String get language => 'Język';
	@override String get manageSubjects => 'Zarządzanie przedmiotami';
	@override String get notifications => 'Powiadomienia';
	@override String get about => 'O aplikacji';
	@override String get contact => 'Kontakt';
	@override String get terms => 'Warunki użytkowania';
	@override String get privacy => 'Polityka prywatności';
}

// Path: page
class _TranslationsPagePl implements TranslationsPageEn {
	_TranslationsPagePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get home => 'Strona główna';
	@override String get homePage => 'Strona główna';
	@override String get profile => 'Profil';
	@override String get profilePage => 'Strona profilu';
	@override String get settings => 'Ustawienia';
	@override String get settingsPage => 'Strona ustawień';
	@override String get search => 'Szukaj';
	@override String get searchPage => 'Strona wyszukiwania';
	@override String get sheet => 'Notatka';
	@override String get sheetPage => 'Strona notatki';
	@override String get subject => 'Przedmiot';
	@override String get subjectPage => 'Strona przedmiotu';
	@override String get topic => 'Temat';
	@override String get topicPage => 'Strona tematu';
	@override String get event => 'Wydarzenie';
	@override String get eventPage => 'Strona wydarzenia';
	@override String get user => 'Użytkownik';
	@override String get userPage => 'Strona użytkownika';
	@override String get about => 'O nas';
	@override String get aboutPage => 'Strona o nas';
	@override String get contact => 'Kontakt';
	@override String get contactPage => 'Strona kontaktowa';
	@override String get terms => 'Warunki korzystania';
	@override String get termsPage => 'Strona warunków korzystania';
	@override String get privacy => 'Polityka prywatności';
	@override String get privacyPage => 'Strona polityki prywatności';
	@override String get notifications => 'Powiadomienia';
	@override String get events => 'Wydarzenia';
	@override String get sheets => 'Notatki';
	@override String get subjects => 'Przedmioty';
	@override String get topics => 'Tematy';
	@override String get users => 'Użytkownicy';
	@override String get help => 'Pomoc';
	@override String get helpPage => 'Strona pomocy';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Zaloguj się';
			case 'app.signup': return 'Zarejestruj się';
			case 'app.logout': return 'Wyloguj się';
			case 'app.search': return 'Szukaj';
			case 'app.searchLanguage': return 'Szukaj języka';
			case 'app.add': return 'Dodaj';
			case 'app.edit': return 'Edytuj';
			case 'app.delete': return 'Usuń';
			case 'app.cancel': return 'Anuluj';
			case 'app.save': return 'Zapisz';
			case 'app.yes': return 'Tak';
			case 'app.no': return 'Nie';
			case 'app.confirm': return 'Potwierdź';
			case 'app.error': return 'Błąd';
			case 'app.loading': return 'Ładowanie...';
			case 'app.noResults': return 'Brak wyników';
			case 'app.noResultsFound': return 'Nie znaleziono wyników';
			case 'app.skip': return 'Pomiń';
			case 'app.next': return 'Następny';
			case 'app.previous': return 'Poprzedni';
			case 'app.finish': return 'Zakończ';
			case 'app.back': return 'Powrót';
			case 'app.submit': return 'Wyślij';
			case 'app.searchUser': return 'Szukaj użytkownika';
			case 'app.searchSubject': return 'Szukaj przedmiotu';
			case 'app.searchTopic': return 'Szukaj tematu';
			case 'app.searchSheet': return 'Szukaj notatki';
			case 'app.alreadyHaveAccount': return 'Masz już konto?';
			case 'app.loadingIndicator': return 'Ładowanie...';
			case 'app.errorOccurred': return 'Wystąpił błąd';
			case 'app.backTo': return 'Powrót do ';
			case 'app.unknown': return 'Nieznane';
			case 'user.email': return 'Email';
			case 'user.username': return 'Nazwa użytkownika';
			case 'user.name': return 'Nazwisko';
			case 'user.firstname': return 'Imię';
			case 'user.birthdate': return 'Data urodzenia';
			case 'user.location': return 'Miejsce';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Liczba zgłoszeń';
			case 'user.address': return 'Adres';
			case 'user.password': return 'Hasło';
			case 'user.newPassword': return 'Nowe hasło';
			case 'user.anonymous': return 'Anonimowy';
			case 'user.noDescription': return 'Brak opisu';
			case 'user.noAddress': return 'Adres niedostępny';
			case 'user.noReportsAvailable': return 'Liczba zgłoszeń niedostępna';
			case 'user.noBio': return 'Brak dostępnych informacji o biografii';
			case 'user.noBirthdate': return 'Data urodzenia niedostępna';
			case 'user.noLocation': return 'Miejsce niedostępne';
			case 'user.noEmail': return 'Email niedostępny';
			case 'user.noUsername': return 'Nazwa użytkownika niedostępna';
			case 'user.noName': return 'Imię i nazwisko niedostępne';
			case 'user.noFirstname': return 'Imię niedostępne';
			case 'user.you': return 'ty';
			case 'user.me': return '(ja)';
			case 'welcome.welcome': return 'Witamy w Edumeet, platformie do wspólnej nauki';
			case 'welcome.setup': return 'Zacznijmy od wyboru języka';
			case 'welcome.whatLanguage': return 'W jakim języku mówisz?';
			case 'welcome.chooseLanguage': return 'Wybierz język, abyśmy mogli się komunikować';
			case 'welcome.title1': return 'Znajdź swoje notatki do nauki';
			case 'welcome.description1': return 'Uzyskaj dostęp do tysięcy notatek do nauki stworzonych przez studentów za darmo';
			case 'welcome.title2': return 'Organizuj swoje nauki';
			case 'welcome.description2': return 'Sortuj i organizuj swoje notatki dla skutecznej pamięci';
			case 'welcome.title3': return 'Pozostań zmotywowany';
			case 'welcome.description3': return 'Osiągaj swoje cele dzięki praktycznym wskazówkom';
			case 'welcome.title4': return 'Dołącz do naszej społeczności';
			case 'welcome.description4': return 'Dziel się swoimi notatkami i otrzymuj spersonalizowane porady';
			case 'login.title': return 'Logowanie';
			case 'login.description': return 'Wprowadź swoje dane poniżej, aby się zalogować';
			case 'login.forgotPassword': return 'Zapomniałeś hasła?';
			case 'login.noAccount': return 'Nie masz konta?';
			case 'login.createAccount': return 'Utwórz konto';
			case 'register.title': return 'Załóż konto';
			case 'register.description': return 'Dołącz do nas, aby korzystać z naszych usług';
			case 'register.conditions': return 'Tworząc konto, akceptujesz nasze Warunki korzystania i Politykę prywatności';
			case 'register.registerConfirm': return 'Rejestracja potwierdzona';
			case 'form.emptyUsername': return 'Proszę wprowadzić nazwę użytkownika';
			case 'form.emptyFirstname': return 'Proszę wprowadzić imię';
			case 'form.emptyEmail': return 'Proszę wprowadzić adres email';
			case 'form.emptyLastname': return 'Proszę wprowadzić nazwisko';
			case 'form.emptyPassword': return 'Proszę wprowadzić hasło';
			case 'form.emptyConfirmPassword': return 'Proszę potwierdzić hasło';
			case 'form.passwordMismatch': return 'Hasła się nie zgadzają';
			case 'form.invalidEmail': return 'Proszę wprowadzić poprawny adres e-mail';
			case 'form.invalidAddress': return 'Proszę wprowadzić poprawny adres';
			case 'form.shortPassword': return 'Hasło musi mieć co najmniej 8 znaków';
			case 'form.passwordUpperCase': return 'Hasło musi zawierać przynajmniej jedną dużą literę';
			case 'form.passwordDigit': return 'Hasło musi zawierać przynajmniej jedną cyfrę';
			case 'form.passwordSpecialChar': return 'Hasło musi zawierać przynajmniej jeden znak specjalny';
			case 'form.haveToAcceptConditions': return 'Musisz zaakceptować warunki korzystania i politykę prywatności';
			case 'form.confirmPassword': return 'Potwierdź hasło';
			case 'form.pleaseConfirmPassword': return 'Proszę potwierdzić hasło';
			case 'form.passwordNotMatch': return 'Hasła się nie zgadzają';
			case 'form.invalidUsername': return 'Nazwa użytkownika musi:\n- mieć od 3 do 20 znaków\n- zaczynać się od litery\n- nie zawierać znaków specjalnych';
			case 'swipe_cards.loading_error': return 'Błąd ładowania wydarzeń';
			case 'swipe_cards.end_of_list': return 'Osiągnąłeś koniec listy!';
			case 'swipe_cards.nope': return 'Nie dla {{title}}';
			case 'swipe_cards.joined_event': return 'Dołączyłeś do wydarzenia {{title}}';
			case 'swipe_cards.item_changed': return 'Element zmieniony: {{title}}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Fizyczny';
			case 'event.participants': return 'Uczestnicy';
			case 'event.hasJoinEvent': return 'Dołączyłeś do wydarzenia {{event_title}}';
			case 'event.address_copied': return 'Adres skopiowany do schowka';
			case 'event.createEvent': return 'Utwórz wydarzenie';
			case 'event.name': return 'Nazwa';
			case 'event.description': return 'Opis';
			case 'event.date': return 'Data';
			case 'event.time': return 'Czas';
			case 'event.location': return 'Miejsce';
			case 'event.maxParticipants': return 'Liczba uczestników';
			case 'event.price': return 'Cena';
			case 'event.image': return 'Obraz';
			case 'event.create': return 'Utwórz';
			case 'event.enterName': return 'Proszę wprowadzić nazwę';
			case 'event.enterDescription': return 'Proszę wprowadzić opis';
			case 'event.enterDate': return 'Proszę wprowadzić datę';
			case 'event.enterTime': return 'Proszę wprowadzić czas';
			case 'event.enterLocation': return 'Proszę wprowadzić miejsce';
			case 'event.enterMaxParticipants': return 'Proszę wprowadzić liczbę uczestników';
			case 'event.invalidMaxParticipants': return 'Proszę wprowadzić poprawną liczbę';
			case 'event.enterPrice': return 'Proszę wprowadzić cenę';
			case 'event.invalidPrice': return 'Proszę wprowadzić poprawną cenę';
			case 'event.enterImage': return 'Proszę wprowadzić URL obrazu';
			case 'event.joinEvent': return 'Dołącz do wydarzenia';
			case 'event.eventNotStarted': return 'Link do połączenia będzie dostępny tutaj, gdy wydarzenie się rozpocznie.';
			case 'error.details': return 'Błąd: {{error}}';
			case 'error.general': return 'Wystąpił błąd';
			case 'error.no_results': return 'Nie znaleziono żadnych wyników';
			case 'error.no_internet': return 'Brak połączenia z internetem';
			case 'error.no_internet_description': return 'Proszę sprawdzić połączenie z internetem i spróbować ponownie';
			case 'error.no_events': return 'Brak wydarzeń';
			case 'error.no_events_description': return 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
			case 'error.no_events_found': return 'Nie znaleziono wydarzeń';
			case 'error.no_events_found_description': return 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
			case 'error.no_events_found_title': return 'Nie znaleziono wydarzeń';
			case 'error.no_events_found_description_title': return 'Nie znaleziono żadnych wydarzeń. Proszę spróbować później';
			case 'error.no_events_found_description_title_search': return 'Nie znaleziono żadnych wydarzeń dla podanego wyszukiwania. Proszę spróbować z innym terminem';
			case 'error.loadingEvents': return 'Wystąpił błąd podczas ładowania wydarzeń';
			case 'error.failedToResetPassword': return 'Nie udało się zresetować hasła';
			case 'auth.forgotPassword': return 'Zapomniałeś hasła?';
			case 'auth.enterEmail': return 'Podaj swój adres e-mail, aby otrzymać instrukcje resetowania';
			case 'auth.resetPassword': return 'Zresetuj hasło';
			case 'auth.enterNewPassword': return 'Podaj nowe hasło';
			case 'auth.resetInstructionsSent': return 'Instrukcje resetowania zostały wysłane na twój e-mail';
			case 'auth.passwordResertSuccess': return 'Twoje hasło zostało pomyślnie zresetowane';
			case 'verify.title': return 'Weryfikacja kodu';
			case 'verify.description': return 'Wprowadź kod weryfikacyjny wysłany na twój e-mail';
			case 'verify.inputLabel': return 'Kod weryfikacyjny';
			case 'verify.button': return 'Sprawdź';
			case 'verify.error': return 'Proszę wprowadzić kod weryfikacyjny';
			case 'profile.editProfile': return 'Edytuj mój profil';
			case 'profile.firstname': return 'Imię';
			case 'profile.lastname': return 'Nazwisko';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Data urodzenia';
			case 'profile.address': return 'Adres';
			case 'profile.save': return 'Zapisz';
			case 'profile.cancel': return 'Anuluj';
			case 'profile.enterFirstname': return 'Proszę wprowadzić imię';
			case 'profile.enterLastname': return 'Proszę wprowadzić nazwisko';
			case 'profile.enterEmail': return 'Proszę wprowadzić adres e-mail';
			case 'profile.invalidEmail': return 'Proszę wprowadzić poprawny adres e-mail';
			case 'profile.logout': return 'Wyloguj się';
			case 'resources.availableResources': return 'Dostępne zasoby';
			case 'resources.name': return 'Nazwa';
			case 'resources.type': return 'Typ';
			case 'messages.latestMessages': return 'Najnowsze wiadomości';
			case 'messages.seeAllMessages': return 'Zobacz wszystkie wiadomości';
			case 'messages.noMessages': return 'Brak wiadomości';
			case 'messages.writeMessageHint': return 'Napisz wiadomość...';
			case 'messages.sendMessage': return 'Wyślij';
			case 'common.sender': return 'Nadawca';
			case 'common.message': return 'Wiadomość';
			case 'settings.account': return 'Konto';
			case 'settings.settings': return 'Ustawienia';
			case 'settings.language': return 'Język';
			case 'settings.manageSubjects': return 'Zarządzanie przedmiotami';
			case 'settings.notifications': return 'Powiadomienia';
			case 'settings.about': return 'O aplikacji';
			case 'settings.contact': return 'Kontakt';
			case 'settings.terms': return 'Warunki użytkowania';
			case 'settings.privacy': return 'Polityka prywatności';
			case 'page.home': return 'Strona główna';
			case 'page.homePage': return 'Strona główna';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Strona profilu';
			case 'page.settings': return 'Ustawienia';
			case 'page.settingsPage': return 'Strona ustawień';
			case 'page.search': return 'Szukaj';
			case 'page.searchPage': return 'Strona wyszukiwania';
			case 'page.sheet': return 'Notatka';
			case 'page.sheetPage': return 'Strona notatki';
			case 'page.subject': return 'Przedmiot';
			case 'page.subjectPage': return 'Strona przedmiotu';
			case 'page.topic': return 'Temat';
			case 'page.topicPage': return 'Strona tematu';
			case 'page.event': return 'Wydarzenie';
			case 'page.eventPage': return 'Strona wydarzenia';
			case 'page.user': return 'Użytkownik';
			case 'page.userPage': return 'Strona użytkownika';
			case 'page.about': return 'O nas';
			case 'page.aboutPage': return 'Strona o nas';
			case 'page.contact': return 'Kontakt';
			case 'page.contactPage': return 'Strona kontaktowa';
			case 'page.terms': return 'Warunki korzystania';
			case 'page.termsPage': return 'Strona warunków korzystania';
			case 'page.privacy': return 'Polityka prywatności';
			case 'page.privacyPage': return 'Strona polityki prywatności';
			case 'page.notifications': return 'Powiadomienia';
			case 'page.events': return 'Wydarzenia';
			case 'page.sheets': return 'Notatki';
			case 'page.subjects': return 'Przedmioty';
			case 'page.topics': return 'Tematy';
			case 'page.users': return 'Użytkownicy';
			case 'page.help': return 'Pomoc';
			case 'page.helpPage': return 'Strona pomocy';
			default: return null;
		}
	}
}


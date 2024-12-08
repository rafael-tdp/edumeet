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
	@override String get hello => 'Cześć';
	@override String get save => 'Zapisz';
	@override late final _TranslationsLoginPl login = _TranslationsLoginPl._(_root);
	@override late final _TranslationsWelcomePl welcome = _TranslationsWelcomePl._(_root);
}

// Path: login
class _TranslationsLoginPl implements TranslationsLoginFr {
	_TranslationsLoginPl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get success => 'Logowanie udane';
	@override String get fail => 'Logowanie nieudane';
}

// Path: welcome
class _TranslationsWelcomePl implements TranslationsWelcomeFr {
	_TranslationsWelcomePl._(this._root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get chooseLanguage => 'Wybierz swój język';
	@override String get title1 => 'Odnajdź swoje karty do nauki';
	@override String get description1 => 'Dostęp do setek tysięcy \nkart do nauki utworzonych przez studentów za darmo';
	@override String get title2 => 'Organizuj swoją naukę';
	@override String get description2 => 'Sortuj i organizuj swoje karty dla skutecznej \npamięci';
	@override String get title3 => 'Pozostań zmotywowany';
	@override String get description3 => 'Osiągnij swoje cele dzięki praktycznym \nporadom';
	@override String get title4 => 'Dołącz do naszej społeczności';
	@override String get description4 => 'Podziel się swoimi kartami do nauki i \notrzymuj spersonalizowane porady';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Cześć';
			case 'save': return 'Zapisz';
			case 'login.success': return 'Logowanie udane';
			case 'login.fail': return 'Logowanie nieudane';
			case 'welcome.chooseLanguage': return 'Wybierz swój język';
			case 'welcome.title1': return 'Odnajdź swoje karty do nauki';
			case 'welcome.description1': return 'Dostęp do setek tysięcy \nkart do nauki utworzonych przez studentów za darmo';
			case 'welcome.title2': return 'Organizuj swoją naukę';
			case 'welcome.description2': return 'Sortuj i organizuj swoje karty dla skutecznej \npamięci';
			case 'welcome.title3': return 'Pozostań zmotywowany';
			case 'welcome.description3': return 'Osiągnij swoje cele dzięki praktycznym \nporadom';
			case 'welcome.title4': return 'Dołącz do naszej społeczności';
			case 'welcome.description4': return 'Podziel się swoimi kartami do nauki i \notrzymuj spersonalizowane porady';
			default: return null;
		}
	}
}


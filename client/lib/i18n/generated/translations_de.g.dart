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
	@override String get hello => 'Hallo';
	@override String get save => 'Speichern';
	@override late final _TranslationsLoginDe login = _TranslationsLoginDe._(_root);
	@override late final _TranslationsWelcomeDe welcome = _TranslationsWelcomeDe._(_root);
}

// Path: login
class _TranslationsLoginDe implements TranslationsLoginFr {
	_TranslationsLoginDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get success => 'Anmeldung erfolgreich';
	@override String get fail => 'Anmeldung fehlgeschlagen';
}

// Path: welcome
class _TranslationsWelcomeDe implements TranslationsWelcomeFr {
	_TranslationsWelcomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get chooseLanguage => 'Wählen Sie Ihre Sprache';
	@override String get title1 => 'Finde deine Lernkarten';
	@override String get description1 => 'Greife kostenlos auf Tausende von Lernkarten zu, die von Studenten erstellt wurden';
	@override String get title2 => 'Organisiere deine Lernkarten';
	@override String get description2 => 'Sortiere und organisiere deine Karten für ein besseres Gedächtnis';
	@override String get title3 => 'Bleib motiviert';
	@override String get description3 => 'Erreiche deine Ziele mit praktischen Tipps';
	@override String get title4 => 'Tritt unserer Gemeinschaft bei';
	@override String get description4 => 'Teile deine Lernkarten und erhalte personalisierte Ratschläge';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Hallo';
			case 'save': return 'Speichern';
			case 'login.success': return 'Anmeldung erfolgreich';
			case 'login.fail': return 'Anmeldung fehlgeschlagen';
			case 'welcome.chooseLanguage': return 'Wählen Sie Ihre Sprache';
			case 'welcome.title1': return 'Finde deine Lernkarten';
			case 'welcome.description1': return 'Greife kostenlos auf Tausende von Lernkarten zu, die von Studenten erstellt wurden';
			case 'welcome.title2': return 'Organisiere deine Lernkarten';
			case 'welcome.description2': return 'Sortiere und organisiere deine Karten für ein besseres Gedächtnis';
			case 'welcome.title3': return 'Bleib motiviert';
			case 'welcome.description3': return 'Erreiche deine Ziele mit praktischen Tipps';
			case 'welcome.title4': return 'Tritt unserer Gemeinschaft bei';
			case 'welcome.description4': return 'Teile deine Lernkarten und erhalte personalisierte Ratschläge';
			default: return null;
		}
	}
}


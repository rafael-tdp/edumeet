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
	@override String get hello => 'Ciao';
	@override String get save => 'Salva';
	@override late final _TranslationsLoginIt login = _TranslationsLoginIt._(_root);
	@override late final _TranslationsWelcomeIt welcome = _TranslationsWelcomeIt._(_root);
}

// Path: login
class _TranslationsLoginIt implements TranslationsLoginFr {
	_TranslationsLoginIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get success => 'Accesso riuscito';
	@override String get fail => 'Accesso fallito';
}

// Path: welcome
class _TranslationsWelcomeIt implements TranslationsWelcomeFr {
	_TranslationsWelcomeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get chooseLanguage => 'Scegli la tua lingua';
	@override String get title1 => 'Trova le tue schede di revisione';
	@override String get description1 => 'Accedi gratuitamente a migliaia di \nschede di revisione create da studenti';
	@override String get title2 => 'Organizza le tue revisioni';
	@override String get description2 => 'Classifica e organizza le tue schede per una \nmigliore memoria';
	@override String get title3 => 'Rimani motivato';
	@override String get description3 => 'Raggiungi i tuoi obiettivi con consigli \npratici';
	@override String get title4 => 'Unisciti alla nostra comunità';
	@override String get description4 => 'Condividi le tue schede di revisione e \nricevi consigli personalizzati';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Ciao';
			case 'save': return 'Salva';
			case 'login.success': return 'Accesso riuscito';
			case 'login.fail': return 'Accesso fallito';
			case 'welcome.chooseLanguage': return 'Scegli la tua lingua';
			case 'welcome.title1': return 'Trova le tue schede di revisione';
			case 'welcome.description1': return 'Accedi gratuitamente a migliaia di \nschede di revisione create da studenti';
			case 'welcome.title2': return 'Organizza le tue revisioni';
			case 'welcome.description2': return 'Classifica e organizza le tue schede per una \nmigliore memoria';
			case 'welcome.title3': return 'Rimani motivato';
			case 'welcome.description3': return 'Raggiungi i tuoi obiettivi con consigli \npratici';
			case 'welcome.title4': return 'Unisciti alla nostra comunità';
			case 'welcome.description4': return 'Condividi le tue schede di revisione e \nricevi consigli personalizzati';
			default: return null;
		}
	}
}


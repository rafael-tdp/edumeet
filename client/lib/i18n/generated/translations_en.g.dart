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
class TranslationsEn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override String get hello => 'Hello';
	@override String get save => 'Save';
	@override late final _TranslationsLoginEn login = _TranslationsLoginEn._(_root);
	@override late final _TranslationsWelcomeEn welcome = _TranslationsWelcomeEn._(_root);
}

// Path: login
class _TranslationsLoginEn implements TranslationsLoginFr {
	_TranslationsLoginEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get success => 'Login successful';
	@override String get fail => 'Login failed';
}

// Path: welcome
class _TranslationsWelcomeEn implements TranslationsWelcomeFr {
	_TranslationsWelcomeEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get chooseLanguage => 'Choose your language';
	@override String get title1 => 'Find your review sheets';
	@override String get description1 => 'Access thousands of review sheets created by students for free';
	@override String get title2 => 'Organize your reviews';
	@override String get description2 => 'Sort and organize your sheets for better memory';
	@override String get title3 => 'Stay motivated';
	@override String get description3 => 'Achieve your goals with practical tips';
	@override String get title4 => 'Join our community';
	@override String get description4 => 'Share your review sheets and receive personalized advice';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Hello';
			case 'save': return 'Save';
			case 'login.success': return 'Login successful';
			case 'login.fail': return 'Login failed';
			case 'welcome.chooseLanguage': return 'Choose your language';
			case 'welcome.title1': return 'Find your review sheets';
			case 'welcome.description1': return 'Access thousands of review sheets created by students for free';
			case 'welcome.title2': return 'Organize your reviews';
			case 'welcome.description2': return 'Sort and organize your sheets for better memory';
			case 'welcome.title3': return 'Stay motivated';
			case 'welcome.description3': return 'Achieve your goals with practical tips';
			case 'welcome.title4': return 'Join our community';
			case 'welcome.description4': return 'Share your review sheets and receive personalized advice';
			default: return null;
		}
	}
}


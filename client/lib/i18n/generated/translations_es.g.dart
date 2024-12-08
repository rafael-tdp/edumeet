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
class TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override String get hello => 'Hola';
	@override String get save => 'Guardar';
	@override late final _TranslationsLoginEs login = _TranslationsLoginEs._(_root);
	@override late final _TranslationsWelcomeEs welcome = _TranslationsWelcomeEs._(_root);
}

// Path: login
class _TranslationsLoginEs implements TranslationsLoginFr {
	_TranslationsLoginEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get success => 'Inicio de sesión exitoso';
	@override String get fail => 'Fallo en el inicio de sesión';
}

// Path: welcome
class _TranslationsWelcomeEs implements TranslationsWelcomeFr {
	_TranslationsWelcomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get chooseLanguage => 'Elige tu idioma';
	@override String get title1 => 'Encuentra tus apuntes de revisión';
	@override String get description1 => 'Accede gratis a miles de \n apuntes de revisión creados por estudiantes';
	@override String get title2 => 'Organiza tus revisiones';
	@override String get description2 => 'Ordena y organiza tus apuntes para una \n memoria eficaz';
	@override String get title3 => 'Mantente motivado';
	@override String get description3 => 'Alcanza tus objetivos gracias a consejos \n prácticos';
	@override String get title4 => 'Únete a nuestra comunidad';
	@override String get description4 => 'Comparte tus apuntes de revisión y \n recibe consejos personalizados';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Hola';
			case 'save': return 'Guardar';
			case 'login.success': return 'Inicio de sesión exitoso';
			case 'login.fail': return 'Fallo en el inicio de sesión';
			case 'welcome.chooseLanguage': return 'Elige tu idioma';
			case 'welcome.title1': return 'Encuentra tus apuntes de revisión';
			case 'welcome.description1': return 'Accede gratis a miles de \n apuntes de revisión creados por estudiantes';
			case 'welcome.title2': return 'Organiza tus revisiones';
			case 'welcome.description2': return 'Ordena y organiza tus apuntes para una \n memoria eficaz';
			case 'welcome.title3': return 'Mantente motivado';
			case 'welcome.description3': return 'Alcanza tus objetivos gracias a consejos \n prácticos';
			case 'welcome.title4': return 'Únete a nuestra comunidad';
			case 'welcome.description4': return 'Comparte tus apuntes de revisión y \n recibe consejos personalizados';
			default: return null;
		}
	}
}


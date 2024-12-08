///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsFr = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get hello => 'Bonjour';
	String get save => 'Enregistrer';
	late final TranslationsLoginFr login = TranslationsLoginFr._(_root);
	late final TranslationsWelcomeFr welcome = TranslationsWelcomeFr._(_root);
}

// Path: login
class TranslationsLoginFr {
	TranslationsLoginFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get success => 'Connexion réussie';
	String get fail => 'Échec de la connexion';
}

// Path: welcome
class TranslationsWelcomeFr {
	TranslationsWelcomeFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get chooseLanguage => 'Choisissez votre langue';
	String get title1 => 'Retrouve tes fiches de révision';
	String get description1 => 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants';
	String get title2 => 'Organise tes révisions';
	String get description2 => 'Classe et organise tes fiches pour une \nmémoire efficace';
	String get title3 => 'Reste motivé';
	String get description3 => 'Atteins tes objectifs grâce à des conseils \npratiques';
	String get title4 => 'Rejoins notre communauté';
	String get description4 => 'Partage tes fiches de révision et \nreçois des conseils personnalisés';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return 'Bonjour';
			case 'save': return 'Enregistrer';
			case 'login.success': return 'Connexion réussie';
			case 'login.fail': return 'Échec de la connexion';
			case 'welcome.chooseLanguage': return 'Choisissez votre langue';
			case 'welcome.title1': return 'Retrouve tes fiches de révision';
			case 'welcome.description1': return 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants';
			case 'welcome.title2': return 'Organise tes révisions';
			case 'welcome.description2': return 'Classe et organise tes fiches pour une \nmémoire efficace';
			case 'welcome.title3': return 'Reste motivé';
			case 'welcome.description3': return 'Atteins tes objectifs grâce à des conseils \npratiques';
			case 'welcome.title4': return 'Rejoins notre communauté';
			case 'welcome.description4': return 'Partage tes fiches de révision et \nreçois des conseils personnalisés';
			default: return null;
		}
	}
}


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
class TranslationsFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppFr app = _TranslationsAppFr._(_root);
	@override late final _TranslationsUserFr user = _TranslationsUserFr._(_root);
	@override late final _TranslationsWelcomeFr welcome = _TranslationsWelcomeFr._(_root);
	@override late final _TranslationsLoginFr login = _TranslationsLoginFr._(_root);
	@override late final _TranslationsRegisterFr register = _TranslationsRegisterFr._(_root);
	@override late final _TranslationsFormFr form = _TranslationsFormFr._(_root);
	@override late final _TranslationsSwipeCardsFr swipe_cards = _TranslationsSwipeCardsFr._(_root);
	@override late final _TranslationsEventFr event = _TranslationsEventFr._(_root);
	@override late final _TranslationsErrorFr error = _TranslationsErrorFr._(_root);
	@override late final _TranslationsAuthFr auth = _TranslationsAuthFr._(_root);
	@override late final _TranslationsVerifyFr verify = _TranslationsVerifyFr._(_root);
	@override late final _TranslationsProfileFr profile = _TranslationsProfileFr._(_root);
	@override late final _TranslationsResourcesFr resources = _TranslationsResourcesFr._(_root);
	@override late final _TranslationsMessagesFr messages = _TranslationsMessagesFr._(_root);
	@override late final _TranslationsCommonFr common = _TranslationsCommonFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsPageFr page = _TranslationsPageFr._(_root);
}

// Path: app
class _TranslationsAppFr implements TranslationsAppEn {
	_TranslationsAppFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Se connecter';
	@override String get signup => 'S\'inscrire';
	@override String get logout => 'Se déconnecter';
	@override String get search => 'Rechercher';
	@override String get searchLanguage => 'Rechercher une langue';
	@override String get add => 'Ajouter';
	@override String get edit => 'Modifier';
	@override String get delete => 'Supprimer';
	@override String get cancel => 'Annuler';
	@override String get save => 'Enregistrer';
	@override String get yes => 'Oui';
	@override String get no => 'Non';
	@override String get confirm => 'Confirmer';
	@override String get error => 'Erreur';
	@override String get loading => 'Chargement...';
	@override String get noResults => 'Aucun résultat';
	@override String get noResultsFound => 'Aucun résultat trouvé';
	@override String get skip => 'Passer';
	@override String get next => 'Suivant';
	@override String get previous => 'Précédent';
	@override String get finish => 'Terminer';
	@override String get back => 'Retour';
	@override String get submit => 'Envoyer';
	@override String get searchUser => 'Rechercher un utilisateur';
	@override String get searchSubject => 'Rechercher une matière';
	@override String get searchTopic => 'Rechercher un thème';
	@override String get searchSheet => 'Rechercher une fiche';
	@override String get alreadyHaveAccount => 'Vous avez déjà un compte ?';
	@override String get loadingIndicator => 'Chargement...';
	@override String get errorOccurred => 'Une erreur est survenue';
	@override String get backTo => 'Retour à ';
	@override String get unknown => 'Inconnu';
}

// Path: user
class _TranslationsUserFr implements TranslationsUserEn {
	_TranslationsUserFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Nom d\'utilisateur';
	@override String get name => 'Nom';
	@override String get firstname => 'Prénom';
	@override String get birthdate => 'Date de naissance';
	@override String get location => 'Lieu';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Nombre de signalements';
	@override String get address => 'Adresse';
	@override String get password => 'Mot de passe';
	@override String get newPassword => 'Nouveau mot de passe';
	@override String get anonymous => 'Anonyme';
	@override String get noDescription => 'Aucune description';
	@override String get noAddress => 'Adresse non disponible';
	@override String get noReportsAvailable => 'Nombre de signalements non disponible';
	@override String get noBio => 'Bio non disponible';
	@override String get noBirthdate => 'Date de naissance non disponible';
	@override String get noLocation => 'Lieu non disponible';
	@override String get noEmail => 'Email non disponible';
	@override String get noUsername => 'Nom d\'utilisateur non disponible';
	@override String get noName => 'Nom non disponible';
	@override String get noFirstname => 'Prénom non disponible';
	@override String get you => 'vous';
}

// Path: welcome
class _TranslationsWelcomeFr implements TranslationsWelcomeEn {
	_TranslationsWelcomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Bienvenue sur Edumeet, la plateforme de révision collaborative';
	@override String get setup => 'Commençons par choisir une langue';
	@override String get whatLanguage => 'Quelle langue parles-tu ?';
	@override String get chooseLanguage => 'Choisis une langue pour que nous puissions communiquer ensemble';
	@override String get title1 => 'Retrouve tes fiches de révision';
	@override String get description1 => 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants';
	@override String get title2 => 'Organise tes révisions';
	@override String get description2 => 'Classe et organise tes fiches pour une \nmémoire efficace';
	@override String get title3 => 'Reste motivé';
	@override String get description3 => 'Atteins tes objectifs grâce à des conseils \npratiques';
	@override String get title4 => 'Rejoins notre communauté';
	@override String get description4 => 'Partage tes fiches de révision et \nreçois des conseils personnalisés';
}

// Path: login
class _TranslationsLoginFr implements TranslationsLoginEn {
	_TranslationsLoginFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connexion';
	@override String get description => 'Entrez vos informations ci-dessous pour vous connecter';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get noAccount => 'Vous n\'avez pas de compte ?';
	@override String get createAccount => 'Créer un compte';
}

// Path: register
class _TranslationsRegisterFr implements TranslationsRegisterEn {
	_TranslationsRegisterFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créer un compte';
	@override String get description => 'Rejoignez-nous pour bénéficier de nos services';
	@override String get conditions => 'En créant un compte, vous acceptez nos Conditions d\'utilisation et Politique de confidentialité';
	@override String get registerConfirm => 'Inscription confirmée';
}

// Path: form
class _TranslationsFormFr implements TranslationsFormEn {
	_TranslationsFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Veuillez entrer un nom d\'utilisateur';
	@override String get emptyFirstname => 'Veuillez entrer votre prénom';
	@override String get emptyEmail => 'Veuillez entrer votre adresse email';
	@override String get emptyLastname => 'Veuillez entrer votre nom';
	@override String get emptyPassword => 'Veuillez entrer votre mot de passe';
	@override String get emptyConfirmPassword => 'Veuillez confirmer votre mot de passe';
	@override String get passwordMismatch => 'Les mots de passe ne correspondent pas';
	@override String get invalidEmail => 'Veuillez entrer une adresse e-mail valide';
	@override String get invalidAddress => 'Veuillez entrer une adresse valide';
	@override String get shortPassword => 'Au moins 8 caractères';
	@override String get passwordUpperCase => 'Au moins une lettre majuscule';
	@override String get passwordDigit => 'Au moins un chiffre';
	@override String get passwordSpecialChar => 'Au moins un caractère spécial';
	@override String get haveToAcceptConditions => 'Vous devez accepter les conditions d\'utilisation et la politique de confidentialité';
	@override String get confirmPassword => 'Confirmer le mot de passe';
	@override String get pleaseConfirmPassword => 'Veuillez confirmer votre mot de passe';
	@override String get passwordNotMatch => 'Les mots de passe ne correspondent pas';
	@override String get invalidUsername => 'Le nom d\'utilisateur doit débuter par une lettre et contenir : \n- Au moins 3 caractères \n- Au maximum 20 caractères \n- Aucun caractères spéciaul';
}

// Path: swipe_cards
class _TranslationsSwipeCardsFr implements TranslationsSwipeCardsEn {
	_TranslationsSwipeCardsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Erreur de chargement des événements';
	@override String get end_of_list => 'Vous avez atteint la fin de la liste !';
	@override String get nope => 'Non à {{title}}';
	@override String get joined_event => 'Vous avez rejoint l\'événement {{title}}';
	@override String get item_changed => 'Item modifié: {{title}}';
}

// Path: event
class _TranslationsEventFr implements TranslationsEventEn {
	_TranslationsEventFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get online => 'En ligne';
	@override String get physical => 'Physique';
	@override String get participants => 'Participants';
	@override String get hasJoinEvent => 'Vous avez rejoint l\'événement {{event_title}}';
	@override String get address_copied => 'Adresse copiée dans le presse-papiers';
	@override String get createEvent => 'Créer un événement';
	@override String get name => 'Nom';
	@override String get description => 'Description';
	@override String get date => 'Date';
	@override String get time => 'Heure';
	@override String get location => 'Lieu';
	@override String get maxParticipants => 'Nombre de participants';
	@override String get price => 'Prix';
	@override String get image => 'Image';
	@override String get create => 'Créer';
	@override String get enterName => 'Veuillez entrer un nom';
	@override String get enterDescription => 'Veuillez entrer une description';
	@override String get enterDate => 'Veuillez entrer une date';
	@override String get enterTime => 'Veuillez entrer une heure';
	@override String get enterLocation => 'Veuillez entrer un lieu';
	@override String get enterMaxParticipants => 'Veuillez entrer un nombre de participants';
	@override String get invalidMaxParticipants => 'Veuillez entrer un nombre valide';
	@override String get enterPrice => 'Veuillez entrer un prix';
	@override String get invalidPrice => 'Veuillez entrer un prix valide';
	@override String get enterImage => 'Veuillez entrer une URL d\'image';
	@override String get joinEvent => 'Rejoindre l\'évènement';
	@override String get eventNotStarted => 'Le lien de connexion sera disponible ici lorsque l\'événement commencera.';
}

// Path: error
class _TranslationsErrorFr implements TranslationsErrorEn {
	_TranslationsErrorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get details => 'Erreur : {{error}}';
	@override String get general => 'Une erreur est survenue';
	@override String get no_results => 'Aucun résultat trouvé';
	@override String get no_internet => 'Pas de connexion Internet';
	@override String get no_internet_description => 'Veuillez vérifier votre connexion Internet et réessayer';
	@override String get no_events => 'Aucun événement trouvé';
	@override String get no_events_description => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	@override String get no_events_found => 'Aucun événement trouvé';
	@override String get no_events_found_description => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	@override String get no_events_found_title => 'Aucun événement trouvé';
	@override String get no_events_found_description_title => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	@override String get no_events_found_description_title_search => 'Aucun événement n\'a été trouvé pour la recherche effectuée. Veuillez réessayer avec un autre terme';
	@override String get loadingEvents => 'Une erreur est survenue lors du chargement des événements';
	@override String get failedToResetPassword => 'Échec de la réinitialisation du mot de passe';
}

// Path: auth
class _TranslationsAuthFr implements TranslationsAuthEn {
	_TranslationsAuthFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get enterEmail => 'Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation';
	@override String get resetPassword => 'Réinitialiser le mot de passe';
	@override String get enterNewPassword => 'Entrez votre nouveau mot de passe';
	@override String get resetInstructionsSent => 'Instructions de réinitialisation envoyées à votre e-mail';
	@override String get passwordResertSuccess => 'Votre mot de passe a été réinitialisé avec succès';
}

// Path: verify
class _TranslationsVerifyFr implements TranslationsVerifyEn {
	_TranslationsVerifyFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vérification du code';
	@override String get description => 'Entrez le code de vérification envoyé à votre e-mail';
	@override String get inputLabel => 'Code de vérification';
	@override String get button => 'Vérifier';
	@override String get error => 'Veuillez entrer le code de vérification';
}

// Path: profile
class _TranslationsProfileFr implements TranslationsProfileEn {
	_TranslationsProfileFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Modifier mon profil';
	@override String get firstname => 'Prénom';
	@override String get lastname => 'Nom';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Date de naissance';
	@override String get address => 'Adresse';
	@override String get save => 'Enregistrer';
	@override String get cancel => 'Annuler';
	@override String get enterFirstname => 'Veuillez entrer votre prénom';
	@override String get enterLastname => 'Veuillez entrer votre nom';
	@override String get enterEmail => 'Veuillez entrer votre adresse e-mail';
	@override String get invalidEmail => 'Veuillez entrer une adresse e-mail valide';
	@override String get logout => 'Se déconnecter';
}

// Path: resources
class _TranslationsResourcesFr implements TranslationsResourcesEn {
	_TranslationsResourcesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Ressources disponibles';
	@override String get name => 'Nom';
	@override String get type => 'Type';
}

// Path: messages
class _TranslationsMessagesFr implements TranslationsMessagesEn {
	_TranslationsMessagesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Derniers messages';
	@override String get seeAllMessages => 'Voir tous les messages';
	@override String get noMessages => 'Aucun message';
	@override String get writeMessageHint => 'Écrivez un message...';
	@override String get sendMessage => 'Envoyer';
}

// Path: common
class _TranslationsCommonFr implements TranslationsCommonEn {
	_TranslationsCommonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Expéditeur';
	@override String get message => 'Message';
}

// Path: settings
class _TranslationsSettingsFr implements TranslationsSettingsEn {
	_TranslationsSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get account => 'Compte';
	@override String get settings => 'Paramètres';
	@override String get language => 'Langue';
	@override String get manageSubjects => 'Gestion des matières';
	@override String get notifications => 'Notifications';
	@override String get about => 'À propos';
	@override String get contact => 'Contact';
	@override String get terms => 'Conditions d\'utilisation';
	@override String get privacy => 'Politique de confidentialité';
}

// Path: page
class _TranslationsPageFr implements TranslationsPageEn {
	_TranslationsPageFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get home => 'Accueil';
	@override String get homePage => 'Page d\'accueil';
	@override String get profile => 'Profil';
	@override String get profilePage => 'Page de profil';
	@override String get settings => 'Paramètres';
	@override String get settingsPage => 'Page des paramètres';
	@override String get search => 'Recherche';
	@override String get searchPage => 'Page de recherche';
	@override String get sheet => 'Fiche';
	@override String get sheetPage => 'Page de la fiche';
	@override String get subject => 'Matière';
	@override String get subjectPage => 'Page de la matière';
	@override String get topic => 'Thème';
	@override String get topicPage => 'Page du thème';
	@override String get event => 'Événement';
	@override String get eventPage => 'Page de l\'événement';
	@override String get user => 'Utilisateur';
	@override String get userPage => 'Page de l\'utilisateur';
	@override String get about => 'À propos';
	@override String get aboutPage => 'Page À propos';
	@override String get contact => 'Contact';
	@override String get contactPage => 'Page de contact';
	@override String get terms => 'Conditions d\'utilisation';
	@override String get termsPage => 'Page des conditions d\'utilisation';
	@override String get privacy => 'Politique de confidentialité';
	@override String get privacyPage => 'Page de la politique de confidentialité';
	@override String get notifications => 'Notifications';
	@override String get events => 'Événements';
	@override String get sheets => 'Fiches';
	@override String get subjects => 'Matières';
	@override String get topics => 'Thèmes';
	@override String get users => 'Utilisateurs';
	@override String get help => 'Aide';
	@override String get helpPage => 'Page d\'aide';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Se connecter';
			case 'app.signup': return 'S\'inscrire';
			case 'app.logout': return 'Se déconnecter';
			case 'app.search': return 'Rechercher';
			case 'app.searchLanguage': return 'Rechercher une langue';
			case 'app.add': return 'Ajouter';
			case 'app.edit': return 'Modifier';
			case 'app.delete': return 'Supprimer';
			case 'app.cancel': return 'Annuler';
			case 'app.save': return 'Enregistrer';
			case 'app.yes': return 'Oui';
			case 'app.no': return 'Non';
			case 'app.confirm': return 'Confirmer';
			case 'app.error': return 'Erreur';
			case 'app.loading': return 'Chargement...';
			case 'app.noResults': return 'Aucun résultat';
			case 'app.noResultsFound': return 'Aucun résultat trouvé';
			case 'app.skip': return 'Passer';
			case 'app.next': return 'Suivant';
			case 'app.previous': return 'Précédent';
			case 'app.finish': return 'Terminer';
			case 'app.back': return 'Retour';
			case 'app.submit': return 'Envoyer';
			case 'app.searchUser': return 'Rechercher un utilisateur';
			case 'app.searchSubject': return 'Rechercher une matière';
			case 'app.searchTopic': return 'Rechercher un thème';
			case 'app.searchSheet': return 'Rechercher une fiche';
			case 'app.alreadyHaveAccount': return 'Vous avez déjà un compte ?';
			case 'app.loadingIndicator': return 'Chargement...';
			case 'app.errorOccurred': return 'Une erreur est survenue';
			case 'app.backTo': return 'Retour à ';
			case 'app.unknown': return 'Inconnu';
			case 'user.email': return 'Email';
			case 'user.username': return 'Nom d\'utilisateur';
			case 'user.name': return 'Nom';
			case 'user.firstname': return 'Prénom';
			case 'user.birthdate': return 'Date de naissance';
			case 'user.location': return 'Lieu';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Nombre de signalements';
			case 'user.address': return 'Adresse';
			case 'user.password': return 'Mot de passe';
			case 'user.newPassword': return 'Nouveau mot de passe';
			case 'user.anonymous': return 'Anonyme';
			case 'user.noDescription': return 'Aucune description';
			case 'user.noAddress': return 'Adresse non disponible';
			case 'user.noReportsAvailable': return 'Nombre de signalements non disponible';
			case 'user.noBio': return 'Bio non disponible';
			case 'user.noBirthdate': return 'Date de naissance non disponible';
			case 'user.noLocation': return 'Lieu non disponible';
			case 'user.noEmail': return 'Email non disponible';
			case 'user.noUsername': return 'Nom d\'utilisateur non disponible';
			case 'user.noName': return 'Nom non disponible';
			case 'user.noFirstname': return 'Prénom non disponible';
			case 'user.you': return 'vous';
			case 'welcome.welcome': return 'Bienvenue sur Edumeet, la plateforme de révision collaborative';
			case 'welcome.setup': return 'Commençons par choisir une langue';
			case 'welcome.whatLanguage': return 'Quelle langue parles-tu ?';
			case 'welcome.chooseLanguage': return 'Choisis une langue pour que nous puissions communiquer ensemble';
			case 'welcome.title1': return 'Retrouve tes fiches de révision';
			case 'welcome.description1': return 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants';
			case 'welcome.title2': return 'Organise tes révisions';
			case 'welcome.description2': return 'Classe et organise tes fiches pour une \nmémoire efficace';
			case 'welcome.title3': return 'Reste motivé';
			case 'welcome.description3': return 'Atteins tes objectifs grâce à des conseils \npratiques';
			case 'welcome.title4': return 'Rejoins notre communauté';
			case 'welcome.description4': return 'Partage tes fiches de révision et \nreçois des conseils personnalisés';
			case 'login.title': return 'Connexion';
			case 'login.description': return 'Entrez vos informations ci-dessous pour vous connecter';
			case 'login.forgotPassword': return 'Mot de passe oublié ?';
			case 'login.noAccount': return 'Vous n\'avez pas de compte ?';
			case 'login.createAccount': return 'Créer un compte';
			case 'register.title': return 'Créer un compte';
			case 'register.description': return 'Rejoignez-nous pour bénéficier de nos services';
			case 'register.conditions': return 'En créant un compte, vous acceptez nos Conditions d\'utilisation et Politique de confidentialité';
			case 'register.registerConfirm': return 'Inscription confirmée';
			case 'form.emptyUsername': return 'Veuillez entrer un nom d\'utilisateur';
			case 'form.emptyFirstname': return 'Veuillez entrer votre prénom';
			case 'form.emptyEmail': return 'Veuillez entrer votre adresse email';
			case 'form.emptyLastname': return 'Veuillez entrer votre nom';
			case 'form.emptyPassword': return 'Veuillez entrer votre mot de passe';
			case 'form.emptyConfirmPassword': return 'Veuillez confirmer votre mot de passe';
			case 'form.passwordMismatch': return 'Les mots de passe ne correspondent pas';
			case 'form.invalidEmail': return 'Veuillez entrer une adresse e-mail valide';
			case 'form.invalidAddress': return 'Veuillez entrer une adresse valide';
			case 'form.shortPassword': return 'Au moins 8 caractères';
			case 'form.passwordUpperCase': return 'Au moins une lettre majuscule';
			case 'form.passwordDigit': return 'Au moins un chiffre';
			case 'form.passwordSpecialChar': return 'Au moins un caractère spécial';
			case 'form.haveToAcceptConditions': return 'Vous devez accepter les conditions d\'utilisation et la politique de confidentialité';
			case 'form.confirmPassword': return 'Confirmer le mot de passe';
			case 'form.pleaseConfirmPassword': return 'Veuillez confirmer votre mot de passe';
			case 'form.passwordNotMatch': return 'Les mots de passe ne correspondent pas';
			case 'form.invalidUsername': return 'Le nom d\'utilisateur doit débuter par une lettre et contenir : \n- Au moins 3 caractères \n- Au maximum 20 caractères \n- Aucun caractères spéciaul';
			case 'swipe_cards.loading_error': return 'Erreur de chargement des événements';
			case 'swipe_cards.end_of_list': return 'Vous avez atteint la fin de la liste !';
			case 'swipe_cards.nope': return 'Non à {{title}}';
			case 'swipe_cards.joined_event': return 'Vous avez rejoint l\'événement {{title}}';
			case 'swipe_cards.item_changed': return 'Item modifié: {{title}}';
			case 'event.online': return 'En ligne';
			case 'event.physical': return 'Physique';
			case 'event.participants': return 'Participants';
			case 'event.hasJoinEvent': return 'Vous avez rejoint l\'événement {{event_title}}';
			case 'event.address_copied': return 'Adresse copiée dans le presse-papiers';
			case 'event.createEvent': return 'Créer un événement';
			case 'event.name': return 'Nom';
			case 'event.description': return 'Description';
			case 'event.date': return 'Date';
			case 'event.time': return 'Heure';
			case 'event.location': return 'Lieu';
			case 'event.maxParticipants': return 'Nombre de participants';
			case 'event.price': return 'Prix';
			case 'event.image': return 'Image';
			case 'event.create': return 'Créer';
			case 'event.enterName': return 'Veuillez entrer un nom';
			case 'event.enterDescription': return 'Veuillez entrer une description';
			case 'event.enterDate': return 'Veuillez entrer une date';
			case 'event.enterTime': return 'Veuillez entrer une heure';
			case 'event.enterLocation': return 'Veuillez entrer un lieu';
			case 'event.enterMaxParticipants': return 'Veuillez entrer un nombre de participants';
			case 'event.invalidMaxParticipants': return 'Veuillez entrer un nombre valide';
			case 'event.enterPrice': return 'Veuillez entrer un prix';
			case 'event.invalidPrice': return 'Veuillez entrer un prix valide';
			case 'event.enterImage': return 'Veuillez entrer une URL d\'image';
			case 'event.joinEvent': return 'Rejoindre l\'évènement';
			case 'event.eventNotStarted': return 'Le lien de connexion sera disponible ici lorsque l\'événement commencera.';
			case 'error.details': return 'Erreur : {{error}}';
			case 'error.general': return 'Une erreur est survenue';
			case 'error.no_results': return 'Aucun résultat trouvé';
			case 'error.no_internet': return 'Pas de connexion Internet';
			case 'error.no_internet_description': return 'Veuillez vérifier votre connexion Internet et réessayer';
			case 'error.no_events': return 'Aucun événement trouvé';
			case 'error.no_events_description': return 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
			case 'error.no_events_found': return 'Aucun événement trouvé';
			case 'error.no_events_found_description': return 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
			case 'error.no_events_found_title': return 'Aucun événement trouvé';
			case 'error.no_events_found_description_title': return 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
			case 'error.no_events_found_description_title_search': return 'Aucun événement n\'a été trouvé pour la recherche effectuée. Veuillez réessayer avec un autre terme';
			case 'error.loadingEvents': return 'Une erreur est survenue lors du chargement des événements';
			case 'error.failedToResetPassword': return 'Échec de la réinitialisation du mot de passe';
			case 'auth.forgotPassword': return 'Mot de passe oublié ?';
			case 'auth.enterEmail': return 'Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation';
			case 'auth.resetPassword': return 'Réinitialiser le mot de passe';
			case 'auth.enterNewPassword': return 'Entrez votre nouveau mot de passe';
			case 'auth.resetInstructionsSent': return 'Instructions de réinitialisation envoyées à votre e-mail';
			case 'auth.passwordResertSuccess': return 'Votre mot de passe a été réinitialisé avec succès';
			case 'verify.title': return 'Vérification du code';
			case 'verify.description': return 'Entrez le code de vérification envoyé à votre e-mail';
			case 'verify.inputLabel': return 'Code de vérification';
			case 'verify.button': return 'Vérifier';
			case 'verify.error': return 'Veuillez entrer le code de vérification';
			case 'profile.editProfile': return 'Modifier mon profil';
			case 'profile.firstname': return 'Prénom';
			case 'profile.lastname': return 'Nom';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Date de naissance';
			case 'profile.address': return 'Adresse';
			case 'profile.save': return 'Enregistrer';
			case 'profile.cancel': return 'Annuler';
			case 'profile.enterFirstname': return 'Veuillez entrer votre prénom';
			case 'profile.enterLastname': return 'Veuillez entrer votre nom';
			case 'profile.enterEmail': return 'Veuillez entrer votre adresse e-mail';
			case 'profile.invalidEmail': return 'Veuillez entrer une adresse e-mail valide';
			case 'profile.logout': return 'Se déconnecter';
			case 'resources.availableResources': return 'Ressources disponibles';
			case 'resources.name': return 'Nom';
			case 'resources.type': return 'Type';
			case 'messages.latestMessages': return 'Derniers messages';
			case 'messages.seeAllMessages': return 'Voir tous les messages';
			case 'messages.noMessages': return 'Aucun message';
			case 'messages.writeMessageHint': return 'Écrivez un message...';
			case 'messages.sendMessage': return 'Envoyer';
			case 'common.sender': return 'Expéditeur';
			case 'common.message': return 'Message';
			case 'settings.account': return 'Compte';
			case 'settings.settings': return 'Paramètres';
			case 'settings.language': return 'Langue';
			case 'settings.manageSubjects': return 'Gestion des matières';
			case 'settings.notifications': return 'Notifications';
			case 'settings.about': return 'À propos';
			case 'settings.contact': return 'Contact';
			case 'settings.terms': return 'Conditions d\'utilisation';
			case 'settings.privacy': return 'Politique de confidentialité';
			case 'page.home': return 'Accueil';
			case 'page.homePage': return 'Page d\'accueil';
			case 'page.profile': return 'Profil';
			case 'page.profilePage': return 'Page de profil';
			case 'page.settings': return 'Paramètres';
			case 'page.settingsPage': return 'Page des paramètres';
			case 'page.search': return 'Recherche';
			case 'page.searchPage': return 'Page de recherche';
			case 'page.sheet': return 'Fiche';
			case 'page.sheetPage': return 'Page de la fiche';
			case 'page.subject': return 'Matière';
			case 'page.subjectPage': return 'Page de la matière';
			case 'page.topic': return 'Thème';
			case 'page.topicPage': return 'Page du thème';
			case 'page.event': return 'Événement';
			case 'page.eventPage': return 'Page de l\'événement';
			case 'page.user': return 'Utilisateur';
			case 'page.userPage': return 'Page de l\'utilisateur';
			case 'page.about': return 'À propos';
			case 'page.aboutPage': return 'Page À propos';
			case 'page.contact': return 'Contact';
			case 'page.contactPage': return 'Page de contact';
			case 'page.terms': return 'Conditions d\'utilisation';
			case 'page.termsPage': return 'Page des conditions d\'utilisation';
			case 'page.privacy': return 'Politique de confidentialité';
			case 'page.privacyPage': return 'Page de la politique de confidentialité';
			case 'page.notifications': return 'Notifications';
			case 'page.events': return 'Événements';
			case 'page.sheets': return 'Fiches';
			case 'page.subjects': return 'Matières';
			case 'page.topics': return 'Thèmes';
			case 'page.users': return 'Utilisateurs';
			case 'page.help': return 'Aide';
			case 'page.helpPage': return 'Page d\'aide';
			default: return null;
		}
	}
}


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
	late final TranslationsAppFr app = TranslationsAppFr._(_root);
	late final TranslationsUserFr user = TranslationsUserFr._(_root);
	late final TranslationsWelcomeFr welcome = TranslationsWelcomeFr._(_root);
	late final TranslationsLoginFr login = TranslationsLoginFr._(_root);
	late final TranslationsRegisterFr register = TranslationsRegisterFr._(_root);
	late final TranslationsFormFr form = TranslationsFormFr._(_root);
	late final TranslationsSwipeCardsFr swipe_cards = TranslationsSwipeCardsFr._(_root);
	late final TranslationsEventFr event = TranslationsEventFr._(_root);
	late final TranslationsErrorFr error = TranslationsErrorFr._(_root);
	late final TranslationsAuthFr auth = TranslationsAuthFr._(_root);
	late final TranslationsVerifyFr verify = TranslationsVerifyFr._(_root);
	late final TranslationsProfileFr profile = TranslationsProfileFr._(_root);
	late final TranslationsResourcesFr resources = TranslationsResourcesFr._(_root);
	late final TranslationsMessagesFr messages = TranslationsMessagesFr._(_root);
	late final TranslationsCommonFr common = TranslationsCommonFr._(_root);
	late final TranslationsSettingsFr settings = TranslationsSettingsFr._(_root);
	late final TranslationsPageFr page = TranslationsPageFr._(_root);
}

// Path: app
class TranslationsAppFr {
	TranslationsAppFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Se connecter';
	String get signup => 'S\'inscrire';
	String get logout => 'Se déconnecter';
	String get search => 'Rechercher';
	String get searchLanguage => 'Rechercher une langue';
	String get add => 'Ajouter';
	String get edit => 'Modifier';
	String get delete => 'Supprimer';
	String get cancel => 'Annuler';
	String get save => 'Enregistrer';
	String get yes => 'Oui';
	String get no => 'Non';
	String get confirm => 'Confirmer';
	String get error => 'Erreur';
	String get loading => 'Chargement...';
	String get noResults => 'Aucun résultat';
	String get noResultsFound => 'Aucun résultat trouvé';
	String get skip => 'Passer';
	String get next => 'Suivant';
	String get previous => 'Précédent';
	String get finish => 'Terminer';
	String get back => 'Retour';
	String get submit => 'Envoyer';
	String get searchUser => 'Rechercher un utilisateur';
	String get searchSubject => 'Rechercher une matière';
	String get searchTopic => 'Rechercher un thème';
	String get searchSheet => 'Rechercher une fiche';
	String get alreadyHaveAccount => 'Vous avez déjà un compte ?';
	String get loadingIndicator => 'Chargement...';
	String get errorOccurred => 'Une erreur est survenue';
	String get backTo => 'Retour à ';
	String get unknown => 'Inconnu';
}

// Path: user
class TranslationsUserFr {
	TranslationsUserFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get email => 'Email';
	String get username => 'Nom d\'utilisateur';
	String get name => 'Nom';
	String get firstname => 'Prénom';
	String get birthdate => 'Date de naissance';
	String get location => 'Lieu';
	String get bio => 'Bio';
	String get nbReports => 'Nombre de signalements';
	String get address => 'Adresse';
	String get password => 'Mot de passe';
	String get newPassword => 'Nouveau mot de passe';
	String get anonymous => 'Anonyme';
	String get noDescription => 'Aucune description';
	String get noAddress => 'Adresse non disponible';
	String get noReportsAvailable => 'Nombre de signalements non disponible';
	String get noBio => 'Bio non disponible';
	String get noBirthdate => 'Date de naissance non disponible';
	String get noLocation => 'Lieu non disponible';
	String get noEmail => 'Email non disponible';
	String get noUsername => 'Nom d\'utilisateur non disponible';
	String get noName => 'Nom non disponible';
	String get noFirstname => 'Prénom non disponible';
	String get you => 'vous';
}

// Path: welcome
class TranslationsWelcomeFr {
	TranslationsWelcomeFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome => 'Bienvenue sur Edumeet, la plateforme de révision collaborative';
	String get setup => 'Commençons par choisir une langue';
	String get whatLanguage => 'Quelle langue parles-tu ?';
	String get chooseLanguage => 'Choisis une langue pour que nous puissions communiquer ensemble';
	String get title1 => 'Retrouve tes fiches de révision';
	String get description1 => 'Accède gratuitement à des milliers de \nfiches de révision créées par des étudiants';
	String get title2 => 'Organise tes révisions';
	String get description2 => 'Classe et organise tes fiches pour une \nmémoire efficace';
	String get title3 => 'Reste motivé';
	String get description3 => 'Atteins tes objectifs grâce à des conseils \npratiques';
	String get title4 => 'Rejoins notre communauté';
	String get description4 => 'Partage tes fiches de révision et \nreçois des conseils personnalisés';
}

// Path: login
class TranslationsLoginFr {
	TranslationsLoginFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Connexion';
	String get description => 'Entrez vos informations ci-dessous pour vous connecter';
	String get forgotPassword => 'Mot de passe oublié ?';
	String get noAccount => 'Vous n\'avez pas de compte ?';
	String get createAccount => 'Créer un compte';
}

// Path: register
class TranslationsRegisterFr {
	TranslationsRegisterFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Créer un compte';
	String get description => 'Rejoignez-nous pour bénéficier de nos services';
	String get conditions => 'En créant un compte, vous acceptez nos Conditions d\'utilisation et Politique de confidentialité';
	String get registerConfirm => 'Inscription confirmée';
}

// Path: form
class TranslationsFormFr {
	TranslationsFormFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emptyUsername => 'Veuillez entrer un nom d\'utilisateur';
	String get emptyFirstname => 'Veuillez entrer votre prénom';
	String get emptyEmail => 'Veuillez entrer votre adresse email';
	String get emptyLastname => 'Veuillez entrer votre nom';
	String get emptyPassword => 'Veuillez entrer votre mot de passe';
	String get emptyConfirmPassword => 'Veuillez confirmer votre mot de passe';
	String get passwordMismatch => 'Les mots de passe ne correspondent pas';
	String get invalidEmail => 'Veuillez entrer une adresse e-mail valide';
	String get invalidAddress => 'Veuillez entrer une adresse valide';
	String get shortPassword => 'Au moins 8 caractères';
	String get passwordUpperCase => 'Au moins une lettre majuscule';
	String get passwordDigit => 'Au moins un chiffre';
	String get passwordSpecialChar => 'Au moins un caractère spécial';
	String get haveToAcceptConditions => 'Vous devez accepter les conditions d\'utilisation et la politique de confidentialité';
	String get confirmPassword => 'Confirmer le mot de passe';
	String get pleaseConfirmPassword => 'Veuillez confirmer votre mot de passe';
	String get passwordNotMatch => 'Les mots de passe ne correspondent pas';
	String get invalidUsername => 'Le nom d\'utilisateur doit débuter par une lettre et contenir : \n- Au moins 3 caractères \n- Au maximum 20 caractères \n- Aucun caractères spéciaul';
}

// Path: swipe_cards
class TranslationsSwipeCardsFr {
	TranslationsSwipeCardsFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loading_error => 'Erreur de chargement des événements';
	String get end_of_list => 'Vous avez atteint la fin de la liste !';
	String nope({required Object title}) => 'Non à ${title}';
	String joined_event({required Object title}) => 'Vous avez rejoint l\'événement ${title}';
	String item_changed({required Object title}) => 'Item modifié: ${title}';
}

// Path: event
class TranslationsEventFr {
	TranslationsEventFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get online => 'En ligne';
	String get physical => 'Physique';
	String get participants => 'Participants';
	String hasJoinEvent({required Object event_title}) => 'Vous avez rejoint l\'événement ${event_title}';
	String get address_copied => 'Adresse copiée dans le presse-papiers';
	String get createEvent => 'Créer un événement';
	String get name => 'Nom';
	String get description => 'Description';
	String get date => 'Date';
	String get time => 'Heure';
	String get location => 'Lieu';
	String get maxParticipants => 'Nombre de participants';
	String get price => 'Prix';
	String get image => 'Image';
	String get create => 'Créer';
	String get enterName => 'Veuillez entrer un nom';
	String get enterDescription => 'Veuillez entrer une description';
	String get enterDate => 'Veuillez entrer une date';
	String get enterTime => 'Veuillez entrer une heure';
	String get enterLocation => 'Veuillez entrer un lieu';
	String get enterMaxParticipants => 'Veuillez entrer un nombre de participants';
	String get invalidMaxParticipants => 'Veuillez entrer un nombre valide';
	String get enterPrice => 'Veuillez entrer un prix';
	String get invalidPrice => 'Veuillez entrer un prix valide';
	String get enterImage => 'Veuillez entrer une URL d\'image';
	String get joinEvent => 'Rejoindre l\'évènement';
	String get eventNotStarted => 'Le lien de connexion sera disponible ici lorsque l\'événement commencera.';
}

// Path: error
class TranslationsErrorFr {
	TranslationsErrorFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String details({required Object error}) => 'Erreur : ${error}';
	String get general => 'Une erreur est survenue';
	String get no_results => 'Aucun résultat trouvé';
	String get no_internet => 'Pas de connexion Internet';
	String get no_internet_description => 'Veuillez vérifier votre connexion Internet et réessayer';
	String get no_events => 'Aucun événement trouvé';
	String get no_events_description => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	String get no_events_found => 'Aucun événement trouvé';
	String get no_events_found_description => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	String get no_events_found_title => 'Aucun événement trouvé';
	String get no_events_found_description_title => 'Aucun événement n\'a été trouvé pour le moment. Veuillez réessayer plus tard';
	String get no_events_found_description_title_search => 'Aucun événement n\'a été trouvé pour la recherche effectuée. Veuillez réessayer avec un autre terme';
	String get loadingEvents => 'Une erreur est survenue lors du chargement des événements';
	String get failedToResetPassword => 'Échec de la réinitialisation du mot de passe';
}

// Path: auth
class TranslationsAuthFr {
	TranslationsAuthFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get forgotPassword => 'Mot de passe oublié ?';
	String get enterEmail => 'Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation';
	String get resetPassword => 'Réinitialiser le mot de passe';
	String get enterNewPassword => 'Entrez votre nouveau mot de passe';
	String get resetInstructionsSent => 'Instructions de réinitialisation envoyées à votre e-mail';
	String get passwordResertSuccess => 'Votre mot de passe a été réinitialisé avec succès';
}

// Path: verify
class TranslationsVerifyFr {
	TranslationsVerifyFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Vérification du code';
	String get description => 'Entrez le code de vérification envoyé à votre e-mail';
	String get inputLabel => 'Code de vérification';
	String get button => 'Vérifier';
	String get error => 'Veuillez entrer le code de vérification';
}

// Path: profile
class TranslationsProfileFr {
	TranslationsProfileFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get editProfile => 'Modifier mon profil';
	String get firstname => 'Prénom';
	String get lastname => 'Nom';
	String get bio => 'Bio';
	String get email => 'Email';
	String get birthdate => 'Date de naissance';
	String get address => 'Adresse';
	String get save => 'Enregistrer';
	String get cancel => 'Annuler';
	String get enterFirstname => 'Veuillez entrer votre prénom';
	String get enterLastname => 'Veuillez entrer votre nom';
	String get enterEmail => 'Veuillez entrer votre adresse e-mail';
	String get invalidEmail => 'Veuillez entrer une adresse e-mail valide';
	String get logout => 'Se déconnecter';
}

// Path: resources
class TranslationsResourcesFr {
	TranslationsResourcesFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get availableResources => 'Ressources disponibles';
	String get name => 'Nom';
	String get type => 'Type';
}

// Path: messages
class TranslationsMessagesFr {
	TranslationsMessagesFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get latestMessages => 'Derniers messages';
	String get seeAllMessages => 'Voir tous les messages';
	String get noMessages => 'Aucun message';
	String get writeMessageHint => 'Écrivez un message...';
	String get sendMessage => 'Envoyer';
}

// Path: common
class TranslationsCommonFr {
	TranslationsCommonFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sender => 'Expéditeur';
	String get message => 'Message';
}

// Path: settings
class TranslationsSettingsFr {
	TranslationsSettingsFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get account => 'Compte';
	String get settings => 'Paramètres';
	String get language => 'Langue';
	String get manageSubjects => 'Gestion des matières';
	String get notifications => 'Notifications';
	String get about => 'À propos';
	String get contact => 'Contact';
	String get terms => 'Conditions d\'utilisation';
	String get privacy => 'Politique de confidentialité';
}

// Path: page
class TranslationsPageFr {
	TranslationsPageFr._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'Accueil';
	String get homePage => 'Page d\'accueil';
	String get profile => 'Profil';
	String get profilePage => 'Page de profil';
	String get settings => 'Paramètres';
	String get settingsPage => 'Page des paramètres';
	String get search => 'Recherche';
	String get searchPage => 'Page de recherche';
	String get sheet => 'Fiche';
	String get sheetPage => 'Page de la fiche';
	String get subject => 'Matière';
	String get subjectPage => 'Page de la matière';
	String get topic => 'Thème';
	String get topicPage => 'Page du thème';
	String get event => 'Événement';
	String get eventPage => 'Page de l\'événement';
	String get user => 'Utilisateur';
	String get userPage => 'Page de l\'utilisateur';
	String get about => 'À propos';
	String get aboutPage => 'Page À propos';
	String get contact => 'Contact';
	String get contactPage => 'Page de contact';
	String get terms => 'Conditions d\'utilisation';
	String get termsPage => 'Page des conditions d\'utilisation';
	String get privacy => 'Politique de confidentialité';
	String get privacyPage => 'Page de la politique de confidentialité';
	String get notifications => 'Notifications';
	String get events => 'Événements';
	String get sheets => 'Fiches';
	String get subjects => 'Matières';
	String get topics => 'Thèmes';
	String get users => 'Utilisateurs';
	String get help => 'Aide';
	String get helpPage => 'Page d\'aide';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
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
			case 'swipe_cards.nope': return ({required Object title}) => 'Non à ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Vous avez rejoint l\'événement ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Item modifié: ${title}';
			case 'event.online': return 'En ligne';
			case 'event.physical': return 'Physique';
			case 'event.participants': return 'Participants';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Vous avez rejoint l\'événement ${event_title}';
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
			case 'error.details': return ({required Object error}) => 'Erreur : ${error}';
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


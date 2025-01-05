///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
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
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsUserEn user = TranslationsUserEn._(_root);
	late final TranslationsWelcomeEn welcome = TranslationsWelcomeEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsRegisterEn register = TranslationsRegisterEn._(_root);
	late final TranslationsFormEn form = TranslationsFormEn._(_root);
	late final TranslationsSwipeCardsEn swipe_cards = TranslationsSwipeCardsEn._(_root);
	late final TranslationsEventEn event = TranslationsEventEn._(_root);
	late final TranslationsErrorEn error = TranslationsErrorEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsVerifyEn verify = TranslationsVerifyEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsResourcesEn resources = TranslationsResourcesEn._(_root);
	late final TranslationsMessagesEn messages = TranslationsMessagesEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsPageEn page = TranslationsPageEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Log in';
	String get signup => 'Sign up';
	String get logout => 'Log out';
	String get search => 'Search';
	String get searchLanguage => 'Search a language';
	String get add => 'Add';
	String get edit => 'Edit';
	String get delete => 'Delete';
	String get cancel => 'Cancel';
	String get save => 'Save';
	String get yes => 'Yes';
	String get no => 'No';
	String get confirm => 'Confirm';
	String get error => 'Error';
	String get loading => 'Loading...';
	String get noResults => 'No results';
	String get noResultsFound => 'No results found';
	String get skip => 'Skip';
	String get next => 'Next';
	String get previous => 'Previous';
	String get finish => 'Finish';
	String get back => 'Back';
	String get submit => 'Submit';
	String get searchUser => 'Search a user';
	String get searchSubject => 'Search a subject';
	String get searchTopic => 'Search a topic';
	String get searchSheet => 'Search a sheet';
	String get alreadyHaveAccount => 'Already have an account?';
	String get loadingIndicator => 'Loading...';
	String get errorOccurred => 'An error occurred';
	String get backTo => 'Back to ';
	String get unknown => 'Unknown';
}

// Path: user
class TranslationsUserEn {
	TranslationsUserEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get email => 'Email';
	String get username => 'Username';
	String get name => 'Name';
	String get firstname => 'First name';
	String get birthdate => 'Date of birth';
	String get location => 'Location';
	String get bio => 'Bio';
	String get nbReports => 'Number of reports';
	String get address => 'Address';
	String get password => 'Password';
	String get newPassword => 'New password';
	String get anonymous => 'Anonymous';
	String get noDescription => 'No description';
	String get noAddress => 'Address not available';
	String get noReportsAvailable => 'Number of reports not available';
	String get noBio => 'Bio not available';
	String get noBirthdate => 'Birthdate not available';
	String get noLocation => 'Location not available';
	String get noEmail => 'Email not available';
	String get noUsername => 'Username not available';
	String get noName => 'Name not available';
	String get noFirstname => 'First name not available';
	String get you => 'you';
	String get me => '(me)';
}

// Path: welcome
class TranslationsWelcomeEn {
	TranslationsWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome => 'Welcome to Edumeet, the collaborative revision platform';
	String get setup => 'Let\'s start by choosing a language';
	String get whatLanguage => 'What language do you speak?';
	String get chooseLanguage => 'Choose a language so we can communicate together';
	String get title1 => 'Find your revision sheets';
	String get description1 => 'Access thousands of revision sheets created by students for free';
	String get title2 => 'Organize your revisions';
	String get description2 => 'Sort and organize your sheets for effective memory';
	String get title3 => 'Stay motivated';
	String get description3 => 'Achieve your goals with practical advice';
	String get title4 => 'Join our community';
	String get description4 => 'Share your revision sheets and receive personalized advice';
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Login';
	String get description => 'Enter your information below to log in';
	String get forgotPassword => 'Forgot password?';
	String get noAccount => 'Don\'t have an account?';
	String get createAccount => 'Create an account';
}

// Path: register
class TranslationsRegisterEn {
	TranslationsRegisterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Create an account';
	String get description => 'Join us to benefit from our services';
	String get conditions => 'By creating an account, you agree to our Terms of use and Privacy policy';
	String get registerConfirm => 'Registration confirmed';
}

// Path: form
class TranslationsFormEn {
	TranslationsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emptyUsername => 'Please enter a username';
	String get emptyFirstname => 'Please enter your first name';
	String get emptyEmail => 'Please enter your email address';
	String get emptyLastname => 'Please enter your last name';
	String get emptyPassword => 'Please enter your password';
	String get emptyConfirmPassword => 'Please confirm your password';
	String get passwordMismatch => 'Passwords do not match';
	String get invalidEmail => 'Please enter a valid email address';
	String get invalidAddress => 'Please enter a valid address';
	String get shortPassword => 'Password must be at least 8 characters long';
	String get passwordUpperCase => 'Password must contain at least one uppercase letter';
	String get passwordDigit => 'Password must contain at least one digit';
	String get passwordSpecialChar => 'Password must contain at least one special character';
	String get haveToAcceptConditions => 'You must accept the terms of use and privacy policy';
	String get confirmPassword => 'Confirm password';
	String get pleaseConfirmPassword => 'Please confirm your password';
	String get passwordNotMatch => 'Passwords do not match';
	String get invalidUsername => 'The username must: \n- be between 3 and 20 characters long \n- start with a letter \n- not contain special characters';
}

// Path: swipe_cards
class TranslationsSwipeCardsEn {
	TranslationsSwipeCardsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loading_error => 'Error loading events';
	String get end_of_list => 'You have reached the end of the list!';
	String get nope => 'No to {{title}}';
	String get joined_event => 'You have joined the event {{title}}';
	String get item_changed => 'Item changed: {{title}}';
}

// Path: event
class TranslationsEventEn {
	TranslationsEventEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get online => 'Online';
	String get physical => 'Physical';
	String get participants => 'Participants';
	String get hasJoinEvent => 'You have joined the event {{event_title}}';
	String get address_copied => 'Address copied to clipboard';
	String get createEvent => 'Create an event';
	String get name => 'Name';
	String get description => 'Description';
	String get date => 'Date';
	String get time => 'Time';
	String get location => 'Location';
	String get maxParticipants => 'Number of participants';
	String get price => 'Price';
	String get image => 'Image';
	String get create => 'Create';
	String get enterName => 'Please enter a name';
	String get enterDescription => 'Please enter a description';
	String get enterDate => 'Please enter a date';
	String get enterTime => 'Please enter a time';
	String get enterLocation => 'Please enter a location';
	String get enterMaxParticipants => 'Please enter a number of participants';
	String get invalidMaxParticipants => 'Please enter a valid number';
	String get enterPrice => 'Please enter a price';
	String get invalidPrice => 'Please enter a valid price';
	String get enterImage => 'Please enter an image URL';
	String get joinEvent => 'Join the event';
	String get eventNotStarted => 'The connection link will be available here when the event starts.';
}

// Path: error
class TranslationsErrorEn {
	TranslationsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get details => 'Error: {{error}}';
	String get general => 'An error occurred';
	String get no_results => 'No results found';
	String get no_internet => 'No internet connection';
	String get no_internet_description => 'Please check your internet connection and try again';
	String get no_events => 'No events found';
	String get no_events_description => 'No events were found at this time. Please try again later';
	String get no_events_found => 'No events found';
	String get no_events_found_description => 'No events were found at this time. Please try again later';
	String get no_events_found_title => 'No events found';
	String get no_events_found_description_title => 'No events were found at this time. Please try again later';
	String get no_events_found_description_title_search => 'No events were found for the search made. Please try again with another term';
	String get loadingEvents => 'An error occurred while loading events';
	String get failedToResetPassword => 'Failed to reset password';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get forgotPassword => 'Forgot password?';
	String get enterEmail => 'Enter your email address to receive reset instructions';
	String get resetPassword => 'Reset password';
	String get enterNewPassword => 'Enter your new password';
	String get resetInstructionsSent => 'Reset instructions sent to your email';
	String get passwordResertSuccess => 'Your password has been reset successfully';
}

// Path: verify
class TranslationsVerifyEn {
	TranslationsVerifyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Code verification';
	String get description => 'Enter the verification code sent to your email';
	String get inputLabel => 'Verification code';
	String get button => 'Verify';
	String get error => 'Please enter the verification code';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get editProfile => 'Edit my profile';
	String get firstname => 'First name';
	String get lastname => 'Last name';
	String get bio => 'Bio';
	String get email => 'Email';
	String get birthdate => 'Date of birth';
	String get address => 'Address';
	String get save => 'Save';
	String get cancel => 'Cancel';
	String get enterFirstname => 'Please enter your first name';
	String get enterLastname => 'Please enter your last name';
	String get enterEmail => 'Please enter your email address';
	String get invalidEmail => 'Please enter a valid email address';
	String get logout => 'Log out';
}

// Path: resources
class TranslationsResourcesEn {
	TranslationsResourcesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get availableResources => 'Available resources';
	String get name => 'Name';
	String get type => 'Type';
}

// Path: messages
class TranslationsMessagesEn {
	TranslationsMessagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get latestMessages => 'Latest messages';
	String get seeAllMessages => 'See all messages';
	String get noMessages => 'No messages';
	String get writeMessageHint => 'Write a message...';
	String get sendMessage => 'Send';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get sender => 'Sender';
	String get message => 'Message';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get account => 'Account';
	String get settings => 'Settings';
	String get language => 'Language';
	String get manageSubjects => 'Manage Subjects';
	String get notifications => 'Notifications';
	String get about => 'About';
	String get contact => 'Contact';
	String get terms => 'Terms of Use';
	String get privacy => 'Privacy Policy';
}

// Path: page
class TranslationsPageEn {
	TranslationsPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get home => 'Home';
	String get homePage => 'Home page';
	String get profile => 'Profile';
	String get profilePage => 'Profile page';
	String get settings => 'Settings';
	String get settingsPage => 'Settings page';
	String get search => 'Search';
	String get searchPage => 'Search page';
	String get sheet => 'Sheet';
	String get sheetPage => 'Sheet page';
	String get subject => 'Subject';
	String get subjectPage => 'Subject page';
	String get topic => 'Topic';
	String get topicPage => 'Topic page';
	String get event => 'Event';
	String get eventPage => 'Event page';
	String get user => 'User';
	String get userPage => 'User page';
	String get about => 'About';
	String get aboutPage => 'About page';
	String get contact => 'Contact';
	String get contactPage => 'Contact page';
	String get terms => 'Terms of use';
	String get termsPage => 'Terms of use page';
	String get privacy => 'Privacy policy';
	String get privacyPage => 'Privacy policy page';
	String get notifications => 'Notifications';
	String get events => 'Events';
	String get sheets => 'Sheets';
	String get subjects => 'Subjects';
	String get topics => 'Topics';
	String get users => 'Users';
	String get help => 'Help';
	String get helpPage => 'Help page';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Log in';
			case 'app.signup': return 'Sign up';
			case 'app.logout': return 'Log out';
			case 'app.search': return 'Search';
			case 'app.searchLanguage': return 'Search a language';
			case 'app.add': return 'Add';
			case 'app.edit': return 'Edit';
			case 'app.delete': return 'Delete';
			case 'app.cancel': return 'Cancel';
			case 'app.save': return 'Save';
			case 'app.yes': return 'Yes';
			case 'app.no': return 'No';
			case 'app.confirm': return 'Confirm';
			case 'app.error': return 'Error';
			case 'app.loading': return 'Loading...';
			case 'app.noResults': return 'No results';
			case 'app.noResultsFound': return 'No results found';
			case 'app.skip': return 'Skip';
			case 'app.next': return 'Next';
			case 'app.previous': return 'Previous';
			case 'app.finish': return 'Finish';
			case 'app.back': return 'Back';
			case 'app.submit': return 'Submit';
			case 'app.searchUser': return 'Search a user';
			case 'app.searchSubject': return 'Search a subject';
			case 'app.searchTopic': return 'Search a topic';
			case 'app.searchSheet': return 'Search a sheet';
			case 'app.alreadyHaveAccount': return 'Already have an account?';
			case 'app.loadingIndicator': return 'Loading...';
			case 'app.errorOccurred': return 'An error occurred';
			case 'app.backTo': return 'Back to ';
			case 'app.unknown': return 'Unknown';
			case 'user.email': return 'Email';
			case 'user.username': return 'Username';
			case 'user.name': return 'Name';
			case 'user.firstname': return 'First name';
			case 'user.birthdate': return 'Date of birth';
			case 'user.location': return 'Location';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Number of reports';
			case 'user.address': return 'Address';
			case 'user.password': return 'Password';
			case 'user.newPassword': return 'New password';
			case 'user.anonymous': return 'Anonymous';
			case 'user.noDescription': return 'No description';
			case 'user.noAddress': return 'Address not available';
			case 'user.noReportsAvailable': return 'Number of reports not available';
			case 'user.noBio': return 'Bio not available';
			case 'user.noBirthdate': return 'Birthdate not available';
			case 'user.noLocation': return 'Location not available';
			case 'user.noEmail': return 'Email not available';
			case 'user.noUsername': return 'Username not available';
			case 'user.noName': return 'Name not available';
			case 'user.noFirstname': return 'First name not available';
			case 'user.you': return 'you';
			case 'user.me': return '(me)';
			case 'welcome.welcome': return 'Welcome to Edumeet, the collaborative revision platform';
			case 'welcome.setup': return 'Let\'s start by choosing a language';
			case 'welcome.whatLanguage': return 'What language do you speak?';
			case 'welcome.chooseLanguage': return 'Choose a language so we can communicate together';
			case 'welcome.title1': return 'Find your revision sheets';
			case 'welcome.description1': return 'Access thousands of revision sheets created by students for free';
			case 'welcome.title2': return 'Organize your revisions';
			case 'welcome.description2': return 'Sort and organize your sheets for effective memory';
			case 'welcome.title3': return 'Stay motivated';
			case 'welcome.description3': return 'Achieve your goals with practical advice';
			case 'welcome.title4': return 'Join our community';
			case 'welcome.description4': return 'Share your revision sheets and receive personalized advice';
			case 'login.title': return 'Login';
			case 'login.description': return 'Enter your information below to log in';
			case 'login.forgotPassword': return 'Forgot password?';
			case 'login.noAccount': return 'Don\'t have an account?';
			case 'login.createAccount': return 'Create an account';
			case 'register.title': return 'Create an account';
			case 'register.description': return 'Join us to benefit from our services';
			case 'register.conditions': return 'By creating an account, you agree to our Terms of use and Privacy policy';
			case 'register.registerConfirm': return 'Registration confirmed';
			case 'form.emptyUsername': return 'Please enter a username';
			case 'form.emptyFirstname': return 'Please enter your first name';
			case 'form.emptyEmail': return 'Please enter your email address';
			case 'form.emptyLastname': return 'Please enter your last name';
			case 'form.emptyPassword': return 'Please enter your password';
			case 'form.emptyConfirmPassword': return 'Please confirm your password';
			case 'form.passwordMismatch': return 'Passwords do not match';
			case 'form.invalidEmail': return 'Please enter a valid email address';
			case 'form.invalidAddress': return 'Please enter a valid address';
			case 'form.shortPassword': return 'Password must be at least 8 characters long';
			case 'form.passwordUpperCase': return 'Password must contain at least one uppercase letter';
			case 'form.passwordDigit': return 'Password must contain at least one digit';
			case 'form.passwordSpecialChar': return 'Password must contain at least one special character';
			case 'form.haveToAcceptConditions': return 'You must accept the terms of use and privacy policy';
			case 'form.confirmPassword': return 'Confirm password';
			case 'form.pleaseConfirmPassword': return 'Please confirm your password';
			case 'form.passwordNotMatch': return 'Passwords do not match';
			case 'form.invalidUsername': return 'The username must: \n- be between 3 and 20 characters long \n- start with a letter \n- not contain special characters';
			case 'swipe_cards.loading_error': return 'Error loading events';
			case 'swipe_cards.end_of_list': return 'You have reached the end of the list!';
			case 'swipe_cards.nope': return 'No to {{title}}';
			case 'swipe_cards.joined_event': return 'You have joined the event {{title}}';
			case 'swipe_cards.item_changed': return 'Item changed: {{title}}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Physical';
			case 'event.participants': return 'Participants';
			case 'event.hasJoinEvent': return 'You have joined the event {{event_title}}';
			case 'event.address_copied': return 'Address copied to clipboard';
			case 'event.createEvent': return 'Create an event';
			case 'event.name': return 'Name';
			case 'event.description': return 'Description';
			case 'event.date': return 'Date';
			case 'event.time': return 'Time';
			case 'event.location': return 'Location';
			case 'event.maxParticipants': return 'Number of participants';
			case 'event.price': return 'Price';
			case 'event.image': return 'Image';
			case 'event.create': return 'Create';
			case 'event.enterName': return 'Please enter a name';
			case 'event.enterDescription': return 'Please enter a description';
			case 'event.enterDate': return 'Please enter a date';
			case 'event.enterTime': return 'Please enter a time';
			case 'event.enterLocation': return 'Please enter a location';
			case 'event.enterMaxParticipants': return 'Please enter a number of participants';
			case 'event.invalidMaxParticipants': return 'Please enter a valid number';
			case 'event.enterPrice': return 'Please enter a price';
			case 'event.invalidPrice': return 'Please enter a valid price';
			case 'event.enterImage': return 'Please enter an image URL';
			case 'event.joinEvent': return 'Join the event';
			case 'event.eventNotStarted': return 'The connection link will be available here when the event starts.';
			case 'error.details': return 'Error: {{error}}';
			case 'error.general': return 'An error occurred';
			case 'error.no_results': return 'No results found';
			case 'error.no_internet': return 'No internet connection';
			case 'error.no_internet_description': return 'Please check your internet connection and try again';
			case 'error.no_events': return 'No events found';
			case 'error.no_events_description': return 'No events were found at this time. Please try again later';
			case 'error.no_events_found': return 'No events found';
			case 'error.no_events_found_description': return 'No events were found at this time. Please try again later';
			case 'error.no_events_found_title': return 'No events found';
			case 'error.no_events_found_description_title': return 'No events were found at this time. Please try again later';
			case 'error.no_events_found_description_title_search': return 'No events were found for the search made. Please try again with another term';
			case 'error.loadingEvents': return 'An error occurred while loading events';
			case 'error.failedToResetPassword': return 'Failed to reset password';
			case 'auth.forgotPassword': return 'Forgot password?';
			case 'auth.enterEmail': return 'Enter your email address to receive reset instructions';
			case 'auth.resetPassword': return 'Reset password';
			case 'auth.enterNewPassword': return 'Enter your new password';
			case 'auth.resetInstructionsSent': return 'Reset instructions sent to your email';
			case 'auth.passwordResertSuccess': return 'Your password has been reset successfully';
			case 'verify.title': return 'Code verification';
			case 'verify.description': return 'Enter the verification code sent to your email';
			case 'verify.inputLabel': return 'Verification code';
			case 'verify.button': return 'Verify';
			case 'verify.error': return 'Please enter the verification code';
			case 'profile.editProfile': return 'Edit my profile';
			case 'profile.firstname': return 'First name';
			case 'profile.lastname': return 'Last name';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Date of birth';
			case 'profile.address': return 'Address';
			case 'profile.save': return 'Save';
			case 'profile.cancel': return 'Cancel';
			case 'profile.enterFirstname': return 'Please enter your first name';
			case 'profile.enterLastname': return 'Please enter your last name';
			case 'profile.enterEmail': return 'Please enter your email address';
			case 'profile.invalidEmail': return 'Please enter a valid email address';
			case 'profile.logout': return 'Log out';
			case 'resources.availableResources': return 'Available resources';
			case 'resources.name': return 'Name';
			case 'resources.type': return 'Type';
			case 'messages.latestMessages': return 'Latest messages';
			case 'messages.seeAllMessages': return 'See all messages';
			case 'messages.noMessages': return 'No messages';
			case 'messages.writeMessageHint': return 'Write a message...';
			case 'messages.sendMessage': return 'Send';
			case 'common.sender': return 'Sender';
			case 'common.message': return 'Message';
			case 'settings.account': return 'Account';
			case 'settings.settings': return 'Settings';
			case 'settings.language': return 'Language';
			case 'settings.manageSubjects': return 'Manage Subjects';
			case 'settings.notifications': return 'Notifications';
			case 'settings.about': return 'About';
			case 'settings.contact': return 'Contact';
			case 'settings.terms': return 'Terms of Use';
			case 'settings.privacy': return 'Privacy Policy';
			case 'page.home': return 'Home';
			case 'page.homePage': return 'Home page';
			case 'page.profile': return 'Profile';
			case 'page.profilePage': return 'Profile page';
			case 'page.settings': return 'Settings';
			case 'page.settingsPage': return 'Settings page';
			case 'page.search': return 'Search';
			case 'page.searchPage': return 'Search page';
			case 'page.sheet': return 'Sheet';
			case 'page.sheetPage': return 'Sheet page';
			case 'page.subject': return 'Subject';
			case 'page.subjectPage': return 'Subject page';
			case 'page.topic': return 'Topic';
			case 'page.topicPage': return 'Topic page';
			case 'page.event': return 'Event';
			case 'page.eventPage': return 'Event page';
			case 'page.user': return 'User';
			case 'page.userPage': return 'User page';
			case 'page.about': return 'About';
			case 'page.aboutPage': return 'About page';
			case 'page.contact': return 'Contact';
			case 'page.contactPage': return 'Contact page';
			case 'page.terms': return 'Terms of use';
			case 'page.termsPage': return 'Terms of use page';
			case 'page.privacy': return 'Privacy policy';
			case 'page.privacyPage': return 'Privacy policy page';
			case 'page.notifications': return 'Notifications';
			case 'page.events': return 'Events';
			case 'page.sheets': return 'Sheets';
			case 'page.subjects': return 'Subjects';
			case 'page.topics': return 'Topics';
			case 'page.users': return 'Users';
			case 'page.help': return 'Help';
			case 'page.helpPage': return 'Help page';
			default: return null;
		}
	}
}


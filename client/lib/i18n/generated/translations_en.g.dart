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
	@override late final _TranslationsAppEn app = _TranslationsAppEn._(_root);
	@override late final _TranslationsUserEn user = _TranslationsUserEn._(_root);
	@override late final _TranslationsWelcomeEn welcome = _TranslationsWelcomeEn._(_root);
	@override late final _TranslationsLoginEn login = _TranslationsLoginEn._(_root);
	@override late final _TranslationsRegisterEn register = _TranslationsRegisterEn._(_root);
	@override late final _TranslationsFormEn form = _TranslationsFormEn._(_root);
	@override late final _TranslationsSwipeCardsEn swipe_cards = _TranslationsSwipeCardsEn._(_root);
	@override late final _TranslationsEventEn event = _TranslationsEventEn._(_root);
	@override late final _TranslationsErrorEn error = _TranslationsErrorEn._(_root);
	@override late final _TranslationsAuthEn auth = _TranslationsAuthEn._(_root);
	@override late final _TranslationsVerifyEn verify = _TranslationsVerifyEn._(_root);
	@override late final _TranslationsProfileEn profile = _TranslationsProfileEn._(_root);
	@override late final _TranslationsResourcesEn resources = _TranslationsResourcesEn._(_root);
	@override late final _TranslationsMessagesEn messages = _TranslationsMessagesEn._(_root);
	@override late final _TranslationsCommonEn common = _TranslationsCommonEn._(_root);
	@override late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
	@override late final _TranslationsPageEn page = _TranslationsPageEn._(_root);
}

// Path: app
class _TranslationsAppEn implements TranslationsAppFr {
	_TranslationsAppEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get login => 'Log in';
	@override String get signup => 'Sign up';
	@override String get logout => 'Log out';
	@override String get search => 'Search';
	@override String get searchLanguage => 'Search a language';
	@override String get add => 'Add';
	@override String get edit => 'Edit';
	@override String get delete => 'Delete';
	@override String get cancel => 'Cancel';
	@override String get save => 'Save';
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get confirm => 'Confirm';
	@override String get error => 'Error';
	@override String get loading => 'Loading...';
	@override String get noResults => 'No results';
	@override String get noResultsFound => 'No results found';
	@override String get skip => 'Skip';
	@override String get next => 'Next';
	@override String get previous => 'Previous';
	@override String get finish => 'Finish';
	@override String get back => 'Back';
	@override String get submit => 'Submit';
	@override String get searchUser => 'Search a user';
	@override String get searchSubject => 'Search a subject';
	@override String get searchTopic => 'Search a topic';
	@override String get searchSheet => 'Search a sheet';
	@override String get alreadyHaveAccount => 'Already have an account?';
	@override String get loadingIndicator => 'Loading...';
	@override String get errorOccurred => 'An error occurred';
	@override String get backTo => 'Back to ';
	@override String get unknown => 'Unknown';
}

// Path: user
class _TranslationsUserEn implements TranslationsUserFr {
	_TranslationsUserEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Username';
	@override String get name => 'Name';
	@override String get firstname => 'First name';
	@override String get birthdate => 'Date of birth';
	@override String get location => 'Location';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Number of reports';
	@override String get address => 'Address';
	@override String get password => 'Password';
	@override String get newPassword => 'New password';
	@override String get anonymous => 'Anonymous';
	@override String get noDescription => 'No description';
	@override String get noAddress => 'Address not available';
	@override String get noReportsAvailable => 'Number of reports not available';
}

// Path: welcome
class _TranslationsWelcomeEn implements TranslationsWelcomeFr {
	_TranslationsWelcomeEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Welcome to Edumeet, the collaborative revision platform';
	@override String get setup => 'Let\'s start by choosing a language';
	@override String get whatLanguage => 'What language do you speak?';
	@override String get chooseLanguage => 'Choose a language so we can communicate together';
	@override String get title1 => 'Find your revision sheets';
	@override String get description1 => 'Access thousands of revision sheets created by students for free';
	@override String get title2 => 'Organize your revisions';
	@override String get description2 => 'Sort and organize your sheets for effective memory';
	@override String get title3 => 'Stay motivated';
	@override String get description3 => 'Achieve your goals with practical advice';
	@override String get title4 => 'Join our community';
	@override String get description4 => 'Share your revision sheets and receive personalized advice';
}

// Path: login
class _TranslationsLoginEn implements TranslationsLoginFr {
	_TranslationsLoginEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Login';
	@override String get description => 'Enter your information below to log in';
	@override String get forgotPassword => 'Forgot password?';
	@override String get noAccount => 'Don\'t have an account?';
	@override String get createAccount => 'Create an account';
}

// Path: register
class _TranslationsRegisterEn implements TranslationsRegisterFr {
	_TranslationsRegisterEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Create an account';
	@override String get description => 'Join us to benefit from our services';
	@override String get conditions => 'By creating an account, you agree to our Terms of use and Privacy policy';
	@override String get registerConfirm => 'Registration confirmed';
}

// Path: form
class _TranslationsFormEn implements TranslationsFormFr {
	_TranslationsFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Please enter a username';
	@override String get emptyFirstname => 'Please enter your first name';
	@override String get emptyEmail => 'Please enter your email address';
	@override String get emptyLastname => 'Please enter your last name';
	@override String get emptyPassword => 'Please enter your password';
	@override String get emptyConfirmPassword => 'Please confirm your password';
	@override String get passwordMismatch => 'Passwords do not match';
	@override String get invalidEmail => 'Please enter a valid email address';
	@override String get invalidAddress => 'Please enter a valid address';
	@override String get shortPassword => 'Password must be at least 8 characters long';
	@override String get passwordUpperCase => 'Password must contain at least one uppercase letter';
	@override String get passwordDigit => 'Password must contain at least one digit';
	@override String get passwordSpecialChar => 'Password must contain at least one special character';
	@override String get haveToAcceptConditions => 'You must accept the terms of use and privacy policy';
	@override String get confirmPassword => 'Confirm password';
	@override String get pleaseConfirmPassword => 'Please confirm your password';
	@override String get passwordNotMatch => 'Passwords do not match';
	@override String get invalidUsername => 'The username must: \n- be between 3 and 20 characters long \n- start with a letter \n- not contain special characters';
}

// Path: swipe_cards
class _TranslationsSwipeCardsEn implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Error loading events';
	@override String get end_of_list => 'You have reached the end of the list!';
	@override String nope({required Object title}) => 'No to ${title}';
	@override String joined_event({required Object title}) => 'You have joined the event ${title}';
	@override String item_changed({required Object title}) => 'Item changed: ${title}';
}

// Path: event
class _TranslationsEventEn implements TranslationsEventFr {
	_TranslationsEventEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Physical';
	@override String get participants => 'Participants';
	@override String hasJoinEvent({required Object event_title}) => 'You have joined the event ${event_title}';
	@override String get address_copied => 'Address copied to clipboard';
	@override String get createEvent => 'Create an event';
	@override String get name => 'Name';
	@override String get description => 'Description';
	@override String get date => 'Date';
	@override String get time => 'Time';
	@override String get location => 'Location';
	@override String get maxParticipants => 'Number of participants';
	@override String get price => 'Price';
	@override String get image => 'Image';
	@override String get create => 'Create';
	@override String get enterName => 'Please enter a name';
	@override String get enterDescription => 'Please enter a description';
	@override String get enterDate => 'Please enter a date';
	@override String get enterTime => 'Please enter a time';
	@override String get enterLocation => 'Please enter a location';
	@override String get enterMaxParticipants => 'Please enter a number of participants';
	@override String get invalidMaxParticipants => 'Please enter a valid number';
	@override String get enterPrice => 'Please enter a price';
	@override String get invalidPrice => 'Please enter a valid price';
	@override String get enterImage => 'Please enter an image URL';
	@override String get joinEvent => 'Join the event';
	@override String get eventNotStarted => 'The connection link will be available here when the event starts.';
}

// Path: error
class _TranslationsErrorEn implements TranslationsErrorFr {
	_TranslationsErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Error: ${error}';
	@override String get general => 'An error occurred';
	@override String get no_results => 'No results found';
	@override String get no_internet => 'No internet connection';
	@override String get no_internet_description => 'Please check your internet connection and try again';
	@override String get no_events => 'No events found';
	@override String get no_events_description => 'No events were found at this time. Please try again later';
	@override String get no_events_found => 'No events found';
	@override String get no_events_found_description => 'No events were found at this time. Please try again later';
	@override String get no_events_found_title => 'No events found';
	@override String get no_events_found_description_title => 'No events were found at this time. Please try again later';
	@override String get no_events_found_description_title_search => 'No events were found for the search made. Please try again with another term';
	@override String get loadingEvents => 'An error occurred while loading events';
	@override String get failedToResetPassword => 'Failed to reset password';
}

// Path: auth
class _TranslationsAuthEn implements TranslationsAuthFr {
	_TranslationsAuthEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Forgot password?';
	@override String get enterEmail => 'Enter your email address to receive reset instructions';
	@override String get resetPassword => 'Reset password';
	@override String get enterNewPassword => 'Enter your new password';
	@override String get resetInstructionsSent => 'Reset instructions sent to your email';
	@override String get passwordResertSuccess => 'Your password has been reset successfully';
}

// Path: verify
class _TranslationsVerifyEn implements TranslationsVerifyFr {
	_TranslationsVerifyEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Code verification';
	@override String get description => 'Enter the verification code sent to your email';
	@override String get inputLabel => 'Verification code';
	@override String get button => 'Verify';
	@override String get error => 'Please enter the verification code';
}

// Path: profile
class _TranslationsProfileEn implements TranslationsProfileFr {
	_TranslationsProfileEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Edit my profile';
	@override String get firstname => 'First name';
	@override String get lastname => 'Last name';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Date of birth';
	@override String get address => 'Address';
	@override String get save => 'Save';
	@override String get cancel => 'Cancel';
	@override String get enterFirstname => 'Please enter your first name';
	@override String get enterLastname => 'Please enter your last name';
	@override String get enterEmail => 'Please enter your email address';
	@override String get invalidEmail => 'Please enter a valid email address';
	@override String get logout => 'Log out';
}

// Path: resources
class _TranslationsResourcesEn implements TranslationsResourcesFr {
	_TranslationsResourcesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Available resources';
	@override String get name => 'Name';
	@override String get type => 'Type';
}

// Path: messages
class _TranslationsMessagesEn implements TranslationsMessagesFr {
	_TranslationsMessagesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Latest messages';
	@override String get seeAllMessages => 'See all messages';
	@override String get noMessages => 'No messages';
	@override String get writeMessageHint => 'Write a message...';
	@override String get sendMessage => 'Send';
}

// Path: common
class _TranslationsCommonEn implements TranslationsCommonFr {
	_TranslationsCommonEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Sender';
	@override String get message => 'Message';
}

// Path: settings
class _TranslationsSettingsEn implements TranslationsSettingsFr {
	_TranslationsSettingsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Account';
	@override String get settings => 'Settings';
	@override String get language => 'Language';
	@override String get manageSubjects => 'Manage Subjects';
	@override String get notifications => 'Notifications';
	@override String get about => 'About';
	@override String get contact => 'Contact';
	@override String get terms => 'Terms of Use';
	@override String get privacy => 'Privacy Policy';
}

// Path: page
class _TranslationsPageEn implements TranslationsPageFr {
	_TranslationsPageEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get homePage => 'Home page';
	@override String get profile => 'Profile';
	@override String get profilePage => 'Profile page';
	@override String get settings => 'Settings';
	@override String get settingsPage => 'Settings page';
	@override String get search => 'Search';
	@override String get searchPage => 'Search page';
	@override String get sheet => 'Sheet';
	@override String get sheetPage => 'Sheet page';
	@override String get subject => 'Subject';
	@override String get subjectPage => 'Subject page';
	@override String get topic => 'Topic';
	@override String get topicPage => 'Topic page';
	@override String get event => 'Event';
	@override String get eventPage => 'Event page';
	@override String get user => 'User';
	@override String get userPage => 'User page';
	@override String get about => 'About';
	@override String get aboutPage => 'About page';
	@override String get contact => 'Contact';
	@override String get contactPage => 'Contact page';
	@override String get terms => 'Terms of use';
	@override String get termsPage => 'Terms of use page';
	@override String get privacy => 'Privacy policy';
	@override String get privacyPage => 'Privacy policy page';
	@override String get notifications => 'Notifications';
	@override String get events => 'Events';
	@override String get sheets => 'Sheets';
	@override String get subjects => 'Subjects';
	@override String get topics => 'Topics';
	@override String get users => 'Users';
	@override String get help => 'Help';
	@override String get helpPage => 'Help page';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEn {
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
			case 'swipe_cards.nope': return ({required Object title}) => 'No to ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'You have joined the event ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Item changed: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Physical';
			case 'event.participants': return 'Participants';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'You have joined the event ${event_title}';
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
			case 'error.details': return ({required Object error}) => 'Error: ${error}';
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


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
	@override late final _TranslationsAppEs app = _TranslationsAppEs._(_root);
	@override late final _TranslationsUserEs user = _TranslationsUserEs._(_root);
	@override late final _TranslationsWelcomeEs welcome = _TranslationsWelcomeEs._(_root);
	@override late final _TranslationsLoginEs login = _TranslationsLoginEs._(_root);
	@override late final _TranslationsRegisterEs register = _TranslationsRegisterEs._(_root);
	@override late final _TranslationsFormEs form = _TranslationsFormEs._(_root);
	@override late final _TranslationsSwipeCardsEs swipe_cards = _TranslationsSwipeCardsEs._(_root);
	@override late final _TranslationsEventEs event = _TranslationsEventEs._(_root);
	@override late final _TranslationsErrorEs error = _TranslationsErrorEs._(_root);
	@override late final _TranslationsAuthEs auth = _TranslationsAuthEs._(_root);
	@override late final _TranslationsVerifyEs verify = _TranslationsVerifyEs._(_root);
	@override late final _TranslationsProfileEs profile = _TranslationsProfileEs._(_root);
	@override late final _TranslationsResourcesEs resources = _TranslationsResourcesEs._(_root);
	@override late final _TranslationsMessagesEs messages = _TranslationsMessagesEs._(_root);
	@override late final _TranslationsCommonEs common = _TranslationsCommonEs._(_root);
	@override late final _TranslationsPageEs page = _TranslationsPageEs._(_root);
}

// Path: app
class _TranslationsAppEs implements TranslationsAppEn {
	_TranslationsAppEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get login => 'Iniciar sesión';
	@override String get signup => 'Registrarse';
	@override String get logout => 'Cerrar sesión';
	@override String get search => 'Buscar';
	@override String get searchLanguage => 'Buscar un idioma';
	@override String get add => 'Agregar';
	@override String get edit => 'Modificar';
	@override String get delete => 'Eliminar';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get yes => 'Sí';
	@override String get no => 'No';
	@override String get confirm => 'Confirmar';
	@override String get error => 'Error';
	@override String get loading => 'Cargando...';
	@override String get noResults => 'Sin resultados';
	@override String get noResultsFound => 'No se encontraron resultados';
	@override String get skip => 'Omitir';
	@override String get next => 'Siguiente';
	@override String get previous => 'Anterior';
	@override String get finish => 'Terminar';
	@override String get back => 'Regresar';
	@override String get submit => 'Enviar';
	@override String get searchUser => 'Buscar un usuario';
	@override String get searchSubject => 'Buscar una materia';
	@override String get searchTopic => 'Buscar un tema';
	@override String get searchSheet => 'Buscar una ficha';
	@override String get alreadyHaveAccount => '¿Ya tienes una cuenta?';
	@override String get loadingIndicator => 'Cargando...';
	@override String get errorOccurred => 'Ocurrió un error';
	@override String get backTo => 'Regresar a ';
}

// Path: user
class _TranslationsUserEs implements TranslationsUserEn {
	_TranslationsUserEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get email => 'Correo electrónico';
	@override String get username => 'Nombre de usuario';
	@override String get name => 'Nombre';
	@override String get firstname => 'Nombre';
	@override String get birthdate => 'Fecha de nacimiento';
	@override String get location => 'Ubicación';
	@override String get bio => 'Biografía';
	@override String get nbReports => 'Número de reportes';
	@override String get address => 'Dirección';
	@override String get password => 'Contraseña';
	@override String get newPassword => 'Nueva contraseña';
	@override String get anonymous => 'Anónimo';
	@override String get noDescription => 'Sin descripción';
	@override String get noAddress => 'Dirección no disponible';
	@override String get noReportsAvailable => 'Número de reportes no disponible';
}

// Path: welcome
class _TranslationsWelcomeEs implements TranslationsWelcomeEn {
	_TranslationsWelcomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Bienvenido a Edumeet, la plataforma de revisión colaborativa';
	@override String get setup => 'Comencemos eligiendo un idioma';
	@override String get whatLanguage => '¿Qué idioma hablas?';
	@override String get chooseLanguage => 'Elige un idioma para que podamos comunicarnos juntos';
	@override String get title1 => 'Encuentra tus fichas de revisión';
	@override String get description1 => 'Accede gratuitamente a miles de \nfichas de revisión creadas por estudiantes';
	@override String get title2 => 'Organiza tus revisiones';
	@override String get description2 => 'Clasifica y organiza tus fichas para una \nmneoria eficaz';
	@override String get title3 => 'Mantente motivado';
	@override String get description3 => 'Alcanza tus objetivos con consejos \nprácticos';
	@override String get title4 => 'Únete a nuestra comunidad';
	@override String get description4 => 'Comparte tus fichas de revisión y \nrecibe consejos personalizados';
}

// Path: login
class _TranslationsLoginEs implements TranslationsLoginEn {
	_TranslationsLoginEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conexión';
	@override String get description => 'Ingrese su información a continuación para iniciar sesión';
	@override String get forgotPassword => '¿Olvidaste tu contraseña?';
	@override String get noAccount => '¿No tienes una cuenta?';
	@override String get createAccount => 'Crear una cuenta';
}

// Path: register
class _TranslationsRegisterEs implements TranslationsRegisterEn {
	_TranslationsRegisterEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crear una cuenta';
	@override String get description => 'Únete a nosotros para obtener nuestros servicios';
	@override String get conditions => 'Al crear una cuenta, aceptas nuestras Condiciones de uso y Política de privacidad';
	@override String get registerConfirm => 'Registro confirmado';
}

// Path: form
class _TranslationsFormEs implements TranslationsFormEn {
	_TranslationsFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Por favor ingresa un nombre de usuario';
	@override String get emptyFirstname => 'Por favor ingresa tu nombre';
	@override String get emptyEmail => 'Por favor ingresa tu dirección de correo electrónico';
	@override String get emptyLastname => 'Por favor ingresa tu apellido';
	@override String get emptyPassword => 'Por favor ingresa tu contraseña';
	@override String get emptyConfirmPassword => 'Por favor confirma tu contraseña';
	@override String get passwordMismatch => 'Las contraseñas no coinciden';
	@override String get invalidEmail => 'Por favor ingresa una dirección de correo electrónico válida';
	@override String get invalidAddress => 'Por favor ingresa una dirección válida';
	@override String get shortPassword => 'La contraseña debe tener al menos 8 caracteres';
	@override String get passwordUpperCase => 'La contraseña debe contener al menos una letra mayúscula';
	@override String get passwordDigit => 'La contraseña debe contener al menos un número';
	@override String get passwordSpecialChar => 'La contraseña debe contener al menos un carácter especial';
	@override String get haveToAcceptConditions => 'Debes aceptar las condiciones de uso y la política de privacidad';
	@override String get confirmPassword => 'Confirmar contraseña';
	@override String get pleaseConfirmPassword => 'Por favor confirma tu contraseña';
	@override String get passwordNotMatch => 'Las contraseñas no coinciden';
	@override String get invalidUsername => 'El nombre de usuario debe: \n- contener entre 3 y 20 caracteres \n- comenzar con una letra \n- no contener caracteres especiales';
}

// Path: swipe_cards
class _TranslationsSwipeCardsEs implements TranslationsSwipeCardsEn {
	_TranslationsSwipeCardsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Error al cargar los eventos';
	@override String get end_of_list => '¡Has llegado al final de la lista!';
	@override String get nope => 'No a {{title}}';
	@override String get joined_event => 'Te has unido al evento {{title}}';
	@override String get item_changed => 'Elemento modificado: {{title}}';
}

// Path: event
class _TranslationsEventEs implements TranslationsEventEn {
	_TranslationsEventEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get online => 'En línea';
	@override String get physical => 'Físico';
	@override String get participants => 'Participantes';
	@override String get hasJoinEvent => 'Te has unido al evento {{event_title}}';
	@override String get address_copied => 'Dirección copiada al portapapeles';
	@override String get createEvent => 'Crear un evento';
	@override String get name => 'Nombre';
	@override String get description => 'Descripción';
	@override String get date => 'Fecha';
	@override String get time => 'Hora';
	@override String get location => 'Ubicación';
	@override String get maxParticipants => 'Número de participantes';
	@override String get price => 'Precio';
	@override String get image => 'Imagen';
	@override String get create => 'Crear';
	@override String get enterName => 'Por favor ingresa un nombre';
	@override String get enterDescription => 'Por favor ingresa una descripción';
	@override String get enterDate => 'Por favor ingresa una fecha';
	@override String get enterTime => 'Por favor ingresa una hora';
	@override String get enterLocation => 'Por favor ingresa un lugar';
	@override String get enterMaxParticipants => 'Por favor ingresa un número de participantes';
	@override String get invalidMaxParticipants => 'Por favor ingresa un número válido';
	@override String get enterPrice => 'Por favor ingresa un precio';
	@override String get invalidPrice => 'Por favor ingresa un precio válido';
	@override String get enterImage => 'Por favor ingresa una URL de imagen';
	@override String get joinEvent => 'Unirse al evento';
	@override String get eventNotStarted => 'El enlace para unirse estará disponible aquí cuando el evento comience.';
}

// Path: error
class _TranslationsErrorEs implements TranslationsErrorEn {
	_TranslationsErrorEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get details => 'Error: {{error}}';
	@override String get general => 'Se ha producido un error';
	@override String get no_internet => 'Sin conexión a Internet';
	@override String get no_internet_description => 'Por favor verifica tu conexión a Internet y vuelve a intentarlo';
	@override String get no_events => 'No se encontraron eventos';
	@override String get no_events_description => 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
	@override String get no_events_found => 'No se encontraron eventos';
	@override String get no_events_found_description => 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
	@override String get no_events_found_title => 'No se encontraron eventos';
	@override String get no_events_found_description_title => 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
	@override String get no_events_found_description_title_search => 'No se encontraron eventos para la búsqueda realizada. Por favor intenta de nuevo con otro término';
	@override String get loadingEvents => 'Ocurrió un error al cargar los eventos';
	@override String get failedToResetPassword => 'Error al restablecer la contraseña';
}

// Path: auth
class _TranslationsAuthEs implements TranslationsAuthEn {
	_TranslationsAuthEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => '¿Olvidaste tu contraseña?';
	@override String get enterEmail => 'Ingresa tu dirección de correo electrónico para recibir las instrucciones de restablecimiento';
	@override String get resetPassword => 'Restablecer la contraseña';
	@override String get enterNewPassword => 'Ingresa tu nueva contraseña';
	@override String get resetInstructionsSent => 'Instrucciones de restablecimiento enviadas a tu correo electrónico';
	@override String get passwordResertSuccess => 'Tu contraseña ha sido restablecida con éxito';
}

// Path: verify
class _TranslationsVerifyEs implements TranslationsVerifyEn {
	_TranslationsVerifyEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verificación del código';
	@override String get description => 'Ingresa el código de verificación enviado a tu correo electrónico';
	@override String get inputLabel => 'Código de verificación';
	@override String get button => 'Verificar';
	@override String get error => 'Por favor ingresa el código de verificación';
}

// Path: profile
class _TranslationsProfileEs implements TranslationsProfileEn {
	_TranslationsProfileEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Modificar mi perfil';
	@override String get firstname => 'Nombre';
	@override String get lastname => 'Apellido';
	@override String get bio => 'Biografía';
	@override String get email => 'Correo electrónico';
	@override String get birthdate => 'Fecha de nacimiento';
	@override String get address => 'Dirección';
	@override String get save => 'Guardar';
	@override String get cancel => 'Cancelar';
	@override String get enterFirstname => 'Por favor ingresa tu nombre';
	@override String get enterLastname => 'Por favor ingresa tu apellido';
	@override String get enterEmail => 'Por favor ingresa tu dirección de correo electrónico';
	@override String get invalidEmail => 'Por favor ingresa una dirección de correo electrónico válida';
	@override String get logout => 'Cerrar sesión';
}

// Path: resources
class _TranslationsResourcesEs implements TranslationsResourcesEn {
	_TranslationsResourcesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Recursos disponibles';
	@override String get name => 'Nombre';
	@override String get type => 'Tipo';
}

// Path: messages
class _TranslationsMessagesEs implements TranslationsMessagesEn {
	_TranslationsMessagesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Últimos mensajes';
	@override String get seeAllMessages => 'Ver todos los mensajes';
	@override String get noMessages => 'Sin mensajes';
	@override String get writeMessageHint => 'Escribe un mensaje...';
	@override String get sendMessage => 'Enviar';
}

// Path: common
class _TranslationsCommonEs implements TranslationsCommonEn {
	_TranslationsCommonEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Remitente';
	@override String get message => 'Mensaje';
}

// Path: page
class _TranslationsPageEs implements TranslationsPageEn {
	_TranslationsPageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get homePage => 'Página de inicio';
	@override String get profile => 'Perfil';
	@override String get profilePage => 'Página de perfil';
	@override String get settings => 'Configuraciones';
	@override String get settingsPage => 'Página de configuraciones';
	@override String get search => 'Buscar';
	@override String get searchPage => 'Página de búsqueda';
	@override String get sheet => 'Ficha';
	@override String get sheetPage => 'Página de la ficha';
	@override String get subject => 'Materia';
	@override String get subjectPage => 'Página de la materia';
	@override String get topic => 'Tema';
	@override String get topicPage => 'Página del tema';
	@override String get event => 'Evento';
	@override String get eventPage => 'Página del evento';
	@override String get user => 'Usuario';
	@override String get userPage => 'Página del usuario';
	@override String get about => 'Acerca de';
	@override String get aboutPage => 'Página Acerca de';
	@override String get contact => 'Contacto';
	@override String get contactPage => 'Página de contacto';
	@override String get terms => 'Condiciones de uso';
	@override String get termsPage => 'Página de condiciones de uso';
	@override String get privacy => 'Política de privacidad';
	@override String get privacyPage => 'Página de políticas de privacidad';
	@override String get notifications => 'Notificaciones';
	@override String get events => 'Eventos';
	@override String get sheets => 'Fichas';
	@override String get subjects => 'Materias';
	@override String get topics => 'Temas';
	@override String get users => 'Usuarios';
	@override String get help => 'Ayuda';
	@override String get helpPage => 'Página de ayuda';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Iniciar sesión';
			case 'app.signup': return 'Registrarse';
			case 'app.logout': return 'Cerrar sesión';
			case 'app.search': return 'Buscar';
			case 'app.searchLanguage': return 'Buscar un idioma';
			case 'app.add': return 'Agregar';
			case 'app.edit': return 'Modificar';
			case 'app.delete': return 'Eliminar';
			case 'app.cancel': return 'Cancelar';
			case 'app.save': return 'Guardar';
			case 'app.yes': return 'Sí';
			case 'app.no': return 'No';
			case 'app.confirm': return 'Confirmar';
			case 'app.error': return 'Error';
			case 'app.loading': return 'Cargando...';
			case 'app.noResults': return 'Sin resultados';
			case 'app.noResultsFound': return 'No se encontraron resultados';
			case 'app.skip': return 'Omitir';
			case 'app.next': return 'Siguiente';
			case 'app.previous': return 'Anterior';
			case 'app.finish': return 'Terminar';
			case 'app.back': return 'Regresar';
			case 'app.submit': return 'Enviar';
			case 'app.searchUser': return 'Buscar un usuario';
			case 'app.searchSubject': return 'Buscar una materia';
			case 'app.searchTopic': return 'Buscar un tema';
			case 'app.searchSheet': return 'Buscar una ficha';
			case 'app.alreadyHaveAccount': return '¿Ya tienes una cuenta?';
			case 'app.loadingIndicator': return 'Cargando...';
			case 'app.errorOccurred': return 'Ocurrió un error';
			case 'app.backTo': return 'Regresar a ';
			case 'user.email': return 'Correo electrónico';
			case 'user.username': return 'Nombre de usuario';
			case 'user.name': return 'Nombre';
			case 'user.firstname': return 'Nombre';
			case 'user.birthdate': return 'Fecha de nacimiento';
			case 'user.location': return 'Ubicación';
			case 'user.bio': return 'Biografía';
			case 'user.nbReports': return 'Número de reportes';
			case 'user.address': return 'Dirección';
			case 'user.password': return 'Contraseña';
			case 'user.newPassword': return 'Nueva contraseña';
			case 'user.anonymous': return 'Anónimo';
			case 'user.noDescription': return 'Sin descripción';
			case 'user.noAddress': return 'Dirección no disponible';
			case 'user.noReportsAvailable': return 'Número de reportes no disponible';
			case 'welcome.welcome': return 'Bienvenido a Edumeet, la plataforma de revisión colaborativa';
			case 'welcome.setup': return 'Comencemos eligiendo un idioma';
			case 'welcome.whatLanguage': return '¿Qué idioma hablas?';
			case 'welcome.chooseLanguage': return 'Elige un idioma para que podamos comunicarnos juntos';
			case 'welcome.title1': return 'Encuentra tus fichas de revisión';
			case 'welcome.description1': return 'Accede gratuitamente a miles de \nfichas de revisión creadas por estudiantes';
			case 'welcome.title2': return 'Organiza tus revisiones';
			case 'welcome.description2': return 'Clasifica y organiza tus fichas para una \nmneoria eficaz';
			case 'welcome.title3': return 'Mantente motivado';
			case 'welcome.description3': return 'Alcanza tus objetivos con consejos \nprácticos';
			case 'welcome.title4': return 'Únete a nuestra comunidad';
			case 'welcome.description4': return 'Comparte tus fichas de revisión y \nrecibe consejos personalizados';
			case 'login.title': return 'Conexión';
			case 'login.description': return 'Ingrese su información a continuación para iniciar sesión';
			case 'login.forgotPassword': return '¿Olvidaste tu contraseña?';
			case 'login.noAccount': return '¿No tienes una cuenta?';
			case 'login.createAccount': return 'Crear una cuenta';
			case 'register.title': return 'Crear una cuenta';
			case 'register.description': return 'Únete a nosotros para obtener nuestros servicios';
			case 'register.conditions': return 'Al crear una cuenta, aceptas nuestras Condiciones de uso y Política de privacidad';
			case 'register.registerConfirm': return 'Registro confirmado';
			case 'form.emptyUsername': return 'Por favor ingresa un nombre de usuario';
			case 'form.emptyFirstname': return 'Por favor ingresa tu nombre';
			case 'form.emptyEmail': return 'Por favor ingresa tu dirección de correo electrónico';
			case 'form.emptyLastname': return 'Por favor ingresa tu apellido';
			case 'form.emptyPassword': return 'Por favor ingresa tu contraseña';
			case 'form.emptyConfirmPassword': return 'Por favor confirma tu contraseña';
			case 'form.passwordMismatch': return 'Las contraseñas no coinciden';
			case 'form.invalidEmail': return 'Por favor ingresa una dirección de correo electrónico válida';
			case 'form.invalidAddress': return 'Por favor ingresa una dirección válida';
			case 'form.shortPassword': return 'La contraseña debe tener al menos 8 caracteres';
			case 'form.passwordUpperCase': return 'La contraseña debe contener al menos una letra mayúscula';
			case 'form.passwordDigit': return 'La contraseña debe contener al menos un número';
			case 'form.passwordSpecialChar': return 'La contraseña debe contener al menos un carácter especial';
			case 'form.haveToAcceptConditions': return 'Debes aceptar las condiciones de uso y la política de privacidad';
			case 'form.confirmPassword': return 'Confirmar contraseña';
			case 'form.pleaseConfirmPassword': return 'Por favor confirma tu contraseña';
			case 'form.passwordNotMatch': return 'Las contraseñas no coinciden';
			case 'form.invalidUsername': return 'El nombre de usuario debe: \n- contener entre 3 y 20 caracteres \n- comenzar con una letra \n- no contener caracteres especiales';
			case 'swipe_cards.loading_error': return 'Error al cargar los eventos';
			case 'swipe_cards.end_of_list': return '¡Has llegado al final de la lista!';
			case 'swipe_cards.nope': return 'No a {{title}}';
			case 'swipe_cards.joined_event': return 'Te has unido al evento {{title}}';
			case 'swipe_cards.item_changed': return 'Elemento modificado: {{title}}';
			case 'event.online': return 'En línea';
			case 'event.physical': return 'Físico';
			case 'event.participants': return 'Participantes';
			case 'event.hasJoinEvent': return 'Te has unido al evento {{event_title}}';
			case 'event.address_copied': return 'Dirección copiada al portapapeles';
			case 'event.createEvent': return 'Crear un evento';
			case 'event.name': return 'Nombre';
			case 'event.description': return 'Descripción';
			case 'event.date': return 'Fecha';
			case 'event.time': return 'Hora';
			case 'event.location': return 'Ubicación';
			case 'event.maxParticipants': return 'Número de participantes';
			case 'event.price': return 'Precio';
			case 'event.image': return 'Imagen';
			case 'event.create': return 'Crear';
			case 'event.enterName': return 'Por favor ingresa un nombre';
			case 'event.enterDescription': return 'Por favor ingresa una descripción';
			case 'event.enterDate': return 'Por favor ingresa una fecha';
			case 'event.enterTime': return 'Por favor ingresa una hora';
			case 'event.enterLocation': return 'Por favor ingresa un lugar';
			case 'event.enterMaxParticipants': return 'Por favor ingresa un número de participantes';
			case 'event.invalidMaxParticipants': return 'Por favor ingresa un número válido';
			case 'event.enterPrice': return 'Por favor ingresa un precio';
			case 'event.invalidPrice': return 'Por favor ingresa un precio válido';
			case 'event.enterImage': return 'Por favor ingresa una URL de imagen';
			case 'event.joinEvent': return 'Unirse al evento';
			case 'event.eventNotStarted': return 'El enlace para unirse estará disponible aquí cuando el evento comience.';
			case 'error.details': return 'Error: {{error}}';
			case 'error.general': return 'Se ha producido un error';
			case 'error.no_internet': return 'Sin conexión a Internet';
			case 'error.no_internet_description': return 'Por favor verifica tu conexión a Internet y vuelve a intentarlo';
			case 'error.no_events': return 'No se encontraron eventos';
			case 'error.no_events_description': return 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
			case 'error.no_events_found': return 'No se encontraron eventos';
			case 'error.no_events_found_description': return 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
			case 'error.no_events_found_title': return 'No se encontraron eventos';
			case 'error.no_events_found_description_title': return 'No se encontraron eventos en este momento. Por favor intenta de nuevo más tarde';
			case 'error.no_events_found_description_title_search': return 'No se encontraron eventos para la búsqueda realizada. Por favor intenta de nuevo con otro término';
			case 'error.loadingEvents': return 'Ocurrió un error al cargar los eventos';
			case 'error.failedToResetPassword': return 'Error al restablecer la contraseña';
			case 'auth.forgotPassword': return '¿Olvidaste tu contraseña?';
			case 'auth.enterEmail': return 'Ingresa tu dirección de correo electrónico para recibir las instrucciones de restablecimiento';
			case 'auth.resetPassword': return 'Restablecer la contraseña';
			case 'auth.enterNewPassword': return 'Ingresa tu nueva contraseña';
			case 'auth.resetInstructionsSent': return 'Instrucciones de restablecimiento enviadas a tu correo electrónico';
			case 'auth.passwordResertSuccess': return 'Tu contraseña ha sido restablecida con éxito';
			case 'verify.title': return 'Verificación del código';
			case 'verify.description': return 'Ingresa el código de verificación enviado a tu correo electrónico';
			case 'verify.inputLabel': return 'Código de verificación';
			case 'verify.button': return 'Verificar';
			case 'verify.error': return 'Por favor ingresa el código de verificación';
			case 'profile.editProfile': return 'Modificar mi perfil';
			case 'profile.firstname': return 'Nombre';
			case 'profile.lastname': return 'Apellido';
			case 'profile.bio': return 'Biografía';
			case 'profile.email': return 'Correo electrónico';
			case 'profile.birthdate': return 'Fecha de nacimiento';
			case 'profile.address': return 'Dirección';
			case 'profile.save': return 'Guardar';
			case 'profile.cancel': return 'Cancelar';
			case 'profile.enterFirstname': return 'Por favor ingresa tu nombre';
			case 'profile.enterLastname': return 'Por favor ingresa tu apellido';
			case 'profile.enterEmail': return 'Por favor ingresa tu dirección de correo electrónico';
			case 'profile.invalidEmail': return 'Por favor ingresa una dirección de correo electrónico válida';
			case 'profile.logout': return 'Cerrar sesión';
			case 'resources.availableResources': return 'Recursos disponibles';
			case 'resources.name': return 'Nombre';
			case 'resources.type': return 'Tipo';
			case 'messages.latestMessages': return 'Últimos mensajes';
			case 'messages.seeAllMessages': return 'Ver todos los mensajes';
			case 'messages.noMessages': return 'Sin mensajes';
			case 'messages.writeMessageHint': return 'Escribe un mensaje...';
			case 'messages.sendMessage': return 'Enviar';
			case 'common.sender': return 'Remitente';
			case 'common.message': return 'Mensaje';
			case 'page.home': return 'Inicio';
			case 'page.homePage': return 'Página de inicio';
			case 'page.profile': return 'Perfil';
			case 'page.profilePage': return 'Página de perfil';
			case 'page.settings': return 'Configuraciones';
			case 'page.settingsPage': return 'Página de configuraciones';
			case 'page.search': return 'Buscar';
			case 'page.searchPage': return 'Página de búsqueda';
			case 'page.sheet': return 'Ficha';
			case 'page.sheetPage': return 'Página de la ficha';
			case 'page.subject': return 'Materia';
			case 'page.subjectPage': return 'Página de la materia';
			case 'page.topic': return 'Tema';
			case 'page.topicPage': return 'Página del tema';
			case 'page.event': return 'Evento';
			case 'page.eventPage': return 'Página del evento';
			case 'page.user': return 'Usuario';
			case 'page.userPage': return 'Página del usuario';
			case 'page.about': return 'Acerca de';
			case 'page.aboutPage': return 'Página Acerca de';
			case 'page.contact': return 'Contacto';
			case 'page.contactPage': return 'Página de contacto';
			case 'page.terms': return 'Condiciones de uso';
			case 'page.termsPage': return 'Página de condiciones de uso';
			case 'page.privacy': return 'Política de privacidad';
			case 'page.privacyPage': return 'Página de políticas de privacidad';
			case 'page.notifications': return 'Notificaciones';
			case 'page.events': return 'Eventos';
			case 'page.sheets': return 'Fichas';
			case 'page.subjects': return 'Materias';
			case 'page.topics': return 'Temas';
			case 'page.users': return 'Usuarios';
			case 'page.help': return 'Ayuda';
			case 'page.helpPage': return 'Página de ayuda';
			default: return null;
		}
	}
}


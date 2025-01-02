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
class TranslationsPt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsPt _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppPt app = _TranslationsAppPt._(_root);
	@override late final _TranslationsUserPt user = _TranslationsUserPt._(_root);
	@override late final _TranslationsWelcomePt welcome = _TranslationsWelcomePt._(_root);
	@override late final _TranslationsLoginPt login = _TranslationsLoginPt._(_root);
	@override late final _TranslationsRegisterPt register = _TranslationsRegisterPt._(_root);
	@override late final _TranslationsFormPt form = _TranslationsFormPt._(_root);
	@override late final _TranslationsSwipeCardsPt swipe_cards = _TranslationsSwipeCardsPt._(_root);
	@override late final _TranslationsEventPt event = _TranslationsEventPt._(_root);
	@override late final _TranslationsErrorPt error = _TranslationsErrorPt._(_root);
	@override late final _TranslationsAuthPt auth = _TranslationsAuthPt._(_root);
	@override late final _TranslationsVerifyPt verify = _TranslationsVerifyPt._(_root);
	@override late final _TranslationsProfilePt profile = _TranslationsProfilePt._(_root);
	@override late final _TranslationsResourcesPt resources = _TranslationsResourcesPt._(_root);
	@override late final _TranslationsMessagesPt messages = _TranslationsMessagesPt._(_root);
	@override late final _TranslationsCommonPt common = _TranslationsCommonPt._(_root);
	@override late final _TranslationsSettingsPt settings = _TranslationsSettingsPt._(_root);
	@override late final _TranslationsPagePt page = _TranslationsPagePt._(_root);
}

// Path: app
class _TranslationsAppPt implements TranslationsAppFr {
	_TranslationsAppPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get login => 'Entrar';
	@override String get signup => 'Inscrever-se';
	@override String get logout => 'Sair';
	@override String get search => 'Pesquisar';
	@override String get searchLanguage => 'Pesquisar um idioma';
	@override String get add => 'Adicionar';
	@override String get edit => 'Modificar';
	@override String get delete => 'Excluir';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Salvar';
	@override String get yes => 'Sim';
	@override String get no => 'Não';
	@override String get confirm => 'Confirmar';
	@override String get error => 'Erro';
	@override String get loading => 'Carregando...';
	@override String get noResults => 'Nenhum resultado';
	@override String get noResultsFound => 'Nenhum resultado encontrado';
	@override String get skip => 'Saltar';
	@override String get next => 'Próximo';
	@override String get previous => 'Anterior';
	@override String get finish => 'Terminar';
	@override String get back => 'Voltar';
	@override String get submit => 'Enviar';
	@override String get searchUser => 'Pesquisar um usuário';
	@override String get searchSubject => 'Pesquisar uma matéria';
	@override String get searchTopic => 'Pesquisar um tema';
	@override String get searchSheet => 'Pesquisar uma ficha';
	@override String get alreadyHaveAccount => 'Você já tem uma conta?';
	@override String get loadingIndicator => 'Carregando...';
	@override String get errorOccurred => 'Ocorreu um erro';
	@override String get backTo => 'Retornar a ';
	@override String get unknown => 'Desconhecido';
}

// Path: user
class _TranslationsUserPt implements TranslationsUserFr {
	_TranslationsUserPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get username => 'Nome de usuário';
	@override String get name => 'Nome';
	@override String get firstname => 'Sobrenome';
	@override String get birthdate => 'Data de nascimento';
	@override String get location => 'Localização';
	@override String get bio => 'Bio';
	@override String get nbReports => 'Número de denúncias';
	@override String get address => 'Endereço';
	@override String get password => 'Senha';
	@override String get newPassword => 'Nova senha';
	@override String get anonymous => 'Anônimo';
	@override String get noDescription => 'Nenhuma descrição';
	@override String get noAddress => 'Endereço não disponível';
	@override String get noReportsAvailable => 'Número de denúncias não disponível';
}

// Path: welcome
class _TranslationsWelcomePt implements TranslationsWelcomeFr {
	_TranslationsWelcomePt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Bem-vindo ao Edumeet, a plataforma de revisão colaborativa';
	@override String get setup => 'Vamos começar escolhendo um idioma';
	@override String get whatLanguage => 'Qual idioma você fala?';
	@override String get chooseLanguage => 'Escolha um idioma para que possamos nos comunicar juntos';
	@override String get title1 => 'Encontre suas fichas de revisão';
	@override String get description1 => 'Acesse gratuitamente milhares de \nfichas de revisão criadas por estudantes';
	@override String get title2 => 'Organize suas revisões';
	@override String get description2 => 'Classifique e organize suas fichas para uma \nmemória eficaz';
	@override String get title3 => 'Mantenha-se motivado';
	@override String get description3 => 'Alcance seus objetivos com conselhos \npráticos';
	@override String get title4 => 'Junte-se à nossa comunidade';
	@override String get description4 => 'Compartilhe suas fichas de revisão e \nreceba conselhos personalizados';
}

// Path: login
class _TranslationsLoginPt implements TranslationsLoginFr {
	_TranslationsLoginPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conexão';
	@override String get description => 'Insira suas informações abaixo para fazer login';
	@override String get forgotPassword => 'Esqueceu a senha?';
	@override String get noAccount => 'Você não tem uma conta?';
	@override String get createAccount => 'Criar uma conta';
}

// Path: register
class _TranslationsRegisterPt implements TranslationsRegisterFr {
	_TranslationsRegisterPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Criar uma conta';
	@override String get description => 'Junte-se a nós para aproveitar nossos serviços';
	@override String get conditions => 'Ao criar uma conta, você aceita nossos Termos de uso e Política de privacidade';
	@override String get registerConfirm => 'Inscrição confirmada';
}

// Path: form
class _TranslationsFormPt implements TranslationsFormFr {
	_TranslationsFormPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get emptyUsername => 'Por favor, insira um nome de usuário';
	@override String get emptyFirstname => 'Por favor, insira seu sobrenome';
	@override String get emptyEmail => 'Por favor, insira seu endereço de e-mail';
	@override String get emptyLastname => 'Por favor, insira seu nome';
	@override String get emptyPassword => 'Por favor, insira sua senha';
	@override String get emptyConfirmPassword => 'Por favor, confirme sua senha';
	@override String get passwordMismatch => 'As senhas não correspondem';
	@override String get invalidEmail => 'Por favor, insira um endereço de e-mail válido';
	@override String get invalidAddress => 'Por favor, insira um endereço válido';
	@override String get shortPassword => 'A senha deve ter pelo menos 8 caracteres';
	@override String get passwordUpperCase => 'A senha deve conter pelo menos uma letra maiúscula';
	@override String get passwordDigit => 'A senha deve conter pelo menos um número';
	@override String get passwordSpecialChar => 'A senha deve conter pelo menos um caractere especial';
	@override String get haveToAcceptConditions => 'Você deve aceitar os termos de uso e a política de privacidade';
	@override String get confirmPassword => 'Confirmar senha';
	@override String get pleaseConfirmPassword => 'Por favor, confirme sua senha';
	@override String get passwordNotMatch => 'As senhas não correspondem';
	@override String get invalidUsername => 'O nome de usuário deve: \n- conter entre 3 e 20 caracteres \n- começar com uma letra \n- não conter caracteres especiais';
}

// Path: swipe_cards
class _TranslationsSwipeCardsPt implements TranslationsSwipeCardsFr {
	_TranslationsSwipeCardsPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get loading_error => 'Erro ao carregar os eventos';
	@override String get end_of_list => 'Você chegou ao final da lista!';
	@override String nope({required Object title}) => 'Não para ${title}';
	@override String joined_event({required Object title}) => 'Você se juntou ao evento ${title}';
	@override String item_changed({required Object title}) => 'Item modificado: ${title}';
}

// Path: event
class _TranslationsEventPt implements TranslationsEventFr {
	_TranslationsEventPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get online => 'Online';
	@override String get physical => 'Presencial';
	@override String get participants => 'Participantes';
	@override String hasJoinEvent({required Object event_title}) => 'Você se juntou ao evento ${event_title}';
	@override String get address_copied => 'Endereço copiado para a área de transferência';
	@override String get createEvent => 'Criar um evento';
	@override String get name => 'Nome';
	@override String get description => 'Descrição';
	@override String get date => 'Data';
	@override String get time => 'Hora';
	@override String get location => 'Localização';
	@override String get maxParticipants => 'Número de participantes';
	@override String get price => 'Preço';
	@override String get image => 'Imagem';
	@override String get create => 'Criar';
	@override String get enterName => 'Por favor, insira um nome';
	@override String get enterDescription => 'Por favor, insira uma descrição';
	@override String get enterDate => 'Por favor, insira uma data';
	@override String get enterTime => 'Por favor, insira uma hora';
	@override String get enterLocation => 'Por favor, insira um local';
	@override String get enterMaxParticipants => 'Por favor, insira um número de participantes';
	@override String get invalidMaxParticipants => 'Por favor, insira um número válido';
	@override String get enterPrice => 'Por favor, insira um preço';
	@override String get invalidPrice => 'Por favor, insira um preço válido';
	@override String get enterImage => 'Por favor, insira uma URL de imagem';
	@override String get joinEvent => 'Participar do evento';
	@override String get eventNotStarted => 'O link de conexão estará disponível aqui quando o evento começar.';
}

// Path: error
class _TranslationsErrorPt implements TranslationsErrorFr {
	_TranslationsErrorPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String details({required Object error}) => 'Erro: ${error}';
	@override String get general => 'Ocorreu um erro';
	@override String get no_results => 'Nenhum resultado encontrado';
	@override String get no_internet => 'Sem conexão com a Internet';
	@override String get no_internet_description => 'Por favor, verifique sua conexão com a Internet e tente novamente';
	@override String get no_events => 'Nenhum evento encontrado';
	@override String get no_events_description => 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
	@override String get no_events_found => 'Nenhum evento encontrado';
	@override String get no_events_found_description => 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
	@override String get no_events_found_title => 'Nenhum evento encontrado';
	@override String get no_events_found_description_title => 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
	@override String get no_events_found_description_title_search => 'Nenhum evento foi encontrado para a pesquisa realizada. Por favor, tente novamente com outro termo';
	@override String get loadingEvents => 'Ocorreu um erro ao carregar os eventos';
	@override String get failedToResetPassword => 'Falha ao redefinir a senha';
}

// Path: auth
class _TranslationsAuthPt implements TranslationsAuthFr {
	_TranslationsAuthPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Esqueceu a senha?';
	@override String get enterEmail => 'Insira seu endereço de e-mail para receber as instruções de redefinição';
	@override String get resetPassword => 'Redefinir a senha';
	@override String get enterNewPassword => 'Insira sua nova senha';
	@override String get resetInstructionsSent => 'Instruções de redefinição enviadas para seu e-mail';
	@override String get passwordResertSuccess => 'Sua senha foi redefinida com sucesso';
}

// Path: verify
class _TranslationsVerifyPt implements TranslationsVerifyFr {
	_TranslationsVerifyPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verificação do código';
	@override String get description => 'Insira o código de verificação enviado para seu e-mail';
	@override String get inputLabel => 'Código de verificação';
	@override String get button => 'Verificar';
	@override String get error => 'Por favor, insira o código de verificação';
}

// Path: profile
class _TranslationsProfilePt implements TranslationsProfileFr {
	_TranslationsProfilePt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get editProfile => 'Modificar meu perfil';
	@override String get firstname => 'Sobrenome';
	@override String get lastname => 'Nome';
	@override String get bio => 'Bio';
	@override String get email => 'Email';
	@override String get birthdate => 'Data de nascimento';
	@override String get address => 'Endereço';
	@override String get save => 'Salvar';
	@override String get cancel => 'Cancelar';
	@override String get enterFirstname => 'Por favor, insira seu sobrenome';
	@override String get enterLastname => 'Por favor, insira seu nome';
	@override String get enterEmail => 'Por favor, insira seu endereço de e-mail';
	@override String get invalidEmail => 'Por favor, insira um endereço de e-mail válido';
	@override String get logout => 'Sair';
}

// Path: resources
class _TranslationsResourcesPt implements TranslationsResourcesFr {
	_TranslationsResourcesPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get availableResources => 'Recursos disponíveis';
	@override String get name => 'Nome';
	@override String get type => 'Tipo';
}

// Path: messages
class _TranslationsMessagesPt implements TranslationsMessagesFr {
	_TranslationsMessagesPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get latestMessages => 'Últimas mensagens';
	@override String get seeAllMessages => 'Ver todas as mensagens';
	@override String get noMessages => 'Nenhuma mensagem';
	@override String get writeMessageHint => 'Escreva uma mensagem...';
	@override String get sendMessage => 'Enviar';
}

// Path: common
class _TranslationsCommonPt implements TranslationsCommonFr {
	_TranslationsCommonPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get sender => 'Remetente';
	@override String get message => 'Mensagem';
}

// Path: settings
class _TranslationsSettingsPt implements TranslationsSettingsFr {
	_TranslationsSettingsPt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get account => 'Conta';
	@override String get settings => 'Configurações';
	@override String get language => 'Idioma';
	@override String get manageSubjects => 'Gerenciar matérias';
	@override String get notifications => 'Notificações';
	@override String get about => 'Sobre';
	@override String get contact => 'Contato';
	@override String get terms => 'Termos de uso';
	@override String get privacy => 'Política de privacidade';
}

// Path: page
class _TranslationsPagePt implements TranslationsPageFr {
	_TranslationsPagePt._(this._root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get home => 'Início';
	@override String get homePage => 'Página inicial';
	@override String get profile => 'Perfil';
	@override String get profilePage => 'Página de perfil';
	@override String get settings => 'Configurações';
	@override String get settingsPage => 'Página de configurações';
	@override String get search => 'Pesquisa';
	@override String get searchPage => 'Página de pesquisa';
	@override String get sheet => 'Ficha';
	@override String get sheetPage => 'Página da ficha';
	@override String get subject => 'Matéria';
	@override String get subjectPage => 'Página da matéria';
	@override String get topic => 'Tema';
	@override String get topicPage => 'Página do tema';
	@override String get event => 'Evento';
	@override String get eventPage => 'Página do evento';
	@override String get user => 'Usuário';
	@override String get userPage => 'Página do usuário';
	@override String get about => 'Sobre';
	@override String get aboutPage => 'Página Sobre';
	@override String get contact => 'Contato';
	@override String get contactPage => 'Página de contato';
	@override String get terms => 'Termos de uso';
	@override String get termsPage => 'Página dos termos de uso';
	@override String get privacy => 'Política de privacidade';
	@override String get privacyPage => 'Página da política de privacidade';
	@override String get notifications => 'Notificações';
	@override String get events => 'Eventos';
	@override String get sheets => 'Fichas';
	@override String get subjects => 'Matérias';
	@override String get topics => 'Temas';
	@override String get users => 'Usuários';
	@override String get help => 'Ajuda';
	@override String get helpPage => 'Página de ajuda';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsPt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.login': return 'Entrar';
			case 'app.signup': return 'Inscrever-se';
			case 'app.logout': return 'Sair';
			case 'app.search': return 'Pesquisar';
			case 'app.searchLanguage': return 'Pesquisar um idioma';
			case 'app.add': return 'Adicionar';
			case 'app.edit': return 'Modificar';
			case 'app.delete': return 'Excluir';
			case 'app.cancel': return 'Cancelar';
			case 'app.save': return 'Salvar';
			case 'app.yes': return 'Sim';
			case 'app.no': return 'Não';
			case 'app.confirm': return 'Confirmar';
			case 'app.error': return 'Erro';
			case 'app.loading': return 'Carregando...';
			case 'app.noResults': return 'Nenhum resultado';
			case 'app.noResultsFound': return 'Nenhum resultado encontrado';
			case 'app.skip': return 'Saltar';
			case 'app.next': return 'Próximo';
			case 'app.previous': return 'Anterior';
			case 'app.finish': return 'Terminar';
			case 'app.back': return 'Voltar';
			case 'app.submit': return 'Enviar';
			case 'app.searchUser': return 'Pesquisar um usuário';
			case 'app.searchSubject': return 'Pesquisar uma matéria';
			case 'app.searchTopic': return 'Pesquisar um tema';
			case 'app.searchSheet': return 'Pesquisar uma ficha';
			case 'app.alreadyHaveAccount': return 'Você já tem uma conta?';
			case 'app.loadingIndicator': return 'Carregando...';
			case 'app.errorOccurred': return 'Ocorreu um erro';
			case 'app.backTo': return 'Retornar a ';
			case 'app.unknown': return 'Desconhecido';
			case 'user.email': return 'Email';
			case 'user.username': return 'Nome de usuário';
			case 'user.name': return 'Nome';
			case 'user.firstname': return 'Sobrenome';
			case 'user.birthdate': return 'Data de nascimento';
			case 'user.location': return 'Localização';
			case 'user.bio': return 'Bio';
			case 'user.nbReports': return 'Número de denúncias';
			case 'user.address': return 'Endereço';
			case 'user.password': return 'Senha';
			case 'user.newPassword': return 'Nova senha';
			case 'user.anonymous': return 'Anônimo';
			case 'user.noDescription': return 'Nenhuma descrição';
			case 'user.noAddress': return 'Endereço não disponível';
			case 'user.noReportsAvailable': return 'Número de denúncias não disponível';
			case 'welcome.welcome': return 'Bem-vindo ao Edumeet, a plataforma de revisão colaborativa';
			case 'welcome.setup': return 'Vamos começar escolhendo um idioma';
			case 'welcome.whatLanguage': return 'Qual idioma você fala?';
			case 'welcome.chooseLanguage': return 'Escolha um idioma para que possamos nos comunicar juntos';
			case 'welcome.title1': return 'Encontre suas fichas de revisão';
			case 'welcome.description1': return 'Acesse gratuitamente milhares de \nfichas de revisão criadas por estudantes';
			case 'welcome.title2': return 'Organize suas revisões';
			case 'welcome.description2': return 'Classifique e organize suas fichas para uma \nmemória eficaz';
			case 'welcome.title3': return 'Mantenha-se motivado';
			case 'welcome.description3': return 'Alcance seus objetivos com conselhos \npráticos';
			case 'welcome.title4': return 'Junte-se à nossa comunidade';
			case 'welcome.description4': return 'Compartilhe suas fichas de revisão e \nreceba conselhos personalizados';
			case 'login.title': return 'Conexão';
			case 'login.description': return 'Insira suas informações abaixo para fazer login';
			case 'login.forgotPassword': return 'Esqueceu a senha?';
			case 'login.noAccount': return 'Você não tem uma conta?';
			case 'login.createAccount': return 'Criar uma conta';
			case 'register.title': return 'Criar uma conta';
			case 'register.description': return 'Junte-se a nós para aproveitar nossos serviços';
			case 'register.conditions': return 'Ao criar uma conta, você aceita nossos Termos de uso e Política de privacidade';
			case 'register.registerConfirm': return 'Inscrição confirmada';
			case 'form.emptyUsername': return 'Por favor, insira um nome de usuário';
			case 'form.emptyFirstname': return 'Por favor, insira seu sobrenome';
			case 'form.emptyEmail': return 'Por favor, insira seu endereço de e-mail';
			case 'form.emptyLastname': return 'Por favor, insira seu nome';
			case 'form.emptyPassword': return 'Por favor, insira sua senha';
			case 'form.emptyConfirmPassword': return 'Por favor, confirme sua senha';
			case 'form.passwordMismatch': return 'As senhas não correspondem';
			case 'form.invalidEmail': return 'Por favor, insira um endereço de e-mail válido';
			case 'form.invalidAddress': return 'Por favor, insira um endereço válido';
			case 'form.shortPassword': return 'A senha deve ter pelo menos 8 caracteres';
			case 'form.passwordUpperCase': return 'A senha deve conter pelo menos uma letra maiúscula';
			case 'form.passwordDigit': return 'A senha deve conter pelo menos um número';
			case 'form.passwordSpecialChar': return 'A senha deve conter pelo menos um caractere especial';
			case 'form.haveToAcceptConditions': return 'Você deve aceitar os termos de uso e a política de privacidade';
			case 'form.confirmPassword': return 'Confirmar senha';
			case 'form.pleaseConfirmPassword': return 'Por favor, confirme sua senha';
			case 'form.passwordNotMatch': return 'As senhas não correspondem';
			case 'form.invalidUsername': return 'O nome de usuário deve: \n- conter entre 3 e 20 caracteres \n- começar com uma letra \n- não conter caracteres especiais';
			case 'swipe_cards.loading_error': return 'Erro ao carregar os eventos';
			case 'swipe_cards.end_of_list': return 'Você chegou ao final da lista!';
			case 'swipe_cards.nope': return ({required Object title}) => 'Não para ${title}';
			case 'swipe_cards.joined_event': return ({required Object title}) => 'Você se juntou ao evento ${title}';
			case 'swipe_cards.item_changed': return ({required Object title}) => 'Item modificado: ${title}';
			case 'event.online': return 'Online';
			case 'event.physical': return 'Presencial';
			case 'event.participants': return 'Participantes';
			case 'event.hasJoinEvent': return ({required Object event_title}) => 'Você se juntou ao evento ${event_title}';
			case 'event.address_copied': return 'Endereço copiado para a área de transferência';
			case 'event.createEvent': return 'Criar um evento';
			case 'event.name': return 'Nome';
			case 'event.description': return 'Descrição';
			case 'event.date': return 'Data';
			case 'event.time': return 'Hora';
			case 'event.location': return 'Localização';
			case 'event.maxParticipants': return 'Número de participantes';
			case 'event.price': return 'Preço';
			case 'event.image': return 'Imagem';
			case 'event.create': return 'Criar';
			case 'event.enterName': return 'Por favor, insira um nome';
			case 'event.enterDescription': return 'Por favor, insira uma descrição';
			case 'event.enterDate': return 'Por favor, insira uma data';
			case 'event.enterTime': return 'Por favor, insira uma hora';
			case 'event.enterLocation': return 'Por favor, insira um local';
			case 'event.enterMaxParticipants': return 'Por favor, insira um número de participantes';
			case 'event.invalidMaxParticipants': return 'Por favor, insira um número válido';
			case 'event.enterPrice': return 'Por favor, insira um preço';
			case 'event.invalidPrice': return 'Por favor, insira um preço válido';
			case 'event.enterImage': return 'Por favor, insira uma URL de imagem';
			case 'event.joinEvent': return 'Participar do evento';
			case 'event.eventNotStarted': return 'O link de conexão estará disponível aqui quando o evento começar.';
			case 'error.details': return ({required Object error}) => 'Erro: ${error}';
			case 'error.general': return 'Ocorreu um erro';
			case 'error.no_results': return 'Nenhum resultado encontrado';
			case 'error.no_internet': return 'Sem conexão com a Internet';
			case 'error.no_internet_description': return 'Por favor, verifique sua conexão com a Internet e tente novamente';
			case 'error.no_events': return 'Nenhum evento encontrado';
			case 'error.no_events_description': return 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
			case 'error.no_events_found': return 'Nenhum evento encontrado';
			case 'error.no_events_found_description': return 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
			case 'error.no_events_found_title': return 'Nenhum evento encontrado';
			case 'error.no_events_found_description_title': return 'Nenhum evento foi encontrado no momento. Por favor, tente novamente mais tarde';
			case 'error.no_events_found_description_title_search': return 'Nenhum evento foi encontrado para a pesquisa realizada. Por favor, tente novamente com outro termo';
			case 'error.loadingEvents': return 'Ocorreu um erro ao carregar os eventos';
			case 'error.failedToResetPassword': return 'Falha ao redefinir a senha';
			case 'auth.forgotPassword': return 'Esqueceu a senha?';
			case 'auth.enterEmail': return 'Insira seu endereço de e-mail para receber as instruções de redefinição';
			case 'auth.resetPassword': return 'Redefinir a senha';
			case 'auth.enterNewPassword': return 'Insira sua nova senha';
			case 'auth.resetInstructionsSent': return 'Instruções de redefinição enviadas para seu e-mail';
			case 'auth.passwordResertSuccess': return 'Sua senha foi redefinida com sucesso';
			case 'verify.title': return 'Verificação do código';
			case 'verify.description': return 'Insira o código de verificação enviado para seu e-mail';
			case 'verify.inputLabel': return 'Código de verificação';
			case 'verify.button': return 'Verificar';
			case 'verify.error': return 'Por favor, insira o código de verificação';
			case 'profile.editProfile': return 'Modificar meu perfil';
			case 'profile.firstname': return 'Sobrenome';
			case 'profile.lastname': return 'Nome';
			case 'profile.bio': return 'Bio';
			case 'profile.email': return 'Email';
			case 'profile.birthdate': return 'Data de nascimento';
			case 'profile.address': return 'Endereço';
			case 'profile.save': return 'Salvar';
			case 'profile.cancel': return 'Cancelar';
			case 'profile.enterFirstname': return 'Por favor, insira seu sobrenome';
			case 'profile.enterLastname': return 'Por favor, insira seu nome';
			case 'profile.enterEmail': return 'Por favor, insira seu endereço de e-mail';
			case 'profile.invalidEmail': return 'Por favor, insira um endereço de e-mail válido';
			case 'profile.logout': return 'Sair';
			case 'resources.availableResources': return 'Recursos disponíveis';
			case 'resources.name': return 'Nome';
			case 'resources.type': return 'Tipo';
			case 'messages.latestMessages': return 'Últimas mensagens';
			case 'messages.seeAllMessages': return 'Ver todas as mensagens';
			case 'messages.noMessages': return 'Nenhuma mensagem';
			case 'messages.writeMessageHint': return 'Escreva uma mensagem...';
			case 'messages.sendMessage': return 'Enviar';
			case 'common.sender': return 'Remetente';
			case 'common.message': return 'Mensagem';
			case 'settings.account': return 'Conta';
			case 'settings.settings': return 'Configurações';
			case 'settings.language': return 'Idioma';
			case 'settings.manageSubjects': return 'Gerenciar matérias';
			case 'settings.notifications': return 'Notificações';
			case 'settings.about': return 'Sobre';
			case 'settings.contact': return 'Contato';
			case 'settings.terms': return 'Termos de uso';
			case 'settings.privacy': return 'Política de privacidade';
			case 'page.home': return 'Início';
			case 'page.homePage': return 'Página inicial';
			case 'page.profile': return 'Perfil';
			case 'page.profilePage': return 'Página de perfil';
			case 'page.settings': return 'Configurações';
			case 'page.settingsPage': return 'Página de configurações';
			case 'page.search': return 'Pesquisa';
			case 'page.searchPage': return 'Página de pesquisa';
			case 'page.sheet': return 'Ficha';
			case 'page.sheetPage': return 'Página da ficha';
			case 'page.subject': return 'Matéria';
			case 'page.subjectPage': return 'Página da matéria';
			case 'page.topic': return 'Tema';
			case 'page.topicPage': return 'Página do tema';
			case 'page.event': return 'Evento';
			case 'page.eventPage': return 'Página do evento';
			case 'page.user': return 'Usuário';
			case 'page.userPage': return 'Página do usuário';
			case 'page.about': return 'Sobre';
			case 'page.aboutPage': return 'Página Sobre';
			case 'page.contact': return 'Contato';
			case 'page.contactPage': return 'Página de contato';
			case 'page.terms': return 'Termos de uso';
			case 'page.termsPage': return 'Página dos termos de uso';
			case 'page.privacy': return 'Política de privacidade';
			case 'page.privacyPage': return 'Página da política de privacidade';
			case 'page.notifications': return 'Notificações';
			case 'page.events': return 'Eventos';
			case 'page.sheets': return 'Fichas';
			case 'page.subjects': return 'Matérias';
			case 'page.topics': return 'Temas';
			case 'page.users': return 'Usuários';
			case 'page.help': return 'Ajuda';
			case 'page.helpPage': return 'Página de ajuda';
			default: return null;
		}
	}
}


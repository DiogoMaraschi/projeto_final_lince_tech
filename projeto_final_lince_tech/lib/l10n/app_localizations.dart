import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Gestão de Produtos'**
  String get appName;

  /// No description provided for @commonSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// No description provided for @commonBack.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get commonBack;

  /// No description provided for @productTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de Produto'**
  String get productTitle;

  /// No description provided for @productName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do Produto'**
  String get productName;

  /// No description provided for @productHintName.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Bola de Futebol'**
  String get productHintName;

  /// No description provided for @productBarcode.
  ///
  /// In pt, this message translates to:
  /// **'Código de Barras'**
  String get productBarcode;

  /// No description provided for @productHintBarcode.
  ///
  /// In pt, this message translates to:
  /// **'984651654892318974'**
  String get productHintBarcode;

  /// No description provided for @productDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get productDescription;

  /// No description provided for @productHintDescription.
  ///
  /// In pt, this message translates to:
  /// **'Descreva detalhes do produto'**
  String get productHintDescription;

  /// No description provided for @productBrand.
  ///
  /// In pt, this message translates to:
  /// **'Marca'**
  String get productBrand;

  /// No description provided for @productHintBrand.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Nike'**
  String get productHintBrand;

  /// No description provided for @productAddImage.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Imagem'**
  String get productAddImage;

  /// No description provided for @customerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de Cliente'**
  String get customerTitle;

  /// No description provided for @customerName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get customerName;

  /// No description provided for @customerCnpj.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ'**
  String get customerCnpj;

  /// No description provided for @customerPhone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get customerPhone;

  /// No description provided for @customerEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get customerEmail;

  /// No description provided for @orderTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pedido'**
  String get orderTitle;

  /// No description provided for @orderNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número do Pedido'**
  String get orderNumber;

  /// No description provided for @orderPaymentMethod.
  ///
  /// In pt, this message translates to:
  /// **'Forma de Pagamento'**
  String get orderPaymentMethod;

  /// No description provided for @orderInstallments.
  ///
  /// In pt, this message translates to:
  /// **'Parcelas'**
  String get orderInstallments;

  /// No description provided for @orderTotal.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get orderTotal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

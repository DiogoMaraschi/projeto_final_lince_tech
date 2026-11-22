import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
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
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Gestão Comercial'**
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

  /// No description provided for @commomPhone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get commomPhone;

  /// No description provided for @commomHintPhone.
  ///
  /// In pt, this message translates to:
  /// **'(47)99900-5060'**
  String get commomHintPhone;

  /// No description provided for @commomEmail.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get commomEmail;

  /// No description provided for @commomHintEmail.
  ///
  /// In pt, this message translates to:
  /// **'seuemail@dominio.com'**
  String get commomHintEmail;

  /// No description provided for @commomAddImage.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Imagem'**
  String get commomAddImage;

  /// No description provided for @commomCnpj.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ'**
  String get commomCnpj;

  /// No description provided for @commomHintCnpj.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 11.222.333/0001-81'**
  String get commomHintCnpj;

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
  /// **'7891234567895'**
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

  /// No description provided for @carrierTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de Transportadora'**
  String get carrierTitle;

  /// No description provided for @carrierName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da Transportadora'**
  String get carrierName;

  /// No description provided for @carrierHintName.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Transportadora Boa Vista'**
  String get carrierHintName;

  /// No description provided for @carrierLegalName.
  ///
  /// In pt, this message translates to:
  /// **'Razão Social'**
  String get carrierLegalName;

  /// No description provided for @carrierHintLegalName.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Transportadora Boa Vista LTDA'**
  String get carrierHintLegalName;

  /// No description provided for @carrierCostPerKm.
  ///
  /// In pt, this message translates to:
  /// **'Custo por km'**
  String get carrierCostPerKm;

  /// No description provided for @carrierHintCostPerKm.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 7,20'**
  String get carrierHintCostPerKm;

  /// No description provided for @carrierMinimumPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço mínimo'**
  String get carrierMinimumPrice;

  /// No description provided for @carrierHintMinimumPrice.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 2,30'**
  String get carrierHintMinimumPrice;

  /// No description provided for @addressTitle.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get addressTitle;

  /// No description provided for @addressCep.
  ///
  /// In pt, this message translates to:
  /// **'CEP'**
  String get addressCep;

  /// No description provided for @addressHintCep.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 89110-001'**
  String get addressHintCep;

  /// No description provided for @addressState.
  ///
  /// In pt, this message translates to:
  /// **'Estado'**
  String get addressState;

  /// No description provided for @addressHintState.
  ///
  /// In pt, this message translates to:
  /// **'Ex: SC'**
  String get addressHintState;

  /// No description provided for @addressCity.
  ///
  /// In pt, this message translates to:
  /// **'Cidade'**
  String get addressCity;

  /// No description provided for @addressHintCity.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Gaspar'**
  String get addressHintCity;

  /// No description provided for @addressStreet.
  ///
  /// In pt, this message translates to:
  /// **'Rua'**
  String get addressStreet;

  /// No description provided for @addressHintStreet.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Rua Gisele Brick Maraschi'**
  String get addressHintStreet;

  /// No description provided for @addressNumber.
  ///
  /// In pt, this message translates to:
  /// **'Número'**
  String get addressNumber;

  /// No description provided for @addressHintNumber.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 20'**
  String get addressHintNumber;

  /// No description provided for @addressNeighborhood.
  ///
  /// In pt, this message translates to:
  /// **'Bairro'**
  String get addressNeighborhood;

  /// No description provided for @addressHintNeighborhood.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Santa Terezinha'**
  String get addressHintNeighborhood;

  /// No description provided for @addressComplement.
  ///
  /// In pt, this message translates to:
  /// **'Complemento'**
  String get addressComplement;

  /// No description provided for @addressHintComplement.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Sala 01'**
  String get addressHintComplement;

  /// No description provided for @costumerCategoryGym.
  ///
  /// In pt, this message translates to:
  /// **'Academia'**
  String get costumerCategoryGym;

  /// No description provided for @costumerCategorySchool.
  ///
  /// In pt, this message translates to:
  /// **'Escola'**
  String get costumerCategorySchool;

  /// No description provided for @costumerCategoryOther.
  ///
  /// In pt, this message translates to:
  /// **'Outro'**
  String get costumerCategoryOther;

  /// No description provided for @paymentTypeCreditCard.
  ///
  /// In pt, this message translates to:
  /// **'Cartão de crédito'**
  String get paymentTypeCreditCard;

  /// No description provided for @paymentTypeCash.
  ///
  /// In pt, this message translates to:
  /// **'Em espécie'**
  String get paymentTypeCash;

  /// No description provided for @paymentTypeBankTransfer.
  ///
  /// In pt, this message translates to:
  /// **'Transferência bancária (TED/DOC)'**
  String get paymentTypeBankTransfer;

  /// No description provided for @paymentTypePix.
  ///
  /// In pt, this message translates to:
  /// **'Pix'**
  String get paymentTypePix;

  /// No description provided for @profileTitle.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @profilePreferences.
  ///
  /// In pt, this message translates to:
  /// **'Preferências'**
  String get profilePreferences;

  /// No description provided for @profileDarkMode.
  ///
  /// In pt, this message translates to:
  /// **'Modo Escuro'**
  String get profileDarkMode;

  /// No description provided for @profileStoreInformation.
  ///
  /// In pt, this message translates to:
  /// **'Informações da loja'**
  String get profileStoreInformation;

  /// No description provided for @profileLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get profileLanguage;

  /// No description provided for @storeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Informações da loja'**
  String get storeTitle;

  /// No description provided for @storeCompanyName.
  ///
  /// In pt, this message translates to:
  /// **'Nome da empresa'**
  String get storeCompanyName;

  /// No description provided for @storeHintCompanyName.
  ///
  /// In pt, this message translates to:
  /// **'Digite o nome da empresa'**
  String get storeHintCompanyName;

  /// No description provided for @customerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de Cliente'**
  String get customerTitle;

  /// No description provided for @customerListTitle.
  ///
  /// In pt, this message translates to:
  /// **'Clientes'**
  String get customerListTitle;

  /// No description provided for @customerChooseOption.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma opção'**
  String get customerChooseOption;

  /// No description provided for @productListTitle.
  ///
  /// In pt, this message translates to:
  /// **'Produtos'**
  String get productListTitle;

  /// No description provided for @carrierListTitle.
  ///
  /// In pt, this message translates to:
  /// **'Transportadoras'**
  String get carrierListTitle;

  /// No description provided for @productListEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum produto cadastrado'**
  String get productListEmpty;

  /// No description provided for @customerListEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum cliente cadastrado'**
  String get customerListEmpty;

  /// No description provided for @carrierListEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma transportadora cadastrada'**
  String get carrierListEmpty;

  /// No description provided for @productDeleteConfirmationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir produto?'**
  String get productDeleteConfirmationTitle;

  /// No description provided for @productDeleteConfirmationMessage.
  ///
  /// In pt, this message translates to:
  /// **'O produto não será exibido na lista, mas seus dados serão mantidos.'**
  String get productDeleteConfirmationMessage;

  /// No description provided for @carrierDeleteConfirmationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir transportadora?'**
  String get carrierDeleteConfirmationTitle;

  /// No description provided for @carrierDeleteConfirmationMessage.
  ///
  /// In pt, this message translates to:
  /// **'A transportadora não será exibida na lista, mas seus dados serão mantidos.'**
  String get carrierDeleteConfirmationMessage;

  /// No description provided for @customerDeleteConfirmationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir cliente?'**
  String get customerDeleteConfirmationTitle;

  /// No description provided for @customerDeleteConfirmationMessage.
  ///
  /// In pt, this message translates to:
  /// **'O cliente não será exibido na lista, mas seus dados serão mantidos.'**
  String get customerDeleteConfirmationMessage;

  /// No description provided for @navCustomers.
  ///
  /// In pt, this message translates to:
  /// **'Clientes'**
  String get navCustomers;

  /// No description provided for @navCarriers.
  ///
  /// In pt, this message translates to:
  /// **'Transportadoras'**
  String get navCarriers;

  /// No description provided for @navProducts.
  ///
  /// In pt, this message translates to:
  /// **'Produtos'**
  String get navProducts;

  /// No description provided for @navProfile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @customerName.
  ///
  /// In pt, this message translates to:
  /// **'Nome do cliente'**
  String get customerName;

  /// No description provided for @customerHintName.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Academia Central'**
  String get customerHintName;

  /// No description provided for @customerLegalName.
  ///
  /// In pt, this message translates to:
  /// **'Razão social'**
  String get customerLegalName;

  /// No description provided for @customerHintLegalName.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Academia Central Ltda.'**
  String get customerHintLegalName;

  /// No description provided for @establishmentType.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de estabelecimento'**
  String get establishmentType;

  /// No description provided for @productPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço'**
  String get productPrice;

  /// No description provided for @productHintPrice.
  ///
  /// In pt, this message translates to:
  /// **'Ex: 49,90'**
  String get productHintPrice;

  /// No description provided for @orderListTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pedidos'**
  String get orderListTitle;

  /// No description provided for @orderListEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum pedido foi encontrado'**
  String get orderListEmpty;

  /// No description provided for @orderSelectProducts.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar produtos'**
  String get orderSelectProducts;

  /// No description provided for @orderSearchProducts.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por nome ou EAN'**
  String get orderSearchProducts;

  /// No description provided for @orderProductsLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar produtos'**
  String get orderProductsLoadError;

  /// No description provided for @orderNoProducts.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum produto cadastrado'**
  String get orderNoProducts;

  /// No description provided for @orderPrice.
  ///
  /// In pt, this message translates to:
  /// **'Preço: {price}'**
  String orderPrice(String price);

  /// No description provided for @commonAdd.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get commonAdd;

  /// No description provided for @orderAddProducts.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar ao pedido - {count} produtos'**
  String orderAddProducts(String count);

  /// No description provided for @orderSelectCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar cliente'**
  String get orderSelectCustomer;

  /// No description provided for @orderSearchCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por nome ou CNPJ'**
  String get orderSearchCustomer;

  /// No description provided for @orderCustomersLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar clientes'**
  String get orderCustomersLoadError;

  /// No description provided for @orderNoCustomers.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum cliente cadastrado'**
  String get orderNoCustomers;

  /// No description provided for @orderSelectCarrier.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar transportadora'**
  String get orderSelectCarrier;

  /// No description provided for @orderSearchCarrier.
  ///
  /// In pt, this message translates to:
  /// **'Buscar por nome ou CNPJ'**
  String get orderSearchCarrier;

  /// No description provided for @orderCarriersLoadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar transportadoras'**
  String get orderCarriersLoadError;

  /// No description provided for @orderNoCarriers.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma transportadora cadastrada'**
  String get orderNoCarriers;

  /// No description provided for @orderSelectPayment.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar forma de pagamento'**
  String get orderSelectPayment;

  /// No description provided for @paymentInFull.
  ///
  /// In pt, this message translates to:
  /// **'À vista'**
  String get paymentInFull;

  /// No description provided for @paymentInstallments.
  ///
  /// In pt, this message translates to:
  /// **'Parcelado'**
  String get paymentInstallments;

  /// No description provided for @commonFinish.
  ///
  /// In pt, this message translates to:
  /// **'Concluir'**
  String get commonFinish;

  /// No description provided for @orderTitleNew.
  ///
  /// In pt, this message translates to:
  /// **'Novo pedido'**
  String get orderTitleNew;

  /// No description provided for @orderCustomer.
  ///
  /// In pt, this message translates to:
  /// **'Cliente'**
  String get orderCustomer;

  /// No description provided for @orderSelectCustomerUpper.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar cliente'**
  String get orderSelectCustomerUpper;

  /// No description provided for @orderProducts.
  ///
  /// In pt, this message translates to:
  /// **'Produtos'**
  String get orderProducts;

  /// No description provided for @orderAddProduct.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar produto'**
  String get orderAddProduct;

  /// No description provided for @orderAddProductUpper.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar produto'**
  String get orderAddProductUpper;

  /// No description provided for @orderNoProductsHint.
  ///
  /// In pt, this message translates to:
  /// **'Adicione os itens que o cliente solicitou'**
  String get orderNoProductsHint;

  /// No description provided for @orderCarrier.
  ///
  /// In pt, this message translates to:
  /// **'Transportadora'**
  String get orderCarrier;

  /// No description provided for @orderSelectCarrierUpper.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar transportadora'**
  String get orderSelectCarrierUpper;

  /// No description provided for @orderDeliveryAddress.
  ///
  /// In pt, this message translates to:
  /// **'Endereço de entrega'**
  String get orderDeliveryAddress;

  /// No description provided for @orderPaymentType.
  ///
  /// In pt, this message translates to:
  /// **'Forma de pagamento'**
  String get orderPaymentType;

  /// No description provided for @orderSelectPaymentUpper.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar forma de pagamento'**
  String get orderSelectPaymentUpper;

  /// No description provided for @orderInstallments.
  ///
  /// In pt, this message translates to:
  /// **'Parcelas'**
  String get orderInstallments;

  /// No description provided for @orderSummary.
  ///
  /// In pt, this message translates to:
  /// **'Resumo do pedido'**
  String get orderSummary;

  /// No description provided for @orderDistanceNotCalculated.
  ///
  /// In pt, this message translates to:
  /// **'Distância não calculada'**
  String get orderDistanceNotCalculated;

  /// No description provided for @orderSubtotalProducts.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal dos produtos'**
  String get orderSubtotalProducts;

  /// No description provided for @orderDiscounts.
  ///
  /// In pt, this message translates to:
  /// **'Descontos'**
  String get orderDiscounts;

  /// No description provided for @orderDelivery.
  ///
  /// In pt, this message translates to:
  /// **'Entrega'**
  String get orderDelivery;

  /// No description provided for @orderPaymentFee.
  ///
  /// In pt, this message translates to:
  /// **'Taxa do pagamento'**
  String get orderPaymentFee;

  /// No description provided for @orderTotal.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// No description provided for @orderPaymentNotesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Observações do pagamento'**
  String get orderPaymentNotesTitle;

  /// No description provided for @orderNotesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Observações'**
  String get orderNotesTitle;

  /// No description provided for @orderPaymentNotesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Observações do pagamento'**
  String get orderPaymentNotesLabel;

  /// No description provided for @orderNotesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Observações do pedido'**
  String get orderNotesLabel;

  /// No description provided for @orderNotesHint.
  ///
  /// In pt, this message translates to:
  /// **'Adicione uma observação'**
  String get orderNotesHint;

  /// No description provided for @commonWarning.
  ///
  /// In pt, this message translates to:
  /// **'Aviso'**
  String get commonWarning;

  /// No description provided for @commonFillRequired.
  ///
  /// In pt, this message translates to:
  /// **'Preencha todos os campos'**
  String get commonFillRequired;

  /// No description provided for @commonError.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get commonError;

  /// No description provided for @orderSaveError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível salvar o pedido.'**
  String get orderSaveError;

  /// No description provided for @orderEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar pedido'**
  String get orderEdit;

  /// No description provided for @orderSave.
  ///
  /// In pt, this message translates to:
  /// **'Salvar pedido'**
  String get orderSave;

  /// No description provided for @orderDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get orderDelete;

  /// No description provided for @profileStoreLocation.
  ///
  /// In pt, this message translates to:
  /// **'Localização da loja'**
  String get profileStoreLocation;

  /// No description provided for @profileSaveError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível salvar o perfil.'**
  String get profileSaveError;

  /// No description provided for @storeLocation.
  ///
  /// In pt, this message translates to:
  /// **'Localização da loja'**
  String get storeLocation;

  /// No description provided for @customerLocation.
  ///
  /// In pt, this message translates to:
  /// **'Localização do cliente'**
  String get customerLocation;

  /// No description provided for @deliveryDistance.
  ///
  /// In pt, this message translates to:
  /// **'Distância da entrega: {distance} km'**
  String deliveryDistance(String distance);

  /// No description provided for @commonContact.
  ///
  /// In pt, this message translates to:
  /// **'Contato: {value}'**
  String commonContact(String value);

  /// No description provided for @productDiscount.
  ///
  /// In pt, this message translates to:
  /// **'Desc.'**
  String get productDiscount;

  /// No description provided for @productSubtotal.
  ///
  /// In pt, this message translates to:
  /// **'Subtotal'**
  String get productSubtotal;

  /// No description provided for @paymentInstallmentUnit.
  ///
  /// In pt, this message translates to:
  /// **'{count}x de {value}'**
  String paymentInstallmentUnit(String count, String value);

  /// No description provided for @navHome.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get navHome;

  /// No description provided for @navOrders.
  ///
  /// In pt, this message translates to:
  /// **'Pedidos'**
  String get navOrders;

  /// No description provided for @navRecords.
  ///
  /// In pt, this message translates to:
  /// **'Cadastros'**
  String get navRecords;

  /// No description provided for @navStore.
  ///
  /// In pt, this message translates to:
  /// **'Minha loja'**
  String get navStore;

  /// No description provided for @orderNumber.
  ///
  /// In pt, this message translates to:
  /// **'Pedido #{id}'**
  String orderNumber(String id);

  /// No description provided for @orderProductsCountSingular.
  ///
  /// In pt, this message translates to:
  /// **'{count} produto'**
  String orderProductsCountSingular(String count);

  /// No description provided for @orderProductsCountPlural.
  ///
  /// In pt, this message translates to:
  /// **'{count} produtos'**
  String orderProductsCountPlural(String count);

  /// No description provided for @commonRequired.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório'**
  String get commonRequired;

  /// No description provided for @cnpjDigitsInvalid.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ deve possuir 14 dígitos'**
  String get cnpjDigitsInvalid;

  /// No description provided for @cnpjInvalid.
  ///
  /// In pt, this message translates to:
  /// **'CNPJ inválido'**
  String get cnpjInvalid;

  /// No description provided for @phoneRequired.
  ///
  /// In pt, this message translates to:
  /// **'Telefone é obrigatório'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In pt, this message translates to:
  /// **'Telefone inválido'**
  String get phoneInvalid;

  /// No description provided for @emailRequired.
  ///
  /// In pt, this message translates to:
  /// **'E-mail é obrigatório'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In pt, this message translates to:
  /// **'E-mail inválido'**
  String get emailInvalid;

  /// No description provided for @cepRequired.
  ///
  /// In pt, this message translates to:
  /// **'CEP é obrigatório'**
  String get cepRequired;

  /// No description provided for @cepInvalid.
  ///
  /// In pt, this message translates to:
  /// **'CEP inválido'**
  String get cepInvalid;

  /// No description provided for @moneyMustBePositive.
  ///
  /// In pt, this message translates to:
  /// **'Informe um valor maior que zero'**
  String get moneyMustBePositive;

  /// No description provided for @carrierMinimumShort.
  ///
  /// In pt, this message translates to:
  /// **'mín.'**
  String get carrierMinimumShort;

  /// No description provided for @orderDeliveryCalculation.
  ///
  /// In pt, this message translates to:
  /// **'{distance} km × {rate}/km · mínimo {minimum}'**
  String orderDeliveryCalculation(String distance, String rate, String minimum);

  /// No description provided for @productEAN.
  ///
  /// In pt, this message translates to:
  /// **'EAN: {value}'**
  String productEAN(String value);

  /// No description provided for @imageSourceTakePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Tirar foto'**
  String get imageSourceTakePhoto;

  /// No description provided for @imageSourceChooseGallery.
  ///
  /// In pt, this message translates to:
  /// **'Escolher da galeria'**
  String get imageSourceChooseGallery;
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
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
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

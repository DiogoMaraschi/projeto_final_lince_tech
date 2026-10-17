// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Gestión de Productos';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commomName => 'Nombre';

  @override
  String get commomPhone => 'Teléfono';

  @override
  String get commomHintPhone => '(47) 99900-5060';

  @override
  String get commomEmail => 'Correo electrónico';

  @override
  String get commomHintEmail => 'tucorreo@dominio.com';

  @override
  String get commomAdress => 'Dirección';

  @override
  String get commomAddImage => 'Agregar imagen';

  @override
  String get commomCnpj => 'CNPJ';

  @override
  String get commomHintCnpj => 'Ej.: 34.562.785/0001-40';

  @override
  String get productTitle => 'Registro de producto';

  @override
  String get productName => 'Nombre del producto';

  @override
  String get productHintName => 'Ej.: Balón de fútbol';

  @override
  String get productBarcode => 'Código de barras';

  @override
  String get productHintBarcode => '984651654892318974';

  @override
  String get productDescription => 'Descripción';

  @override
  String get productHintDescription => 'Describe los detalles del producto';

  @override
  String get productBrand => 'Marca';

  @override
  String get productHintBrand => 'Ej.: Nike';

  @override
  String get carrierTitle => 'Registro de transportista';

  @override
  String get carrierName => 'Nombre del transportista';

  @override
  String get carrierHintName => 'Ej.: Transportes Boa Vista';

  @override
  String get carrierLegalName => 'Razón social';

  @override
  String get carrierHintLegalName => 'Ej.: Transportes Boa Vista S. A.';

  @override
  String get carrierCostPerKm => 'Costo por km';

  @override
  String get carrierHintCostPerKm => 'Ej.: 7.20';

  @override
  String get carrierMinimumPrice => 'Precio mínimo';

  @override
  String get carrierHintMinimumPrice => 'Ej.: 2.30';

  @override
  String get addressTitle => 'Dirección';

  @override
  String get addressCep => 'Código postal';

  @override
  String get addressHintCep => 'Ej.: 89110-001';

  @override
  String get addressState => 'Estado';

  @override
  String get addressHintState => 'Ej.: SC';

  @override
  String get addressCity => 'Ciudad';

  @override
  String get addressHintCity => 'Ej.: Gaspar';

  @override
  String get addressStreet => 'Calle';

  @override
  String get addressHintStreet => 'Ej.: Calle Gisele Brick Maraschi';

  @override
  String get addressNumber => 'Número';

  @override
  String get addressHintNumber => 'Ej.: 20';

  @override
  String get addressNeighborhood => 'Barrio';

  @override
  String get addressHintNeighborhood => 'Ej.: Santa Terezinha';

  @override
  String get addressComplement => 'Complemento';

  @override
  String get addressHintComplement => 'Ej.: Oficina 01';

  @override
  String get costumerCategoryGym => 'Gimnasio';

  @override
  String get costumerCategorySchool => 'Escuela';

  @override
  String get costumerCategoryOther => 'Otro';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profilePreferences => 'Preferencias';

  @override
  String get profileDarkMode => 'Modo oscuro';

  @override
  String get profileStoreInformation => 'Información de la tienda';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get storeTitle => 'Información de la tienda';

  @override
  String get storeCompanyName => 'Nombre de la empresa';

  @override
  String get storeHintCompanyName => 'Ingresa el nombre de la empresa';

  @override
  String get customerTitle => 'Registro de cliente';

  @override
  String get customerListTitle => 'Clientes';

  @override
  String get customerChooseOption => 'Elige una opción';

  @override
  String get productListTitle => 'Productos';

  @override
  String get carrierListTitle => 'Transportistas';

  @override
  String get productListEmpty => 'No hay productos registrados';

  @override
  String get customerListEmpty => 'No hay clientes registrados';

  @override
  String get carrierListEmpty => 'No hay transportistas registrados';

  @override
  String get productDeleteConfirmationTitle => '¿Eliminar producto?';

  @override
  String get productDeleteConfirmationMessage =>
      'El producto se ocultará de la lista, pero sus datos se conservarán.';

  @override
  String get carrierDeleteConfirmationTitle => '¿Eliminar transportista?';

  @override
  String get carrierDeleteConfirmationMessage =>
      'El transportista se ocultará de la lista, pero sus datos se conservarán.';

  @override
  String get customerDeleteConfirmationTitle => '¿Eliminar cliente?';

  @override
  String get customerDeleteConfirmationMessage =>
      'El cliente se ocultará de la lista, pero sus datos se conservarán.';
}

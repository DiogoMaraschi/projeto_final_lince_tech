// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Product Management';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonBack => 'Back';

  @override
  String get productTitle => 'Product Registration';

  @override
  String get productName => 'Product Name';

  @override
  String get productHintName => 'Ex: Soccer Ball';

  @override
  String get productBarcode => 'Barcode';

  @override
  String get productHintBarcode => '984651654892318974';

  @override
  String get productDescription => 'Description';

  @override
  String get productHintDescription => 'Describe about product details';

  @override
  String get productBrand => 'Brand';

  @override
  String get productHintBrand => 'Ex: Nike';

  @override
  String get productAddImage => 'Add Image';

  @override
  String get customerTitle => 'Customer Registration';

  @override
  String get customerName => 'Name';

  @override
  String get customerCnpj => 'CNPJ';

  @override
  String get customerPhone => 'Phone';

  @override
  String get customerEmail => 'Email';

  @override
  String get orderTitle => 'Order';

  @override
  String get orderNumber => 'Order Number';

  @override
  String get orderPaymentMethod => 'Payment Method';

  @override
  String get orderInstallments => 'Installments';

  @override
  String get orderTotal => 'Total';
}

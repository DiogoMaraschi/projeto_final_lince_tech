// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Business Management';

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
  String get commomName => 'Name';

  @override
  String get commomPhone => 'Phone';

  @override
  String get commomHintPhone => '(47) 99900-5060';

  @override
  String get commomEmail => 'Email';

  @override
  String get commomHintEmail => 'youremail@domain.com';

  @override
  String get commomAdress => 'Address';

  @override
  String get commomAddImage => 'Add Image';

  @override
  String get commomCnpj => 'CNPJ';

  @override
  String get commomHintCnpj => 'E.g.: 11.222.333/0001-81';

  @override
  String get productTitle => 'Product Registration';

  @override
  String get productName => 'Product Name';

  @override
  String get productHintName => 'E.g.: Soccer Ball';

  @override
  String get productBarcode => 'Barcode';

  @override
  String get productHintBarcode => '7891234567895';

  @override
  String get productDescription => 'Description';

  @override
  String get productHintDescription => 'Describe product details';

  @override
  String get productBrand => 'Brand';

  @override
  String get productHintBrand => 'E.g.: Nike';

  @override
  String get carrierTitle => 'Carrier Registration';

  @override
  String get carrierName => 'Carrier Name';

  @override
  String get carrierHintName => 'E.g.: Boa Vista Transport';

  @override
  String get carrierLegalName => 'Legal Name';

  @override
  String get carrierHintLegalName => 'E.g.: Boa Vista Transport Ltd.';

  @override
  String get carrierCostPerKm => 'Cost per km';

  @override
  String get carrierHintCostPerKm => 'E.g.: 7,20';

  @override
  String get carrierMinimumPrice => 'Minimum price';

  @override
  String get carrierHintMinimumPrice => 'E.g.: 2,30';

  @override
  String get addressTitle => 'Address';

  @override
  String get addressCep => 'Postal Code';

  @override
  String get addressHintCep => 'E.g.: 89110-001';

  @override
  String get addressState => 'State';

  @override
  String get addressHintState => 'E.g.: SC';

  @override
  String get addressCity => 'City';

  @override
  String get addressHintCity => 'E.g.: Gaspar';

  @override
  String get addressStreet => 'Street';

  @override
  String get addressHintStreet => 'E.g.: Gisele Brick Maraschi Street';

  @override
  String get addressNumber => 'Number';

  @override
  String get addressHintNumber => 'E.g.: 20';

  @override
  String get addressNeighborhood => 'Neighborhood';

  @override
  String get addressHintNeighborhood => 'E.g.: Santa Terezinha';

  @override
  String get addressComplement => 'Complement';

  @override
  String get addressHintComplement => 'E.g.: Suite 01';

  @override
  String get costumerCategoryGym => 'Gym';

  @override
  String get costumerCategorySchool => 'School';

  @override
  String get costumerCategoryOther => 'Other';

  @override
  String get paymentTypeCreditCard => 'Credit card';

  @override
  String get paymentTypeCash => 'Cash';

  @override
  String get paymentTypeBankTransfer => 'Bank transfer (TED/DOC)';

  @override
  String get paymentTypePix => 'Pix';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profilePreferences => 'Preferences';

  @override
  String get profileDarkMode => 'Dark Mode';

  @override
  String get profileStoreInformation => 'Store Information';

  @override
  String get profileLanguage => 'Language';

  @override
  String get storeTitle => 'Store Information';

  @override
  String get storeCompanyName => 'Company Name';

  @override
  String get storeHintCompanyName => 'Enter the company name';

  @override
  String get customerTitle => 'Customer Registration';

  @override
  String get customerListTitle => 'Customers';

  @override
  String get customerChooseOption => 'Choose an option';

  @override
  String get productListTitle => 'Products';

  @override
  String get carrierListTitle => 'Carriers';

  @override
  String get productListEmpty => 'No products registered';

  @override
  String get customerListEmpty => 'No customers registered';

  @override
  String get carrierListEmpty => 'No carriers registered';

  @override
  String get productDeleteConfirmationTitle => 'Delete product?';

  @override
  String get productDeleteConfirmationMessage =>
      'The product will be hidden from the list, but its data will be kept.';

  @override
  String get carrierDeleteConfirmationTitle => 'Delete carrier?';

  @override
  String get carrierDeleteConfirmationMessage =>
      'The carrier will be hidden from the list, but its data will be kept.';

  @override
  String get customerDeleteConfirmationTitle => 'Delete customer?';

  @override
  String get customerDeleteConfirmationMessage =>
      'The customer will be hidden from the list, but their data will be kept.';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navCarriers => 'Carriers';

  @override
  String get navProducts => 'Products';

  @override
  String get navProfile => 'Profile';

  @override
  String get customerName => 'Customer name';

  @override
  String get customerHintName => 'E.g.: Central Gym';

  @override
  String get customerLegalName => 'Legal name';

  @override
  String get customerHintLegalName => 'E.g.: Central Gym Ltd.';

  @override
  String get establishmentType => 'Type of establishment';

  @override
  String get productPrice => 'Price';

  @override
  String get productHintPrice => 'E.g.: 49,90';

  @override
  String get orderListTitle => 'Orders';

  @override
  String get orderListEmpty => 'No orders were found';

  @override
  String get orderSelectProducts => 'Select products';

  @override
  String get orderSearchProducts => 'Search by name or EAN';

  @override
  String get orderProductsLoadError => 'Could not load products';

  @override
  String get orderNoProducts => 'No products registered';

  @override
  String orderPrice(String price) {
    return 'Price: $price';
  }

  @override
  String get commonAdd => 'Add';

  @override
  String orderAddProducts(String count) {
    return 'Add to order - $count products';
  }

  @override
  String get orderSelectCustomer => 'Select customer';

  @override
  String get orderSearchCustomer => 'Search by name or CNPJ';

  @override
  String get orderCustomersLoadError => 'Could not load customers';

  @override
  String get orderNoCustomers => 'No customers registered';

  @override
  String get orderSelectCarrier => 'Select carrier';

  @override
  String get orderSearchCarrier => 'Search by name or CNPJ';

  @override
  String get orderCarriersLoadError => 'Could not load carriers';

  @override
  String get orderNoCarriers => 'No carriers registered';

  @override
  String get orderSelectPayment => 'Select payment method';

  @override
  String get paymentInFull => 'Paid in full';

  @override
  String get paymentInstallments => 'Installments';

  @override
  String get commonFinish => 'Done';

  @override
  String get orderTitleNew => 'New order';

  @override
  String get orderCustomer => 'Customer';

  @override
  String get orderSelectCustomerUpper => 'Select customer';

  @override
  String get orderProducts => 'Products';

  @override
  String get orderAddProduct => 'Add product';

  @override
  String get orderAddProductUpper => 'Add product';

  @override
  String get orderNoProductsHint => 'Add the items requested by the customer';

  @override
  String get orderCarrier => 'Carrier';

  @override
  String get orderSelectCarrierUpper => 'Select carrier';

  @override
  String get orderDeliveryAddress => 'Delivery address';

  @override
  String get orderPaymentType => 'Payment method';

  @override
  String get orderSelectPaymentUpper => 'Select payment method';

  @override
  String get orderInstallments => 'Installments';

  @override
  String get orderSummary => 'Order summary';

  @override
  String get orderDistanceNotCalculated => 'Distance not calculated';

  @override
  String get orderSubtotalProducts => 'Products subtotal';

  @override
  String get orderDiscounts => 'Discounts';

  @override
  String get orderDelivery => 'Delivery';

  @override
  String get orderTotal => 'Total';

  @override
  String get orderPaymentNotesTitle => 'Payment notes';

  @override
  String get orderNotesTitle => 'Notes';

  @override
  String get orderPaymentNotesLabel => 'Payment notes';

  @override
  String get orderNotesLabel => 'Order notes';

  @override
  String get orderNotesHint => 'Add a note';

  @override
  String get commonWarning => 'Warning';

  @override
  String get commonFillRequired => 'Please fill in all required fields';

  @override
  String get commonError => 'Error';

  @override
  String get orderSaveError => 'Could not save the order.';

  @override
  String get orderEdit => 'Edit order';

  @override
  String get orderSave => 'Save order';

  @override
  String get orderDelete => 'Delete';

  @override
  String get profileStoreLocation => 'Store location';

  @override
  String get profileSaveError => 'Could not save the profile.';

  @override
  String get storeLocation => 'Store location';

  @override
  String get customerLocation => 'Customer location';

  @override
  String deliveryDistance(String distance) {
    return 'Delivery distance: $distance km';
  }

  @override
  String productCountSingular(String count) {
    return '$count product';
  }

  @override
  String productCountPlural(String count) {
    return '$count products';
  }

  @override
  String get customerTypeGym => 'Gym';

  @override
  String get customerTypeSchool => 'School';

  @override
  String get customerTypeOther => 'Other';

  @override
  String commonContact(String value) {
    return 'Contact: $value';
  }

  @override
  String get productDiscount => 'Discount';

  @override
  String get productSubtotal => 'Subtotal';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonCnpj => 'CNPJ';

  @override
  String get commonStore => 'Store location';

  @override
  String paymentInstallmentUnit(String count, String value) {
    return '${count}x of $value';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navOrders => 'Orders';

  @override
  String get navRecords => 'Records';

  @override
  String get navStore => 'My store';

  @override
  String get orderSingleTitle => 'Order';

  @override
  String orderNumber(String id) {
    return 'Order #$id';
  }

  @override
  String orderProductsCountSingular(String count) {
    return '$count product';
  }

  @override
  String orderProductsCountPlural(String count) {
    return '$count products';
  }

  @override
  String get commonRequired => 'This field is required';

  @override
  String get cnpjDigitsInvalid => 'CNPJ must contain 14 digits';

  @override
  String get cnpjInvalid => 'Invalid CNPJ';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalid => 'Invalid phone number';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email address';

  @override
  String get cepRequired => 'ZIP code is required';

  @override
  String get cepInvalid => 'Invalid ZIP code';

  @override
  String get moneyMustBePositive => 'Enter an amount greater than zero';

  @override
  String get carrierMinimumShort => 'min.';

  @override
  String orderDeliveryCalculation(
    String distance,
    String rate,
    String minimum,
  ) {
    return '$distance km × $rate/km · minimum $minimum';
  }

  @override
  String productEAN(String value) {
    return 'EAN: $value';
  }

  @override
  String get imageSourceTakePhoto => 'Take a photo';

  @override
  String get imageSourceChooseGallery => 'Choose from the gallery';
}

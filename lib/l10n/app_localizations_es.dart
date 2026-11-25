// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Gestión Comercial';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commomPhone => 'Teléfono';

  @override
  String get commomHintPhone => '(47) 99900-5060';

  @override
  String get commomEmail => 'Correo electrónico';

  @override
  String get commomHintEmail => 'tucorreo@dominio.com';

  @override
  String get commomAddImage => 'Agregar imagen';

  @override
  String get commomCnpj => 'CNPJ';

  @override
  String get commomHintCnpj => 'Ej.: 11.222.333/0001-81';

  @override
  String get productTitle => 'Registro de producto';

  @override
  String get productName => 'Nombre del producto';

  @override
  String get productHintName => 'Ej.: Balón de fútbol';

  @override
  String get productBarcode => 'Código de barras';

  @override
  String get productHintBarcode => '7891234567895';

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
  String get carrierHintCostPerKm => 'Ej.: 7,20';

  @override
  String get carrierMinimumPrice => 'Precio mínimo';

  @override
  String get carrierHintMinimumPrice => 'Ej.: 2,30';

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
  String get paymentTypeCreditCard => 'Tarjeta de crédito';

  @override
  String get paymentTypeCash => 'En efectivo';

  @override
  String get paymentTypeBankTransfer => 'Transferencia bancaria (TED/DOC)';

  @override
  String get paymentTypePix => 'Pix';

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

  @override
  String get navCustomers => 'Clientes';

  @override
  String get navCarriers => 'Transportistas';

  @override
  String get navProducts => 'Productos';

  @override
  String get navProfile => 'Perfil';

  @override
  String get customerName => 'Nombre del cliente';

  @override
  String get customerHintName => 'Ej.: Gimnasio Central';

  @override
  String get customerLegalName => 'Razón social';

  @override
  String get customerHintLegalName => 'Ej.: Gimnasio Central S. A.';

  @override
  String get establishmentType => 'Tipo de establecimiento';

  @override
  String get productPrice => 'Precio';

  @override
  String get productHintPrice => 'Ej.: 49,90';

  @override
  String get orderListTitle => 'Pedidos';

  @override
  String get orderListEmpty => 'No se encontraron pedidos';

  @override
  String get orderSummaryLoadError => 'No se pudieron cargar los pedidos.';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String get orderSelectProducts => 'Seleccionar productos';

  @override
  String get orderSearchProducts => 'Buscar por nombre o EAN';

  @override
  String get orderProductsLoadError => 'No se pudieron cargar los productos';

  @override
  String get orderNoProducts => 'No hay productos registrados';

  @override
  String orderPrice(String price) {
    return 'Precio: $price';
  }

  @override
  String get commonAdd => 'Agregar';

  @override
  String orderAddProducts(String count) {
    return 'Agregar al pedido - $count productos';
  }

  @override
  String get orderSelectCustomer => 'Seleccionar cliente';

  @override
  String get orderSearchCustomer => 'Buscar por nombre o CNPJ';

  @override
  String get orderCustomersLoadError => 'No se pudieron cargar los clientes';

  @override
  String get customerSaveFailed => 'No se pudo guardar el cliente.';

  @override
  String get customerNotFound => 'Cliente no encontrado.';

  @override
  String get cnpjAlreadyRegistered => 'Este CNPJ ya está registrado.';

  @override
  String get customersLoadFailed => 'No se pudieron cargar los clientes.';

  @override
  String get locationNotObtained =>
      'No se pudo obtener la ubicación de la dirección.';

  @override
  String get orderNoCustomers => 'No hay clientes registrados';

  @override
  String get orderSelectCarrier => 'Seleccionar transportista';

  @override
  String get orderSearchCarrier => 'Buscar por nombre o CNPJ';

  @override
  String get orderCarriersLoadError =>
      'No se pudieron cargar los transportistas';

  @override
  String get orderNoCarriers => 'No hay transportistas registrados';

  @override
  String get orderSelectPayment => 'Seleccionar forma de pago';

  @override
  String get paymentInFull => 'Pago único';

  @override
  String get paymentInstallments => 'A plazos';

  @override
  String get commonFinish => 'Finalizar';

  @override
  String get orderTitleNew => 'Nuevo pedido';

  @override
  String get orderCustomer => 'Cliente';

  @override
  String get orderSelectCustomerUpper => 'Seleccionar cliente';

  @override
  String get orderProducts => 'Productos';

  @override
  String get orderAddProduct => 'Agregar producto';

  @override
  String get orderAddProductUpper => 'Agregar producto';

  @override
  String get orderNoProductsHint =>
      'Agrega los artículos solicitados por el cliente';

  @override
  String get orderCarrier => 'Transportista';

  @override
  String get orderSelectCarrierUpper => 'Seleccionar transportista';

  @override
  String get orderDeliveryAddress => 'Dirección de entrega';

  @override
  String get orderPaymentType => 'Forma de pago';

  @override
  String get orderSelectPaymentUpper => 'Seleccionar forma de pago';

  @override
  String get orderInstallments => 'Cuotas';

  @override
  String get orderSummary => 'Resumen del pedido';

  @override
  String get orderDistanceNotCalculated => 'Distancia no calculada';

  @override
  String get orderSubtotalProducts => 'Subtotal de productos';

  @override
  String get orderDiscounts => 'Descuentos';

  @override
  String get orderDelivery => 'Entrega';

  @override
  String get orderPaymentFee => 'Recargo por pago';

  @override
  String get orderTotal => 'Total';

  @override
  String get orderPaymentNotesTitle => 'Observaciones del pago';

  @override
  String get orderNotesTitle => 'Observaciones';

  @override
  String get orderPaymentNotesLabel => 'Observaciones del pago';

  @override
  String get orderNotesLabel => 'Observaciones del pedido';

  @override
  String get orderNotesHint => 'Agrega una observación';

  @override
  String get commonWarning => 'Aviso';

  @override
  String get commonFillRequired => 'Completa todos los campos obligatorios';

  @override
  String get commonError => 'Error';

  @override
  String get orderSaveError => 'No se pudo guardar el pedido.';

  @override
  String get invalidOrder =>
      'Revisa los datos del pedido e inténtalo de nuevo.';

  @override
  String get deliveryNotCalculated =>
      'Calcula el costo de envío antes de guardar el pedido.';

  @override
  String get profileCoordinatesMissing =>
      'Configura la ubicación de la tienda en el perfil antes de calcular el envío.';

  @override
  String get orderSaveFailed => 'No se pudo guardar el pedido.';

  @override
  String get orderNotFound =>
      'No se encontró el pedido. Actualiza la lista e inténtalo de nuevo.';

  @override
  String get orderEdit => 'Editar pedido';

  @override
  String get orderSave => 'Guardar pedido';

  @override
  String get orderDelete => 'Eliminar';

  @override
  String get profileStoreLocation => 'Ubicación de la tienda';

  @override
  String get profileSaveError => 'No se pudo guardar el perfil.';

  @override
  String get storeLocation => 'Ubicación de la tienda';

  @override
  String get customerLocation => 'Ubicación del cliente';

  @override
  String deliveryDistance(String distance) {
    return 'Distancia de entrega: $distance km';
  }

  @override
  String commonContact(String value) {
    return 'Contacto: $value';
  }

  @override
  String get productDiscount => 'Desc.';

  @override
  String get productSubtotal => 'Subtotal';

  @override
  String paymentInstallmentUnit(String count, String value) {
    return '${count}x de $value';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navOrders => 'Pedidos';

  @override
  String get navRecords => 'Registros';

  @override
  String get navStore => 'Mi tienda';

  @override
  String orderNumber(String id) {
    return 'Pedido n.º $id';
  }

  @override
  String orderProductsCountSingular(String count) {
    return '$count producto';
  }

  @override
  String orderProductsCountPlural(String count) {
    return '$count productos';
  }

  @override
  String get commonRequired => 'Este campo es obligatorio';

  @override
  String get cnpjDigitsInvalid => 'El CNPJ debe tener 14 dígitos';

  @override
  String get cnpjInvalid => 'CNPJ no válido';

  @override
  String get phoneRequired => 'El teléfono es obligatorio';

  @override
  String get phoneInvalid => 'Teléfono no válido';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get emailInvalid => 'Correo electrónico no válido';

  @override
  String get cepRequired => 'El código postal es obligatorio';

  @override
  String get cepInvalid => 'Código postal no válido';

  @override
  String get moneyMustBePositive => 'Ingresa un valor mayor que cero';

  @override
  String get carrierMinimumShort => 'mín.';

  @override
  String orderDeliveryCalculation(
    String distance,
    String rate,
    String minimum,
  ) {
    return '$distance km × $rate/km · mínimo $minimum';
  }

  @override
  String productEAN(String value) {
    return 'EAN: $value';
  }

  @override
  String get imageSourceTakePhoto => 'Tomar una foto';

  @override
  String get imageSourceChooseGallery => 'Elegir una imagen de la galería';

  @override
  String get removeImage => 'Eliminar imagen';
}

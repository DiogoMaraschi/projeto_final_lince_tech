import 'package:flutter/cupertino.dart';

import '../../core/dependencies/injection.dart';
import '../../entities/customer.dart';
import '../../modules/address/usecases/get_address_by_zipcode_usecase.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/customer/usecases/create_customer_usecase.dart';
import '../../modules/customer/usecases/get_all_customers_usecase.dart';
import '../../l10n/app_localizations.dart';

class CustomerController with ChangeNotifier {
  final GetAddressByZipcodeUsecase _getAddressByZipcodeUsecase;
  final GetCnpjUsecase _getCnpjUsecase;
  final CreateCustomerUsecase _createCustomerUsecase;
  final GetAllCustomersUsecase _getAllCustomersUsecase;

  CustomerController({
    required this._getAddressByZipcodeUsecase,
    required this._getCnpjUsecase,
    required this._createCustomerUsecase,
    required this._getAllCustomersUsecase,
  });

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final zipcodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final complementController = TextEditingController();

  bool _isLoading = false;
  EstablishmentType? _establishmentType;

  EstablishmentType? get establishmentType => _establishmentType;

  void setEstablishmentType(EstablishmentType? value) {
    _establishmentType = value;
  }

  bool get isLoading => _isLoading;

  @override
  void dispose() {
    cnpjController.dispose();
    nameController.dispose();
    legalNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> searchZipcode() async {
    try {
      final result = await _getAddressByZipcodeUsecase(zipcodeController.text);

      stateController.text = result.state;
      cityController.text = result.city;
      streetController.text = result.street;
      neighborhoodController.text = result.neighborhood ?? '';

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchCnpj() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _getCnpjUsecase(cnpjController.text);

      nameController.text = result.nomeFantasia;
      legalNameController.text = result.razaoSocial;
      emailController.text = result.email ?? '';
      phoneController.text = result.telefone ?? '';

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveCostumer() async {
    final customerEdited = convertTextToCustomer();

    try {
      print('entrou try');
      await _createCustomerUsecase(customerEdited);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Customer convertTextToCustomer() {
    return Customer(
      name: nameController.text,
      cnpj: cnpjController.text,
      legalName: legalNameController.text,
      establishmentType: _establishmentType!,
      state: stateController.text,
      city: cityController.text,
      zipCode: zipcodeController.text,
      street: streetController.text,
      number: numberController.text,
      latitude: 0,
      longitude: 0,
    );
  }
}

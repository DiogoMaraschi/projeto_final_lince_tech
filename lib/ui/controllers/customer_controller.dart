import 'package:flutter/cupertino.dart';

import '../../core/dependencies/injection.dart';
import '../../entities/costumer.dart';
import '../../modules/address/usecases/get_address_by_zipcode.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/customer/usecases/create_customer_usecase.dart';
import '../../modules/customer/usecases/delete_customer_usecase.dart';
import '../../modules/customer/usecases/get_all_customers_usecase.dart';
import '../../l10n/app_localizations.dart';
import '../../modules/customer/usecases/update_customer_usecase.dart';
import '../formatters/app_formatters.dart';

class CustomerController with ChangeNotifier {
  final Customer? _customerReceived;
  final GetAddressByZipcodeUsecase _getAddressByZipcodeUsecase;
  final GetCnpjUsecase _getCnpjUsecase;
  final CreateCustomerUsecase _createCustomerUsecase;
  final UpdateCustomerUsecase _updateCustomerUsecase;
  final DeleteCustomerUsecase _deleteCustomerUsecase;

  CustomerController({
    required this._getAddressByZipcodeUsecase,
    required this._getCnpjUsecase,
    required this._createCustomerUsecase,
    required this._updateCustomerUsecase,
    required this._deleteCustomerUsecase,
    Customer? customer,
  }) : _customerReceived = customer {
    if (customer != null) {
      _fillFields(customer);
    }
  }

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

  bool get isEditing => _customerReceived != null;

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
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _getAddressByZipcodeUsecase(zipcodeController.text);

      stateController.text = result.state;
      cityController.text = result.city;
      streetController.text = result.street;
      neighborhoodController.text = result.neighborhood ?? '';

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
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
      if (isEditing) {
        await _updateCustomerUsecase(customerEdited);
      } else {
        await _createCustomerUsecase(customerEdited);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Customer convertTextToCustomer() {
    return Customer(
      id: _customerReceived?.id,
      name: nameController.text,
      cnpj: AppFormatters.onlyNumber(cnpjController.text),
      legalName: legalNameController.text,
      establishmentType: _establishmentType!,
      state: stateController.text,
      city: cityController.text,
      zipCode: AppFormatters.onlyNumber(zipcodeController.text),
      street: streetController.text,
      number: numberController.text,
      phoneNumber: AppFormatters.onlyNumber(phoneController.text),
      email: emailController.text,
      latitude: 0,
      longitude: 0,
    );
  }

  void _fillFields(Customer customer) {
    nameController.text = customer.name;
    cnpjController.text = customer.cnpj;
    legalNameController.text = customer.legalName;
    emailController.text = customer.email ?? '';
    phoneController.text = customer.phoneNumber ?? '';

    stateController.text = customer.state;
    cityController.text = customer.city;
    zipcodeController.text = customer.zipCode;
    streetController.text = customer.street;
    numberController.text = customer.number;

    setEstablishmentType(customer.establishmentType);
  }


  Future<bool> delete() async {
    final id = _customerReceived?.id;
    if (id == null) return false;

    try {
      await _deleteCustomerUsecase(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}

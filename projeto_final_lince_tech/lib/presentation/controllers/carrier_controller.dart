import 'package:flutter/material.dart';

import '../../domain/entities/address.dart';
import '../../domain/entities/carrier.dart';
import '../../domain/usecases/carriers/create_carrier_usecase.dart';
import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';

class CarrierController with ChangeNotifier {
  final GetCnpjUsecase _getCnpjUsecase;
  final CreateCarrierUsecase _createCarrierUsecase;

  CarrierController({
    required this._getCnpjUsecase,
    required this._createCarrierUsecase,
  });

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final costPerKmController = TextEditingController();
  final minimumPriceController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    cnpjController.dispose();
    nameController.dispose();
    legalNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    costPerKmController.dispose();
    minimumPriceController.dispose();

    super.dispose();
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

  // Future<void> searchZipcode() async {
  //   try {
  //     final result = await _getAddressByZipcodeUsecase(zipcodeController.text);

  //     stateController.text = result.state;
  //     cityController.text = result.city;
  //     streetController.text = result.street;
  //     neighborhoodController.text = result.neighborhood ?? '';

  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<bool> saveCarrier() async {
    final carrier = convertTextToCarrier();

    try {
      final carrierId = await _createCarrierUsecase(carrier);

      print('Carrier salvo com ID: $carrierId');
      return true;
    } catch (e) {
      print('Erro ao salvar carrier: $e');
      return false;
    }
  }

  Carrier convertTextToCarrier() {
    return Carrier(
      name: nameController.text,
      costPerKm: double.parse(costPerKmController.text),
      minimumPrice: double.parse(minimumPriceController.text),
      legalName: legalNameController.text,
      email: emailController.text,
      cnpj: cnpjController.text,
      phoneNumber: phoneController.text,
    );
  }
}

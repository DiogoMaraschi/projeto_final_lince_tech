import 'package:flutter/material.dart';

import '../../domain/usecases/adress/get_adress_usecase.dart';
import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';

class CarrierController with ChangeNotifier {
  final GetCnpjUsecase getCnpjUsecase;
  final GetAdressUsecase getAdressUsecase;

  CarrierController({
    required this.getCnpjUsecase,
    required this.getAdressUsecase,
  });

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final costPerKmController = TextEditingController();
  final minimumPriceController = TextEditingController();

  final zipcodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final complementController = TextEditingController();

  @override
  void dispose() {
    cnpjController.dispose();
    nameController.dispose();
    legalNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    costPerKmController.dispose();
    minimumPriceController.dispose();

    zipcodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    complementController.dispose();

    super.dispose();
  }

  Future<void> searchCnpj() async {
    try {
      final result = await getCnpjUsecase(cnpjController.text);

      nameController.text = result.nomeFantasia;
      legalNameController.text = result.razaoSocial;
      emailController.text = result.email ?? '';
      phoneController.text = result.telefone ?? '';

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchZipcode() async {
    try {
      final result = await getAdressUsecase(zipcodeController.text);

      stateController.text = result.state;
      cityController.text = result.city;
      streetController.text = result.street;
      neighborhoodController.text = result.neighborhood ?? '';

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

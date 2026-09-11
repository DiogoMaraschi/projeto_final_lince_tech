import 'package:flutter/material.dart';

import '../../domain/usecases/cnpj/get_cnpj_usecase.dart';

class CarrierController with ChangeNotifier {
  final GetCnpjUsecase getCnpjUsecase;

  CarrierController({required this.getCnpjUsecase});

  final nameController = TextEditingController();
  final legalNameController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final costPerKmController = TextEditingController();
  final minimumPriceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    legalNameController.dispose();
    cnpjController.dispose();
    emailController.dispose();
    phoneController.dispose();
    costPerKmController.dispose();
    minimumPriceController.dispose();
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
}

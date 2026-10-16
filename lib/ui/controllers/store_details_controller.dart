import 'package:flutter/material.dart';

import '../../modules/address/usecases/get_address_by_zipcode.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/imagePicker/usecases/pick_image_from_galery_usecase.dart';

class StoreDetailsController with ChangeNotifier {
  final GetAddressByZipcodeUsecase _getAddressByZipcodeUsecase;
  final GetCnpjUsecase _getCnpjUsecase;
  final PickImageFromGaleryUsecase _pickImageFromGaleryUsecase;

  StoreDetailsController({
    required this._getCnpjUsecase,
    required this._getAddressByZipcodeUsecase,
    required this._pickImageFromGaleryUsecase,
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

  String? _imagePath;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? get imagePath => _imagePath;

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

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickImageFromGalery() async {
    final path = await _pickImageFromGaleryUsecase();

    if (path != null) {
      _imagePath = path;
      notifyListeners();
    }
  }
}

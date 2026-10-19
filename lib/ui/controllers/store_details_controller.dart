import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../modules/address/usecases/get_address_by_zipcode.dart';
import '../../modules/address/usecases/get_location_by_address_usecase.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/imagePicker/usecases/pick_image_from_galery_usecase.dart';

class StoreDetailsController with ChangeNotifier {
  final GetAddressByZipcodeUsecase _getAddressByZipcodeUsecase;
  final GetLocationByAddressUsecase _getLocationByAddressUsecase;
  final GetCnpjUsecase _getCnpjUsecase;
  final PickImageFromGaleryUsecase _pickImageFromGaleryUsecase;

  StoreDetailsController({
    required this._getCnpjUsecase,
    required this._getAddressByZipcodeUsecase,
    required this._getLocationByAddressUsecase,
    required this._pickImageFromGaleryUsecase,
  }) {
    streetController.addListener(_onAddressChanged);
    cityController.addListener(_onAddressChanged);
    numberController.addListener(_onAddressChanged);
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

  GoogleMapController? _mapController;

  String? _imagePath;
  bool _isLoading = false;
  LatLng? _location;
  LatLng defaultPosition = LatLng(-23.5505, -46.6333);
  Timer? _addressDebounce;
  String? _lastSearchedAddress;

  bool get isLoading => _isLoading;

  String? get imagePath => _imagePath;

  LatLng? get location => _location;

  void setController(GoogleMapController controller) {
    _mapController = controller;
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

  Future<void> getLocationByAddress() async {
    final street = streetController.text;
    final city = cityController.text;
    final number = numberController.text;

    if (street.isEmpty || city.isEmpty || number.isEmpty) return;

    try {
      final result = await _getLocationByAddressUsecase(street, city, number);

      if (result == null) result;

      _location = LatLng(result!.latitude, result.longitude);
      changeCameraPosition();
      notifyListeners();
    } catch (e) {
      print('Não foi possível localizar o endereço: $e');
    }
  }

  void changeCameraPosition() {
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_location!.latitude, _location!.longitude),
          zoom: 18,
        ),
      ),
    );
  }

  void _onAddressChanged() {
    _addressDebounce?.cancel();

    final street = streetController.text.trim();
    final city = cityController.text.trim();
    final number = numberController.text.trim();

    if (street.isEmpty || city.isEmpty || number.isEmpty) {
      _lastSearchedAddress = null;
      return;
    }

    final address = '$street|$number|$city';
    _addressDebounce = Timer(const Duration(milliseconds: 700), () {
      if (address == _lastSearchedAddress) return;

      _lastSearchedAddress = address;
      getLocationByAddress();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    legalNameController.dispose();
    cnpjController.dispose();
    emailController.dispose();
    phoneController.dispose();

    zipcodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    streetController.dispose();
    numberController.dispose();
    neighborhoodController.dispose();
    complementController.dispose();

    _addressDebounce?.cancel();

    streetController.removeListener(_onAddressChanged);
    cityController.removeListener(_onAddressChanged);
    numberController.removeListener(_onAddressChanged);

  }
}

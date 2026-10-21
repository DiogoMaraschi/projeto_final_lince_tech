import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../entities/profile.dart';
import '../../modules/address/usecases/get_address_by_zipcode.dart';
import '../../modules/address/usecases/get_location_by_address_usecase.dart';
import '../../modules/cnpj/usecases/get_cnpj_usecase.dart';
import '../../modules/imagePicker/usecases/pick_image_from_galery_usecase.dart';
import '../../modules/profile/usecases/create_profile_usecase.dart';
import '../../modules/profile/usecases/get_profile_usecase.dart';
import '../../modules/profile/usecases/update_profile_usecase.dart';
import '../formatters/app_formatters.dart';

class ProfileDetailsController with ChangeNotifier {
  Profile? _profileReceived;
  final GetAddressByZipcodeUsecase _getAddressByZipcodeUsecase;
  final GetLocationByAddressUsecase _getLocationByAddressUsecase;
  final GetCnpjUsecase _getCnpjUsecase;
  final PickImageFromGaleryUsecase _pickImageFromGaleryUsecase;
  final CreateProfileUsecase _createProfileUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final GetProfileUsecase _getProfileUsecase;

  ProfileDetailsController({
    required this._getCnpjUsecase,
    required this._getAddressByZipcodeUsecase,
    required this._getLocationByAddressUsecase,
    required this._pickImageFromGaleryUsecase,
    required this._createProfileUsecase,
    required this._updateProfileUsecase,
    required this._getProfileUsecase,
    Profile? profile,
  }) : _profileReceived = profile {
    if (profile != null) _fillFields(profile);

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

  bool get isEditing => _profileReceived != null;

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

      if (result == null) return;

      _location = LatLng(result.latitude, result.longitude);
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

  Future<bool> saveProfile() async {
    try {
      final profileEdited = convertTextToProfile();

      if (isEditing) {
        await _updateProfileUsecase(profileEdited);
        print('editado');
      } else {
        await _createProfileUsecase(profileEdited);
        print('criado');
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _getProfileUsecase();
      _profileReceived = result;
      if (result != null) {
        _fillFields(_profileReceived!);
        _location = LatLng(result.latitude, result.longitude);
      }
    } catch (e) {
      print('ERRO AO BUSCAR PERFIL: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Profile convertTextToProfile() {
    final location = _location;
    if (location == null) {
      throw StateError('Busque a localização do endereço antes de salvar.');
    }

    return Profile(
      id: _profileReceived?.id,
      name: nameController.text,
      legalName: legalNameController.text,
      cnpj: AppFormatters.onlyNumber(cnpjController.text),
      state: stateController.text,
      city: cityController.text,
      zipCode: AppFormatters.onlyNumber(zipcodeController.text),
      street: streetController.text,
      number: numberController.text,
      neighborhood: neighborhoodController.text,
      complement: complementController.text,
      latitude: location.latitude,
      longitude: location.longitude,
      imagePath: _imagePath,
    );
  }

  void _fillFields(Profile profile) {
    nameController.text = profile.name;
    legalNameController.text = profile.legalName ?? '';
    cnpjController.text = profile.cnpj;
    _imagePath = profile.imagePath;
    zipcodeController.text = profile.zipCode;
    stateController.text = profile.state;
    cityController.text = profile.city;
    streetController.text = profile.street;
    numberController.text = profile.number;
    neighborhoodController.text = profile.neighborhood ?? '';
    complementController.text = profile.complement ?? '';
  }

  @override
  void dispose() {
    _addressDebounce?.cancel();

    streetController.removeListener(_onAddressChanged);
    cityController.removeListener(_onAddressChanged);
    numberController.removeListener(_onAddressChanged);

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

    super.dispose();
  }
}

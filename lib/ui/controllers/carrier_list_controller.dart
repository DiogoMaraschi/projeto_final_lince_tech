import 'package:flutter/material.dart';

import '../../entities/carrier.dart';
import '../../modules/carrier/usecases/create_carrier_usecase.dart';
import '../../modules/carrier/usecases/get_all_carriers_usecase.dart';

class CarrierListController with ChangeNotifier {
  final GetAllCarriersUsecase _getAllCarriersUsecase;

  CarrierListController({required this._getAllCarriersUsecase});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Carrier> _carriers = [];

  List<Carrier> get carriers => List.unmodifiable(_carriers);

  Future<void> getAllCarriers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _getAllCarriersUsecase();

      _carriers = result;
      print(carriers.length);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}

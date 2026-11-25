import 'package:flutter/cupertino.dart';

import '../../../entities/customer/costumer.dart';
import '../../../modules/customer/customer_failure.dart';
import '../../../modules/customer/usecases/get_all_customers_usecase.dart';

class CustomerListController with ChangeNotifier {
  final GetAllCustomersUsecase _getAllCustomersUsecase;

  CustomerListController({required this._getAllCustomersUsecase});

  bool _isLoading = false;
  List<Customer> _customers = [];

  CustomerListFailure? error;

  bool get isLoading => _isLoading;

  List<Customer> get customers => List.unmodifiable(_customers);

  Future<void> getAllCustomers() async {
    error = null;
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _getAllCustomersUsecase();

      result.fold(
        (failure) {
          error = failure;
        },
        (list) {
          _customers = list;
          error = null;
        },
      );
    }on Exception catch (e) {
      debugPrint('Erro $e');
      error = CustomerListFailure.customersLoadFailed;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

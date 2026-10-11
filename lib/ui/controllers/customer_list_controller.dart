import 'package:flutter/cupertino.dart';

import '../../entities/customer.dart';
import '../../modules/customer/usecases/get_all_customers_usecase.dart';

class CustomerListController with ChangeNotifier{
  final GetAllCustomersUsecase _getAllCustomersUsecase;

  CustomerListController({required this._getAllCustomersUsecase});

  bool _isLoading = false;
  List<Customer> _customers = [];

  bool get isLoading => _isLoading;
  List<Customer> get customers => List.unmodifiable(_customers);

  Future<void> getAllCustomers () async{
    _isLoading = true;
    notifyListeners();

    try{
      _customers = await _getAllCustomersUsecase();
    } catch(e){
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }



  }



}
import 'package:flutter/cupertino.dart';

import '../../entities/carrier.dart';
import '../../entities/costumer.dart';
import '../../entities/order_item_draft.dart';
import '../../entities/product.dart';
import '../../modules/carrier/usecases/get_carrier_by_id_usecase.dart';
import '../../modules/customer/usecases/get_customer_by_id_usecase.dart';

class OrderDetailsController with ChangeNotifier {
  final GetCustomerByIdUsecase getCustomerByIdUsecase;
  final GetCarrierByIdUsecase getCarrierByIdUsecase;

  OrderDetailsController({
    required this.getCustomerByIdUsecase,
    required this.getCarrierByIdUsecase,
  });

  Customer? _selectedCustomer;
  Carrier? _selectedCarrier;
  List<OrderItemDraft> _selectedProducts = [];

  Customer? get selectedCustomer => _selectedCustomer;

  Carrier? get selectedCarrier => _selectedCarrier;

  List<OrderItemDraft> get selectedProducts =>
      List.unmodifiable(_selectedProducts);

  Future<void> selectCustomer(int id) async {
    try {
      final result = await getCustomerByIdUsecase(id);
      _selectedCustomer = result;
      notifyListeners();
    } catch (e) {
      debugPrint('Não foi possível buscar os dados');
    }
  }

  Future<void> selectCarrier(int id) async {
    try {
      final result = await getCarrierByIdUsecase(id);
      _selectedCarrier = result;
      notifyListeners();
    } catch (e) {
      debugPrint('Não foi possível buscar os dados');
    }
  }

  void selectProducts({
    required List<Product> productsCompleteList,
    required Map<int, int> quantities,
  }) {
    _selectedProducts = productsCompleteList
        .where((p) => p.id != null && quantities.containsKey(p.id))
        .map((p) {
          final id = p.id!;
          return OrderItemDraft(
            product: p,
            quantity: quantities[id]!,
            unitPrice: p.salePrice,
          );
        })
        .toList();

    notifyListeners();
  }

  void incrementProduct(int productId) {
    _selectedProducts = selectedProducts.map((m) {
      if (m.product.id == productId) {
        return m.copyWith(quantity: m.quantity + 1);
      }
      return m;
    }).toList();

    notifyListeners();
  }

  void decrementProduct(int productId) {
    _selectedProducts = selectedProducts.map((m) {
      if (m.product.id == productId && m.quantity > 1) {
        return m.copyWith(quantity: m.quantity - 1);
      }
      return m;
    }).toList();

    notifyListeners();
  }

  void deleteProduct(int productId) {
    _selectedProducts.removeWhere((m) => m.product.id == productId);
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import '../../entities/carrier.dart';
import '../../entities/customer/costumer.dart';
import '../../entities/order/order_item_draft.dart';
import '../../entities/order/payment_type.dart';
import '../../entities/product.dart';
import '../../entities/profile.dart';
import '../../modules/carrier/usecases/get_carrier_by_id_usecase.dart';
import '../../modules/customer/usecases/get_customer_by_id_usecase.dart';
import '../../modules/profile/usecases/get_profile_usecase.dart';
import '../../modules/routes/usecases/get_distance_between_latlng.dart';

class OrderDetailsController with ChangeNotifier {
  final GetCustomerByIdUsecase getCustomerByIdUsecase;
  final GetCarrierByIdUsecase getCarrierByIdUsecase;
  final GetDistanceBetweenLatlng getDistanceBetweenLatlng;
  final GetProfileUsecase getProfileUsecase;

  OrderDetailsController({
    required this.getCustomerByIdUsecase,
    required this.getCarrierByIdUsecase,
    required this.getDistanceBetweenLatlng,
    required this.getProfileUsecase,
  });

  final notesController = TextEditingController();
  final paymentNotesController = TextEditingController();

  Profile? _profile;
  Customer? _selectedCustomer;
  Carrier? _selectedCarrier;
  List<OrderItemDraft> _selectedProducts = [];
  int? _deliveryDistance;
  PaymentType? _selectedPaymentType;
  int? _installments = 1;

  GoogleMapController? _mapController;

  Customer? get selectedCustomer => _selectedCustomer;

  Carrier? get selectedCarrier => _selectedCarrier;

  Profile? get profile => _profile;

  List<OrderItemDraft> get selectedProducts =>
      List.unmodifiable(_selectedProducts);

  int? get deliveryDistance => _deliveryDistance;

  PaymentType? get selectedPaymentType => _selectedPaymentType;

  int? get installments => _installments;

  void setController(GoogleMapController controller) {
    _mapController = controller;

    if (_profile != null && _selectedCustomer != null) {
      changeCameraPosition();
    }
  }

  Future<void> selectCustomer(int id) async {
    try {
      final result = await getCustomerByIdUsecase(id);

      _selectedCustomer = result;

      await getDistance();
      await changeCameraPosition();
    } catch (e) {
      debugPrint('Não foi possível buscar os dados $e');
    } finally {
      notifyListeners();
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

  Future<void> getDistance() async {
    final profile = _profile;
    final customer = _selectedCustomer;

    if (profile == null || customer == null) return;

    _deliveryDistance = null;

    try {
      _deliveryDistance = await getDistanceBetweenLatlng(
        originLatitude: profile.latitude,
        originLongitude: profile.longitude,
        destinationLatitude: customer.latitude,
        destinationLongitude: customer.longitude,
      );
    } catch (e) {
      debugPrint('Não foi possível calcular a distância: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getProfile() async {
    try {
      _profile = await getProfileUsecase();
      notifyListeners();
    } catch (e) {
      debugPrint('Não foi possível retornar os dados $e');
    }
  }

  Future<void> changeCameraPosition() async {
    final origin = _profile;
    final destination = _selectedCustomer;

    if (origin == null || destination == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        math.min(origin.latitude, destination.latitude),
        math.min(origin.longitude, destination.longitude),
      ),
      northeast: LatLng(
        math.max(origin.latitude, destination.latitude),
        math.max(origin.longitude, destination.longitude),
      ),
    );

    await _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 60),
    );
  }

  void setItemDiscount({required int productId, required double percent}) {
    final safePercent = percent.clamp(0.0, 100.0).toDouble();

    _selectedProducts = _selectedProducts.map((item) {
      if (item.product.id != productId) return item;

      final discountAmount = item.subtotal * safePercent / 100;

      return item.copyWith(
        discountPercent: safePercent,
        discountAmount: discountAmount,
      );
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    notesController.dispose();
    paymentNotesController.dispose();

    super.dispose();
  }
}

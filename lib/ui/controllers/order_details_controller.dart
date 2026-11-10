import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../entities/carrier.dart';
import '../../entities/customer/costumer.dart';
import '../../entities/order/order_item.dart';
import '../../entities/order/payment_type.dart';
import '../../entities/product.dart';
import '../../entities/profile.dart';
import '../../entities/route_result.dart';
import '../../modules/carrier/usecases/get_carrier_by_id_usecase.dart';
import '../../modules/customer/usecases/get_customer_by_id_usecase.dart';
import '../../modules/profile/usecases/get_profile_usecase.dart';
import '../../modules/routes/usecases/get_driving_route_usecase.dart';

class OrderDetailsController with ChangeNotifier {
  final GetCustomerByIdUsecase getCustomerByIdUsecase;
  final GetCarrierByIdUsecase getCarrierByIdUsecase;
  final GetDrivingRouteUsecase getDrivingRouteUsecase;
  final GetProfileUsecase getProfileUsecase;

  OrderDetailsController({
    required this.getCustomerByIdUsecase,
    required this.getCarrierByIdUsecase,
    required this.getDrivingRouteUsecase,
    required this.getProfileUsecase,
  });

  final notesController = TextEditingController();
  final paymentNotesController = TextEditingController();

  Profile? _profile;
  Customer? _selectedCustomer;
  Carrier? _selectedCarrier;
  List<OrderItem> _selectedProducts = [];
  double? _deliveryValue;
  PaymenItem? _selectedPaymentItem;

  double? get deliveryValue => _deliveryValue;

  GoogleMapController? _mapController;

  Customer? get selectedCustomer => _selectedCustomer;

  Carrier? get selectedCarrier => _selectedCarrier;

  Profile? get profile => _profile;

  RouteResult? _routeResult;

  List<OrderItem> get selectedProducts =>
      List.unmodifiable(_selectedProducts);

  int? get deliveryDistance => _routeResult?.distanceMeters;

  PaymenItem? get selectedPaymentItem => _selectedPaymentItem;

  double get productsSubtotal =>
      _selectedProducts.fold(0.0, (sum, item) => sum + item.subtotal);

  double get totalDiscount =>
      _selectedProducts.fold(0.0, (sum, item) => sum + item.discountAmount);

  double get productsTotal =>
      _selectedProducts.fold(0.0, (sum, item) => sum + item.total);

  double get orderTotal => productsTotal + (_deliveryValue ?? 0);

  List<LatLng> get geoPoints {
    return _routeResult?.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList() ??
        [];
  }

  void setController(GoogleMapController controller) {
    _mapController = controller;

    if (_profile != null && _selectedCustomer != null) {
      changeCameraPosition();
    }
  }

  void selectPaymentItem(PaymenItem paymentItem) {
    _selectedPaymentItem = paymentItem;
    notifyListeners();
  }

  Future<void> selectCustomer(int id) async {
    try {
      final result = await getCustomerByIdUsecase(id);

      _selectedCustomer = result;

      await getDrivingRoute();
      await changeCameraPosition();

      if (_selectedCustomer != null && _selectedCarrier != null)
        setDeliveryValue();
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

      if (_selectedCustomer != null && _selectedCarrier != null)
        setDeliveryValue();
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
          return OrderItem(
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

  Future<void> getDrivingRoute() async {
    final profile = _profile;
    final customer = _selectedCustomer;

    if (profile == null || customer == null) return;

    _routeResult = null;

    try {
      _routeResult = await getDrivingRouteUsecase(
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
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  void setItemDiscount({required int productId, required double percent}) {
    final safePercent = percent.clamp(0.0, 100.0).toDouble();

    _selectedProducts = _selectedProducts.map((item) {
      if (item.product.id != productId) return item;

      return item.copyWith(discountPercent: safePercent);
    }).toList();

    notifyListeners();
  }

  String getCustomerAddress() {
    final customer = _selectedCustomer;
    if (customer == null) return '';

    final street = customer.street;
    final number = customer.number;
    final city = customer.city;
    final state = customer.state;
    final zipcode = customer.zipCode;

    return '''
    ${street}, $number
    $city/$state - CEP $zipcode
    ''';
  }

  void setDeliveryValue() {
    final distanceMeters = _routeResult?.distanceMeters;
    final carrier = _selectedCarrier;

    if (distanceMeters == null || carrier == null) {
      _deliveryValue = null;
    } else {
      final value = (distanceMeters / 1000) * carrier.costPerKm;

      value < carrier.minimumPrice
          ? _deliveryValue = carrier.minimumPrice
          : _deliveryValue = value;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    notesController.dispose();
    paymentNotesController.dispose();

    super.dispose();
  }
}

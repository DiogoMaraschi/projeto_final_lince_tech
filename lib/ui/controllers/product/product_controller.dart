import 'package:flutter/material.dart';
import '../../../core/utils/digits_only.dart';
import '../../../entities/product.dart';
import '../../../modules/imagePicker/usecases/capture_image_usecase.dart';
import '../../../modules/imagePicker/usecases/pick_image_from_galery_usecase.dart';
import '../../../modules/product/usecases/create_product_usecase.dart';
import '../../../modules/product/usecases/delete_product_usecase.dart';
import '../../../modules/product/usecases/update_product_usecase.dart';
import '../../formatters/input_formatters.dart';

class ProductController with ChangeNotifier {
  Product? _productReceived;
  final CreateProductUsecase _createProductUsecase;
  final CaptureImageUsecase _captureImageUsecase;
  final UpdateProductUsecase _updateProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;
  final PickImageFromGaleryUsecase _pickImageFromGaleryUsecase;

  ProductController({
    required this._createProductUsecase,
    required this._captureImageUsecase,
    required this._updateProductUsecase,
    required this._deleteProductUsecase,
    required this._pickImageFromGaleryUsecase,
    Product? product,
  }) : _productReceived = product {
    if (product != null) {
      _fillFields(product);
    }
  }

  final nameController = TextEditingController();
  final barcodeController = TextEditingController();
  final descriptionController = TextEditingController();
  final brandController = TextEditingController();
  final salePriceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    salePriceController.dispose();

    super.dispose();
  }

  String? _imagePath;

  String? get imagePath => _imagePath;

  bool get isEditing => _productReceived != null;

  Future<void> captureImage() async {
    final path = await _captureImageUsecase();

    if (path != null) {
      _imagePath = path;
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

  void deleteSelectedImage(){
    _imagePath = null;
    notifyListeners();
  }

  Future<bool> saveProduct() async {
    final productEdited = convertTextToProduct();

    try {
      if (isEditing) {
        await _updateProductUsecase(productEdited);
      } else {
        await _createProductUsecase(productEdited);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Product convertTextToProduct() {
    return Product(
      id: _productReceived?.id,
      name: nameController.text,
      barcode: barcodeController.text,
      description: descriptionController.text,
      brand: brandController.text,
      imagePath: _imagePath,
      salePrice: _parseMoney(salePriceController.text),
    );
  }

  double _parseMoney(String value) {
    final digits = digitsOnly(value);
    return int.parse(digits) / 100;
  }

  void _fillFields(Product product) {
    nameController.text = product.name;
    barcodeController.text = product.barcode;
    brandController.text = product.brand;
    descriptionController.text = product.description ?? '';
    _imagePath = product.imagePath;
    salePriceController.text = product.salePrice.toString();
  }

  Future<bool> delete() async {
    if (_productReceived?.id == null) {
      return false;
    }

    try {
      await _deleteProductUsecase(_productReceived!.id!);
      return true;
    } catch (e) {
      return false;
    }
  }
}

import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class CreateProductUsecase {
  final ProductRepository repository;

  CreateProductUsecase({required this.repository});

  Future<int> call(Product product) async {
    return await repository.insert(product);
  }
}

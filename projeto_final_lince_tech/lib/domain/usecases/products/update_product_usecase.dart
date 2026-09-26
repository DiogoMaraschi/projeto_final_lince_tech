import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepositoryImpl repository;

  UpdateProductUsecase({required this.repository});

  Future<int> call(Product product) async {
    return repository.update(product);
  }
}

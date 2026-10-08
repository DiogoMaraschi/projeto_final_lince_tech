import '../../../entities/product.dart';
import '../repository.dart';

class CreateProductUsecase {
  final ProductRepository repository;

  CreateProductUsecase({required this.repository});

  Future<int> call(Product product) {
    return repository.insert(product);
  }
}

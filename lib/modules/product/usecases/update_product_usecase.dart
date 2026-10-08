import '../../../entities/product.dart';
import '../repository.dart';

class UpdateProductUsecase {
  final ProductRepository repository;

  UpdateProductUsecase({required this.repository});

  Future<int> call(Product product) async {
    return repository.update(product);
  }
}

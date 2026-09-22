import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase({required this.repository});

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}

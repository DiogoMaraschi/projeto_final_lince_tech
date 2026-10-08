import '../../../entities/product.dart';
import '../repository.dart';

class GetAllProductsUsecase {
  final ProductRepository repository;

  GetAllProductsUsecase({required this.repository});

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}

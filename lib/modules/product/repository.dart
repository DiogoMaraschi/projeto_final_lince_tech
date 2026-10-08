import '../../entities/product.dart';

abstract class ProductRepository {
  Future<int> insert(Product product);

  Future<List<Product>> getAllProducts();

  Future<int> update(Product product);

  Future<int> softDelete(int id);
}

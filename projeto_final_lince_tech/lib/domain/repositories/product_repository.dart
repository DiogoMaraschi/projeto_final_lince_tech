import '../../core/database/database_helper.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<int> insert(Product product);
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  final DatabaseHelper databaseHelper;

  ProductRepositoryImpl({required this.databaseHelper});

  static const String tableName = 'products';

  @override
  Future<int> insert(Product product) async {
    final productModel = ProductModel.fromEntity(product);

    final conn = await databaseHelper.database;

    return conn.insert(tableName, productModel.toMap());
  }

  @override
  Future<List<Product>> getProducts() async {
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName);
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }
}

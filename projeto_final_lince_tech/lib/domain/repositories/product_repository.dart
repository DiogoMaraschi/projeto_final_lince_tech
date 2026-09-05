import '../../core/database/database_helper.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<int> insert(Product product);
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
}

import '../../core/database/database_helper.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<int> insert(Product product);
  Future<List<Product>> getAllProducts();
  Future<int> update(Product product);
  Future<int> softDelete(int id);
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
  Future<List<Product>> getAllProducts() async {
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName, where: 'deleted_at IS NULL');
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<int> update(Product product) async {
    final productModel = ProductModel.fromEntity(product).toMap();

    final conn = await databaseHelper.database;

    return conn.update(
      tableName,
      productModel,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<int> softDelete(int id) async {
    final conn = await databaseHelper.database;

    return conn.update(
      tableName,
      {'deleted_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

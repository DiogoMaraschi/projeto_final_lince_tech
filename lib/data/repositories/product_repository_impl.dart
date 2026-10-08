import '../../core/database/database_helper.dart';
import '../../entities/product.dart';
import '../../modules/product/repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DatabaseHelper databaseHelper;

  ProductRepositoryImpl({required this.databaseHelper});

  static const tableName = 'products';

  Future<int> insert(Product product) async {
    final conn = await databaseHelper.database;
    return conn.insert(tableName, ProductModel.fromEntity(product).toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final conn = await databaseHelper.database;
    final rows = await conn.query(tableName, where: 'deleted_at IS NULL');
    return rows.map((m) => ProductModel.fromMap(m)).toList();
  }

  Future<int> update(Product product) async {
    final conn = await databaseHelper.database;
    return conn.update(
      tableName,
      ProductModel.fromEntity(product).toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

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

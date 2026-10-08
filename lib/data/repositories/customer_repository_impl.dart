import '../../core/database/database_helper.dart';
import '../../entities/customer.dart';
import '../../modules/customer/repository.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final DatabaseHelper databaseHelper;

  CustomerRepositoryImpl({required this.databaseHelper});

  static const tableName = 'customers';

  Future<int> insert(Customer customer) async {
    final conn = await databaseHelper.database;
    return conn.insert(tableName, CustomerModel.fromEntity(customer).toMap());
  }

  Future<List<Customer>> getAllCustomers() async {
    final conn = await databaseHelper.database;
    final rows = await conn.query(tableName, where: 'deleted_at IS NULL');
    return rows.map((m) => CustomerModel.fromMap(m)).toList();
  }

  Future<int> update(Customer customer) async {
    final conn = await databaseHelper.database;
    return conn.update(
      tableName,
      CustomerModel.fromEntity(customer).toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
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

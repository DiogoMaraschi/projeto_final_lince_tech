import '../../core/database/database_helper.dart';
import '../../data/models/customer_model.dart';
import '../entities/costumer.dart';

abstract class CustomerRepository {
  Future<int> insert(Customer customer);
  Future<List<Customer>> getAllCustomers();
  Future<int> update(Customer customer);
  Future<int> softDelete(int id);
}

class CustomerRepositoryImpl implements CustomerRepository {
  final DatabaseHelper databaseHelper;

  static const String tableName = 'customers';

  CustomerRepositoryImpl({required this.databaseHelper});

  @override
  Future<int> insert(Customer customer) async{
    final customerModel = CustomerModel.fromEntity(customer);

    final conn = await databaseHelper.database;

    final id = await conn.insert(tableName, customerModel.toMap());
    print('${customer.establishmentType}');

    return id;
  }

  @override
  Future<List<Customer>> getAllCustomers() async{
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName, where: 'deleted_at IS NULL');

    return result.map((map) => CustomerModel.fromMap(map)).toList();
  }

  @override
  Future<int> update(Customer customer) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> softDelete(int id) {
    // TODO: implement softDelete
    throw UnimplementedError();
  }

}

import '../../entities/customer.dart';

abstract class CustomerRepository {
  Future<int> insert(Customer customer);

  Future<List<Customer>> getAllCustomers();

  Future<int> update(Customer customer);

  Future<int> softDelete(int id);
}

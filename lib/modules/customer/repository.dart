import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../../entities/customer/costumer.dart';
import './models/customer_model.dart';
import 'customer_failure.dart';

abstract class CustomerRepository {
  Future<Either<CustomerFailure, int>> createOrReactivate(Customer customer);

  Future<Either<CustomerListFailure, List<Customer>>> getAllCustomers();

  Future<Either<CustomerFailure, int>> update(Customer customer);

  Future<int> softDelete(int id);

  Future<Customer?> getById(int id);
}

class CustomerRepositoryImpl implements CustomerRepository {
  final DatabaseHelper databaseHelper;

  static const String tableName = 'customers';

  CustomerRepositoryImpl({required this.databaseHelper});

  Future<Either<CustomerFailure, int>> createOrReactivate(
    Customer customer,
  ) async {
    final customerModel = CustomerModel.fromEntity(customer);

    try {
      final conn = await databaseHelper.database;

      return await conn.transaction<Either<CustomerFailure, int>>((txn) async {
        final existingRows = await txn.query(
          tableName,
          where: 'cnpj = ?',
          whereArgs: [customer.cnpj],
        );

        if (existingRows.isNotEmpty) {
          final row = existingRows.first;
          final existingId = row['id'] as int;
          final isDeleted = row['deleted_at'] != null;

          if (!isDeleted) {
            return const Left(CustomerFailure.cnpjAlreadyRegistered);
          }

          await txn.update(
            tableName,
            {'deleted_at': null},
            where: 'id = ? AND deleted_at IS NOT NULL',
            whereArgs: [existingId],
          );

          return Right(existingId);
        }

        final newId = await txn.insert(tableName, customerModel.toMap());

        return Right(newId);
      });
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        return const Left(CustomerFailure.cnpjAlreadyRegistered);
      }

      return const Left(CustomerFailure.saveFailed);
    }
  }

  @override
  Future<Either<CustomerListFailure, List<Customer>>> getAllCustomers() async {
    try {
      final conn = await databaseHelper.database;

      final rows = await conn.query(tableName, where: 'deleted_at IS NULL');

      return Right(rows.map(CustomerModel.fromMap).toList());
    } on DatabaseException {
      return const Left(CustomerListFailure.customersLoadFailed);
    }
  }

  @override
  Future<Either<CustomerFailure, int>> update(Customer customer) async {
    final customerModel = CustomerModel.fromEntity(customer);

    try {
      final conn = await databaseHelper.database;

      return await conn.transaction<Either<CustomerFailure, int>>((txn) async {
        final currentRows = await txn.query(
          tableName,
          columns: ['cnpj'],
          where: 'id = ?',
          whereArgs: [customer.id],
          limit: 1,
        );

        if (currentRows.isEmpty) {
          return const Left(CustomerFailure.customerNotFound);
        }

        final currentCnpj = currentRows.first['cnpj'] as String;

        if (currentCnpj != customer.cnpj) {
          final duplicateRows = await txn.query(
            tableName,
            columns: ['id'],
            where: 'cnpj = ?',
            whereArgs: [customer.cnpj],
            limit: 1,
          );

          if (duplicateRows.isNotEmpty) {
            return const Left(CustomerFailure.cnpjAlreadyRegistered);
          }
        }

        final updatedRows = await txn.update(
          tableName,
          customerModel.toMap(),
          where: 'id = ?',
          whereArgs: [customer.id],
        );

        return updatedRows > 0
            ? Right(updatedRows)
            : const Left(CustomerFailure.customerNotFound);
      });
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        return const Left(CustomerFailure.cnpjAlreadyRegistered);
      }
      return const Left(CustomerFailure.saveFailed);
    }
  }

  @override
  Future<int> softDelete(int id) async {
    final conn = await databaseHelper.database;

    return conn.update(
      tableName,
      {'deleted_at': DateTime.now().toIso8601String()},
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [id],
    );
  }

  @override
  Future<Customer?> getById(int id) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return CustomerModel.fromMap(result.first);
  }
}

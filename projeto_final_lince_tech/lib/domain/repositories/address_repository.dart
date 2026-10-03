import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../../data/datasources/brasil_api_datasource.dart';
import '../../data/datasources/viacep_api_datasource.dart';
import '../../data/models/address_model.dart';
import '../entities/address.dart';

abstract class AddressRepository {
  Future<Address> getByZipcode(String zipcode);
  Future<Address?> getById(int id);
  Future<int> insertWithTransaction(Address address, Transaction txn);
}

class AdressRepositoryImpl implements AddressRepository {
  final BrasilApiDatasource brasilApiDatasource;
  final ViacepApiDatasource viacepApiDatasource;
  final DatabaseHelper databaseHelper;

  static const String tableName = 'addresses';

  AdressRepositoryImpl({
    required this.brasilApiDatasource,
    required this.viacepApiDatasource,
    required this.databaseHelper,
  });

  @override
  Future<Address> getByZipcode(String zipcode) async {
    try {
      return await brasilApiDatasource.getByZipcode(zipcode);
    } catch (e) {
      debugPrint('Brasil Api falhou $e');
      return await viacepApiDatasource.getByZipcode(zipcode);
    }
  }

  @override
  Future<Address?> getById(int id) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return AddressModel.fromDatabaseMap(result.first);
  }

  @override
  Future<int> insertWithTransaction(Address address, Transaction txn) async {
    final addressModel = AddressModel.fromEntity(address);

    return txn.insert(tableName, addressModel.toMap());
  }
}

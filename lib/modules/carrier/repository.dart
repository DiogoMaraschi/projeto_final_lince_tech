import '../../core/database/database_helper.dart';
import './models/carrier_model.dart';
import '../../entities/carrier.dart';

abstract class CarrierRepository {
  Future<int> insert(Carrier carrier);

  Future<List<Carrier>> getAllCarriers();

  Future<int> update(Carrier carrier);

  Future<int> softDelete(int id);

  Future<Carrier?> getById(int id);
}

class CarrierRepositoryImpl implements CarrierRepository {
  final DatabaseHelper databaseHelper;

  CarrierRepositoryImpl({required this.databaseHelper});

  static const String tableName = 'carriers';

  @override
  Future<int> insert(Carrier carrier) async {
    final carrierModel = CarrierModel.fromEntity(carrier);

    final conn = await databaseHelper.database;

    return conn.insert(tableName, carrierModel.toMap());
  }

  @override
  Future<List<Carrier>> getAllCarriers() async {
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName, where: 'deleted_at IS NULL');

    return result.map((map) => CarrierModel.fromMap(map)).toList();
  }

  @override
  Future<int> update(Carrier carrier) async {
    final carrierModel = CarrierModel.fromEntity(carrier);

    final conn = await databaseHelper.database;

    return await conn.update(
      tableName,
      carrierModel.toMap(),
      where: 'id = ?',
      whereArgs: [carrier.id],
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

  @override
  Future<Carrier?> getById(int id) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return CarrierModel.fromMap(result.first);
  }
}

sealed class Result {
  final String message;

  //TODO estudar sobre
  const Result({required this.message});
}

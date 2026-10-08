import '../../core/database/database_helper.dart';
import '../../entities/carrier.dart';
import '../../modules/carrier/repository.dart';
import '../models/carrier_model.dart';

class CarrierRepositoryImpl implements CarrierRepository {
  final DatabaseHelper databaseHelper;

  CarrierRepositoryImpl({required this.databaseHelper});

  static const tableName = 'carriers';

  Future<int> insert(Carrier carrier) async {
    final conn = await databaseHelper.database;
    return conn.insert(tableName, CarrierModel.fromEntity(carrier).toMap());
  }

  Future<List<Carrier>> getAllCarriers() async {
    final conn = await databaseHelper.database;
    final rows = await conn.query(tableName, where: 'deleted_at IS NULL');
    return rows.map((m) => CarrierModel.fromMap(m)).toList();
  }

  Future<int> update(Carrier carrier) async {
    final conn = await databaseHelper.database;
    return conn.update(
      tableName,
      CarrierModel.fromEntity(carrier).toMap(),
      where: 'id = ?',
      whereArgs: [carrier.id],
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

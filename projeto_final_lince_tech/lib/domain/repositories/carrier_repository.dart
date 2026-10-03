import '../../core/database/database_helper.dart';
import '../../data/models/carrier_model.dart';
import '../entities/carrier.dart';

abstract class CarrierRepository {
  Future<int> insert(Carrier carrier);
  Future<List<Carrier>> getAllCarriers();
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

    print(result.map((map) => CarrierModel.fromMap(map)).toList().length);

    return result.map((map) => CarrierModel.fromMap(map)).toList();
  }
}

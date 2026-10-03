import '../../core/database/database_helper.dart';
import '../../data/models/carrier_model.dart';
import '../entities/carrier.dart';
import '../usecases/carriers/update_carrier_usecase.dart';

abstract class CarrierRepository {
  Future<int> insert(Carrier carrier);
  Future<List<Carrier>> getAllCarriers();
  Future<int> update(Carrier carrier);
  Future<int> softDelete(int id);
}

class CarrierRepositoryImpl implements CarrierRepository {
  final DatabaseHelper databaseHelper;

  CarrierRepositoryImpl({required this.databaseHelper});

  static const String tableName = 'carriers';

  @override
  Future<int> insert(Carrier carrier) async {
    final carrierModel = CarrierModel.fromEntity(carrier);

    final conn = await databaseHelper.database;

    // final result = await conn.query(tableName, where: 'cnpj = ?', whereArgs: [carrierModel.cnpj]);
    // // if (result.isNotEmpty) {
    // //   return UpdateCarrierStatus.cnpjAlreadyExists;
    // // }
    print('email no repo enti ${carrier.email}');
    print('email no repo model ${carrierModel.email}');

    return conn.insert(tableName, carrierModel.toMap());
  }

  @override
  Future<List<Carrier>> getAllCarriers() async {
    final conn = await databaseHelper.database;

    final result = await conn.query(tableName, where: 'deleted_at IS NULL');

    print(result.map((map) => CarrierModel.fromMap(map)).toList().length);

    return result.map((map) => CarrierModel.fromMap(map)).toList();
  }

  @override
  Future<int> update(Carrier carrier) async {
    final carrierModel = CarrierModel.fromEntity(carrier);

    final conn = await databaseHelper.database;

    print('-----repo----');
    print('id ${carrier.id}');
    print('nome ${carrier.name}');
    print('id email ${carrier.email}');
    print('id cnpj ${carrier.cnpj}');
    print('id mim ${carrier.minimumPrice}');
    print('id cost ${carrier.costPerKm}');
    print('id phone ${carrier.phoneNumber}');



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
}


sealed class Result {
  final String message;
  //TODO estudar sobre
  const Result({required this.message});
}


import '../../entities/carrier.dart';

abstract class CarrierRepository {
  Future<int> insert(Carrier carrier);

  Future<List<Carrier>> getAllCarriers();

  Future<int> update(Carrier carrier);

  Future<int> softDelete(int id);
}

import '../../domain/entities/carrier.dart';

class CarrierModel extends Carrier {
  final String? deletedAt;

  CarrierModel({
    super.id,
    required super.name,
    super.legalName,
    super.cnpj,
    super.email,
    super.phoneNumber,
    required super.costPerKm,
    required super.minimunPrice,
    required super.adressId,
    this.deletedAt,
  });

  factory CarrierModel.fromMap(Map<String, dynamic> map) {
    return CarrierModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      legalName: map['legal_name'] as String?,
      cnpj: map['cnpj'] as String?,
      phoneNumber: map['phone'] as String?,
      costPerKm: map['cost_per_km'] as double,
      minimunPrice: map['minimum_price'] as double,
      adressId: map['adress_id'] as int,
      deletedAt: map['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'legal_name': legalName,
      'cnpj': cnpj,
      'phone': phoneNumber,
      'cost_per_km': costPerKm,
      'minimum_price': minimunPrice,
      'adress_id': adressId,
      'deleted_at': deletedAt,
    };
  }

  factory CarrierModel.fromEntity(Carrier carrier) {
    return CarrierModel(
      id: carrier.id,
      name: carrier.name,
      legalName: carrier.legalName,
      cnpj: carrier.cnpj,
      phoneNumber: carrier.phoneNumber,
      costPerKm: carrier.costPerKm,
      minimunPrice: carrier.minimunPrice,
      adressId: carrier.adressId,
    );
  }
}

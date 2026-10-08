import '../../entities/carrier.dart';

class CarrierModel extends Carrier {
  final String? deletedAt;

  CarrierModel({
    super.id,
    required super.name,
    required super.legalName,
    required super.cnpj,
    super.email,
    super.phoneNumber,
    required super.costPerKm,
    required super.minimumPrice,
    this.deletedAt,
  });

  factory CarrierModel.fromMap(Map<String, dynamic> map) {
    return CarrierModel.fromDatabaseMap(map);
  }

  factory CarrierModel.fromDatabaseMap(Map<String, dynamic> map) {
    return CarrierModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      legalName: map['legal_name'] as String,
      cnpj: map['cnpj'] as String,
      email: map['email'] as String?,
      phoneNumber: map['phone'] as String?,
      costPerKm: (map['cost_per_km'] as num).toDouble(),
      minimumPrice: (map['minimum_price'] as num).toDouble(),
      deletedAt: map['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'legal_name': legalName,
      'cnpj': cnpj,
      'phone': phoneNumber,
      'email': email,
      'cost_per_km': costPerKm,
      'minimum_price': minimumPrice,
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
      email: carrier.email,
      costPerKm: carrier.costPerKm,
      minimumPrice: carrier.minimumPrice,
    );
  }
}

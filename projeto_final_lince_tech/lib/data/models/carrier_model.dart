import '../../domain/entities/carrier.dart';
import 'address_model.dart';

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
    required super.minimumPrice,
    super.addressId,
    super.address,
    this.deletedAt,
  });

  factory CarrierModel.fromMap(Map<String, dynamic> map) {
    return CarrierModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      legalName: map['legal_name'] as String?,
      cnpj: map['cnpj'] as String?,
      phoneNumber: map['phone'] as String?,
      costPerKm: (map['cost_per_km'] as num).toDouble(),
      minimumPrice: (map['minimum_price'] as num).toDouble(),
      addressId: map['address_id'] as int?,
      deletedAt: map['deleted_at'] as String?,
    );
  }

  factory CarrierModel.fromDatabaseMap(Map<String, dynamic> map) {
    return CarrierModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      legalName: map['legal_name'] as String?,
      cnpj: map['cnpj'] as String?,
      phoneNumber: map['phone'] as String?,
      costPerKm: map['cost_per_km'] as double,
      minimumPrice: map['minimum_price'] as double,
      addressId: map['address_id'] as int?,
      deletedAt: map['deleted_at'] as String?,
      address: map['address_id'] != null
          ? AddressModel.fromDatabaseMap(map)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'legal_name': legalName,
      'cnpj': cnpj,
      'phone': phoneNumber,
      'cost_per_km': costPerKm,
      'minimum_price': minimumPrice,
      'address_id': addressId,
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
      minimumPrice: carrier.minimumPrice,
      addressId: carrier.addressId,
    );
  }
}

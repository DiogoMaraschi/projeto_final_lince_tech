import '../../entities/customer.dart';

class CustomerModel extends Customer {
  final String? deletedAt;

  CustomerModel({
    super.id,
    required super.name,
    required super.cnpj,
    required super.legalName,
    super.phoneNumber,
    super.email,
    required super.establishmentType,
    required super.state,
    required super.city,
    required super.zipCode,
    required super.street,
    required super.number,
    required super.latitude,
    required super.longitude,
    this.deletedAt,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel.fromDatabaseMap(map);
  }

  factory CustomerModel.fromDatabaseMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      cnpj: map['cnpj'] as String,
      legalName: map['legal_name'] as String,
      phoneNumber: map['phone'] as String?,
      email: map['email'] as String?,
      establishmentType: EstablishmentType.fromDatabaseValue(
        map['establishment_type'] as String,
      ),
      state: map['state'] as String,
      city: map['city'] as String,
      zipCode: map['zip_code'] as String,
      street: map['street'] as String,
      number: map['number'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      deletedAt: map['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cnpj': cnpj,
      'legal_name': legalName,
      'phone': phoneNumber,
      'email': email,
      'establishment_type': establishmentType.databaseValue,
      'state': state,
      'city': city,
      'zip_code': zipCode,
      'street': street,
      'number': number,
      'latitude': latitude,
      'longitude': longitude,
      'deleted_at': deletedAt,
    };
  }

  factory CustomerModel.fromEntity(Customer customer) {
    return CustomerModel(
      id: customer.id,
      name: customer.name,
      cnpj: customer.cnpj,
      legalName: customer.legalName,
      phoneNumber: customer.phoneNumber,
      email: customer.email,
      establishmentType: customer.establishmentType,
      state: customer.state,
      city: customer.city,
      zipCode: customer.zipCode,
      street: customer.street,
      number: customer.number,
      latitude: customer.latitude,
      longitude: customer.longitude,
    );
  }
}

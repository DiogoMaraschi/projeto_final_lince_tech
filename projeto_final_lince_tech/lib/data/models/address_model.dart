import '../../domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    super.id,
    required super.zipCode,
    required super.street,
    required super.number,
    super.neighborhood,
    super.complement,
    required super.city,
    required super.state,
    super.latitude,
    super.longitude,
  });

  factory AddressModel.fromViaCepApiMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int?,
      zipCode: map['cep'] as String,
      street: map['logradouro'] as String,
      number: '',
      neighborhood: map['bairro'] as String?,
      complement: map['complemento'] as String?,
      city: map['localidade'] as String,
      state: map['uf'] as String,
      latitude: null,
      longitude: null,
    );
  }

  factory AddressModel.fromBrasilApiMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int?,
      zipCode: map['cep'] as String,
      street: map['street'] as String,
      number: '',
      neighborhood: map['neighborhood'] as String?,
      complement: '',
      city: map['city'] as String,
      state: map['state'] as String,
      latitude: null,
      longitude: null,
    );
  }

  factory AddressModel.fromDatabaseMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int?,
      zipCode: map['zip_code'] as String,
      street: map['street'] as String,
      number: map['number'] as String,
      neighborhood: map['neighborhood'] as String?,
      complement: map['complement'] as String?,
      city: map['city'] as String,
      state: map['state'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'zip_code': zipCode,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
      'city': city,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromEntity(Address address) {
    return AddressModel(
      id: address.id,
      zipCode: address.zipCode,
      street: address.street,
      number: address.number,
      neighborhood: address.neighborhood,
      complement: address.complement,
      city: address.city,
      state: address.state,
      latitude: address.latitude,
      longitude: address.longitude,
    );
  }
}

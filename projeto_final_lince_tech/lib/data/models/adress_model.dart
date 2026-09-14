import '../../domain/entities/adress.dart';

class AdressModel extends Adress {
  AdressModel({
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

  factory AdressModel.fromMap(Map<String, dynamic> map) {
    return AdressModel(
      id: map['id'] as int?,
      zipCode: map['cep'] as String,
      street: map['logradouro'] as String,
      number: 0,
      neighborhood: map['bairro'] as String?,
      complement: map['complemento'] as String?,
      city: map['localidade'] as String,
      state: map['uf'] as String,
      latitude: null,
      longitude: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  factory AdressModel.fromEntity(Adress adress) {
    return AdressModel(
      id: adress.id,
      zipCode: adress.zipCode,
      street: adress.street,
      number: adress.number,
      neighborhood: adress.neighborhood,
      complement: adress.complement,
      city: adress.city,
      state: adress.state,
      latitude: adress.latitude,
      longitude: adress.longitude,
    );
  }
}

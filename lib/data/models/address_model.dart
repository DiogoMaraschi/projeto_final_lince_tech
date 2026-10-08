import '../../entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.zipCode,
    required super.street,
    super.neighborhood,
    super.complement,
    required super.city,
    required super.state,
  });

  factory AddressModel.fromViaCepApiMap(Map<String, dynamic> map) =>
      AddressModel(
        zipCode: map['cep'] as String,
        street: map['logradouro'] as String,
        neighborhood: map['bairro'] as String?,
        complement: map['complemento'] as String?,
        city: map['localidade'] as String,
        state: map['uf'] as String,
      );

  factory AddressModel.fromBrasilApiMap(Map<String, dynamic> map) =>
      AddressModel(
        zipCode: map['cep'] as String,
        street: map['street'] as String,
        neighborhood: map['neighborhood'] as String?,
        complement: '',
        city: map['city'] as String,
        state: map['state'] as String,
      );
}
